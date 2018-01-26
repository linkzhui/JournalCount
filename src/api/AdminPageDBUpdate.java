package api;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import db.MySQLDBConnection;
/**
 * Servlet implementation class AdminSearchDataByArray
 */
@WebServlet("/AdminPageDBUpdate")
public class AdminPageDBUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MySQLDBConnection sqlcon = new MySQLDBConnection();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPageDBUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String[] data = request.getParameterValues("list[]");
		String option = request.getParameter("option");
		String sql = request.getParameter("sql");
		boolean result = false;
		if(option!=null)
		{
			if(option.equals("delete")&&data!=null)
			{
				for(String element:data)
				{
					result = sqlcon.deleteData(element);
					response.getWriter().append("delete data result:" + result);
				}
			}
			else if(option.equals("modify")){
				System.out.println(sql);
				result = sqlcon.executeUpdate(sql);
				response.getWriter().append("update data result:" + result);
			}
			
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
