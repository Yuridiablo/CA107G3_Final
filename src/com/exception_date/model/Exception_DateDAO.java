package com.exception_date.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.reservation_time.model.Reservation_TimeVO;

public class Exception_DateDAO implements Exception_DateDAO_Interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),?,?)";
	
	private static final String GET_ALL_STMT = 
			"SELECT EXC_NO, VENDOR_NO, EXC_DATE FROM EXCEPTION_DATE ORDER by EXC_NO";
	
	private static final String GET_ONE_STMT = 
			"SELECT EXC_NO, VENDOR_NO, EXC_DATE FROM EXCEPTION_DATE WHERE EXC_NO =?";
	
	private static final String GET_ALL_EXCDATE=
			"SELECT	* FROM EXCEPTION_DATE where (case when VENDOR_NO=? then 1 else 0 end+ case when EXC_NO=? then 1 else 0 end)>=1";
	
	private static final String DELETE = 
			"DELETE FROM EXCEPTION_DATE WHERE EXC_NO = ?";
	private static final String UPDATE = 
			"UPDATE EXCEPTION_DATE SET VENDOR_NO=?, EXC_DATE=? where EXC_NO=?";
	
	private static final String GET_ONE_BY_VENDOR = 
			"SELECT EXC_NO, VENDOR_NO, EXC_DATE FROM EXCEPTION_DATE WHERE VENDOR_NO =?";
	
	@Override
	public void insert(Exception_DateVO exception_dateVO) {
//		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, exception_dateVO.getVendor_no());
			pstmt.setDate(2, exception_dateVO.getExc_date());
			

			pstmt.executeUpdate();
				System.out.println("OK1");
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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

	}

	@Override
	public void update(Exception_DateVO exception_dateVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, exception_dateVO.getVendor_no() );
			pstmt.setDate(2, exception_dateVO.getExc_date() );
			pstmt.setString(3, exception_dateVO.getExc_no());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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


	}

	@Override
	public void delete(String exc_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, exc_no);

			pstmt.executeUpdate();
				System.out.println("OKOK");
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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


	}

	@Override
	public Exception_DateVO findByPrimaryKey(String exc_no) {
		Exception_DateVO exception_dateVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, exc_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				exception_dateVO = new Exception_DateVO();
				exception_dateVO.setExc_no(rs.getString("exc_no"));
				exception_dateVO.setVendor_no(rs.getString("vendor_no"));
				exception_dateVO.setExc_date(rs. getDate("exc_date"));
				
				
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		
	return exception_dateVO;
	}

	@Override
	public List<Exception_DateVO> getAll() {
		List<Exception_DateVO> list = new ArrayList<Exception_DateVO>();
		Exception_DateVO edVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				
				edVO = new Exception_DateVO();
				edVO.setExc_no(rs.getString("exc_no"));
				edVO.setVendor_no(rs.getString("vendor_no"));
				edVO.setExc_date(rs. getDate("exc_date"));
				
				
				list.add(edVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public List<Exception_DateVO> getAll(Map<String, String[]> map) {
		// TODO Auto-generated method stub
		return null;
	}

	public static void main(String[] args) {
		
		Exception_DateDAO dao = new Exception_DateDAO();
		Exception_DateVO edVO1 = new Exception_DateVO();
		
		//insert
//		resVO1.setVendor_no("V000003");
//		resVO1.setExc_date(java.sql.Date.valueOf("2018-07-25"));
//		
//		
//		System.out.println(edVO1);
//		dao.insert(edVO1);
//		System.out.println("OKK");
		
		
		//update
//		Exception_dateVO edVO2 = new Exception_dateVO();
//		resVO2 .setExc_no("ED00000004");
//		resVO2 .setVendor_no("V000004");
//		resVO2.setExc_date(java.sql.Date.valueOf("2018-07-25"));
//		
//		System.out.println(edVO2);
//		dao.update(edVO2);
		
		//delete
//		dao.delete("ED00000007");
//		System.out.println("OK");
//		
//		//findByPrimaryKey
//		
//		Exception_dateVO edVO3 = dao.findByPrimaryKey("ED00000005");
//		System.out.print(edVO3.getExc_no() + ",");
//		System.out.print(edVO3.getVendor_no() + ",");
//		System.out.print(edVO3.getExc_date() + ",");
//		
////		
//		System.out.println("---------------------");
		
		//findAll
		
//		List<Exception_DateVO> list = dao.getAll();
//			for (Exception_DateVO exc : list) {
//			System.out.print(exc.getExc_no() + ",");
//			System.out.print(exc.getVendor_no() + ",");
//			System.out.print(exc.getExc_date() + ",");
//			
//					
//			System.out.println("-------------------");
//				
//				}
			
			
			List<Exception_DateVO> list = dao.getdate("V000001");
			 for (Exception_DateVO res : list) {
				System.out.print(res.getExc_date());
//				System.out.println(list.size());
			}
		System.out.println(list.size());	
		
	}

	@Override
	public List<Exception_DateVO> getdate(String vendor_no) {
		
		List<Exception_DateVO> list = new ArrayList<Exception_DateVO>();
		Exception_DateVO exception_DateVO = null;
			System.out.println("come1");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_EXCDATE);
			pstmt.setString(1,vendor_no);
			pstmt.setString(2,vendor_no);
			rs = pstmt.executeQuery();
	
			
			
			while (rs.next()==true) {
				exception_DateVO = new Exception_DateVO();
				exception_DateVO.setExc_date(rs.getDate("exc_date"));
				
			
			list.add(exception_DateVO); // Store the row in the list
			System.out.println(list);
			
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public List<Exception_DateVO> find_by_vendor(String vendor_no) {
		List<Exception_DateVO> list = new ArrayList<Exception_DateVO>();
		Exception_DateVO exception_DateVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_VENDOR);
			pstmt.setString(1,vendor_no);
			rs = pstmt.executeQuery();
	
			
			
			while (rs.next()==true) {
				exception_DateVO = new Exception_DateVO();
				exception_DateVO.setExc_date(rs.getDate("exc_date"));
				exception_DateVO.setExc_no(rs.getString("exc_no"));
				exception_DateVO.setVendor_no(rs.getNString("vendor_no"));
				
			
			list.add(exception_DateVO); // Store the row in the list
			System.out.println(list);
			
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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

}
