package ch13;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileloadMgr {
	
	//업로드 파일 저장 위치
	public final static String SAVEFOLDER = "C:/JSP/myapp/src/main/webapp/ch13/storage/";
	//업로드 파일명 인코딩 
	final static String ENCODING = "UTF-8";
	//업로드 파일 크기 제한
	final static int MAXSIZE = 1024*1024*50; //50MB
	
	private DBConnectionMgr pool;
	
	public FileloadMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//file upload
	//HttpServletRequest :bean 아니고 MultipartRequest 매개변수
	public void uploadFile (HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			//파일 업로드
			MultipartRequest multi = new MultipartRequest(req,
					SAVEFOLDER,MAXSIZE,ENCODING, new DefaultFileRenamePolicy());
			String upFile = multi.getFilesystemName("upFile");
			File f = multi.getFile("upFile");
			long size = f.length();
			//테이블저장
			con = pool.getConnection();
			sql = "insert into tblFileload(upFile,size) values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, upFile);
			pstmt.setLong(2, size);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//file list
	public Vector<FileloadBean> listFile() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FileloadBean>vlist = new Vector<FileloadBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblFileload";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) { 
				FileloadBean bean = new FileloadBean();
				bean.setNum(rs.getInt(1));
				bean.setUpFile(rs.getString(2));
				bean.setSize(rs.getInt(3));
				vlist.addElement(bean);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//file delete 
	public void deleteFile (int num[]) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			for (int i = 0; i < num.length; i++) {
				String upFile = getFile(num[i]);
				File f = new File(SAVEFOLDER+upFile);
				if(f.exists()) //파일이 존재한다면
					f.delete(); //파일삭제
				sql = "delete from tblfileload where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num[i]);
				pstmt.executeUpdate();
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}

	}

	//file information
	public String getFile (int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String upFile = null;
		try {
			con = pool.getConnection();
			sql = "select upFile from tblFileload where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				upFile = rs.getString(1);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return upFile;
	}
	public void deleteFile2 (int num[]) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			for (int i = 0; i < num.length; i++) {
				String upFile = getFile(num[i]);
				File f = new File(SAVEFOLDER+upFile);
				if(f.exists()) //파일이 존재한다면
					f.delete(); //파일삭제
			}
			//num in (?,?,?)
			con = pool.getConnection();
			sql = "delete from tblfileload where num in ("+UtilMgr.ph(num.length)+")";
			pstmt = con.prepareStatement(sql);
			for (int j = 0; j < num.length; j++) {
				pstmt.setInt(j+1, num[j]); //num in ()
			}		
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
