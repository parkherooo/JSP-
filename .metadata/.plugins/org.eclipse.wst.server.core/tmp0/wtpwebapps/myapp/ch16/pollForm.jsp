<%@page import="java.util.Vector"%>
<%@page import="ch16.PollItemBean"%>
<%@page import="ch16.PollListBean"%>
<%@page import="ch16.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="ch16.PollMgr"/>
<%
	int num=0;
	if(request.getParameter("num")!=null){
		num = UtilMgr.parseInt(request, "num");
	}
	PollListBean plbean = mgr.getPoll(num);
	Vector<String>vItem = mgr.getItemList(num);
	String question = plbean.getQuestion();
	int type = plbean.getType();
	int active = plbean.getActive();
	int sumCount = mgr.sumCount(num); //총 투표수
	
%>
<form action="pollFormProc.jsp"> 
<table border="1">
	<tr>
		<td colspan="2" width="300">
			Q : <%=question%> <font color="blue">(<%=UtilMgr.intFormat(sumCount)%>)</font>
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<%
				for(int i=0;i<vItem.size();i++){
					String item = vItem.get(i);
		%>
		<%if(type==1){%>
			<input type="checkbox" name="itemnum" value="<%=i%>">
		<%} else {%>
			<input type="radio" name="itemnum" value="<%=i%>">
		<%}//--if-else %>
		<%=item %><br>
		<%} //--for%>
		</td>
	</tr>
	<tr>
		<td width="150">
		<%if(active==1){ %>
		<input type="submit" value="투표">
		<%} else{%>
			투표종료
		<%} %>
		</td>
		<td>
			<input type="button" value="결과" 
			onclick="javascript:window.open('pollView.jsp?num=<%=num%>'
			,'pollView','width=500, height=350')">
		</td>
	</tr>
</table>	
<input type="hidden" name="num" value="<%=num%>">
</form>
