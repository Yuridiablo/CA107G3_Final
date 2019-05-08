package com.employee.model;

import java.sql.Date;
import java.util.List;

public class EmployeeService {
	private EmployeeDAO_interface dao;

	public EmployeeService() {
		dao = new EmployeeJDBCDAO();
	}

	public EmployeeVO addEmployee(String emp_name, String emp_sex, String emp_acc, String emp_pwd,
			Date emp_hire) {
		EmployeeVO employeeVO = new EmployeeVO();

		employeeVO.setEmp_name(emp_name);
		employeeVO.setEmp_sex(emp_sex);
		employeeVO.setEmp_acc(emp_acc);
		employeeVO.setEmp_pwd(emp_pwd);
		employeeVO.setEmp_hire(emp_hire);
		employeeVO.setEmp_stat(1);
		dao.insert(employeeVO);
		return employeeVO;
	}

	public EmployeeVO updateEmployee(String emp_no, String emp_name, String emp_sex, String emp_acc, String emp_pwd,
			Date emp_hire, Date emp_resign, Integer emp_stat) {
		EmployeeVO employeeVO = new EmployeeVO();

		employeeVO.setEmp_no(emp_no);
		employeeVO.setEmp_name(emp_name);
		employeeVO.setEmp_sex(emp_sex);
		employeeVO.setEmp_acc(emp_acc);
		employeeVO.setEmp_pwd(emp_pwd);
		employeeVO.setEmp_hire(emp_hire);
		employeeVO.setEmp_resign(emp_resign);
		employeeVO.setEmp_stat(emp_stat);
		dao.update(employeeVO);
		return employeeVO;
	}

	public int deleteEmployee(String emp_no) {
		return dao.delete(emp_no);
	}

	public EmployeeVO getOneEmployee(String emp_no) {
		return dao.findByPrimaryKey(emp_no);
	}
	
	public EmployeeVO getOneEmployeeByAccount(String emp_acc) {
		return dao.findByEmp_acc(emp_acc);
	}
	
	public List<EmployeeVO> getOneEmployeeByName(String emp_name){
		return dao.findByEmployeeName(emp_name);
	}

	public List<EmployeeVO> getAll(){
		return dao.getAll();
	}
}
