<%@page import="ch07.MUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	//requset 메소드 리스트
	String protocol = request.getProtocol();
	int port = request.getServerPort();
	//ip값
	String remodeAddr = request.getRemoteAddr();
	String method = request.getMethod();
	String uri = request.getRequestURI();
	StringBuffer url = request.getRequestURL();
	String qurey = request.getQueryString();
	//정수 타입으로 매개변수 변환
	int age = Integer.parseInt(request.getParameter("age"));
	int age2 = MUtil.paresInt(request, "age");
%>
protocol : <%=protocol%><br>
port : <%=port%><br>
remodeAddr : <%=remodeAddr%><br>
method : <%=method%><br>
uri : <%=uri%><br>
url : <%=url%><br>
qurey : <%=qurey%><br>
age : <%=age%><br>
age2 : <%=age2%><br>


