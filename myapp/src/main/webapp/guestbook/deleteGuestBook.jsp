<%@page import="guestbook.MUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="guestbook.GuestBookMgr"/>
<jsp:useBean id="cmgr" class="guestbook.CommentMgr"/>
<%
	String method = request.getMethod();
	//System.out.println("method"+method);
	int num = 0;
	if(request.getParameter("num")!=null&&method.equalsIgnoreCase("POST")){
		num=MUtil.parseInt(request, "num");
		mgr.deleteGuestBook(num);
		//방명록 원글 삭제시 관련된 댓글도 모두 삭제
		cmgr.deleteAllComment(num);
	}
	response.sendRedirect("showGuestBook.jsp");
%>