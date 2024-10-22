<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="ch14.MemberMgr"/>
<jsp:useBean id="bean" class="ch14.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>
<%	

	boolean result = mgr.updateMember(bean);

	String msg = "수정실패";
	String url = "memberUpdate.jsp";
	if(result){
		msg = "수정성공";
		url = "login.jsp";
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>