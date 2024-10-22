<%@ page contentType="text/html; charset=UTF-8"%>
<%
		String bloodType = request.getParameter("bloodType");
		String name = "홍길동";
%>
<!-- 표현식에서 ""값이 필요하면 "으로 시작한다.-->
<jsp:include page='<%=bloodType+".jsp"%>'>
	<jsp:param value="<%=name %>" name="name"/>
</jsp:include>