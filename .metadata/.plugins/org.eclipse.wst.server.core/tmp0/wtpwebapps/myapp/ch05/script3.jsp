<%@page import="ch05.MUtil" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
		for(int i = 0; i<10; i++){
			out.println("<font color ="+MUtil.randomColor()+">");
			out.println("모레는 즐거운 토요일<p>");
			out.println("</font>");
		}
%>