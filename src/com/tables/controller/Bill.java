package com.tables.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Timer;

import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.ord.controller.OrdVOn;
import com.ord.model.OrdVO;
import com.ord_detail.model.Order_DetailService;
import com.ord_detail.model.Order_DetailVO;
import com.wait_pos.controller.PersonInLine;

public class Bill {
	Long date;
	String bill_no; // Booking: ord_no; Walk in, Wait:date-w-no
	Long startTime;
	Long endTime;
	String tbl_no;
	Integer party_size;
	LinkedHashMap<String, Bill_item> bill_items; // Booking: ord_detail
	Integer total;
	
	java.util.Date bookingTime; // Booking
	// ----------------------
	Integer source;
	Integer status;
//	Timer timer;
	// ----------------------
//	MemberVO
	String mem_no;
	String mem_name;
	
	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	// from 訂位
	public Bill(OrdVO ordVO) {
		this.source = 1;
		this.status = 0;
		this.mem_no = ordVO.getMem_no();
		this.party_size = ordVO.getParty_size();
		this.tbl_no = ordVO.getTbl_no(); // may be null
		this.bill_no = ordVO.getOrd_no();
		this.total = ordVO.getTotal();
		
		// booking timestamp
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HHmm z");
		java.util.Date bookingTimestamp = null;
		try {
			bookingTimestamp = format.parse(ordVO.getBooking_date().toString() + " " +  ordVO.getBooking_time() + " GMT+8:00");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		this.bookingTime = bookingTimestamp;
		
		// bill item
		this.bill_items = new LinkedHashMap<String, Bill_item>();
		Order_DetailService ord_DetailService = new Order_DetailService();
		List<Order_DetailVO> odList =  ord_DetailService.findbyOrd_no(ordVO.getOrd_no());
		for(Order_DetailVO odVO: odList) {
			this.bill_items.put(odVO.getMenu_no(), new Bill_item(odVO));
		}
		
		OrdVOn oVO2 = new OrdVOn(ordVO);
		this.mem_name = oVO2.getMem_name();
	}
	
	// from 候位
	public Bill(PersonInLine pil) {
		this.source = 2;
		this.status = 0;
		this.mem_no = pil.getMem_no();
		this.party_size = pil.getParty_size();
		this.bill_items = new LinkedHashMap<String, Bill_item>();
		MemberService ms = new MemberService();
		MemberVO memVO = ms.getOneMember(mem_no);
		this.mem_name = memVO.getMem_name();
	}
	

	// from 散客
	public Bill(String tbl_no, Integer party_size) {
		this.source = 3;
		this.status = 1;
		this.tbl_no = tbl_no;
		this.party_size = party_size;
		this.startTime = new java.util.Date().getTime();
		this.bill_items = new LinkedHashMap<String, Bill_item>();
	}

	

	public Long getDate() {
		return date;
	}

	public void setDate(Long date) {
		this.date = date;
	}

	public String getBill_no() {
		return bill_no;
	}

	public void setBill_no(String bill_no) {
		this.bill_no = bill_no;
	}

	public Long getStartTime() {
		return startTime;
	}

	public void setStartTime(Long startTime) {
		this.startTime = startTime;
	}

	public Long getEndTime() {
		return endTime;
	}

	public void setEndTime(Long endTime) {
		this.endTime = endTime;
	}

	public String getTbl_no() {
		return tbl_no;
	}

	public void setTbl_no(String tbl_no) {
		this.tbl_no = tbl_no;
	}

	public Integer getParty_size() {
		return party_size;
	}

	public void setParty_size(Integer party_size) {
		this.party_size = party_size;
	}

	public LinkedHashMap<String, Bill_item> getBill_items() {
		return bill_items;
	}

	public void setBill_items(LinkedHashMap<String, Bill_item> bill_items) {
		this.bill_items = bill_items;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public java.util.Date getBookingTime() {
		return bookingTime;
	}

	public void setBookingTime(java.util.Date bookingTime) {
		this.bookingTime = bookingTime;
	}

	public Integer getSource() {
		return source;
	}

	public void setSource(Integer source) {
		this.source = source;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getMem_no() {
		return mem_no;
	}

	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}

	@Override
	public String toString() {
		return "Bill [date=" + date + ", bill_no=" + bill_no + ", startTime=" + startTime + ", endTime=" + endTime
				+ ", tbl_no=" + tbl_no + ", party_size=" + party_size + ", bill_items=" + bill_items + ", total="
				+ total + ", bookingTime=" + bookingTime + ", source=" + source + ", status=" + status + ", mem_no="
				+ mem_no + "]";
	}	

	


}
