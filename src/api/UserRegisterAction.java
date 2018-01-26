package api;

import db.*;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserRegisterAction
 */
@WebServlet("/UserRegisterAction")
public class UserRegisterAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
    MySQLDBConnection sqlcon = new MySQLDBConnection();
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserRegisterAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
	    response.setContentType("text/html;charset=UTF-8");
		String userId = request.getParameter("user");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		int workId = Integer.parseInt(request.getParameter("work_id"));
		String forward;
		
		////check the database to verify the user registration info
		if(sqlcon.verifyRegister(userId))
		{
			boolean register_result = sqlcon.userRegister(userId, password,name, workId, email);
			if(register_result)
			{
				request.setCharacterEncoding("UTF-8");
				forward = "journalUpload.jsp";
				request.setAttribute("userId", userId);
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
				dispatcher.forward(request,response);
			}
			else{
				forward = "user_register_fail.jsp";
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
				dispatcher.forward(request,response);
			}
		}
		else{
			forward = "user_register_fail.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
			dispatcher.forward(request,response);
		}
	}
}
