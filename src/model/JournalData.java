package model;

public class JournalData {
	private int id;
	private String update_date;
	private String date;
	private String title;
	private int photo_num;
	private int journal_id;
	private String journal_name;
	private String journal_department;
	private int phorograph_id;
	private String phorograph_name;
	private String phorograph_department;
	private int payment;
	private String accept_status;
	private String note;
	private String accept_level;
	private String media_company;
	private String web;
	private String score;
	public JournalData(int id, String update_date, String date, String title, int photo_num, int journal_id,
			String journal_name, String journal_department, int phorograph_id, String phorograph_name,
			String phorograph_department, int payment, String accept_status, String note, String accept_level,
			String media_company, String web, String score) {
		super();
		this.id = id;
		this.update_date = update_date;
		this.date = date;
		this.title = title;
		this.photo_num = photo_num;
		this.journal_id = journal_id;
		this.journal_name = journal_name;
		this.journal_department = journal_department;
		this.phorograph_id = phorograph_id;
		this.phorograph_name = phorograph_name;
		this.phorograph_department = phorograph_department;
		this.payment = payment;
		this.accept_status = accept_status;
		this.note = note;
		this.accept_level = accept_level;
		this.media_company = media_company;
		this.web = web;
		this.score = score;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPhoto_num() {
		return photo_num;
	}
	public void setPhoto_num(int photo_num) {
		this.photo_num = photo_num;
	}
	public int getJournal_id() {
		return journal_id;
	}
	public void setJournal_id(int journal_id) {
		this.journal_id = journal_id;
	}
	public String getJournal_name() {
		return journal_name;
	}
	public void setJournal_name(String journal_name) {
		this.journal_name = journal_name;
	}
	public String getJournal_department() {
		return journal_department;
	}
	public void setJournal_department(String journal_department) {
		this.journal_department = journal_department;
	}
	public int getPhorograph_id() {
		return phorograph_id;
	}
	public void setPhorograph_id(int phorograph_id) {
		this.phorograph_id = phorograph_id;
	}
	public String getPhorograph_name() {
		return phorograph_name;
	}
	public void setPhorograph_name(String phorograph_name) {
		this.phorograph_name = phorograph_name;
	}
	public String getPhorograph_department() {
		return phorograph_department;
	}
	public void setPhorograph_department(String phorograph_department) {
		this.phorograph_department = phorograph_department;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
	public String getAccept_status() {
		return accept_status;
	}
	public void setAccept_status(String accept_status) {
		this.accept_status = accept_status;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getAccept_level() {
		return accept_level;
	}
	public void setAccept_level(String accept_level) {
		this.accept_level = accept_level;
	}
	public String getMedia_company() {
		return media_company;
	}
	public void setMedia_company(String media_company) {
		this.media_company = media_company;
	}
	public String getWeb() {
		return web;
	}
	public void setWeb(String web) {
		this.web = web;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	
	

}
