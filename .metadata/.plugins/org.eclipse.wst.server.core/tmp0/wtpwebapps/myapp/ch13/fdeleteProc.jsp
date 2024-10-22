<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="ch13.FileloadMgr"></jsp:useBean>
<%
	String snum[] = request.getParameterValues("fch");
	int num[] = new int[snum.length];
	for(int i=0; i<num.length; i++){
		num[i] = Integer.parseInt(snum[i]);
	}
	mgr.deleteFile2(num);
	response.sendRedirect("flist.jsp");
%>