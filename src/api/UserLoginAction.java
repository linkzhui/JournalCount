package api;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import db.*;
/**
 * Servlet implementation class UserLogin
 */
@WebServlet("/UserLoginAction")
public class UserLoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MySQLDBConnection mysqlcon = new MySQLDBConnection();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLoginAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.addHeader("Access-Control-Allow-Origin", "*");
		String username = "";
		String password = "";
		PrintWriter out = response.getWriter();
		if (request.getParameter("user") != null && request.getParameter("password") != null) {
		username = request.getParameter("user");
		password = request.getParameter("password");
		if(mysqlcon.verifyLogin(username, password))
		{
			String forward = "journalUpload.jsp";
			request.setAttribute("userId", username);
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
			dispatcher.forward(request,response);
		}
		else{
			String forward = "login_fail.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
			dispatcher.forward(request,response);
		}
		}
		out.flush();
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
