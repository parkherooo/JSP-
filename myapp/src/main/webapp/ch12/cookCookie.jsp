<%@ page contentType="text/html; charset=UTF-8"%>
<%
	//서버에서 쿠키에 저장된 값을 만든다.
	String cookieName = "myCookie";

	//쿠키를 생성
	Cookie cookie = new Cookie(cookieName,"Apple");
	cookie.setMaxAge(60); //1분
	cookie.setValue("Melone"); //쿠키값 수정
	
	//생성된 쿠키는 클라이언트로 전송
	response.addCookie(cookie);
	
%>
쿠키를 만들었습니다.<br>
쿠키 내용은 <a href="taseteCookie.jsp">여기로~</a>