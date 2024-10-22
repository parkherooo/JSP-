<%@page import="ch15.BCommentMgr"%>
<%@page import="ch15.BCommentBean"%>
<%@page import="ch15.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page import="javax.swing.plaf.basic.BasicInternalFrameTitlePane.MaximizeAction"%>
<%@page import="ch15.UtilMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="ch15.BoardMgr"/>
<jsp:useBean id="bmgr" class="ch15.BCommentMgr"/>

<%
	int totalRecord = 0; //총게시물수
	int numPerPage = 10; //페이지당 레코드 갯수 (5,10,20,30)
	int pagePerBlock = 15; //한블럭당 페이지 갯수
	int totalPage = 0; //총 페이지 개수
	int totalBlock = 0; //총 블럭 개수
	int nowPage = 1;//현재 페이지
	int nowBlock = 1; //현재 블럭
	
	//요청된 numPerPage처리
	if(request.getParameter("numPerPage")!=null){
		numPerPage= UtilMgr.parseInt(request, "numPerPage");
	}
	//검색에 필요한 처리
	String keyField = "", keyWord = "";
	if(request.getParameter("keyWord")!=null){
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	//검색 후에 다시 리셋 요청
	/* if(request.getParameter("reload")!=null&&request.getParameter("reload").equals("true")){
		keyField = "";
		keyWord = "";
	} */
	totalRecord = mgr.getTotalCount(keyField, keyWord);
	//out.print(totalRecord);
	if(request.getParameter("nowPage")!=null){
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}
	int start = (nowPage *numPerPage)-numPerPage;
	int cnt = numPerPage; //(5,10,20,30)
	
	//전체 페이지수 (1004/10 = 100.4 ->101)
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);	
	
	//전체 블럭수 (101/15 = 6.7 ->7)
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);	
	
	//현재블럭 (nowPage : 7/15 = 0.4 = ->1)
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);	
	/* out.print("totalPage : "+ totalPage + "<br>");
	out.print("totalBlock : "+ totalBlock + "<br>");
	out.print("nowPage : "+ nowPage + "<br>");
	out.print("nowBlock : "+ nowBlock + "<br>"); */
%>
<!DOCTYPE html>
<html>
<head>
	<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	function block(block) {
		document.readFrm.nowPage.value = <%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	function numPerFn(numPerPage) {
		document.readFrm.numPerPage.value = numPerPage;
		document.readFrm.submit();
	}
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	function read(num) {
		document.readFrm.num.value=num;
		document.readFrm.action="read.jsp";
		document.readFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC" >
<div align="center"><br/>
<h2>JSP Board</h2><br/>
<table>
	<tr>
		<td width="600">
		Total : <%=totalRecord %>Article(
		<font color="red"><%=nowPage+"/"+totalPage %>Pages</font>)
		</td>
		<td align="left">
		<form name="npFrm" method="post">
			<select name="numPerPage" size="1" onchange="javascript:numPerFn(this.form.numPerPage.value)">
   				<option value="5">5개 보기</option>
   				<option value="10" selected>10개 보기</option>
   				<option value="15">15개 보기</option>
   				<option value="30">30개 보기</option>
  			</select>
  			<script type="text/javascript">
  				document.npFrm.numPerPage.value = <%=numPerPage%>;
  			</script>
   		</form>
	</tr>
</table>
<table>
	<tr>
		<td align="center" colspan="2">
		<%
			Vector<BoardBean> vlist = mgr.getBoardList(keyField, keyWord, start, cnt);
			int listSize = vlist.size();
			if(vlist.isEmpty()){
				out.println("등록된 게시물이 없습니다");
			} else{
		%>
		 <table cellspacing="0">
			<tr align="center" bgcolor="#D0D0D0">
				<td width="100">번 호</td>
				<td width="250">제 목</td>
				<td width="100">이 름</td>
				<td width="150">날 짜</td>
				<td width="100">조회수</td>
			</tr>
			<%
			for(int i=0; i<numPerPage;i++){
				if(i==listSize) break; //제일 마지막 페이지 사용
				BoardBean bean = vlist.get(i);
				int num = bean.getNum();
				String subject = bean.getSubject();
				String name = bean.getName();
				String regdate = bean.getRegdate();
				int depth = bean.getDepth();
				int count = bean.getCount();
				String filename = bean.getFilename();
				int bcount = bmgr.getBCommentCount(num);
			%>
			<tr align="center">
				<td><%=totalRecord-start-i %></td>
				<td align="left">
					<%for(int j=0; j<depth; j++){out.println("&nbsp;&nbsp;");} %>
					<a href="javascript:read('<%=num%>')"><%=subject %></a>
					<%if(bcount>0){ %>
					<font color="red">{<%=bcount %>}</font>
					<%} %>
					<%if(filename!=null&&!filename.equals("")){ %>
					<img alt="첨부파일" src="img/icon.gif" align="top" style="padding: 2px">
					<%} %>
				</td>
				<td><%=name %></td>
				<td><%=regdate %></td>
				<td><%=count %></td>
			</tr>
			<%} //--for%>
		</table>
		<%} //if-else%>
		</td>
	</tr>
<tr>
	<td colspan="2"><br><br></td>
</tr>
<tr align="center">
	<td>
	<!-- 이전블럭 -->
		<%if(nowBlock>1){ %>
			<a href="javascript:block('<%=nowBlock-1%>')">prev...</a>
		<%} %>
		<!-- 페이징 -->
		<%
			int pageStart = (nowBlock-1)*pagePerBlock+1;
			int pageEnd = (pageStart+pagePerBlock)<totalPage?
					pageStart + pagePerBlock:totalPage+1;
			for(;pageStart<pageEnd;pageStart++){
		%>
		<a href="javascript:pageing('<%=pageStart%>')">
		<%if(nowPage==pageStart){ %><font color="blue"><b><%} %>
		[<%=pageStart %>]
		<%if(nowPage==pageStart){ %></b></font><%} %>
		</a>
		<%
			} //--for
		%>
		<!-- 다음블럭 -->
		<%if(totalBlock>nowBlock){ %>
			<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
		<%} %>
	</td>
	<td align="left">
		<a href="post.jsp">[글쓰기]</a>
		<a href="list.jsp">[처음으로]</a>
	</td>
</tr>
</table>
<hr width="750">
<form name="searchFrm">
	<table  width="600" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<select name="keyField" size="1" >
    				<option value="name"> 이 름</option>
    				<option value="subject"> 제 목</option>
    				<option value="content"> 내 용</option>
   				</select>
   				<input size="16" name="keyWord">
   				<input type="button"  value="찾기" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
   				<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
  			</td>
 		</tr>
	</table>
</form>
<form name="readFrm">
	<input type="hidden" name="num">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
</form>
</div>
</body>
</html>