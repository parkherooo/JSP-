package ch16;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class PollMgr {
	private DBConnectionMgr pool;
	
	public PollMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//Max Num : 가장 큰 Num 값 리턴
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum=0;
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblpolllist";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				maxNum = rs.getInt(1);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	//Poll insert
	public boolean insertPoll (PollListBean plbean, PollItemBean pibean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblpolllist values(null,?,?,?,now(),?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, plbean.getQuestion());
			pstmt.setString(2, plbean.getSdate());
			pstmt.setString(3, plbean.getEdate());
			pstmt.setInt(4, plbean.getType());
			int cnt = pstmt.executeUpdate();
			pstmt.close();
			if(cnt == 1) {
				sql="insert tblpollitem values(?,?,?,0)";
				pstmt = con.prepareStatement(sql);
				int listNum = getMaxNum();
				String item[] = pibean.getItem();
				for (int i = 0; i < item.length; i++) {
					if(item[i]==null||item[i].trim().equals("")) {
						break;
					}
					pstmt.setInt(1, listNum);
					pstmt.setInt(2, i);
					pstmt.setString(3, item[i]);
					if(pstmt.executeUpdate()==1) flag= true;
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Poll list
	public Vector<PollListBean> getPollList () {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollListBean> vlist = new Vector<PollListBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblpolllist order by num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) { 
				PollListBean plbean = new PollListBean();
				plbean.setNum(rs.getInt("num"));
				plbean.setQuestion(rs.getString("question"));
				plbean.setSdate(rs.getString("sdate"));
				plbean.setEdate(rs.getString("edate"));
				vlist.addElement(plbean);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//PollRead
	public PollListBean getPoll(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PollListBean plbean = new PollListBean();
		try {
			con = pool.getConnection();
			sql = "select num, question, type, active "
					+ "from tblpolllist where num = ?";
			pstmt = con.prepareStatement(sql);
			if(num==0)
				num = getMaxNum();
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				plbean.setNum(rs.getInt("num"));
				plbean.setQuestion(rs.getString("question"));
				plbean.setType(rs.getInt("type"));
				plbean.setActive(rs.getInt("active"));
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return plbean;
	}
	
	//Poll item List
	public Vector<String> getItemList (int listNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> vlist = new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "select item from tblpollitem where listnum = ?";
			pstmt = con.prepareStatement(sql);
			if(listNum==0)
				listNum = getMaxNum();
			pstmt.setInt(1, listNum);
			rs = pstmt.executeQuery();
			while(rs.next()) { 
				vlist.addElement(rs.getString(1));
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//Count Sum : 설문 투표수
	public int sumCount (int listNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int sumCnt = 0;
		try {
			con = pool.getConnection();
			sql = "select sum(count) from tblpollitem where listnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, listNum==0?getMaxNum():listNum);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				sumCnt = rs.getInt(1);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return sumCnt;
	}
	
	//Poll Update : 투표실행
	public boolean updatePoll (int listNum, String itemNum[]) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblpollitem set count = count+1 where listnum = ? and itemnum=?";
			pstmt = con.prepareStatement(sql);
			if(listNum==0)
				listNum = getMaxNum();
			for (int i = 0; i < itemNum.length; i++) {
				pstmt.setInt(1, listNum);
				pstmt.setInt(2, Integer.parseInt(itemNum[i]));
				if(pstmt.executeUpdate()==1)
					flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//Poll View
	public Vector<PollItemBean> getView (int listNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollItemBean> vlist = new Vector<PollItemBean>();
		try {
			con = pool.getConnection();
			sql = "select item,count from tblpollitem where listnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, listNum==0?getMaxNum():listNum);
			rs = pstmt.executeQuery();
			while(rs.next()) { 
				PollItemBean pibean = new PollItemBean();
				String item[] = new String[1];
				item[0]=rs.getString(1);
				pibean.setItem(item);
				pibean.setCount(rs.getInt("count"));
				vlist.addElement(pibean);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Max Item Count : 아이템중에 가장 투표가 높은값
	public int getMaxCount(int listNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxCnt = 0;
		try {
			con = pool.getConnection();
			sql = "select max(count) from tblpollitem where listnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, listNum==0?getMaxNum():listNum);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				maxCnt = rs.getInt(1);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxCnt;
	}
}
