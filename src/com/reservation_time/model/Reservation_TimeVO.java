package com.reservation_time.model;

public class Reservation_TimeVO implements java.io.Serializable{
	
	private String rt_no;
	private String vendor_no;
	private String r_time;
	
	public String getRt_no() {
		return rt_no;
	}
	public void setRt_no(String rt_no) {
		this.rt_no = rt_no;
	}
	public String getVendor_no() {
		return vendor_no;
	}
	public void setVendor_no(String vendor_no) {
		this.vendor_no = vendor_no;
	}
	public String getR_time() {
		return r_time;
	}
	public void setR_time(String r_time) {
		this.r_time = r_time;
	}
	

}
