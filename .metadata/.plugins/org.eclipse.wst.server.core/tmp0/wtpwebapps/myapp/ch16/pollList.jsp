<%@page import="org.w3c.dom.html.HTMLQuoteElement"%>
<%@page import="ch16.PollListBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="ch16.PollMgr"/>
<%
		
%>
<!DOCTYPE html>
<html>
<head>
<title>JSP Poll</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
<div align="center">
<h2>Poll Program</h2>
<hr width="60%">
<!-- include 태그 : 요청정보도 같이 넘어간다. -->
<jsp:include page="pollForm.jsp"/>
<b>설문 리스트</b>
<table>
	<tr>
		<td>
		<table  border="1">
			<tr>
				<th width="50">번호</th>
				<th width="250" align="left">질문</th>
				<th width="200">시작일~종료일</th>
			</tr>
			<% 
				Vector<PollListBean> vlist = mgr.getPollList();
				for(int i=0; i<vlist.size(); i++){
					PollListBean plbean = vlist.get(i);
					int num = plbean.getNum();
					String question = plbean.getQuestion();
					String sdate = plbean.getSdate();
					String edate = plbean.getEdate();
			%>
			<tr align="center">
				<td ><%=vlist.size()-i %></td>
				<td align="left">
					<a href="pollList.jsp?num=<%=num %>">
					<%=question %>
					</a>
				</td>
				<td><%=sdate+"~"+edate %></td>
			</tr>
			<%} //--for%>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="pollInsert.jsp">설문작성하기</a>
		</td>
	</tr>
</table>
</div>
</body>
</html>