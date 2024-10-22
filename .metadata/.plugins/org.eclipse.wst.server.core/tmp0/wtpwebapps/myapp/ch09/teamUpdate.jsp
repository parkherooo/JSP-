<%@page import="ch09.TeamBean"%>
<%@page import="ch09.MUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="ch09.TeamMgr"/>
<%
	int num = 0;
	if(request.getParameter("num")==null){
		//num 값이 넘어오지않음
		response.sendRedirect("teamList.jsp");
		return;
	} 
	num = MUtil.parseInt(request, "num");
	TeamBean bean = mgr.getTeam(num);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Team Mgr</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function update() {
		document.frm.action = "teamUpdate";
		document.frm.submit();
	}
</script>
</head>
<body>
<div align="center">
<h1>Team Update</h1>
<form name="frm" method="post" action="teamUpdateProc.jsp">
<table border="1">
<tr>
	<td width="50" align="center">번호</td>
	<td width="150">
		<input name="num" value="<%=num%>" readonly>
	</td>
</tr>
<tr>
	<td width="50" align="center">이름</td>
	<td width="150"><input name="name" value="<%=bean.getName()%>"></td>
</tr>
<tr>
	<td align="center">사는곳</td>
	<td><input name="city" value="<%=bean.getCity()%>"></td>
</tr>
<tr>
	<td align="center">나이</td>
	<td ><input name="age" value="<%=bean.getAge()%>"></td>
</tr>
<tr>
	<td align="center">팀명</td>
	<td><input name="team" value="<%=bean.getTeam()%>"></td>
</tr>
<tr>
	<td align="center" colspan="2">
		<input type="submit" value="UPDATE">
		<input type="button" value="UPDATE2" onclick="update()">
	</td>
</tr>
</table>
</form><p>
<a href="teamRead.jsp?num=<%=num%>">READ</a>
</div>
</body>
</html>