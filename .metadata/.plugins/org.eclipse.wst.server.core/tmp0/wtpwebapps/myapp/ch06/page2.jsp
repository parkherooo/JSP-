<%@ page contentType="text/html; charset=UTF-8"
					import = "java.util.*, java.net.*"
%>
<%
		Date d = new Date();
%>
현재의 날짜와 시간은?<%=d.toLocaleString() %>