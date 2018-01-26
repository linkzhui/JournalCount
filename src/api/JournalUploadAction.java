package api;

import java.io.IOException;
import db.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class JournalUpload
 */
@WebServlet("/JournalUpload")
public class JournalUploadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MySQLDBConnection sqlcon = new MySQLDBConnection();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JournalUploadAction() {
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
		request.setCharacterEncoding("UTF-8");
		String date = request.getParameter("date");
		String title = request.getParameter("title");
		int photo_num = 0;
		if(!request.getParameter("photo_num").equals(""))
		{
			photo_num = Integer.parseInt(request.getParameter("photo_num"));
		}
		int journal_id = 0;
		if(!request.getParameter("journal_id").equals(""))
		{
			journal_id = Integer.parseInt(request.getParameter("journal_id"));
		}
		String journal_name = request.getParameter("journal_name");
		String journal_department = request.getParameter("journal_department");
		int photograph_id = 0;
		if(!request.getParameter("photograph_id").equals(""))
		{
			photograph_id = Integer.parseInt(request.getParameter("photograph_id"));
		}
		String photograph_name = request.getParameter("photograph_name");
		String photograph_department = request.getParameter("photograph_department");
		String notes = request.getParameter("notes");
		
		try {
			// Forcing the class representing the MySQL driver to load and
			// initialize.
			// The newInstance() call is a work around for some broken Java
			// implementations
			if(!sqlcon.journalUpload(title, date, photo_num, journal_id, journal_name, journal_department, photograph_id, photograph_name, photograph_department, notes)){
				request.setCharacterEncoding("UTF-8");
				request.setAttribute("alert", "yes");
			}
			else{
				request.setCharacterEncoding("UTF-8");
				request.setAttribute("alert", "no");
			}
			String forward = "journal_uplpad.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
			dispatcher.forward(request,response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
