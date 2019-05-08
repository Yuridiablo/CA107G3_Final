package com.member_wallet_list.model;

import java.io.Serializable;
import java.sql.Date;

//LIST_NO           VARCHAR2(10 BYTE) NOT NULL
//MEM_NO            VARCHAR2(7 BYTE) 
//LIST_TIME         DATE
//LIST_WIT          VARCHAR2(10 BYTE) 
//LIST_STAT         NUMBER(1) 
//LIST_DEP          VARCHAR2(10 BYTE) 
//PAY_FOR           VARCHAR2(15 BYTE)

public class Member_Wallet_ListVO implements Serializable{
	
	private String list_no;
	private String mem_no;
	private Date list_time;
	private String list_wit;
	private Integer list_stat;
	private String list_dep;
	private String pay_for;
	
	
	public Member_Wallet_ListVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getList_no() {
		return list_no;
	}

	public void setList_no(String list_no) {
		this.list_no = list_no;
	}

	public String getMem_no() {
		return mem_no;
	}

	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}

	public Date getList_time() {
		return list_time;
	}

	public void setList_time(Date list_time) {
		this.list_time = list_time;
	}

	public String getList_wit() {
		return list_wit;
	}

	public void setList_wit(String list_wit) {
		this.list_wit = list_wit;
	}

	public Integer getList_stat() {
		return list_stat;
	}

	public void setList_stat(Integer list_stat) {
		this.list_stat = list_stat;
	}

	public String getList_dep() {
		return list_dep;
	}

	public void setList_dep(String list_dep) {
		this.list_dep = list_dep;
	}

	public String getPay_for() {
		return pay_for;
	}

	public void setPay_for(String pay_for) {
		this.pay_for = pay_for;
	}
	
	
	
}
