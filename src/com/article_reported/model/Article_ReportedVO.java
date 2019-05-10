package com.article_reported.model;

import java.sql.Date;

public class Article_ReportedVO implements java.io.Serializable{
	private String artre_no;
	private String art_no;
	private String mem_no;
	private String artre_content;
	private Date artre_time;
	private Integer artre_code;
	public String getArtre_no() {
		return artre_no;
	}
	public void setArtre_no(String artre_no) {
		this.artre_no = artre_no;
	}
	public String getArt_no() {
		return art_no;
	}
	public void setArt_no(String art_no) {
		this.art_no = art_no;
	}
	public String getMem_no() {
		return mem_no;
	}
	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}
	public String getArtre_content() {
		return artre_content;
	}
	public void setArtre_content(String artre_content) {
		this.artre_content = artre_content;
	}
	public Date getArtre_time() {
		return artre_time;
	}
	public void setArtre_time(Date artre_time) {
		this.artre_time = artre_time;
	}
	public Integer getArtre_code() {
		return artre_code;
	}
	public void setArtre_code(Integer artre_code) {
		this.artre_code = artre_code;
	}
	
	
}
