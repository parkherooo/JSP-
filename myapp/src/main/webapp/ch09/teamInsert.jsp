<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="ch09.TeamMgr"/>
<%	
	Vector<String> vlist = mgr.teamList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Team Mgr</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function check() {
		f = document.frm;
		if(f.name.value==""){
			alert("이름 입력하세요");
			f.name.focus();
			return;//함수 빠져나옴
		}
		if(f.city.value==""){
			alert("사는곳 입력하세요");
			f.city.focus();
			return;//함수 빠져나옴
		}
		if(f.age.value==""){
			alert("나이 입력하세요");
			f.age.focus();
			return;//함수 빠져나옴
		}
		if(f.team.value==""){
			alert("팀 입력하세요");
			f.team.focus();
			return;//함수 빠져나옴
		}
		f.submit();//제출
	}

	function check2() {
		document.frm.action = "teamInsertProc2.jsp";
		document.frm.submit();
	}
	function selectTeam(){
		document.frm.team.value = team;
	}
	function selectTeam1() {
		teamselect = document.getElementById("teamselect");
		team = teamselect.options[teamselect.selectedIndex].value;  
		document.frm.team.value = team;
	}
	
</script>
</head>
<body>
<div align="center">
<h1>Team Insert</h1>
<form name="frm" method="post" action="teamInsertProc.jsp">
<table border="1">
<tr>
	<td width="50" align="center">이름</td>
	<td width="150"><input name="name" value="홍길동"></td>
</tr>
<tr>
	<td align="center">사는곳</td>
	<td><input name="city" value="부산"></td>
</tr>
<tr>
	<td align="center">나이</td>
	<td ><input name="age" value="27"></td>
</tr>
<tr>
	<td align="center">팀명</td>
	<td>
		<input name="team" size="10">
		<select id = "teamselect" onchange="selectTeam1()">
		<option>팀을 선택하세요</option>
		<%for(int i = 0; i<vlist.size(); i++){%>
		<option value="<%=vlist.get(i)%>">
		<%=vlist.get(i) %></option>
		<%}%>
		</select>
	</td>
</tr>
<tr>
	<td align="center" colspan="2">
		<input type="button" value="SAVE" onclick="check()">
		<input type="button" value="SAVE2" onclick="check2()">
	</td>
</tr>
</table>
</form><p>
<a href="teamList.jsp">LIST</a>
</div>
</body>
</html>