package ch19;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.ant.jmx.JMXAccessorQueryTask;

@WebServlet("/ch19/pBlogUpHCnt")
public class PBlogUpHCntServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PBlogMgr mgr = new PBlogMgr();
		mgr.upHCnt(Integer.parseInt(request.getParameter("num")));
		String gid = request.getParameter("gid");
		if(gid==null) {
			response.sendRedirect("home.jsp");
		} else {
			//gid 가 null이 아니면 다른사람 포토블로그에 방문하여 '좋아요'
			response.sendRedirect("guest.jsp?gid="+gid);
		}
	}
}
