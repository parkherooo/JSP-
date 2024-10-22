<%@page import="java.util.Vector"%>
<%@page import="ch15.BCommentBean"%>
<%@page import="ch15.BoardBean"%>
<%@page import="ch15.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="ch15.BoardMgr"/>
<jsp:useBean id="cmgr" class="ch15.BCommentMgr"/>
<%
	//read.jsp?num=3&nowPage=1&numPerPage=10&keyField=name&keyWord=aaa
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	int num = UtilMgr.parseInt(request, "num");
	
	String flag = request.getParameter("flag");
	if(flag!=null){
		if(flag.equals("insert")){
			BCommentBean cbean = new BCommentBean();
			cbean.setNum(num);
			cbean.setName(request.getParameter("cName"));
			cbean.setComment(request.getParameter("comment"));
			cmgr.insertBComment(cbean);
		} else if(flag.equals("delete")){
			int cnum =UtilMgr.parseInt(request, "cnum");
			cmgr.deleteBComment(cnum);
			
		}
	} else{
		//조회수 증가
		mgr.upCount(num);
	}
	//게시물 가져옴
	BoardBean bean = mgr.getBoard(num);
	//bean객체를 session에 저장
	session.setAttribute("bean", bean);
	
	String name = bean.getName();
	String subject = bean.getSubject();
	String regdate = bean.getRegdate();
	String content = bean.getContent();
	String filename = bean.getFilename();
	int filesize = bean.getFilesize();
	String ip = bean.getIp();
	int count = bean.getCount();
%>
<!DOCTYPE html>
<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function down(filename) {
		document.downFrm.filename.value = filename;
		document.downFrm.submit();
	}
	function list() {
		document.listFrm.action = "list.jsp";
		document.listFrm.submit();
	}
	function delFn() {
		const pass = document.getElementById("passId");
		//alert(pass.value);
		if(pass.value.length==0){
			alert("비밀번호를 입력하세요");
			return;
		}
		document.delFrm.pass.value = pass.value;
		document.delFrm.submit();
	}
	function cInsert() {
		if(document.cFrm.comment.value==""){
			alert("댓글을 입력하세요.");
			document.cFrm.comment.focus();
			return;
		}
		document.cFrm.submit();
	}

	function cDel(cnum) {
		document.cFrm.cnum.value=cnum;
		document.cFrm.flag.value="delete";
		document.cFrm.submit();
	}
	function delBFn(index) {
	    if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
	        document.forms['delCommentForm' + index].submit();
	    }
	}
</script>
</head>
<body bgcolor="#FFFFCC">
<br/><br/>
<table align="center" width="600" cellspacing="3">
 <tr>
  <td bgcolor="#9CA2EE" height="25" align="center">글읽기</td>
 </tr>
 <tr>
  <td colspan="2">
   <table cellpadding="3" cellspacing="0" width="100%"> 
    <tr> 
  <td align="center" bgcolor="#DDDDDD" width="10%"> 이 름 </td>
  <td bgcolor="#FFFFE8"><%=name%></td>
  <td align="center" bgcolor="#DDDDDD" width="10%"> 등록날짜 </td>
  <td bgcolor="#FFFFE8"><%=regdate%></td>
 </tr>
 <tr> 
    <td align="center" bgcolor="#DDDDDD"> 제 목</td>
    <td bgcolor="#FFFFE8" colspan="3"><%=subject%></td>
   </tr>
   <tr> 
     <td align="center" bgcolor="#DDDDDD">첨부파일</td>
     <td bgcolor="#FFFFE8" colspan="3">
		<%if(filename!=null&&!filename.equals("")) {%>
		<a href="javascript:down('<%=filename%>')">
		<%=filename %></a>
		<font color="blue">(<%=UtilMgr.intFormat(filesize) %>bytes)</font>
		<%} else{out.print("첨부된 파일이 없습니다."); }%>
     </td>
   </tr>
   <tr> 
    <td align="center" bgcolor="#DDDDDD">비밀번호</td>
    <td bgcolor="#FFFFE8" colspan="3">
    	<input type="password" name="pass" id="passId">
    </td>
   </tr>
   <tr> 
    <td colspan="4"><br/><pre><%=content%></pre><br/></td>
   </tr>
   <tr>
    <td colspan="4" align="right">
     IP주소 : <%=ip%> / 조회수  <%=count%>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <!-- 댓글 입력 START -->
 <tr>
 	<td align="center" colspan="2">
 		<form name="cFrm"  method="post" action="bCommentPost">
 		<table>
			<tr  align="center">
				<td width="50">이 름</td>
				<td align="left">
					<input name="cname" size="10" value="aaa">
				</td>
			</tr>
			<tr align="center">
				<td>내 용</td>
				<td>
				<input name="comment" size="50"> 
				<input type="button" value="등록" onclick="cInsert()"></td>
			</tr>
		</table>
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="cnum">
	    <input type="hidden" name="nowPage" value="<%=nowPage%>">
	    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
 		</form>
 	</td>
