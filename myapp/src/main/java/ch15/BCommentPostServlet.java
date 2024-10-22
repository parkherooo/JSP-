package ch15;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ch15/bCommentPost")
public class BCommentPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BCommentMgr mgr = new BCommentMgr();
		BCommentBean bean = new BCommentBean();
		int num = UtilMgr.parseInt(request, "num");
		bean.setNum(num);
		bean.setName(request.getParameter("cname"));
		bean.setComment(request.getParameter("comment"));
		mgr.insertBComment(bean);
		
		String nowPage = request.getParameter("nowPage");
		String numPerPage = request.getParameter("numPerPage");
		response.sendRedirect("read.jsp?num="+num+"&nowPage="+nowPage+"&numPerPage="+numPerPage); 
	}
}
