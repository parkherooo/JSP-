<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="cMgr" class="shop.CartMgr"/>
<jsp:useBean id="order" class="shop.OrderBean"/>
<jsp:setProperty property="*" name="order"/>
<%
	String id = (String)session.getAttribute("idKey");
	if(id==null){
		response.sendRedirect("login.jsp");
		return;
	}
	order.setId(id);
	String flag = request.getParameter("flag");
	String msg = null;
	if(flag.equals("insert")){
		msg = "장바구니에 저장하였습니다.";
		cMgr.addCart(order);
	} else if(flag.equals("update")){
		msg = "장바구니를 수정하였습니다.";
		cMgr.updateCart(order);
	} else if(flag.equals("delete")){
		msg = "장바구니를 삭제하였습니다.";
		cMgr.deleteCart(order);
	}
%>
<script>
	alert("<%=msg%>");
	window.location.href = "cartList.jsp";
</script>