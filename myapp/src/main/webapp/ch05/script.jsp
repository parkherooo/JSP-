<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 선언문(Declaration) -->
<%! 
    // 필드 선언
    String dec = "선언문 변수";
    
    // 메소드 선언
    public String decMethod() {
        return dec;
    }
%>
<!-- 스크립트릿(Scriptlet) -->
aaa
<%
    // 스크립트릿에서 변수 선언
    String scriptlet = "스크립트릿";
    out.println("내장 객체를 이용한 출력 :" + dec + "<p>");
    out.println("스크립트릿1 : " + scriptlet + "<p>");
%>
<!-- 표현식(Expression) : 자바코드지만 ; 이 없음 -->
선언문1 : <%=dec%><br>
선언문2 : <%=decMethod()%><br>
<!-- JSP 주석 -->
<%-- JSP 주석1 : <%=comment%> --%>
<%-- JSP 주석 2 : <%=comment%> --%>
<%
		/*부분 및 여러줄 주석*/
		//한줄 주석
%>
