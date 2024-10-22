<%@page import="ch09.SimpleBean"%>
<%@page import="ch09.MUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String msg = request.getParameter("msg");
	//int cnt = MUtil.paresInt(request, "cnt");
	SimpleBean bean = new SimpleBean();
	bean.setMsg(msg);
	//bean.setCnt(cnt);
	
%>
msg : <%=bean.getMsg()%><br>
cnt : <%=bean.getCnt()%><br>