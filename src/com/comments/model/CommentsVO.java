package com.comments.model;

public class CommentsVO implements java.io.Serializable{
	private String cmnt_no;
	private String ord_no;
	private String vendor_no;
	private Integer score;
	private String cmnt;
	private java.sql.Timestamp time;
	private Integer cmnt_status;
	public CommentsVO() {
		super();
	}
	public String getCmnt_no() {
		return cmnt_no;
	}
	public void setCmnt_no(String cmnt_no) {
		this.cmnt_no = cmnt_no;
	}
	public String getOrd_no() {
		return ord_no;
	}
	public void setOrd_no(String ord_no) {
		this.ord_no = ord_no;
	}
	public String getVendor_no() {
		return vendor_no;
	}
	public void setVendor_no(String vendor_no) {
		this.vendor_no = vendor_no;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public String getCmnt() {
		return cmnt;
	}
	public void setCmnt(String cmnt) {
		this.cmnt = cmnt;
	}
	public java.sql.Timestamp getTime() {
		return time;
	}
	public void setTime(java.sql.Timestamp time) {
		this.time = time;
	}
	public Integer getCmnt_status() {
		return cmnt_status;
	}
	public void setCmnt_status(Integer cmnt_status) {
		this.cmnt_status = cmnt_status;
	}
	
	
}
