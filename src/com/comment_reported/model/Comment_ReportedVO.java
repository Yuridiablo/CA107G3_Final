package com.comment_reported.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

//REP_NO            VARCHAR2(10 BYTE) NOT NULL
//CMNT_NO           VARCHAR2(7 BYTE) 
//MEM_NO            VARCHAR2(7 BYTE) 
//REP_FOR           VARCHAR2(500 BYTE) 
//REP_TIME          DATE 
//REP_STAT          NUMBER(1) NOT NULL

public class Comment_ReportedVO implements Serializable{
	
	private String rep_no;
	private String cmnt_no;
	private String mem_no;
	private String rep_for;
	private Timestamp rep_time;
	private Integer rep_stat;		
	
	public Comment_ReportedVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getRep_no() {
		return rep_no;
	}
	public void setRep_no(String rep_no) {
		this.rep_no = rep_no;
	}
	public String getCmnt_no() {
		return cmnt_no;
	}
	public void setCmnt_no(String cmnt_no) {
		this.cmnt_no = cmnt_no;
	}
	public String getMem_no() {
		return mem_no;
	}
	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}
	public String getRep_for() {
		return rep_for;
	}
	public void setRep_for(String rep_for) {
		this.rep_for = rep_for;
	}
	public Timestamp getRep_time() {
		return rep_time;
	}
	public void setRep_time(Timestamp rep_time) {
		this.rep_time = rep_time;
	}
	public Integer getRep_stat() {
		return rep_stat;
	}
	public void setRep_stat(Integer rep_stat) {
		this.rep_stat = rep_stat;
	}
	
	

}
