<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String season = request.getParameter("season");
	String fruit = request.getParameter("fruit");
	
	//세션에 id를 가지고 옴.
	String id = (String)session.getAttribute("idKey");
	int intervealTime = session.getMaxInactiveInterval();
	
	if(id!=null){
%>
<b><%=id%></b>님이 좋아하는 계절과 과일은<p>
<b><%=season%></b>과 <b><%=fruit%></b>입니다.<p>
세션 ID : <%=session.getId()%>><br>
세션 유지 시간 : <%=intervealTime %>sec
<%}else{%>
	세션의 시간이 경과하였거나 다른이유로 연결을 지속할 수 없습니다.
<%}%>