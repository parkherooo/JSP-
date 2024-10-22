<%@ page contentType="text/html; charset=UTF-8"%>
<%@page session="true" %>
<%
		String sessionId = session.getId();
		session.setMaxInactiveInterval(30); //30초

%>
최초 접속시 제공되는 세션ID 값 : <%=sessionId%>