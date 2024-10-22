<%@ page contentType="text/html; charset=UTF-8"%>
<%
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
%>
<!-- 이 페이지가 클라이언트로 응답(response) -->
id : <%=id%><br>
pwd : <%=pwd%><br>