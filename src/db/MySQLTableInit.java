package db;

import java.sql.*;


//数据库分为四个表格，
//1. 文稿（投稿）
//2. 摄影（投稿）
//3. 用户
//4. 稿件录用
public class MySQLTableInit {
	public static void main(String[] args) {
		try {
			// Ensure the driver is imported.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection conn = null;
			try {
				System.out.println("Connecting to \n" + MySQLUtil.URL);
				conn = DriverManager.getConnection(MySQLUtil.URL);
			} catch (SQLException e) {
				System.out.println("SQLException " + e.getMessage());
				System.out.println("SQLState " + e.getSQLState());
				System.out.println("VendorError " + e.getErrorCode());
			}
			if (conn == null) {
				return;
			}
			// Step 1 Drop tables in case they exist.
			Statement stmt = conn.createStatement();
//			String sql = "DROP TABLE IF EXISTS journal";
//			stmt.executeUpdate(sql);
//			sql = "DROP TABLE IF EXISTS photograph";
//			stmt.executeUpdate(sql);
			String sql = "DROP TABLE IF EXISTS 稿件统计";
			stmt.executeUpdate(sql);
			
			// Step 2 Create tables
			
			
//			sql = "CREATE TABLE journal " 
//					+ "(journal_id MEDIUMINT NOT NULL AUTO_INCREMENT, "  
//					+ "date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, "
//					+ " journal_title VARCHAR(255) NOT NULL, "
//					+ "work_id INTEGER NOT NULL, " 
//					+ "name VARCHAR(255) NOT NULL, "
//					+ "department VARCHAR(255) NOT NULL, "
//					+ "acception_status VARCHAR(255) NOT NULL DEFAULT 'No', "
//					+ "note LONGTEXT, "
//					+ "PRIMARY KEY (journal_id))";
//			stmt.executeUpdate(sql);
			
//			//创建文稿表格，(序号，日期，稿件标题，文章作者工号，文章作者，作者科室，录用情况，备注)
//			sql = "CREATE TABLE journal " 
//					+ "(文稿_id MEDIUMINT NOT NULL AUTO_INCREMENT, "  
//					+ "日期 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, "
//					+ "稿件标题 VARCHAR(255) NOT NULL, "
//					+ "文章作者工号 INTEGER NOT NULL, " 
//					+ "文章作者 VARCHAR(255) NOT NULL, "
//					+ "作者科室 VARCHAR(255) NOT NULL, "
//					+ "稿费 INTEGER NOT NULL DEFAULT 0, "
//					+ "录用情况 VARCHAR(255) NOT NULL DEFAULT 'No', "
//					+ "备注 LONGTEXT, "
//					+ "录用级别 VARCHAR(255), "
//					+ "媒体名称 VARCHAR(255), "
//					+ "网址 LONGTEXT, "
//					+ "积分 INTEGER, "
//					+ "PRIMARY KEY (文稿_id))";
//			stmt.executeUpdate(sql);
//			
//			//创建用户账号管理表格
//			sql = "CREATE TABLE users " + "(user_id VARCHAR(255) NOT NULL, " + " password VARCHAR(255) NOT NULL, "
//					+ " 姓名 VARCHAR(255),"
//					+ " 工号 INTEGER,"
//					+ " 科室 VARCHAR(255),"
//					+ " 邮箱 VARCHAR(255),"
//					+ " PRIMARY KEY ( user_id ))";
//			
//			stmt.executeUpdate(sql);
//
//			//创建摄影稿件表格（序号，日期，稿件标题，图片数量，摄影作者工号，摄影作者，作者科室，稿费，录用情况，备注）
//			sql = "CREATE TABLE photograph " 
//					+ "(摄影稿件_id MEDIUMINT NOT NULL AUTO_INCREMENT, "  
//					+ "日期 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, "
//					+ "稿件标题 VARCHAR(255) NOT NULL, "
//					+ "图片数量 INTEGER NOT NULL, "
//					+ "摄影作者工号 INTEGER NOT NULL, " 
//					+ "摄影作者 VARCHAR(255) NOT NULL, "
//					+ "作者科室 VARCHAR(255) NOT NULL, "
//					+ "稿费 INTEGER NOT NULL DEFAULT 0, "
//					+ "录用情况 VARCHAR(255) NOT NULL DEFAULT 'No', "
//					+ "备注 LONGTEXT, "
//					+ "录用级别 VARCHAR(255), "
//					+ "媒体名称 VARCHAR(255), "
//					+ "网址 LONGTEXT, "
//					+ "积分 INTEGER, "
//					+ "PRIMARY KEY (摄影稿件_id))";
//			stmt.executeUpdate(sql);

			sql = "CREATE TABLE 稿件统计 " 
					+ "(序号 MEDIUMINT NOT NULL AUTO_INCREMENT, "  
					+ "修改日期 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, "
					+ "日期 VARCHAR(255) NOT NULL, "
					+ "稿件标题 VARCHAR(255) NOT NULL, "
					+ "图片数量 INTEGER, "
					+ "文章作者工号 VARCHAR(255), "
					+ "文章作者 VARCHAR(255), "
					+ "文章作者科室 VARCHAR(255), "
					+ "摄影作者工号 INTEGER, " 
					+ "摄影作者 VARCHAR(255), "
					+ "摄影作者科室 VARCHAR(255), "
					+ "稿费 INTEGER NOT NULL DEFAULT 0, "
					+ "录用情况 VARCHAR(255) NOT NULL DEFAULT 'No', "
					+ "备注 TEXT, "
					+ "录用级别 VARCHAR(255), "
					+ "媒体名称 TEXT, "
					+ "网址 TEXT, "
					+ "积分 INTEGER, "
					+ "PRIMARY KEY (序号))";
			
			stmt.executeUpdate(sql);
			
			// Step 3: insert data
//			
//			// Create a fake user
//			sql = "INSERT INTO users " + "VALUES (\"linkzhui\",\"qwer\", \"John Smith\", 117381, \"dwaaf@hotmail.com\")";
//			System.out.println("\nDBYelpImport executing query:\n" + sql);
//			stmt.executeUpdate(sql);
//			
//			sql = "INSERT INTO users " + "VALUES (\"admin\",\"admin\", \"NULL\",000000, \"gwafw@hotmail.com\")";
//			System.out.println("\nDBYelpImport executing query:\n" + sql);
//			stmt.executeUpdate(sql);
//			
//			sql = "UPDATE users SET 姓名='Zoe' WHERE 姓名 = 'John Smith'";
//			stmt.executeUpdate(sql);
			System.out.println("DBUsersImport: import is done successfully.");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

}
