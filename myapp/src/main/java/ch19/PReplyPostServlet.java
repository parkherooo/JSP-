package ch19;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ch19/pReplyPost")
public class PReplyPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PReplyMgr mgr = new PReplyMgr();
		PReplyBean bean = new PReplyBean();
		bean.setNum(UtilMgr.parseInt(request, "num"));
		bean.setId(request.getParameter("id"));
		bean.setComment(request.getParameter("comment"));
		mgr.insertReply(bean);
		
		String gid = request.getParameter("gid");
		if(gid==null) {
			response.sendRedirect("home.jsp");
		} else {
			//gid 가 null이 아니면 다른사람 포토블로그에 방문하여 '좋아요'
			response.sendRedirect("guest.jsp?gid="+gid);
		}
	}

}
