package com.news.model;

import java.sql.Date;

public class NewsVO implements java.io.Serializable {
	private String news_no;
	private String emp_no;
	private String news_cont;
	private byte[] news_pic;
	private Date news_rea;
	private String news_text;
	
	public NewsVO() {
		
	}
	
	public String getNews_no() {
		return news_no;
	}
	public void setNews_no(String news_no) {
		this.news_no = news_no;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getNews_cont() {
		return news_cont;
	}
	public void setNews_cont(String news_cont) {
		this.news_cont = news_cont;
	}
	public byte[] getNews_pic() {
		return news_pic;
	}
	public void setNews_pic(byte[] news_pic) {
		this.news_pic = news_pic;
	}
	public Date getNews_rea() {
		return news_rea;
	}
	public void setNews_rea(Date news_rea) {
		this.news_rea = news_rea;
	}

	public String getNews_text() {
		return news_text;
	}

	public void setNews_text(String news_text) {
		this.news_text = news_text;
	}
	
	
}
