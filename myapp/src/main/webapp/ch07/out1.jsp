<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page buffer="5kb" %>
<%
	int totalBuffer = out.getBufferSize();
	int remainBuffer = out.getRemaining();
	int useBuffer = totalBuffer =remainBuffer;
	out.println("출력 버퍼의 크기"+ totalBuffer +"bytes<br>");
	out.println("남은 버퍼의 크기"+ remainBuffer +"bytes<br>");
	out.println("사용 버퍼의 크기"+ useBuffer +"bytes<br>");
	
	String sub[] = {"Java","JSP","Flutter","Spring"};
	for(int i=0; i<sub.length; i++){
		out.println(sub[i]+"<br>");
	}
%>
<hr>
<%for(int i=0; i<sub.length; i++){%>
<%=sub[i]%><br>
<%}%>