package com.employee.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.news.model.NewsVO;

public class EmployeeDAO implements EmployeeDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO employee (emp_no,emp_name,emp_sex,emp_acc,emp_pwd,emp_mail,emp_hire,emp_resign,emp_stat) VALUES ('E'||LPAD(to_char(EMPLOYEE_SEQ.nextval), 9, '0'), ?, ?, ?, ?, ?, ?,?,?)";
	private static final String GET_ALL_STMT = "SELECT emp_no,emp_name,emp_sex,emp_acc,emp_pwd,emp_mail,to_char(emp_hire,'yyyy-mm-dd') emp_hire,to_char(emp_resign,'yyyy-mm-dd') emp_resign,emp_stat FROM employee order by emp_no";
	private static final String GET_ALL_STMT_BYNAME = "SELECT emp_no,emp_name,emp_sex,emp_acc,emp_pwd,emp_mail,to_char(emp_hire,'yyyy-mm-dd') emp_hire,to_char(emp_resign,'yyyy-mm-dd') emp_resign,emp_stat FROM employee where emp_name=? order by emp_no";
	private static final String GET_ONE_STMT_BYACCOUNT = "SELECT emp_no,emp_name,emp_sex,emp_acc,emp_pwd,emp_mail,to_char(emp_hire,'yyyy-mm-dd') emp_hire,to_char(emp_resign,'yyyy-mm-dd') emp_resign,emp_stat FROM employee where emp_acc=?";
	private static final String GET_ONE_STMT = "SELECT emp_no,emp_name,emp_sex,emp_acc,emp_pwd,emp_mail,to_char(emp_hire,'yyyy-mm-dd') emp_hire,to_char(emp_resign,'yyyy-mm-dd') emp_resign,emp_stat FROM employee where emp_no = ?";
	private static final String DELETE = "DELETE FROM employee where emp_no = ?";
	private static final String UPDATE = "UPDATE employee set emp_name=?, emp_pwd=?,emp_hire=?, emp_resign=?, emp_stat=? where emp_no = ?";

	@Override
	public int insert(EmployeeVO employeeVO) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, employeeVO.getEmp_name());
			pstmt.setString(2, employeeVO.getEmp_sex());
			pstmt.setString(3, employeeVO.getEmp_acc());
			pstmt.setString(4, employeeVO.getEmp_mail());
			pstmt.setString(5, employeeVO.getEmp_pwd());
			pstmt.setDate(6, employeeVO.getEmp_hire());
			pstmt.setDate(7, employeeVO.getEmp_resign());
			pstmt.setInt(8, employeeVO.getEmp_stat());

			updateCount = pstmt.executeUpdate();
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return updateCount;
	}

	@Override
	public EmployeeVO findByEmp_acc(String emp_acc) {
		EmployeeVO employeeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_BYACCOUNT);

			pstmt.setString(1, emp_acc);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(rs.getString("emp_no"));
				employeeVO.setEmp_name(rs.getString("emp_name"));
				employeeVO.setEmp_sex(rs.getString("emp_sex"));
				employeeVO.setEmp_acc(rs.getString("emp_acc"));
				employeeVO.setEmp_pwd(rs.getString("emp_pwd"));
				employeeVO.setEmp_mail(rs.getString("emp_mail"));
				employeeVO.setEmp_hire(rs.getDate("emp_hire"));
				employeeVO.setEmp_resign(rs.getDate("emp_resign"));
				employeeVO.setEmp_stat(rs.getInt("emp_stat"));
			} // Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return employeeVO;
	}

	@Override
	public List<EmployeeVO> findByEmployeeName(String emp_name) {
		List<EmployeeVO> list = new ArrayList<EmployeeVO>();
		EmployeeVO employeeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT_BYNAME);
			
			pstmt.setString(1, emp_name);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(rs.getString("emp_no"));
				employeeVO.setEmp_name(rs.getString("emp_name"));
				employeeVO.setEmp_sex(rs.getString("emp_sex"));
				employeeVO.setEmp_acc(rs.getString("emp_acc"));
				employeeVO.setEmp_pwd(rs.getString("emp_pwd"));
				employeeVO.setEmp_mail(rs.getString("emp_mail"));
				employeeVO.setEmp_hire(rs.getDate("emp_hire"));
				employeeVO.setEmp_resign(rs.getDate("emp_resign"));
				employeeVO.setEmp_stat(rs.getInt("emp_stat"));
				list.add(employeeVO); // Store the row in the vector
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

 


	@Override
	public int update(EmployeeVO employeeVO) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, employeeVO.getEmp_name());
			pstmt.setString(2, employeeVO.getEmp_pwd());
			pstmt.setDate(3, employeeVO.getEmp_hire());
			pstmt.setDate(4, employeeVO.getEmp_resign());
			pstmt.setInt(5, employeeVO.getEmp_stat());
			pstmt.setString(6, employeeVO.getEmp_no());

			updateCount = pstmt.executeUpdate();
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return updateCount;
	}

	@Override
	public int delete(String emp_no) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, emp_no);

			updateCount = pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return updateCount;
	}

	@Override
	public EmployeeVO findByPrimaryKey(String emp_no) {
		EmployeeVO employeeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, emp_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(rs.getString("emp_no"));
				employeeVO.setEmp_name(rs.getString("emp_name"));
				employeeVO.setEmp_sex(rs.getString("emp_sex"));
				employeeVO.setEmp_acc(rs.getString("emp_acc"));
				employeeVO.setEmp_pwd(rs.getString("emp_pwd"));
				employeeVO.setEmp_mail(rs.getString("emp_mail"));
				employeeVO.setEmp_hire(rs.getDate("emp_hire"));
				employeeVO.setEmp_resign(rs.getDate("emp_resign"));
				employeeVO.setEmp_stat(rs.getInt("emp_stat"));
			} // Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return employeeVO;
	}

	public List<EmployeeVO> getAll() {
		List<EmployeeVO> list = new ArrayList<EmployeeVO>();
		EmployeeVO employeeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(rs.getString("emp_no"));
				employeeVO.setEmp_name(rs.getString("emp_name"));
				employeeVO.setEmp_sex(rs.getString("emp_sex"));
				employeeVO.setEmp_acc(rs.getString("emp_acc"));
				employeeVO.setEmp_pwd(rs.getString("emp_pwd"));
				employeeVO.setEmp_mail(rs.getString("emp_mail"));
				employeeVO.setEmp_hire(rs.getDate("emp_hire"));
				employeeVO.setEmp_resign(rs.getDate("emp_resign"));
				employeeVO.setEmp_stat(rs.getInt("emp_stat"));
				list.add(employeeVO); // Store the row in the vector
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	public static void main(String[] args) {

		EmployeeDAO dao = new EmployeeDAO();

		// 新增
//		 EmployeeVO empVO1 = new EmployeeVO();
//		 empVO1.setEmp_name("吳永志1");
//		 empVO1.setEmp_sex("M");
//		 empVO1.setEmp_acc("p123");
//		 empVO1.setEmp_pwd("123456");
//		 empVO1.setEmp_hire(java.sql.Date.valueOf("2005-01-01"));
//		 empVO1.setEmp_stat(1);
//		 int updateCount_insert = dao.insert(empVO1);
//		 System.out.println(updateCount_insert);

		// 修改
//		 EmployeeVO empVO2 = new EmployeeVO();
//		 empVO2.setEmp_name("鄒藤正");
//		 empVO2.setEmp_pwd("111222");
//		 empVO2.setEmp_resign(java.sql.Date.valueOf("2019-01-01"));
//		 empVO2.setEmp_stat(2);
//		 empVO2.setEmp_no("E000000002");
//		 int updateCount_update = dao.update(empVO2);
//		 System.out.println(updateCount_update);

		// 刪除
//		 int updateCount_delete = dao.delete("E000000007");
//		 System.out.println(updateCount_delete);

		// 查詢
//		EmployeeVO empVO3 = dao.findByPrimaryKey("E000000001");
//		System.out.print(empVO3.getEmp_no() + ",");
//		System.out.print(empVO3.getEmp_name() + ",");
//		System.out.print(empVO3.getEmp_sex() + ",");
//		System.out.print(empVO3.getEmp_acc() + ",");
//		System.out.print(empVO3.getEmp_pwd() + ",");
//		System.out.print(empVO3.getEmp_hire() + ",");
//		System.out.print(empVO3.getEmp_resign() + ",");
//		System.out.print(empVO3.getEmp_stat());
//		System.out.println("---------------------");

		// 查詢
//		List<EmployeeVO> list = dao.getAll();
//		for (EmployeeVO aEmp : list) {
//			System.out.print(aEmp.getEmp_no() + ",");
//			System.out.print(aEmp.getEmp_name() + ",");
//			System.out.print(aEmp.getEmp_sex() + ",");
//			System.out.print(aEmp.getEmp_acc() + ",");
//			System.out.print(aEmp.getEmp_pwd() + ",");
//			System.out.print(aEmp.getEmp_hire() + ",");
//			System.out.print(aEmp.getEmp_resign() + ",");
//			System.out.print(aEmp.getEmp_stat());
//			System.out.println();
//		}
	}
}
