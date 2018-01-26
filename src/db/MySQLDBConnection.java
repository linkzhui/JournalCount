package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
//import java.sql.SQLException;
import java.util.List;

import model.JournalData;

public class MySQLDBConnection implements DBConnection {
	private Connection conn = null;

	public MySQLDBConnection() {
		this(MySQLUtil.URL);
	}

	public MySQLDBConnection(String url) {
		// TODO Auto-generated constructor stub
		try {
			// Forcing the class representing the MySQL driver to load and
			// initialize.
			// The newInstance() call is a work around for some broken Java
			// implementations
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void close() {
		// TODO Auto-generated method stub
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) { /* ignored */
			}
		}
	}

	@Override
	public Boolean verifyLogin(String userId, String password) {
		// TODO Auto-generated method stub
		try {
			if (conn == null) {
				return false;
			}
			String sql = "SELECT user_id from users WHERE user_id = ? and password = ?";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, userId);
			statement.setString(2, password);
			ResultSet rs = statement.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

	@Override
	public String getAccountType(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean userRegister(String userId, String password, String name,  int workId,String email) {
		// TODO Auto-generated method stub
		try{
			String sql = "INSERT INTO users " + "VALUES (?,?,?,?,?)";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, userId);
			statement.setString(2, password);
			statement.setString(3, name);
			statement.setInt(4, workId);
			statement.setString(5, email);
			int rs = statement.executeUpdate();
			if(rs!=0)
			{
				return true;
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return false;
	}

	@Override
	public Boolean verifyRegister(String userId) {
		// TODO Auto-generated method stub
		try {
			if (conn == null) {
				return false;
			}
			String sql = "SELECT * from users WHERE user_id = ?";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, userId);
			ResultSet rs = statement.executeQuery();
			if (!rs.next()) {
				//当前用户名没有被注册过
				return true;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}


	@Override
	public Boolean journalUpload(String title, String date, int photo_num, int journal_id, String journal_name,
			String journal_department, int photograph_id, String photograph_name, String photograph_department,
			String notes) {
		// TODO Auto-generated method stub
		try {
			if (conn == null) {
				return false;
			}
			String sql = "INSERT INTO `稿件统计` (`序号`, `修改日期`, `日期`, `稿件标题`, `图片数量`, `文章作者工号`, "
					+ "`文章作者`, `文章作者科室`, `摄影作者工号`, `摄影作者`, `摄影作者科室`, `稿费`, `录用情况`, `备注`, "
					+ "`录用级别`, `媒体名称`, `网址`, `积分`) "
					+ "VALUES (NULL, CURRENT_TIMESTAMP, ?, ?, ?, ?, ?, ?, ?, ?, ?, '0', 'No', ?, NULL, NULL, NULL, NULL);";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, date);
			statement.setString(2,title);
			statement.setInt(3, photo_num);
			statement.setInt(4, journal_id);
			statement.setString(5,journal_name);
			statement.setString(6, journal_department);
			statement.setInt(7, photograph_id);
			statement.setString(8, photograph_name);
			statement.setString(9, photograph_department);
			statement.setString(10, notes);
			int rs = statement.executeUpdate();
			if(rs!=0)
			{
				return true;
			}
			else{
				
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

	@Override
	public List<JournalData> getJournalDate(String sql) {
		// TODO Auto-generated method stub
		List<JournalData> list_data = new ArrayList<>();
		try {
			if (conn == null) {
				return list_data;
			}
			PreparedStatement statement = conn.prepareStatement(sql);
			ResultSet rs = statement.executeQuery();
			while(rs.next())
			{
				int id = rs.getInt(1);
				String update_date = rs.getString(2);
				String date = rs.getString(3);
				String title = rs.getString(4);
				int photo_num = rs.getInt(5);
				int journal_id = rs.getInt(6);
				String journal_name = rs.getString(7);
				String journal_department = rs.getString(8);
				int phorograph_id = rs.getInt(9);
				String phorograph_name = rs.getString(10);
				String phorograph_department  = rs.getString(11);
				int payment = rs.getInt(12);
				String accept_status = rs.getString(13);
				String note = rs.getString(14);
				String accept_level = rs.getString(15);
				String media_company = rs.getString(16);
				String web = rs.getString(17);
				String score = rs.getString(18);
				JournalData temp_data = new JournalData(id,update_date,date,title, photo_num,journal_id,
						journal_name, journal_department,phorograph_id, phorograph_name,
						phorograph_department,payment, accept_status, note, accept_level,
						media_company, web, score);
				list_data.add(temp_data);
			}
		} catch (Exception e) {
			System.out.println(sql);
			System.out.println(e.getMessage());
		}
		return list_data;
	}

	@Override
	public Boolean deleteData(String id) {
		// TODO Auto-generated method stub
		try {
			if (conn == null) {
				return false;
			}
			String sql = "DELETE from 稿件统计 WHERE 序号 = ?";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, id);
			int rs = statement.executeUpdate();
			if (rs!=0) {
				//当前用户名没有被注册过
				return true;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

	@Override
	public Boolean executeUpdate(String sql) {
		// TODO Auto-generated method stub
		try {
			if (conn == null) {
				return false;
			}
			PreparedStatement statement = conn.prepareStatement(sql);
			int rs = statement.executeUpdate();
			if (rs!=0) {
				//当前用户名没有被注册过
				return true;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}
	

}
