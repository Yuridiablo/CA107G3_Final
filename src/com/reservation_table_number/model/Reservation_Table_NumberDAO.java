package com.reservation_table_number.model;

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

public class Reservation_Table_NumberDAO implements Reservation_Table_NumberDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),?,?,?,?,?,?)";
	
	private static final String GET_ALL_STMT = 
			"SELECT RTN_NO, VENDOR_NO, RTBL_O_NUM1,RTBL_O_NUM2, RTBL_O_NUM3,RTBL_O_NUM4,RTBL_O_NUM5 FROM RESERVATION_TABLE_NUMBER order by RTN_NO";
	
	private static final String GET_ONE_STMT = 
			"SELECT RTN_NO, VENDOR_NO, RTBL_O_NUM1,RTBL_O_NUM2, RTBL_O_NUM3,RTBL_O_NUM4,RTBL_O_NUM5 FROM RESERVATION_TABLE_NUMBER WHERE RTN_NO =?";
	private static final String GET_ONE_STMT_V = 
			"SELECT RTN_NO, VENDOR_NO, RTBL_O_NUM1,RTBL_O_NUM2, RTBL_O_NUM3,RTBL_O_NUM4,RTBL_O_NUM5 FROM RESERVATION_TABLE_NUMBER WHERE VENDOR_NO =?";
	private static final String DELETE_V = 
			"DELETE FROM RESERVATION_TABLE_NUMBER WHERE VENDOR_NO = ?";
	private static final String DELETE = 
			"DELETE FROM RESERVATION_TABLE_NUMBER WHERE RTN_NO = ?";
	private static final String UPDATE = 
			"UPDATE RESERVATION_TABLE_NUMBER SET VENDOR_NO=?, RTBL_O_NUM1=?,RTBL_O_NUM2=?,RTBL_O_NUM3=?,RTBL_O_NUM4=?,RTBL_O_NUM5=? where RTN_NO=?";
	private static final String UPDATE_T1 = 
			"UPDATE RESERVATION_TABLE_NUMBER SET RTBL_O_NUM1=? where VENDOR_NO=?";
	private static final String UPDATE_T2 = 
			"UPDATE RESERVATION_TABLE_NUMBER SET RTBL_O_NUM2=? where VENDOR_NO=?";
	private static final String UPDATE_T3 = 
			"UPDATE RESERVATION_TABLE_NUMBER SET RTBL_O_NUM3=? where VENDOR_NO=?";
	private static final String UPDATE_T4 = 
			"UPDATE RESERVATION_TABLE_NUMBER SET RTBL_O_NUM4=? where VENDOR_NO=?";
	private static final String UPDATE_T5 = 
			"UPDATE RESERVATION_TABLE_NUMBER SET RTBL_O_NUM5=? where VENDOR_NO=?";
	
	private static final String GET_BY_VENDOR = 
			"SELECT * FROM RESERVATION_TABLE_NUMBER WHERE VENDOR_NO=?";
	
	
	@Override
	public void insert(Reservation_Table_NumberVO reservation_table_numberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, reservation_table_numberVO.getVendor_no());
			pstmt.setInt(2, reservation_table_numberVO.getRtbl_o_num1());
			pstmt.setInt(3, reservation_table_numberVO.getRtbl_o_num2());
			pstmt.setInt(4, reservation_table_numberVO.getRtbl_o_num3());
			pstmt.setInt(5, reservation_table_numberVO.getRtbl_o_num4());
			pstmt.setInt(6, reservation_table_numberVO.getRtbl_o_num5());

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
	public void update(Reservation_Table_NumberVO reservation_table_numberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, reservation_table_numberVO.getVendor_no() );
			pstmt.setInt(2, reservation_table_numberVO.getRtbl_o_num1() );
			pstmt.setInt(3, reservation_table_numberVO.getRtbl_o_num2());
			pstmt.setInt(4, reservation_table_numberVO.getRtbl_o_num3());
			pstmt.setInt(5, reservation_table_numberVO.getRtbl_o_num4());
			pstmt.setInt(6, reservation_table_numberVO.getRtbl_o_num5());
			pstmt.setString(7, reservation_table_numberVO.getRtn_no());
			

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
	public void delete(String rtn_no) {
		
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			Class.forName(driver);
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(DELETE);
//
//			pstmt.setString(1, rtn_no);
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
	public Reservation_Table_NumberVO findByPrimaryKey(String rtn_no) {
		Reservation_Table_NumberVO reservation_Table_NumberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, rtn_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				reservation_Table_NumberVO = new Reservation_Table_NumberVO();
				reservation_Table_NumberVO.setRtn_no(rs.getString("rtn_no"));
				reservation_Table_NumberVO.setVendor_no(rs.getString("vendor_no"));
				reservation_Table_NumberVO.setRtbl_o_num1(rs.getInt("Rtbl_o_num1"));
				reservation_Table_NumberVO.setRtbl_o_num2(rs.getInt("Rtbl_o_num2"));
				reservation_Table_NumberVO.setRtbl_o_num3(rs.getInt("Rtbl_o_num3"));
				reservation_Table_NumberVO.setRtbl_o_num4(rs.getInt("Rtbl_o_num4"));
				reservation_Table_NumberVO.setRtbl_o_num5(rs.getInt("Rtbl_o_num5"));
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
		
	return reservation_Table_NumberVO;
	}

	@Override
	public List<Reservation_Table_NumberVO> getAll() {
		
			List<Reservation_Table_NumberVO> list = new ArrayList<Reservation_Table_NumberVO>();
			Reservation_Table_NumberVO resVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					
					
					resVO = new Reservation_Table_NumberVO();
					resVO.setRtn_no(rs.getString("rtn_no"));
					resVO.setVendor_no(rs.getString("vendor_no"));
					resVO.setRtbl_o_num1(rs. getInt("Rtbl_o_num1"));
					resVO.setRtbl_o_num2(rs. getInt("Rtbl_o_num2"));
					resVO.setRtbl_o_num3(rs. getInt("Rtbl_o_num3"));
					resVO.setRtbl_o_num4(rs. getInt("Rtbl_o_num4"));
					resVO.setRtbl_o_num5(rs. getInt("Rtbl_o_num5"));
					
					list.add(resVO); // Store the row in the list
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
	public List<Reservation_Table_NumberVO> getAll(Map<String, String[]> map) {
		// TODO Auto-generated method stub
		return null;
	}

	public static void main(String[] args) {
		

		Reservation_Table_NumberDAO dao = new Reservation_Table_NumberDAO();
		Reservation_Table_NumberVO resVO1 = new Reservation_Table_NumberVO();
		
		//insert
//		resVO1.setVendor_no("V000003");
//		resVO1.setRtbl_o_num1(2);
//		resVO1.setRtbl_o_num2(6);
//		resVO1.setRtbl_o_num3(3);
//		resVO1.setRtbl_o_num4(5);
//		resVO1.setRtbl_o_num5(7);
//		System.out.println(resVO1);
//		dao.insert(resVO1);
//		System.out.println("OK");
		
		//update
//		Reservation_Table_NumberVO resVO2 = new Reservation_Table_NumberVO();
//		resVO2 .setRtn_no("ETN0000004");
//		resVO2 .setVendor_no("V000004");
//		resVO2.setRtbl_o_num1(6);
//		resVO2 .setRtbl_o_num2(5);
//		resVO2 .setRtbl_o_num3(3);
//		resVO2 .setRtbl_o_num4(5);
//		resVO2 .setRtbl_o_num5(5);
//		System.out.println(resVO2);
//		dao.update(resVO2);
//		System.out.println("OK");
		
//		delete
//		dao.delete("ETN0000004");
//		System.out.println("OK");
		
		//findByPrimaryKey
		
//		Reservation_Table_NumberVO resVO3 = dao.findByPrimaryKey("ETN0000005");
//		System.out.print(resVO3.getRtn_no() + ",");
//		System.out.print(resVO3.getVendor_no() + ",");
//		System.out.print(resVO3.getRtbl_o_num1() + ",");
//		System.out.print(resVO3.getRtbl_o_num2() + ",");
//		System.out.print(resVO3.getRtbl_o_num3() + ",");
//		System.out.print(resVO3.getRtbl_o_num4() + ",");
//		System.out.print(resVO3.getRtbl_o_num5() + ",");
//		
//		System.out.println("---------------------");
		
		//findAll
		
				List<Reservation_Table_NumberVO> list = dao.findBy_vendor("V000001");
				for (Reservation_Table_NumberVO res : list) {
					System.out.print(res.getRtn_no() + ",");
					System.out.print(res.getVendor_no() + ",");
					System.out.print(res.getRtbl_o_num1() + ",");
					System.out.print(res.getRtbl_o_num2() + ",");
					System.out.print(res.getRtbl_o_num3() + ",");
					System.out.print(res.getRtbl_o_num4() + ",");
					System.out.print(res.getRtbl_o_num5() + ",");
					
					System.out.println("-------------------");
	}
	}
	
	@Override
	public List<Reservation_Table_NumberVO> findBy_vendor(String vendor_no) {
		List<Reservation_Table_NumberVO> list = new ArrayList<Reservation_Table_NumberVO>();
		Reservation_Table_NumberVO resVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_VENDOR);
			pstmt.setString(1, vendor_no);
			rs = pstmt.executeQuery();
			
			
			while (rs.next()) {

				
				
				resVO = new Reservation_Table_NumberVO();
				
				resVO.setRtn_no(rs.getString("rtn_no"));
				resVO.setVendor_no(rs.getString("vendor_no"));
				resVO.setRtbl_o_num1(rs. getInt("Rtbl_o_num1"));
				resVO.setRtbl_o_num2(rs. getInt("Rtbl_o_num2"));
				resVO.setRtbl_o_num3(rs. getInt("Rtbl_o_num3"));
				resVO.setRtbl_o_num4(rs. getInt("Rtbl_o_num4"));
				resVO.setRtbl_o_num5(rs. getInt("Rtbl_o_num5"));
				
				list.add(resVO); // Store the row in the list
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
	public void deleteV_no(String vendor_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_V);

			pstmt.setString(1, vendor_no);

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
	public Reservation_Table_NumberVO findByV_no(String vendor_no) {
		Reservation_Table_NumberVO reservation_Table_NumberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_V);

			pstmt.setString(1, vendor_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				reservation_Table_NumberVO = new Reservation_Table_NumberVO();
				reservation_Table_NumberVO.setRtn_no(rs.getString("rtn_no"));
				reservation_Table_NumberVO.setVendor_no(rs.getString("vendor_no"));
				reservation_Table_NumberVO.setRtbl_o_num1(rs.getInt("Rtbl_o_num1"));
				reservation_Table_NumberVO.setRtbl_o_num2(rs.getInt("Rtbl_o_num2"));
				reservation_Table_NumberVO.setRtbl_o_num3(rs.getInt("Rtbl_o_num3"));
				reservation_Table_NumberVO.setRtbl_o_num4(rs.getInt("Rtbl_o_num4"));
				reservation_Table_NumberVO.setRtbl_o_num5(rs.getInt("Rtbl_o_num5"));
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
		
		return reservation_Table_NumberVO;
	}

	@Override
	public void update_t1(Reservation_Table_NumberVO reservation_table_numberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_T1);
			
			pstmt.setInt(1, reservation_table_numberVO.getRtbl_o_num1() );
			pstmt.setString(2, reservation_table_numberVO.getVendor_no() );

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
	public void update_t2(Reservation_Table_NumberVO reservation_table_numberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_T2);
			
			pstmt.setInt(1, reservation_table_numberVO.getRtbl_o_num2() );
			pstmt.setString(2, reservation_table_numberVO.getVendor_no() );

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
	public void update_t3(Reservation_Table_NumberVO reservation_table_numberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_T3);
			
			pstmt.setInt(1, reservation_table_numberVO.getRtbl_o_num3() );
			pstmt.setString(2, reservation_table_numberVO.getVendor_no() );

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
	public void update_t4(Reservation_Table_NumberVO reservation_table_numberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_T4);
			
			pstmt.setInt(1, reservation_table_numberVO.getRtbl_o_num4() );
			pstmt.setString(2, reservation_table_numberVO.getVendor_no() );

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
	public void update_t5(Reservation_Table_NumberVO reservation_table_numberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_T5);
			
			pstmt.setInt(1, reservation_table_numberVO.getRtbl_o_num5() );
			pstmt.setString(2, reservation_table_numberVO.getVendor_no() );

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
}
