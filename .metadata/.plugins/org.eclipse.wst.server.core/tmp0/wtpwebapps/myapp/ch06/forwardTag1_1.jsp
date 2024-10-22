<%@ page contentType="text/html; charset=UTF-8"%>
<%
		//forward 액션태그는 Controll 역할
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
%>
id : <%=id %> / pwd : <%=pwd %>
<jsp:forward page="forwardTag1_2.jsp"/>