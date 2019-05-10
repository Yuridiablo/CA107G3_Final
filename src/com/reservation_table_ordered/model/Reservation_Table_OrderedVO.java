package com.reservation_table_ordered.model;

import java.sql.Date;

public class Reservation_Table_OrderedVO implements java.io.Serializable{
	
	private String rto_no;
	private String vendor_no;
	private	Date   booking_date;
	private String booking_time;
	private	Integer	tbl_o_num1;
	private	Integer	tbl_o_num2; 
	private	Integer	tbl_o_num3;
	private	Integer	tbl_o_num4;
	private	Integer	tbl_o_num5;
	private	Integer	tbl_ordered1;
	private	Integer	tbl_ordered2;
	private	Integer	tbl_ordered3;
	private	Integer	tbl_ordered4;
	private	Integer	tbl_ordered5;
	
	public String getRto_no() {
		return rto_no;
	}
	public void setRto_no(String rto_no) {
		this.rto_no = rto_no;
	}
	public String getVendor_no() {
		return vendor_no;
	}
	public void setVendor_no(String vendor_no) {
		this.vendor_no = vendor_no;
	}
	public Date getBooking_date() {
		return booking_date;
	}
	public void setBooking_date(Date booking_date) {
		this.booking_date = booking_date;
	}
	public String getBooking_time() {
		return booking_time;
	}
	public void setBooking_time(String booking_time) {
		this.booking_time = booking_time;
	}
	public Integer getTbl_o_num1() {
		return tbl_o_num1;
	}
	public void setTbl_o_num1(Integer tbl_o_num1) {
		this.tbl_o_num1 = tbl_o_num1;
	}
	public Integer getTbl_o_num2() {
		return tbl_o_num2;
	}
	public void setTbl_o_num2(Integer tbl_o_num2) {
		this.tbl_o_num2 = tbl_o_num2;
	}
	public Integer getTbl_o_num3() {
		return tbl_o_num3;
	}
	public void setTbl_o_num3(Integer tbl_o_num3) {
		this.tbl_o_num3 = tbl_o_num3;
	}
	public Integer getTbl_o_num4() {
		return tbl_o_num4;
	}
	public void setTbl_o_num4(Integer tbl_o_num4) {
		this.tbl_o_num4 = tbl_o_num4;
	}
	public Integer getTbl_o_num5() {
		return tbl_o_num5;
	}
	public void setTbl_o_num5(Integer tbl_o_num5) {
		this.tbl_o_num5 = tbl_o_num5;
	}
	public Integer getTbl_ordered1() {
		return tbl_ordered1;
	}
	public void setTbl_ordered1(Integer tbl_ordered1) {
		this.tbl_ordered1 = tbl_ordered1;
	}
	public Integer getTbl_ordered2() {
		return tbl_ordered2;
	}
	public void setTbl_ordered2(Integer tbl_ordered2) {
		this.tbl_ordered2 = tbl_ordered2;
	}
	public Integer getTbl_ordered3() {
		return tbl_ordered3;
	}
	public void setTbl_ordered3(Integer tbl_ordered3) {
		this.tbl_ordered3 = tbl_ordered3;
	}
	public Integer getTbl_ordered4() {
		return tbl_ordered4;
	}
	public void setTbl_ordered4(Integer tbl_ordered4) {
		this.tbl_ordered4 = tbl_ordered4;
	}
	public Integer getTbl_ordered5() {
		return tbl_ordered5;
	}
	public void setTbl_ordered5(Integer tbl_ordered5) {
		this.tbl_ordered5 = tbl_ordered5;
	}
	
}
