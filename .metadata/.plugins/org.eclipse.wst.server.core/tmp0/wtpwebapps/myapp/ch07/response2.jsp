<%@ page contentType="text/html; charset=UTF-8"%>
<%
	response.setHeader("Cache-Control","no-store");  
	response.setHeader("Pragma","no-cache");  
	response.setDateHeader("Expires",0);  
	if (request.getProtocol().equals("HTTP/1.1"))        
		response.setHeader("Cache-Control", "no-cache");
	
	//http1.0, 1.1 통합
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>