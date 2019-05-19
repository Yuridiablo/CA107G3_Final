package com.reservation_table_ordered.model;

import java.sql.Connection;
import java.sql.Date;
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
import com.restaurant_transaction_list.model.RES_Transaction_ListVO;



public class Reservation_Table_OrderedDAO implements Reservation_Table_OrderedDAO_interface {
		
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String GET_ALL_STMT = 
			"SELECT RTO_NO, VENDOR_NO, BOOKING_DATE,BOOKING_TIME, TBL_O_NUM1, TBL_O_NUM2, TBL_O_NUM3, TBL_O_NUM4, TBL_O_NUM5,TBL_ORDERED1,TBL_ORDERED2,TBL_ORDERED3,TBL_ORDERED4,TBL_ORDERED5 FROM RESERVATION_TABLE_ORDERED ORDER BY RTO_NO";
	
	private static final String GET_ONE_STMT = 
			"SELECT RTO_NO, VENDOR_NO, BOOKING_DATE,BOOKING_TIME, TBL_O_NUM1, TBL_O_NUM2, TBL_O_NUM3, TBL_O_NUM4, TBL_O_NUM5,TBL_ORDERED1,TBL_ORDERED2,TBL_ORDERED3,TBL_ORDERED4,TBL_ORDERED5 FROM RESERVATION_TABLE_ORDERED WHERE RTO_NO =?";
	
	private static final String DELETE = 
			"DELETE FROM RESERVATION_TABLE_ORDERED where RTO_NO = ?";
	private static final String UPDATE = 
			"UPDATE RESERVATION_TABLE_ORDERED set VENDOR_NO=?, BOOKING_DATE=?,BOOKING_TIME=?, TBL_O_NUM1=?, TBL_O_NUM2=?, TBL_O_NUM3=?, TBL_O_NUM4=?, TBL_O_NUM5=?,TBL_ORDERED1=?,TBL_ORDERED2=?,TBL_ORDERED3=?,TBL_ORDERED4=?,TBL_ORDERED5=? where RTO_NO=?";
	private static final String GET_2TB ="select BOOKING_TIME, RTO_NO from (select RTO_NO,BOOKING_TIME , TBL_O_NUM1 - TBL_ORDERED1 as tbl_remain from reservation_table_ordered where VENDOR_NO=? and BOOKING_DATE=? )where tbl_remain > 0";
	private static final String GET_4TB ="select BOOKING_TIME, RTO_NO from (select RTO_NO,BOOKING_TIME , TBL_O_NUM2 - TBL_ORDERED2 as tbl_remain from reservation_table_ordered where VENDOR_NO=? and BOOKING_DATE=? )where tbl_remain > 0";
	private static final String GET_6TB ="select BOOKING_TIME, RTO_NO from (select RTO_NO,BOOKING_TIME , TBL_O_NUM3 - TBL_ORDERED3 as tbl_remain from reservation_table_ordered where VENDOR_NO=? and BOOKING_DATE=? )where tbl_remain > 0";
	private static final String GET_8TB ="select BOOKING_TIME, RTO_NO from (select RTO_NO,BOOKING_TIME , TBL_O_NUM4 - TBL_ORDERED4 as tbl_remain from reservation_table_ordered where VENDOR_NO=? and BOOKING_DATE=? )where tbl_remain > 0";
	private static final String GET_10TB ="select BOOKING_TIME, RTO_NO from (select RTO_NO,BOOKING_TIME , TBL_O_NUM5 - TBL_ORDERED5 as tbl_remain from reservation_table_ordered where VENDOR_NO=? and BOOKING_DATE=? )where tbl_remain > 0";

