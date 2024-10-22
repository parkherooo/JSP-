<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	//업로드 파일 저장 위치
	final String SAVEFLODER = "C:/JSP/myapp/src/main/webapp/ch13/storage/";
	//업로드 파일명 인코딩 
	final String ENCODING = "UTF-8";
	//업로드 파일 크기 제한
	final int MAXSIZE = 1024*1024*50; //50MB
	try{
		//DefaultFileRenamePolicy : 중복파일 자동으로 index 번호만듬
		//MultipartRequest 객체 생성 시점에 파일은 업로드 완료
		//request는 빈값
		MultipartRequest multi = new MultipartRequest(request,
				SAVEFLODER,MAXSIZE,ENCODING, new DefaultFileRenamePolicy());
		
		String user = multi.getParameter("user");
		String title = multi.getParameter("title");
		//파일정보
		String fileName = multi.getFilesystemName("myfile");
		String fileType = multi.getContentType("myfile");
		File f = multi.getFile("myfile");
		long len = 0;
		if(f!=null){
			len = f.length();
		}
		out.println("user : " + user + "<br>");
		out.println("title : " + title + "<br>");
		out.println("파일명 : " + fileName + "<br>");
		out.println("파일타입 : " + fileType + "<br>");
		out.println("파일크기 : " + len + "<br>");
		
	} catch(Exception e){
		e.printStackTrace();
	}
%>