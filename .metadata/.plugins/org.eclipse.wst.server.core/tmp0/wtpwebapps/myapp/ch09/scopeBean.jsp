<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="pbean" scope="page" class="ch09.ScopeBean"/>
<jsp:useBean id="sbean" scope="session" class="ch09.ScopeBean"/>
<jsp:setProperty property="num" name="pbean" value="<%=pbean.getNum()+10 %>"/>
<jsp:setProperty property="num" name="sbean" value="<%=sbean.getNum()+10 %>"/>
<%
	//세션이 종료되거나 없어지지 않는 한 재사용
	session.setAttribute("sbean", sbean);
%>
<h2>Scope Bean</h2>
pbean num 값 : <jsp:getProperty property="num" name="pbean"/><br>
sbean num 값 : <jsp:getProperty property="num" name="sbean"/><br>
<a href="scopeBean2.jsp">세션종료</a>