package com.ord.controller;

import java.sql.Date;
import java.sql.Timestamp;

import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.ord.model.OrdVO;
import com.tables.model.TablesService;
import com.tables.model.TablesVO;

public class OrdVOn {
	private String ord_no;
	private String mem_no;
	private String mem_name;	
	private String vendor_no;
	private String tbl_no;
	private String tbl_name;
	private Integer party_size;

	private java.sql.Date booking_date;
	private String booking_time;
	private Integer total;
	private String verif_code;
	private Integer status;	
	public OrdVOn(OrdVO ordVO) {
		this.ord_no = ordVO.getOrd_no();
		this.mem_no = ordVO.getMem_no();
		this.vendor_no = ordVO.getVendor_no();
		this.tbl_no = ordVO.getTbl_no();
		this.party_size = ordVO.getParty_size();
		this.booking_date = ordVO.getBooking_date();
		this.booking_time = ordVO.getBooking_time();
		this.total = ordVO.getTotal();
		this.verif_code = ordVO.getVerif_code();
		this.status = ordVO.getStatus();
		
		MemberService ms = new MemberService();
		MemberVO memVO = ms.getOneMember(ordVO.getMem_no());
		this.mem_name = memVO.getMem_name();
		
		TablesService ts = new TablesService();
		String tblName = null;
		if (ordVO.getTbl_no() == null) {
			tblName = "";
		} else {
			TablesVO tblVO = ts.getOneTables(ordVO.getTbl_no());
			tblName = tblVO.getTbl_name();
		}		
		this.tbl_name = tblName;
	}
	public String getOrd_no() {
		return ord_no;
	}
	public void setOrd_no(String ord_no) {
		this.ord_no = ord_no;
	}
	public String getMem_no() {
		return mem_no;
	}
	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getVendor_no() {
		return vendor_no;
	}
	public void setVendor_no(String vendor_no) {
		this.vendor_no = vendor_no;
	}
	public String getTbl_no() {
		return tbl_no;
	}
	public void setTbl_no(String tbl_no) {
		this.tbl_no = tbl_no;
	}
	public String getTbl_name() {
		return tbl_name;
	}
	public void setTbl_name(String tbl_name) {
		this.tbl_name = tbl_name;
	}
	public Integer getParty_size() {
		return party_size;
	}
	public void setParty_size(Integer party_size) {
		this.party_size = party_size;
	}
	public java.sql.Date getBooking_date() {
		return booking_date;
	}
	public void setBooking_date(java.sql.Date booking_date) {
		this.booking_date = booking_date;
	}
	public String getBooking_time() {
		return booking_time;
	}
	public void setBooking_time(String booking_time) {
		this.booking_time = booking_time;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public String getVerif_code() {
		return verif_code;
	}
	public void setVerif_code(String verif_code) {
		this.verif_code = verif_code;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}

	
}