	//	TO_DATE(?,'yyyy-MM-dd') )
	@Override
	public void insert(Reservation_Table_OrderedVO reservation_Table_OrderedVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, reservation_Table_OrderedVO.getVendor_no());
			pstmt.setDate(2, reservation_Table_OrderedVO.getBooking_date());
			pstmt.setString(3, reservation_Table_OrderedVO.getBooking_time());
			pstmt.setInt(4, reservation_Table_OrderedVO.getTbl_o_num1());
			pstmt.setInt(5, reservation_Table_OrderedVO.getTbl_o_num2());
			pstmt.setInt(6, reservation_Table_OrderedVO.getTbl_o_num3());
			pstmt.setInt(7, reservation_Table_OrderedVO.getTbl_o_num4());
			pstmt.setInt(8, reservation_Table_OrderedVO.getTbl_o_num5());
			pstmt.setInt(9, reservation_Table_OrderedVO.getTbl_ordered1());
			pstmt.setInt(10, reservation_Table_OrderedVO.getTbl_ordered2());
			pstmt.setInt(11, reservation_Table_OrderedVO.getTbl_ordered3());
			pstmt.setInt(12, reservation_Table_OrderedVO.getTbl_ordered4());
			pstmt.setInt(13, reservation_Table_OrderedVO.getTbl_ordered5());
			

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
	public void update(Reservation_Table_OrderedVO reservation_Table_OrderedVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, reservation_Table_OrderedVO.getVendor_no() );
			pstmt.setDate(2, reservation_Table_OrderedVO.getBooking_date() );
			pstmt.setString(3, reservation_Table_OrderedVO.getBooking_time());
			pstmt.setInt(4, reservation_Table_OrderedVO.getTbl_o_num1());
			pstmt.setInt(5, reservation_Table_OrderedVO.getTbl_o_num2());
			pstmt.setInt(6, reservation_Table_OrderedVO.getTbl_o_num3());
			pstmt.setInt(7, reservation_Table_OrderedVO.getTbl_o_num4());
			pstmt.setInt(8, reservation_Table_OrderedVO.getTbl_o_num5());
			pstmt.setInt(9, reservation_Table_OrderedVO.getTbl_ordered1());
			pstmt.setInt(10, reservation_Table_OrderedVO.getTbl_ordered2());
			pstmt.setInt(11, reservation_Table_OrderedVO.getTbl_ordered3());
			pstmt.setInt(12, reservation_Table_OrderedVO.getTbl_ordered4());
			pstmt.setInt(13, reservation_Table_OrderedVO.getTbl_ordered5());
			pstmt.setString(14, reservation_Table_OrderedVO.getRto_no());
			
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
	public void delete(String rto_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, rto_no);

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
	public Reservation_Table_OrderedVO findByPrimaryKey(String rto_no) {
		Reservation_Table_OrderedVO reservation_Table_OrderedVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, rto_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				reservation_Table_OrderedVO = new Reservation_Table_OrderedVO();
				
				reservation_Table_OrderedVO.setRto_no(rs.getString("rto_no"));
				reservation_Table_OrderedVO.setVendor_no(rs.getString("vendor_no"));
				reservation_Table_OrderedVO.setBooking_date(rs. getDate("booking_date"));
				reservation_Table_OrderedVO.setBooking_time(rs.getString("booking_time"));
				reservation_Table_OrderedVO.setTbl_o_num1(rs.getInt("tbl_o_num1"));
				reservation_Table_OrderedVO.setTbl_o_num2(rs.getInt("tbl_o_num2"));
				reservation_Table_OrderedVO.setTbl_o_num3(rs.getInt("tbl_o_num3"));
				reservation_Table_OrderedVO.setTbl_o_num4(rs.getInt("tbl_o_num4"));
				reservation_Table_OrderedVO.setTbl_o_num5(rs.getInt("tbl_o_num5"));
				reservation_Table_OrderedVO.setTbl_ordered1(rs.getInt("tbl_ordered1"));
				reservation_Table_OrderedVO.setTbl_ordered2(rs.getInt("tbl_ordered2"));
				reservation_Table_OrderedVO.setTbl_ordered3(rs.getInt("tbl_ordered3"));
				reservation_Table_OrderedVO.setTbl_ordered4(rs.getInt("tbl_ordered4"));
				reservation_Table_OrderedVO.setTbl_ordered5(rs.getInt("tbl_ordered5"));
				
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
		
	return reservation_Table_OrderedVO;
	}

