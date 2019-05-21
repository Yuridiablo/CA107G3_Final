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

	
}
