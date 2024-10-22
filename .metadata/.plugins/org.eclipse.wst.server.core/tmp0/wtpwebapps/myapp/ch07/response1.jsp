<%@ page contentType="text/html; charset=UTF-8"%>
<!-- javascript에서 location.href 는 클라이언트에서 지정한 페이ㅣ 요청-->
<%
	response.sendRedirect("response2.jsp");
%>
<!-- 브라우저에서 실행 -->
<script>
	alert("go");
	location.href = "response2.jsp";
</script>