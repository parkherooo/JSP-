<%@ page contentType="text/html; charset=UTF-8"%>
<%
		String siteName = request.getParameter("siteName");
%>
요청한 사이트명 : <%=siteName %>
<jsp:include page="includeTagTop2.jsp">
	<jsp:param value="aaa" name="id"/>
	<jsp:param value="1234" name="pwd"/>
</jsp:include>
