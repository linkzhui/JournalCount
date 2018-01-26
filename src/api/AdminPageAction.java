package api;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.JournalData;
import java.util.List;

import db.*;
/**
 * Servlet implementation class AdminPageAction
 */
@WebServlet("/AdminPageAction")
public class AdminPageAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MySQLDBConnection sqlcon = new MySQLDBConnection();
    private String option;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPageAction() {
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

		int[] condition_count = new int[1];
		condition_count[0]=0;
		
		String sql = "select * from 稿件统计";
		StringBuilder sb = new StringBuilder();
		sb.append(" WHERE");
		
		option = request.getParameter("search_option");
		
		String date = request.getParameter("date");
		add_condition(condition_count,"日期",date+"",sb);
		
		String update_date = request.getParameter("update_date");
		add_condition(condition_count,"修改日期",update_date+"",sb);

		
		String title = request.getParameter("title");
		add_condition(condition_count,"稿件标题",title+"",sb);
		
		int photo_num;
		if(!request.getParameter("photo_num").equals(""))
		{
			photo_num = Integer.parseInt(request.getParameter("photo_num"));
			add_condition(condition_count,"图片数量",photo_num+"",sb);
		}
		
		int journal_id;
		if(!request.getParameter("journal_id").equals(""))
		{
			journal_id = Integer.parseInt(request.getParameter("journal_id"));
			add_condition(condition_count,"文章作者工号",journal_id+"",sb);
		}
		
		String journal_name = request.getParameter("journal_name");
		add_condition(condition_count,"文章作者名字",journal_name+"",sb);
		
		String journal_department = request.getParameter("journal_department");
		add_condition(condition_count,"文章作者科室",journal_department+"",sb);
		
		int photograph_id;
		if(!request.getParameter("photograph_id").equals(""))
		{
			photograph_id = Integer.parseInt(request.getParameter("photograph_id"));
			add_condition(condition_count,"摄影作者工号",photograph_id+"",sb);
		}
		
		String photograph_name = request.getParameter("photograph_name");
		add_condition(condition_count,"摄影作者名字",photograph_name+"",sb);
		
		String photograph_department = request.getParameter("photograph_department");
		add_condition(condition_count,"摄影作者科室",photograph_department+"",sb);
		
		String notes = request.getParameter("notes");
		add_condition(condition_count,"备注",notes+"",sb);
		
		try{
			if(condition_count[0]!=0)
			{
				sql+=sb.toString();
			}
			List<JournalData> data = sqlcon.getJournalDate(sql);
			request.setAttribute("list_data", data);
			request.setAttribute("sql", sql);
			String forward = "admin_page.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
			dispatcher.forward(request,response);
		}
		catch(Exception e){
			System.out.println(e.getStackTrace());
		}
	}

	private void add_condition(int[] condition_count, String name, String value, StringBuilder sb){
		if(!(value==null||value.length()==0||value.equals("null")))
		{
			if(option.equals("precission"))
			{
				if(condition_count[0]==0)
				{
					sb.append(" `"+name+"` LIKE '"+value+"'");
				}
				else{
					sb.append(" AND `"+name+"` LIKE '"+value+"'");
				}
			}
			else{
				if(condition_count[0]==0)
				{
					sb.append(" `"+name+"` LIKE '%"+value+"%'");
				}
				else{
					sb.append(" AND `"+name+"` LIKE '%"+value+"%'");
				}
			}
			condition_count[0]++;
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
