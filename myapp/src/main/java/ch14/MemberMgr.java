package ch14;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import ch09.DBConnectionMgr;

public class MemberMgr {
	private DBConnectionMgr pool;
	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	public boolean loginMember(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from tblmember where id = ? and pwd = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				flag =true;
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//id 중복체크
	public boolean CheckID(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from tblmember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				flag = true;
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//주소검색
	public Vector<ZipcodeBean> searchZipcode(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean>vlist = new Vector<ZipcodeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblZipcode where area3 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+area3+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) { 
				vlist.addElement(new ZipcodeBean(
						rs.getString(1), 
						rs.getString(2), 
						rs.getString(3), 
						rs.getString(4)));
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//회원가입
	public boolean insertMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblMember values (?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getGender());
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getZipcode());
			pstmt.setString(8, bean.getAddress());
			String lists[] = { "인터넷", "여행", "게임", "영화", "운동" };
			String hobby[] = bean.getHobby(); //{"인터넷","게임"}
			char hb[] = {'0','0','0','0','0'};
			for(int i=0; i<hobby.length; i++) {
				for (int j = 0; j < lists.length; j++) {
					if(hobby[i].equals(lists[j])) {
						hb[j] = '1';
						break;
					}
				}
			}
			pstmt.setString(9, new String(hb));
			pstmt.setString(10, bean.getJob());
			if(pstmt.executeUpdate()==1)
				flag = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//회원정보가져오기
	public MemberBean getMember (String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblmember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				bean.setId(rs.getString(1));
				bean.setPwd(rs.getString(2));
				bean.setName(rs.getString(3));
				bean.setGender(rs.getString(4));
				bean.setBirthday(rs.getString(5));
				bean.setEmail(rs.getString(6));
				bean.setZipcode(rs.getString(7));
				bean.setAddress(rs.getString(8));
				String hobby = rs.getString(9);
				String hb[] = new String[hobby.length()];
				for (int i = 0; i < hb.length; i++) {
					hb[i] = hobby.substring(i,i+1);
				}//01010->{"0","1","0","1","0"}
				bean.setHobby(hb);
				bean.setJob(rs.getString(10));
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//회원수정
	public boolean updateMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblmember "
					+ "set pwd = ?, name = ?, gender = ?, "
					+ "birthday = ?, email = ?, zipcode = ?, "
					+ "address = ?, hobby = ?, job = ? "
					+ "where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getGender());
			pstmt.setString(4, bean.getBirthday());
			pstmt.setString(5, bean.getEmail());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());
			String lists[] = { "인터넷", "여행", "게임", "영화", "운동" };
			String hobby[] = bean.getHobby(); //{"인터넷","게임"}
			char hb[] = {'0','0','0','0','0'};
			for(int i=0; i<hobby.length; i++) {
				for (int j = 0; j < lists.length; j++) {
					if(hobby[i].equals(lists[j])) {
						hb[j] = '1';
						break;
					}
				}
			}
			pstmt.setString(8, new String(hb));
			pstmt.setString(9, bean.getJob());
			pstmt.setString(10, bean.getId());
			if(pstmt.executeUpdate()==1)
				flag = true;;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
}
