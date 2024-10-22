package ch15;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ch15/bCommentDelete")
public class BCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BCommentMgr mgr = new BCommentMgr();
		int num = UtilMgr.parseInt(request, "num");
		mgr.deleteBComment(UtilMgr.parseInt(request, "cnum"));
		
		String nowPage = request.getParameter("nowPage");
		String numPerPage = request.getParameter("numPerPage");
		response.sendRedirect("read.jsp?num="+num+"&nowPage="+nowPage+"&numPerPage="+numPerPage);
	}

}
