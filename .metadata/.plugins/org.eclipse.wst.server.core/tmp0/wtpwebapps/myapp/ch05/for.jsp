<%@ page contentType="text/html; charset=UTF-8"%>
<%
		String subject[] = {"Java","JSP","Flutter","Python","Spring"};
%>
<!-- 표현식 -->
<table border = "1">
	<tr>
		<th>번호</th>
		<th>과목</th>
	</tr>
	<%for(int i =0; i < subject.length; i++){ %>
	<tr>
		<td><%=i+1 %></td>
		<td><%=subject[i]%></td>
	</tr>
	<%} %>
</table><p>

<!-- out.println 형식 -->
<table border = "1">
	<tr>
		<th>번호</th>
		<th>과목</th>
	</tr>
	<%for(int i =0; i < subject.length; i++){ 
				out.println("<tr>");
				out.println("<td>"+(i+1)+"</td>");
				out.println("<td>"+subject[i]+"</td>");
				out.println("</tr>");
			}
	%>


</table><p>