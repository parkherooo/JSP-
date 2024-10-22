<%@page import="ch13.FileloadBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class = "ch13.FileloadMgr"/>
<%
	Vector<FileloadBean> vlist = mgr.listFile();

%>
<head>
	<script>
		
		function checkAll(){
			const checkBoxs = document.querySelectorAll(".checkBox");
			const allCheckBox = document.querySelector("#allCheckBox");
			for(i = 0 ; i < checkBoxs.length ; i++){
				if(allCheckBox.checked == true){
					checkBoxs[i].checked = true;
				}
				else{
					checkBoxs[i].checked = false;
				}
			}
		}

		function check(){
			const checkBoxs = document.querySelectorAll(".checkBox");
			const allCheckBox = document.querySelector("#allCheckBox");
			const delBtn = document.getElementById("delBtn");
			let flag = false;
			for(i = 0 ; i < checkBoxs.length ; i++){
				if(checkBoxs[i].checked == true){
					flag = true;
					delBtn.disabled = false;
				}
			}
			if(!flag){
				allCheckBox.checked = false;
				delBtn.disabled = true;
			}
		}
	</script>
	<style>
		body{
			display:flex;
			flex-direction : column;
			justify-content :center;
			align-items:center;
		}
		td{
			text-align : center;
		}
	</style>
</head>
<body>
<h1>File List2</h1>
<table border = 1>
	<tr>
		<th><input onchange ="checkAll()" type="checkbox" id ="allCheckBox"></th>
		<th>순번</th>
		<th>파일명</th>
		<th>파일크기</th>
	</tr>
<%
	for(int i = 0; i<vlist.size() ; i++){
		FileloadBean bean = vlist.get(i);
%>
	<tr>
		<td><input type="checkbox" onchange ="check()" class ="checkBox" id ="checkBox<%=bean.getNum()%>"></td>
		<td><%=i+1 %></td>
		<td><%=bean.getUpFile() %></td>
		<td><%=bean.getSize() %></td>
	</tr>
<%}%>
	<tr>
		<td style = "display:flex" colspan = 4>
			<button id ="delBtn" disabled>Delete</button>
		</td>
	</tr>
</table>
</body>