</tr>
<!-- 댓글 입력 END -->
<%-- <!-- 댓글 입력폼 Start -->
 <form method="post" name="cFrm">
	<table>
		<tr  align="center">
			<td width="50">이 름</td>
			<td align="left">
				<input name="cName" size="10" value="aaa">
			</td>
		</tr>
		<tr align="center">
			<td>내 용</td>
			<td>
			<input name="comment" size="50"> 
			<input type="button" value="등록" onclick="cInsert()"></td>
		</tr>
	</table>
 <input type="hidden" name="flag" value="insert">	
 <input type="hidden" name="num" value="<%=num%>">
 <input type="hidden" name="cnum">
   <input type="hidden" name="nowPage" value="<%=nowPage%>">
   <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
  <%if(!(keyWord==null||keyWord.equals(""))){ %>
   <input type="hidden" name="keyField" value="<%=keyField%>">
   <input type="hidden" name="keyWord" value="<%=keyWord%>">
<%}%>
</form>
  <!-- 댓글 입력폼 End --> --%>
<!-- 댓글 리스트 START -->
<tr>
   <td colspan="2">
       <hr>
   </td>
</tr>
<tr>
   <% Vector<BCommentBean> vlist = cmgr.listBComment(num); 
   	for(int i=0; i<vlist.size(); i++) {
   		BCommentBean Bbean = vlist.get(i);
   		String Bname = Bbean.getName();
   		String Bcomment = Bbean.getComment();
   		String Bregdate = Bbean.getRegdate();
   		int cnum = Bbean.getCnum();
   %>
   <tr>
      <td><b><%= Bname %></b></td>
   </tr>
   <tr>
      <td>댓글 : <%= Bcomment %></td>
      <td><%= Bregdate %></td>
      <td>
         <form name="delCommentForm<%=i%>" method="post" action="bCommentDelete">
            <input type="hidden" name="cnum" value="<%= cnum %>">
            <input type="hidden" name="num" value="<%= num %>">
            <input type="hidden" name="nowPage" value="<%= nowPage %>">
            <input type="hidden" name="numPerPage" value="<%= numPerPage %>">
            <input type="button" value="삭제" onclick="delBFn(<%= i %>)">
         </form>
      </td>
   </tr>
   <tr>
		<td colspan="3" width="600"><b><%=Bname%></b></td>
	</tr>
	<%-- <tr>
		<td>댓글:<%=Bcomment%></td>
		<td align="right"><%=Bregdate%></td>
		<td align="center" valign="middle">
		<input type="button" value="삭제" onclick="cDel('<%=cnum%>')">
		</td>
	</tr> --%>
	<tr>
		<td colspan="3"><br></td>
	</tr>
   <% } %>
</tr>
<!-- 댓글 리스트 END -->


 <tr>
  <td align="center" colspan="2">
 [ <a href="javascript:list()" >리스트</a> | 
 <a href="update.jsp?nowPage=<%=nowPage%>&numPerPage=<%=numPerPage%>" >수 정</a>|
 <a href="reply.jsp?nowPage=<%=nowPage%>&numPerPage=<%=numPerPage%>" >답 변</a> |
 <a href="javascript:delFn()">삭 제</a> ]<br/>
  </td>
 </tr>
</table>
<form name="downFrm" action="download.jsp" method="post">
	<input type="hidden" name="filename">
</form>
<form name="listFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<%if(!(keyWord==null||keyWord.equals(""))){%>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>
<form method="post" name="downFrm" action="download.jsp">
	<input type="hidden" name="filename">
</form>
<form name="delFrm" action="boardDelete" method="post">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<%if(!(keyWord==null||keyWord.equals(""))){%>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
	<input type="hidden" name="pass">
</form>
</body>
</html>