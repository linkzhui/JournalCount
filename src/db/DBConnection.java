package db;

import java.util.List;

import model.*;

public interface DBConnection {
	public void close();
	public Boolean verifyLogin(String userId, String password);
	public Boolean verifyRegister(String userId);
	public String getAccountType(String userId);
	public Boolean userRegister(String userId, String password, String name, int workId, String email);
	public Boolean journalUpload(String title,String date, int photo_num, int journal_id, String journal_name, String  journal_department, int photograph_id, String photograph_name, String photograph_department, String notes);
	public List<JournalData> getJournalDate(String sql);
	public Boolean deleteData (String id);
	public Boolean executeUpdate(String sql);
}