	@Override
	public List<Reservation_Table_OrderedVO> getAll() {
		List<Reservation_Table_OrderedVO> list = new ArrayList<Reservation_Table_OrderedVO>();
		Reservation_Table_OrderedVO resVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				
				resVO = new Reservation_Table_OrderedVO();
				
				resVO.setRto_no(rs.getString("rto_no"));
				resVO.setVendor_no(rs.getString("vendor_no"));
				resVO.setBooking_date(rs. getDate("booking_date"));
				resVO.setBooking_time(rs.getString("booking_time"));
				resVO.setTbl_o_num1(rs.getInt("tbl_o_num1"));
				resVO.setTbl_o_num2(rs.getInt("tbl_o_num2"));
				resVO.setTbl_o_num3(rs.getInt("tbl_o_num3"));
				resVO.setTbl_o_num4(rs.getInt("tbl_o_num4"));
				resVO.setTbl_o_num5(rs.getInt("tbl_o_num5"));
				resVO.setTbl_ordered1(rs.getInt("tbl_ordered1"));
				resVO.setTbl_ordered2(rs.getInt("tbl_ordered2"));
				resVO.setTbl_ordered3(rs.getInt("tbl_ordered3"));
				resVO.setTbl_ordered4(rs.getInt("tbl_ordered4"));
				resVO.setTbl_ordered5(rs.getInt("tbl_ordered5"));
				
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
	public List<Reservation_Table_OrderedVO> getAll(Map<String, String[]> map) {
		// TODO Auto-generated method stub
		return null;
	}

	public static void main(String[] args) {


		Reservation_Table_OrderedDAO dao = new Reservation_Table_OrderedDAO();
		Reservation_Table_OrderedVO resVO1 = new Reservation_Table_OrderedVO();
		
		//insert
//		resVO1.setVendor_no("V000003");
//		resVO1.setBooking_date(java.sql.Date.valueOf("2018-07-25"));
//		resVO1.setBooking_time("18:00");
//		resVO1.setTbl_o_num1(3);
//		resVO1.setTbl_o_num2(2);
//		resVO1.setTbl_o_num3(1);
//		resVO1.setTbl_o_num4(5);
//		resVO1.setTbl_o_num5(1);
//		resVO1.setTbl_ordered1(2);
//		resVO1.setTbl_ordered2(2);
//		resVO1.setTbl_ordered3(2);
//		resVO1.setTbl_ordered4(1);
//		resVO1.setTbl_ordered5(0);
//		
//		System.out.println(resVO1);
//		dao.insert(resVO1);
//		System.out.println("oKOK");
		
		//update
//		Reservation_Table_OrderedVO resVO2 = new Reservation_Table_OrderedVO();
//		resVO2 .setRto_no("V000002");
//		resVO2.setBooking_date(java.sql.Date.valueOf("2018-07-25"));
//		resVO2.setBooking_time("18:00");
//		resVO2.setTbl_o_num1(3);
//		resVO2.setTbl_o_num2(2);
//		resVO2.setTbl_o_num3(1);
//		resVO2.setTbl_o_num4(5);
//		resVO2.setTbl_o_num5(1);
//		resVO2.setTbl_ordered1(2);
//		resVO2.setTbl_ordered2(2);
//		resVO2.setTbl_ordered3(2);
//		resVO2.setTbl_ordered4(1);
//		resVO2.setTbl_ordered5(0);
//		System.out.println(resVO2);
//		dao.update(resVO2);
//		System.out.println("OKOKOK");

		//delete
//		dao.delete("RTO0000006");
//		System.out.println("OK");
		
		//findByPrimaryKey
		
//		Reservation_Table_OrderedVO resVO3 = dao.findByPrimaryKey("RTO0000001");
//		System.out.print(resVO3.getRto_no() + ",");
//		System.out.print(resVO3.getVendor_no() + ",");
//		System.out.print(resVO3.getBooking_date() + ",");
//		System.out.print(resVO3.getBooking_time() + ",");
//		System.out.print(resVO3.getTbl_o_num1() + ",");
//		System.out.print(resVO3.getTbl_o_num2() + ",");
//		System.out.print(resVO3.getTbl_o_num3() + ",");
//		System.out.print(resVO3.getTbl_o_num4() + ",");
//		System.out.print(resVO3.getTbl_o_num5() + ",");
//		System.out.print(resVO3.getTbl_ordered1() + ",");
//		System.out.print(resVO3.getTbl_ordered2() + ",");
//		System.out.print(resVO3.getTbl_ordered3() + ",");
//		System.out.print(resVO3.getTbl_ordered4() + ",");
//		System.out.print(resVO3.getTbl_ordered5() + ",");
//		
//		System.out.println("---------------------");
		
		//findAll
//		
//				List<Reservation_Table_OrderedVO> list = dao.getAll();
//				for (Reservation_Table_OrderedVO res : list) {
//					System.out.print(res.getRto_no() + ",");
//					System.out.print(res.getVendor_no() + ",");
//					System.out.print(res.getBooking_date() + ",");
//					System.out.print(res.getBooking_time() + ",");
//					System.out.print(res.getTbl_o_num1() + ",");
//					System.out.print(res.getTbl_o_num2() + ",");
//					System.out.print(res.getTbl_o_num3() + ",");
//					System.out.print(res.getTbl_o_num4() + ",");
//					System.out.print(res.getTbl_o_num5() + ",");
//					System.out.print(res.getTbl_ordered1() + ",");
//					System.out.print(res.getTbl_ordered2() + ",");
//					System.out.print(res.getTbl_ordered3() + ",");
//					System.out.print(res.getTbl_ordered4() + ",");
//					System.out.print(res.getTbl_ordered5() + ",");
//					
//					System.out.println("-------------------");
//				
//				}
				
				//get
				List<Reservation_Table_OrderedVO> list = dao.get2table("V000001", (java.sql.Date.valueOf("2018-07-20")));
				 for (Reservation_Table_OrderedVO res : list) {
					System.out.println(res.getBooking_time());
					
				}
			
				
				
				
		
	}

	

	@Override
	public List<Reservation_Table_OrderedVO> get2table(String vendor_no, Date booking_date) {
		
		
		List<Reservation_Table_OrderedVO> list = new ArrayList<Reservation_Table_OrderedVO>();
		Reservation_Table_OrderedVO reservation_Table_OrderedVO = null;
			System.out.println("hello");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_2TB);
			pstmt.setString(1, vendor_no);
			pstmt.setDate(2, booking_date);
			rs = pstmt.executeQuery();
			
			
			
			while (rs.next()==true) {
				reservation_Table_OrderedVO = new Reservation_Table_OrderedVO();
				reservation_Table_OrderedVO.setBooking_time(rs.getString("booking_time"));
				reservation_Table_OrderedVO.setRto_no(rs.getString("rto_no"));
//				reservation_Table_OrderedVO.setVendor_no(rs.getString("vendor_no"));
				System.out.println("hello1");
			
			list.add(reservation_Table_OrderedVO); // Store the row in the list
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
	public List<Reservation_Table_OrderedVO> get4table(String vendor_no, Date booking_date) {
		List<Reservation_Table_OrderedVO> list = new ArrayList<Reservation_Table_OrderedVO>();
		Reservation_Table_OrderedVO reservation_Table_OrderedVO = null;
			System.out.println("hello");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_4TB);
			pstmt.setString(1, vendor_no);
			pstmt.setDate(2, booking_date);
			rs = pstmt.executeQuery();
			
			
			
			while (rs.next()==true) {
				reservation_Table_OrderedVO = new Reservation_Table_OrderedVO();
				reservation_Table_OrderedVO.setBooking_time(rs.getString("booking_time"));
				reservation_Table_OrderedVO.setRto_no(rs.getString("rto_no"));
//				reservation_Table_OrderedVO.setVendor_no(rs.getString("vendor_no"));
				System.out.println("hello1");
			
			list.add(reservation_Table_OrderedVO); // Store the row in the list
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
	public List<Reservation_Table_OrderedVO> get6table(String vendor_no, Date booking_date) {
		List<Reservation_Table_OrderedVO> list = new ArrayList<Reservation_Table_OrderedVO>();
		Reservation_Table_OrderedVO reservation_Table_OrderedVO = null;
			System.out.println("hello");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_6TB);
			pstmt.setString(1, vendor_no);
			pstmt.setDate(2, booking_date);
			rs = pstmt.executeQuery();
			
			
			
			while (rs.next()==true) {
				reservation_Table_OrderedVO = new Reservation_Table_OrderedVO();
				reservation_Table_OrderedVO.setBooking_time(rs.getString("booking_time"));
				reservation_Table_OrderedVO.setRto_no(rs.getString("rto_no"));
//				reservation_Table_OrderedVO.setVendor_no(rs.getString("vendor_no"));
				System.out.println("hello1");
			
			list.add(reservation_Table_OrderedVO); // Store the row in the list
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
	public List<Reservation_Table_OrderedVO> get8table(String vendor_no, Date booking_date) {
		List<Reservation_Table_OrderedVO> list = new ArrayList<Reservation_Table_OrderedVO>();
		Reservation_Table_OrderedVO reservation_Table_OrderedVO = null;
			System.out.println("hello");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_8TB);
			pstmt.setString(1, vendor_no);
			pstmt.setDate(2, booking_date);
			rs = pstmt.executeQuery();
			
			
			
			while (rs.next()==true) {
				reservation_Table_OrderedVO = new Reservation_Table_OrderedVO();
				reservation_Table_OrderedVO.setBooking_time(rs.getString("booking_time"));
				reservation_Table_OrderedVO.setRto_no(rs.getString("rto_no"));
//				reservation_Table_OrderedVO.setVendor_no(rs.getString("vendor_no"));
				System.out.println("hello1");
			
			list.add(reservation_Table_OrderedVO); // Store the row in the list
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
	public List<Reservation_Table_OrderedVO> get10table(String vendor_no, Date booking_date) {
		List<Reservation_Table_OrderedVO> list = new ArrayList<Reservation_Table_OrderedVO>();
		Reservation_Table_OrderedVO reservation_Table_OrderedVO = null;
			System.out.println("hello");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_10TB);
			pstmt.setString(1, vendor_no);
			pstmt.setDate(2, booking_date);
			rs = pstmt.executeQuery();
			
			
			
			while (rs.next()==true) {
				reservation_Table_OrderedVO = new Reservation_Table_OrderedVO();
				reservation_Table_OrderedVO.setBooking_time(rs.getString("booking_time"));
				reservation_Table_OrderedVO.setRto_no(rs.getString("rto_no"));
//				reservation_Table_OrderedVO.setVendor_no(rs.getString("vendor_no"));
				System.out.println("hello1");
			
			list.add(reservation_Table_OrderedVO); // Store the row in the list
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
