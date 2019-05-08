package com.employee.model;

import java.sql.Date;

public class EmployeeVO implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;
	private String emp_no;
	private String emp_name;
	private String emp_sex;
	private String emp_acc;
	private String emp_pwd;
	private Date emp_hire;
	private Date emp_resign;
	private Integer emp_stat;
	
	public EmployeeVO(){
		
	}
	
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getEmp_sex() {
		return emp_sex;
	}
	public void setEmp_sex(String emp_sex) {
		this.emp_sex = emp_sex;
	}
	public String getEmp_acc() {
		return emp_acc;
	}
	public void setEmp_acc(String emp_acc) {
		this.emp_acc = emp_acc;
	}
	public String getEmp_pwd() {
		return emp_pwd;
	}
	public void setEmp_pwd(String emp_pwd) {
		this.emp_pwd = emp_pwd;
	}
	public Date getEmp_hire() {
		return emp_hire;
	}
	public void setEmp_hire(Date emp_hire) {
		this.emp_hire = emp_hire;
	}
	public Date getEmp_resign() {
		return emp_resign;
	}
	public void setEmp_resign(Date emp_resign) {
		this.emp_resign = emp_resign;
	}
	public Integer getEmp_stat() {
		return emp_stat;
	}
	public void setEmp_stat(Integer emp_stat) {
		this.emp_stat = emp_stat;
	}
	
	
}
