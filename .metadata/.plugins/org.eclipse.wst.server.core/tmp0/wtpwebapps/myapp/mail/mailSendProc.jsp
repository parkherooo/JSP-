<!-- mailSendProc.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mail.MailSend"/>
<%
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		boolean result = mgr.sendPwd(id, email);
		String msg = "전송실패";
		if(result){
			msg = "전송성공";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "mailSend.jsp";
</script>
