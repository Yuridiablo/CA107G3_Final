package com.employee.model;

import java.util.List;

import com.news.model.NewsVO;

public interface EmployeeDAO_interface {
	public int insert(EmployeeVO employeeVO);
    public int update(EmployeeVO employeeVO);
    public int delete(String emp_no);
    public EmployeeVO findByPrimaryKey(String emp_no);
    public EmployeeVO findByEmp_acc(String emp_acc);
    public List<EmployeeVO> findByEmployeeName(String emp_name);
    public List<EmployeeVO> getAll();
}
