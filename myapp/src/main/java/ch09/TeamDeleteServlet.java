package ch09;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ch09/teamDelete")
public class TeamDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int num = 0;
		TeamMgr mgr = new TeamMgr();
		if(request.getParameter("num")!=null){
			num = MUtil.parseInt(request, "num");
			mgr.deleteTeam(num);
		}
		response.sendRedirect("teamList.jsp");
	}
}
