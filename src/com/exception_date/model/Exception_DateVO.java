package com.exception_date.model;

import java.sql.Date;

public class Exception_DateVO implements java.io.Serializable{
	
		private String exc_no;
		private String vendor_no;
		private Date exc_date;
		public String getExc_no() {
			return exc_no;
		}
		public void setExc_no(String exc_no) {
			this.exc_no = exc_no;
		}
		public String getVendor_no() {
			return vendor_no;
		}
		public void setVendor_no(String vendor_no) {
			this.vendor_no = vendor_no;
		}
		public Date getExc_date() {
			return exc_date;
		}
		public void setExc_date(Date exc_date) {
			this.exc_date = exc_date;
		}
		
	

}
