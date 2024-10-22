package ch19;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class PBlogMgr {
	private DBConnectionMgr pool;
	public static final String  SAVEFOLDER = "C:/Jsp/myapp/src/main/webapp/ch19/photo/";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 50*1024*1024;

	public PBlogMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//Random List - 자신을 제외한 5명의 리스트
	public Vector<PMemberBean> listPMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PMemberBean> vlist = new Vector<PMemberBean>();
		try {
			con = pool.getConnection();
			sql = "select id,name,profile from tblpmember where id != ? order by rand() limit 5";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) { 
				PMemberBean bean = new PMemberBean();
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setProfile(rs.getString("profile"));
				vlist.addElement(bean);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//PBlog Insert 
	public void insertPBlog (HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		MultipartRequest multi = null;
		String photo = null;
		try {
			con = pool.getConnection();
			sql = "insert into tblpblog (message,id,pdate,photo,hcnt) values(?,?,now(),?,0)";
			pstmt = con.prepareStatement(sql);
			multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());
			if(multi.getFilesystemName("photo")!=null)
				photo = multi.getFilesystemName("photo");
			pstmt.setString(1, multi.getParameter("message"));
			pstmt.setString(2, multi.getParameter("id"));
			pstmt.setString(3, photo);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//HCnt Up
	public void upHCnt(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblpblog set hcnt=hcnt+1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//PBlog Delete
	public void deletePBlog (int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			String photo = getPhoto(num);
			if(photo!=null) {
				File f = new File(SAVEFOLDER+photo);
				if(f.exists()) {
					f.delete();
				}
			}
			con = pool.getConnection();
			sql = "delete from tblpblog where num =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			if(pstmt.executeUpdate()==1) {
				PReplyMgr rmgr = new PReplyMgr();
				rmgr.deleteAllPReply(num);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//PBlog Get Photo
	public String getPhoto(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String photo =null;
		try {
			con = pool.getConnection();
			sql = "select photo from tblpblog where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				photo = rs.getString(1);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return photo;
	}
	
	
	//PBlog List
	public Vector<PBlogBean> listPBlog(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PBlogBean> vlist = new Vector<PBlogBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblpblog where id = ? order by num desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) { 
				PBlogBean bean = new PBlogBean();
				bean.setNum(rs.getInt(1));
				bean.setMessage(rs.getString(2));
				bean.setId(rs.getString(3));
				bean.setPdate(rs.getString(4));
				bean.setPhoto(rs.getString(5));
				bean.setHcnt(rs.getInt(6));
				vlist.addElement(bean);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

}
