<%@page import="ch09.SimpleBean"%>
<%@page import="ch09.MUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="bean" class="ch09.SimpleBean"/>
<%-- <jsp:setProperty property="msg" name="bean"/>
<jsp:setProperty property="cnt" name="bean"/> --%>
<!-- 위 두줄을 *로 전체 설정 -->
<jsp:setProperty property="*" name="bean"/>
<%
	//SimpleBean bean = new SimpleBean();
	/* String msg = request.getParameter("msg");
	int cnt = MUtil.paresInt(request, "cnt");
	
	bean.setMsg(msg);
	bean.setCnt(cnt);
	 */
%>
msg : <%=bean.getMsg()%><br>
cnt : <%=bean.getCnt()%><br>
<hr>
msg : <jsp:getProperty property="msg" name="bean"/><br>
cnt : <jsp:getProperty property="cnt" name="bean"/><br>