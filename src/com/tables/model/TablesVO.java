package com.tables.model;

public class TablesVO implements java.io.Serializable {
	private String tbl_no;
	private String vendor_no;
	private String tbl_name;
	private Integer tbl_size;
	private Integer tbl_type;
	private Integer tbl_x;
	private Integer tbl_y;
	
	public TablesVO() {
		super();
	}
	public String getTbl_no() {
		return tbl_no;
	}
	public void setTbl_no(String tbl_no) {
		this.tbl_no = tbl_no;
	}
	public String getVendor_no() {
		return vendor_no;
	}
	public void setVendor_no(String vendor_no) {
		this.vendor_no = vendor_no;
	}
	public String getTbl_name() {
		return tbl_name;
	}
	public void setTbl_name(String tbl_name) {
		this.tbl_name = tbl_name;
	}
	public Integer getTbl_size() {
		return tbl_size;
	}
	public void setTbl_size(Integer tbl_size) {
		this.tbl_size = tbl_size;
	}
	public Integer getTbl_type() {
		return tbl_type;
	}
	public void setTbl_type(Integer tbl_type) {
		this.tbl_type = tbl_type;
	}
	public Integer getTbl_x() {
		return tbl_x;
	}
	public void setTbl_x(Integer tbl_x) {
		this.tbl_x = tbl_x;
	}
	public Integer getTbl_y() {
		return tbl_y;
	}
	public void setTbl_y(Integer tbl_y) {
		this.tbl_y = tbl_y;
	}
	@Override
	public String toString() {
		return "TablesVO [tbl_no=" + tbl_no + ", vendor_no=" + vendor_no + ", tbl_name=" + tbl_name + ", tbl_size="
				+ tbl_size + ", tbl_type=" + tbl_type + ", tbl_x=" + tbl_x + ", tbl_y=" + tbl_y + "]";
	}

	 
}
