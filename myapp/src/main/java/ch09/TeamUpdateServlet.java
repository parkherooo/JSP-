package ch09;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ch09/teamUpdate")
public class TeamUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TeamBean bean = new TeamBean();
		TeamMgr mgr = new TeamMgr();

		bean.setNum(MUtil.parseInt(request, "num"));
		bean.setName(request.getParameter("name"));
		bean.setCity(request.getParameter("city"));
		bean.setAge(MUtil.parseInt(request, "age"));
		bean.setTeam(request.getParameter("team"));
		
		boolean result = mgr.updateTeam(bean);
		if(!result) {
			response.sendRedirect("teamList.jsp");
		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('수정성공')");
			out.println("location.href=teamRead.jsp?num="+bean.getNum()+"");
			out.println("</script>");
		}
		response.sendRedirect("teamList.jsp");
	}
}