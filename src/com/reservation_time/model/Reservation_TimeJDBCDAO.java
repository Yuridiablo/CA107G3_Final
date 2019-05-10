package com.reservation_time.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;



public class Reservation_TimeJDBCDAO implements Reservation_TimeDAO_Interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	final static String url = "jdbc:oracle:thin:@localhost:1521:XE";
	final static String userid = "CA107G3";
	final static String passwd = "123456";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "WEST";
//	String passwd = "800627";
	
	
	private static final String INSERT_STMT = "INSERT INTO RESERVATION_TIME VALUES('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),?,?)";
	
	private static final String GET_ALL_STMT = 
			"SELECT * FROM RESERVATION_TIME ";
	
	private static final String GET_ONE_STMT = 
			"SELECT RT_NO, VENDOR_NO, R_TIME FROM RESERVATION_TIME WHERE RT_NO =?";
	
	private static final String DELETE = 
			"DELETE FROM RESERVATION_TIME WHERE RT_NO = ?";
	private static final String UPDATE = 
			"UPDATE RESERVATION_TIME SET VENDOR_NO=?, R_TIME=? where RT_NO=?";
	
	private static final String CASE = "SELECT	* FROM RESERVATION_TIME where (case when VENDOR_NO=? then 1 else 0 end+ case when RT_NO=? then 1 else 0 end)>=1";
	
	private static final String GET_BY_VENDOR=
			"SELECT RT_NO, VENDOR_NO, R_TIME FROM RESERVATION_TIME WHERE VENDOR_NO =?";
	@Override
	public void insert(Reservation_TimeVO reservation_timeVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, reservation_timeVO.getVendor_no());
			pstmt.setString(2, reservation_timeVO.getR_time());
			

			pstmt.executeUpdate();
				System.out.println("OK1");
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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
	public void update(Reservation_TimeVO reservation_timeVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, reservation_timeVO.getVendor_no() );
			pstmt.setString(2, reservation_timeVO.getR_time() );
			pstmt.setString(3, reservation_timeVO.getRt_no() );
			
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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
	public void delete(String rt_no) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
//			pstmt = con.prepareStatement(DELETE);
//
//			pstmt.setString(1, rt_no);
//
//			pstmt.executeUpdate();
//				System.out.println("OKOK");
//			// Handle any driver errors
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. "
//					+ e.getMessage());
//			// Handle any SQL errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}

	}


	
	@Override
	public Reservation_TimeVO findByPrimaryKey(String rt_no) {
		Reservation_TimeVO reservation_timeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, rt_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				reservation_timeVO = new Reservation_TimeVO();
				reservation_timeVO.setRt_no(rs.getString("rt_no"));
				reservation_timeVO.setVendor_no(rs.getString("vendor_no"));
				reservation_timeVO.setR_time(rs. getString("r_time"));
				
				
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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
		
	return reservation_timeVO;
		
	}
	
	@Override
	public List<Reservation_TimeVO> getAll() {
		List<Reservation_TimeVO> list = new ArrayList<Reservation_TimeVO>();
		Reservation_TimeVO reservation_TimeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
			reservation_TimeVO = new Reservation_TimeVO();
			reservation_TimeVO.setR_time(rs.getString("R_time"));
			list.add(reservation_TimeVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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
	public List<Reservation_TimeVO> getVendor(String xxxId) {
		List<Reservation_TimeVO> list = new ArrayList<Reservation_TimeVO>();
		Reservation_TimeVO reservation_TimeVO = null;
			System.out.println("come");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(CASE);
			pstmt.setString(1, xxxId);
			pstmt.setString(2, xxxId);
			rs = pstmt.executeQuery();
	
			
			
			while (rs.next()==true) {
			reservation_TimeVO = new Reservation_TimeVO();
			reservation_TimeVO.setR_time(rs.getString("R_time"));
			
			list.add(reservation_TimeVO); // Store the row in the list
			System.out.println(list);
			
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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

	public static void main(String[] args) {
		
		Reservation_TimeJDBCDAO dao = new Reservation_TimeJDBCDAO();
		
		//insert
//		resVO1.setVendor_no("V000003");
//		resVO1.setR_time("2100");
//	
//		dao.insert(resVO1);
//		System.out.println(resVO1);
		
		
		//update
//		Reservation_TimeVO resVO2 = new Reservation_TimeVO();
//		resVO2 .setRt_no("RT00000009");
//		resVO2 .setVendor_no("V000004");
//		resVO2.setR_time("1100");
//		
//		System.out.println(resVO2);
//		dao.update(resVO2);
//		System.out.println("OK");
		
		
		//delete
//		dao.delete("RT00000007");
//		System.out.println("OK");
		
		//findByPrimaryKey
		
//		Reservation_TimeVO resVO3 = dao.findByPrimaryKey("RT00000001");
//		System.out.print(resVO3.getRt_no() + ",");
//		System.out.print(resVO3.getVendor_no() + ",");
//		System.out.print(resVO3.getR_time() + ",");
//		
//		
//		System.out.println("---------------------");
		
		//findAll
		List<Reservation_TimeVO> list = dao.getVendor("V000001");
		 for (Reservation_TimeVO res : list) {
			System.out.print(res.getR_time());
			System.out.println(list.size());
		}
	System.out.println(list.size());
	
	}

	@Override
	public List<Reservation_TimeVO> finby_v_no(String vendor_no) {
		
			List<Reservation_TimeVO> list = new ArrayList<Reservation_TimeVO>();
			Reservation_TimeVO reservation_TimeVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(GET_BY_VENDOR);
				pstmt.setString(1, vendor_no);
				rs = pstmt.executeQuery();
		
				
				
				while (rs.next()==true) {
				reservation_TimeVO = new Reservation_TimeVO();
				reservation_TimeVO.setR_time(rs.getString("R_time"));
				reservation_TimeVO.setRt_no(rs.getString("rt_no"));
				reservation_TimeVO.setVendor_no(rs.getString("vendor_no"));
				
				
				list.add(reservation_TimeVO); // Store the row in the list
				System.out.println(list);
				
				}

				// Handle any driver errors
			} catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver. "
						+ e.getMessage());
				// Handle any SQL errors
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
