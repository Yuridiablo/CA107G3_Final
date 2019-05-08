package com.restaurant_responses.model;

import java.io.Serializable;
import java.sql.Date;

//RES_NO			VARCHAR2(10 BYTE) NOT NULL
//CMNT_NO			VARCHAR2(7 BYTE) NOT NULL 
//RES_TEXT			VARCHAR2(500 BYTE) NOT NULL 
//RES_TIME 			DATE

public class Restaurant_ResponsesVO implements Serializable{
	
	private String res_no;
	private String cmnt_no;
	private String res_text;
	private Date res_time;
	
	public Restaurant_ResponsesVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getRes_no() {
		return res_no;
	}

	public void setRes_no(String res_no) {
		this.res_no = res_no;
	}

	public String getCmnt_no() {
		return cmnt_no;
	}

	public void setCmnt_no(String cmnt_no) {
		this.cmnt_no = cmnt_no;
	}

	public String getRes_text() {
		return res_text;
	}

	public void setRes_text(String res_text) {
		this.res_text = res_text;
	}

	public Date getRes_time() {
		return res_time;
	}

	public void setRes_time(Date res_time) {
		this.res_time = res_time;
	}

	
}
