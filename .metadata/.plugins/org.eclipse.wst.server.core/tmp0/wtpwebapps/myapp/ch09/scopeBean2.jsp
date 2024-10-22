<%@page import="org.apache.tomcat.util.openssl.SSL_CTX_set_verify$callback"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	//세션에 특정한 값만 제거
	session.removeAttribute("sbean");
	//세셔느이 전체 무효화, 초기화, 제거
	session.invalidate();
	response.sendRedirect("scopeBean.jsp");
%>