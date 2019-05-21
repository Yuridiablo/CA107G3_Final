package com.ord.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.ord_detail.model.Order_DetailDAO;
import com.ord_detail.model.Order_DetailVO;

public class OrdDAO implements OrdDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = 
			"INSERT INTO ord (ord_no, mem_no, vendor_no, tbl_no, party_size, share_mem_no1, share_mem_no2, share_amount, ord_time, booking_date, booking_time, notes, total, arrival_time, finish_time, verif_code, status)" + 			
			" VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT ord_no, mem_no, vendor_no, tbl_no, party_size, share_mem_no1, share_mem_no2, share_amount, ord_time, booking_date, booking_time, notes, total, arrival_time, finish_time, verif_code, status" + 
			" FROM ord order by ord_no";
	private static final String GET_ONE_STMT = 
			"SELECT ord_no, mem_no, vendor_no, tbl_no, party_size, share_mem_no1, share_mem_no2, share_amount, ord_time, booking_date, booking_time, notes, total, arrival_time, finish_time, verif_code, status" + 			
			" FROM ord where ord_no = ?";
	private static final String DELETE = 
			"DELETE FROM ord where ord_no = ?";
	private static final String UPDATE = 
			"UPDATE ord set mem_no=?, vendor_no=?, tbl_no=?, party_size=?, share_mem_no1=?, share_mem_no2=?, share_amount=?, ord_time=?, booking_date=?, booking_time=?, notes=?, total=?, arrival_time=?, finish_time=?, verif_code=?, status=?" + 
			" where ord_no = ?";
	private static final String GET_ORD_FOR_MEM=
			"SELECT ord_no, mem_no, vendor_no, tbl_no, party_size, share_mem_no1, share_mem_no2, share_amount, ord_time, booking_date, booking_time, notes, total, arrival_time, finish_time, verif_code, status FROM ord where mem_no = ?";
	private static final String GET_ORD_FOR_VENDOR=
			"SELECT ord_no, mem_no, vendor_no, tbl_no, party_size, share_mem_no1, share_mem_no2, share_amount, ord_time, booking_date, booking_time, notes, total, arrival_time, finish_time, verif_code, status FROM ord where vendor_no = ?";
	private static final String GET_ALL_VENDOR_DATE_STMT = 
			"SELECT ord_no, mem_no, vendor_no, tbl_no, party_size, share_mem_no1, share_mem_no2, share_amount, ord_time, booking_date, booking_time, notes, total, arrival_time, finish_time, verif_code, status" + 
			" FROM ord" +
			" where vendor_no=? and booking_date=?" +
			" order by ord_no";
	private static final String GET_ALL_VENDOR_VERIF_STMT = 
			"SELECT ord_no, mem_no, vendor_no, tbl_no, party_size, share_mem_no1, share_mem_no2, share_amount, ord_time, booking_date, booking_time, notes, total, arrival_time, finish_time, verif_code, status" + 
			" FROM ord" +
			" where vendor_no=? and verif_code like ?" +
			" order by ord_no";
	private static final String GET_ONE_VENDOR_VERIF_STMT = 
			"SELECT ord_no, mem_no, vendor_no, tbl_no, party_size, share_mem_no1, share_mem_no2, share_amount, ord_time, booking_date, booking_time, notes, total, arrival_time, finish_time, verif_code, status" + 
			" FROM ord" +
			" where vendor_no=? and verif_code=?";
	private static final String UPDATE_TBLNO = "UPDATE ord set tbl_no=? where ord_no = ?";
	private static final String UPDATE_STATUS = "UPDATE ord set status=? where ord_no = ?";
	private static final String UPDATE_VERIF_CODE = "UPDATE ord set VERIF_CODE=? where ord_no = ?";
	
	@Override
	public void insert(OrdVO ordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, ordVO.getMem_no());
			pstmt.setString(2, ordVO.getVendor_no());
			
			if (ordVO.getTbl_no() != null) {
				pstmt.setString(3, ordVO.getTbl_no());
			} else {
				pstmt.setNull(3, java.sql.Types.VARCHAR);
			}
			
			pstmt.setInt(4, ordVO.getParty_size());
			
			if (ordVO.getShare_mem_no1() != null) {
				pstmt.setString(5, ordVO.getShare_mem_no1());
			} else {
				pstmt.setNull(5, java.sql.Types.VARCHAR);
			}
			
			if (ordVO.getShare_mem_no2() != null) {
				pstmt.setString(6, ordVO.getShare_mem_no2());
			} else {
				pstmt.setNull(6, java.sql.Types.VARCHAR);
			}
			
			if (ordVO.getShare_amount() != null) {
				pstmt.setInt(7, ordVO.getShare_amount());
			} else {
				pstmt.setNull(7, java.sql.Types.INTEGER);
			}
			
			pstmt.setTimestamp(8, ordVO.getOrd_time());
			
			pstmt.setDate(9, ordVO.getBooking_date());
			
			pstmt.setString(10, ordVO.getBooking_time());
			
			if (ordVO.getNotes() != null) {
				pstmt.setString(11, ordVO.getNotes());
			} else {
				pstmt.setNull(11, java.sql.Types.VARCHAR);
			}
			
			pstmt.setInt(12, ordVO.getTotal());
			
			if (ordVO.getArrival_time() != null) {
				pstmt.setString(13, ordVO.getArrival_time());
			} else {
				pstmt.setNull(13, java.sql.Types.VARCHAR);
			}
			
			if (ordVO.getFinish_time() != null) {
				pstmt.setString(14, ordVO.getFinish_time());
			} else {
				pstmt.setNull(14, java.sql.Types.VARCHAR);
			}
			
			pstmt.setString(15, ordVO.getVerif_code());
			
			pstmt.setInt(16, ordVO.getStatus());


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
	public void update(OrdVO ordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, ordVO.getMem_no());
			pstmt.setString(2, ordVO.getVendor_no());
			pstmt.setString(3, ordVO.getTbl_no());
			pstmt.setInt(4, ordVO.getParty_size());
			pstmt.setString(5, ordVO.getShare_mem_no1());
			pstmt.setString(6, ordVO.getShare_mem_no2());
			pstmt.setInt(7, ordVO.getShare_amount());
			pstmt.setTimestamp(8, ordVO.getOrd_time());
			pstmt.setDate(9, ordVO.getBooking_date());
			pstmt.setString(10, ordVO.getBooking_time());
			pstmt.setString(11, ordVO.getNotes());
			pstmt.setInt(12, ordVO.getTotal());
			pstmt.setString(13, ordVO.getArrival_time());
			pstmt.setString(14, ordVO.getFinish_time());
			pstmt.setString(15, ordVO.getVerif_code());
			pstmt.setInt(16, ordVO.getStatus());
			pstmt.setString(17, ordVO.getOrd_no());

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
	public void delete(String tbl_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, tbl_no);

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
	public OrdVO findByPrimaryKey(String tbl_no) {
		OrdVO ordVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, tbl_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// ordVO 也稱為 Domain objects
				ordVO = new OrdVO();
				ordVO.setOrd_no(rs.getString("ord_no"));
				ordVO.setMem_no(rs.getString("mem_no"));
				ordVO.setVendor_no(rs.getString("vendor_no"));
				ordVO.setTbl_no(rs.getString("tbl_no"));
				ordVO.setParty_size(rs.getInt("party_size"));
				ordVO.setShare_mem_no1(rs.getString("share_mem_no1"));
				ordVO.setShare_mem_no2(rs.getString("share_mem_no2"));
				ordVO.setShare_amount(rs.getInt("share_amount"));
				ordVO.setOrd_time(rs.getTimestamp("ord_time"));
				ordVO.setBooking_date(rs.getDate("booking_date"));
				ordVO.setBooking_time(rs.getString("booking_time"));
				ordVO.setNotes(rs.getString("notes"));
				ordVO.setTotal(rs.getInt("total"));
				ordVO.setArrival_time(rs.getString("arrival_time"));
				ordVO.setFinish_time(rs.getString("finish_time"));
				ordVO.setVerif_code(rs.getString("verif_code"));
				ordVO.setStatus(rs.getInt("status"));
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
		return ordVO;
	}

	@Override
	public List<OrdVO> getAll() {
		List<OrdVO> list = new ArrayList<OrdVO>();
		OrdVO ordVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// ordVO 也稱為 Domain objects
				ordVO = new OrdVO();
				ordVO.setOrd_no(rs.getString("ord_no"));
				ordVO.setMem_no(rs.getString("mem_no"));
				ordVO.setVendor_no(rs.getString("vendor_no"));
				ordVO.setTbl_no(rs.getString("tbl_no"));
				ordVO.setParty_size(rs.getInt("party_size"));
				ordVO.setShare_mem_no1(rs.getString("share_mem_no1"));
				ordVO.setShare_mem_no2(rs.getString("share_mem_no2"));
				ordVO.setShare_amount(rs.getInt("share_amount"));
				ordVO.setOrd_time(rs.getTimestamp("ord_time"));
				ordVO.setBooking_date(rs.getDate("booking_date"));
				ordVO.setBooking_time(rs.getString("booking_time"));
				ordVO.setNotes(rs.getString("notes"));
				ordVO.setTotal(rs.getInt("total"));
				ordVO.setArrival_time(rs.getString("arrival_time"));
				ordVO.setFinish_time(rs.getString("finish_time"));
				ordVO.setVerif_code(rs.getString("verif_code"));
				ordVO.setStatus(rs.getInt("status"));
				list.add(ordVO); // Store the row in the list
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

	public static void main(String[] args) {
		OrdDAO dao = new OrdDAO();

		// 新增
//		OrdVO ordVO1 = new OrdVO();
//		ordVO1.setMem_no("M000001");
//		ordVO1.setVendor_no("V000001");
//		ordVO1.setTbl_no(null);
//		ordVO1.setParty_size(new Integer(5));
//		ordVO1.setShare_mem_no1(null);
//		ordVO1.setShare_mem_no2(null);
//		ordVO1.setShare_amount(null);
//		ordVO1.setShare_amount(null);
//		ordVO1.setOrd_time(new java.sql.Timestamp(new java.util.Date().getTime()));
//		ordVO1.setBooking_date(java.sql.Date.valueOf("2019-03-31"));
//		ordVO1.setBooking_time("10:30");
//		ordVO1.setNotes(null);
//		ordVO1.setTotal(1600);
//		ordVO1.setArrival_time(null);
//		ordVO1.setFinish_time(null);
//		ordVO1.setVerif_code("qL62THYwvZuVkka2aDTt");
//		ordVO1.setStatus(new Integer(1));
//
//		dao.insert(ordVO1);

		// 修改
//		OrdVO ordVO2 = new OrdVO();
//		ordVO2.setOrd_no("20190415-000001");
//		ordVO2.setMem_no("M000001");
//		ordVO2.setVendor_no("V000001");
//		ordVO2.setTbl_no("T000005");
//		ordVO2.setParty_size(new Integer(5));
//		ordVO2.setShare_mem_no1("M000002");
//		ordVO2.setShare_mem_no2("M000003");
//		ordVO2.setShare_amount(300);
//		ordVO2.setOrd_time(java.sql.Timestamp.valueOf("2019-03-09 11:49:45"));
//		ordVO2.setBooking_date(java.sql.Date.valueOf("2019-03-31"));
//		ordVO2.setBooking_time("10:30");
//		ordVO2.setNotes("****");
//		ordVO2.setTotal(1600);
//		ordVO2.setArrival_time("11:05");
//		ordVO2.setFinish_time("12:10");
//		ordVO2.setVerif_code("qL62THYwvZuVkka2aDTt");
//		ordVO2.setStatus(new Integer(1));
//
//		dao.update(ordVO2);

		// 刪除
//		dao.delete("20190415-000001");

		// 查詢
//		OrdVO ordVO3 = dao.findByPrimaryKey("20190415-000002");
//		System.out.print(ordVO3.getOrd_no() + ",");
//		System.out.print(ordVO3.getMem_no() + ",");
//		System.out.print(ordVO3.getVendor_no() + ",");
//		System.out.print(ordVO3.getTbl_no() + ",");
//		System.out.print(ordVO3.getParty_size() + ",");
//		System.out.print(ordVO3.getShare_mem_no1() + ",");
//		System.out.print(ordVO3.getShare_mem_no2() + ",");
//		System.out.print(ordVO3.getShare_amount() + ",");
//		System.out.print(ordVO3.getOrd_time() + ",");
//		System.out.print(ordVO3.getBooking_date() + ",");
//		System.out.print(ordVO3.getBooking_time() + ",");
//		System.out.print(ordVO3.getNotes() + ",");
//		System.out.print(ordVO3.getTotal() + ",");
//		System.out.print(ordVO3.getArrival_time() + ",");
//		System.out.print(ordVO3.getFinish_time() + ",");
//		System.out.print(ordVO3.getVerif_code() + ",");
//		System.out.println(ordVO3.getStatus());
//		System.out.println("---------------------");

		// 查詢
//		List<OrdVO> list = dao.getAll();
//		for (OrdVO aTables : list) {
//			System.out.print(aTables.getOrd_no() + ",");
//			System.out.print(aTables.getMem_no() + ",");
//			System.out.print(aTables.getVendor_no() + ",");
//			System.out.print(aTables.getTbl_no() + ",");
//			System.out.print(aTables.getParty_size() + ",");
//			System.out.print(aTables.getShare_mem_no1() + ",");
//			System.out.print(aTables.getShare_mem_no2() + ",");
//			System.out.print(aTables.getShare_amount() + ",");
//			System.out.print(aTables.getOrd_time() + ",");
//			System.out.print(aTables.getBooking_date() + ",");
//			System.out.print(aTables.getBooking_time() + ",");
//			System.out.print(aTables.getNotes() + ",");
//			System.out.print(aTables.getTotal() + ",");
//			System.out.print(aTables.getArrival_time() + ",");
//			System.out.print(aTables.getFinish_time() + ",");
//			System.out.print(aTables.getVerif_code() + ",");
//			System.out.println(aTables.getStatus() );
//			System.out.println();
//		}
	}

	@Override
	public OrdVO insertWithOrd_detail(OrdVO ordVO, List<Order_DetailVO> list) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			
			// 1●設定於 pstm.executeUpdate()之前
    		con.setAutoCommit(false);
    		
    		// 先新增訂單
    					String cols[] = {"ORD_NO"};
    					pstmt = con.prepareStatement(INSERT_STMT , cols);			
    					pstmt.setString(1, ordVO.getMem_no());
    					pstmt.setString(2, ordVO.getVendor_no());
    					
    					if (ordVO.getTbl_no() != null) {
    						pstmt.setString(3, ordVO.getTbl_no());
    					} else {
    						pstmt.setNull(3, java.sql.Types.VARCHAR);
    					}
    					
    					pstmt.setInt(4, ordVO.getParty_size());
    					
    					if (ordVO.getShare_mem_no1() != null) {
    						pstmt.setString(5, ordVO.getShare_mem_no1());
    					} else {
    						pstmt.setNull(5, java.sql.Types.VARCHAR);
    					}
    					
    					if (ordVO.getShare_mem_no2() != null) {
    						pstmt.setString(6, ordVO.getShare_mem_no2());
    					} else {
    						pstmt.setNull(6, java.sql.Types.VARCHAR);
    					}
    					
    					if (ordVO.getShare_amount() != null) {
    						pstmt.setInt(7, ordVO.getShare_amount());
    					} else {
    						pstmt.setNull(7, java.sql.Types.INTEGER);
    					}
    					
    					pstmt.setTimestamp(8, ordVO.getOrd_time());
    					
    					pstmt.setDate(9, ordVO.getBooking_date());
    					
    					pstmt.setString(10, ordVO.getBooking_time());
    					
    					if (ordVO.getNotes() != null) {
    						pstmt.setString(11, ordVO.getNotes());
    					} else {
    						pstmt.setNull(11, java.sql.Types.VARCHAR);
    					}
    					
    					pstmt.setInt(12, ordVO.getTotal());
    					
    					if (ordVO.getArrival_time() != null) {
    						pstmt.setString(13, ordVO.getArrival_time());
    					} else {
    						pstmt.setNull(13, java.sql.Types.VARCHAR);
    					}
    					
    					if (ordVO.getFinish_time() != null) {
    						pstmt.setString(14, ordVO.getFinish_time());
    					} else {
    						pstmt.setNull(14, java.sql.Types.VARCHAR);
    					}
    					
    					pstmt.setString(15, ordVO.getVerif_code());
    					
    					pstmt.setInt(16, ordVO.getStatus());
    					pstmt.executeUpdate();
    					//掘取對應的自增主鍵值
    					String next_ord_no = null;
    					ResultSet rs = pstmt.getGeneratedKeys();
    					if (rs.next()) {
    						next_ord_no = rs.getString(1);
    						System.out.println("自增主鍵值= " + next_ord_no +"(剛新增成功的訂單編號)");
    					} else {
    						System.out.println("未取得自增主鍵值");
    					}
    					rs.close();
    					// 再同時新增訂單明細
    					Order_DetailDAO dao = new Order_DetailDAO();
    					System.out.println("list.size()-A="+list.size());
    					for (Order_DetailVO order_detail : list) {
    						
    						order_detail.setOrd_no(new String(next_ord_no)) ;
    						dao.insert2(order_detail,con);
    					}
    					con.commit();
    					con.setAutoCommit(true);
    					ordVO.setOrd_no(next_ord_no);
    					System.out.println("list.size()-B="+list.size());
    					System.out.println("新增訂單編號" + next_ord_no + "時,共有訂單明細" + list.size()
    							+ "筆同時被新增");
    					
    					// Handle any driver errors
    				} catch (SQLException se) {
    					if (con != null) {
    						try {
    							// 3●設定於當有exception發生時之catch區塊內
    							System.err.print("Transaction is being ");
    							System.err.println("rolled back-由-ord");
    							con.rollback();
    						} catch (SQLException excep) {
    							throw new RuntimeException("rollback error occured. "
    									+ excep.getMessage());
    						}
    					}
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
		return ordVO;

		
	}

	@Override
	public List<OrdVO> findByvendor_no(String vendor_no) {
		
		List<OrdVO> list = new ArrayList<OrdVO>();
		OrdVO ordVO = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection con = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ORD_FOR_VENDOR);

			pstmt.setString(1, vendor_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// ordVO 也稱為 Domain objects
				ordVO = new OrdVO();
				ordVO.setOrd_no(rs.getString("ord_no"));
				ordVO.setMem_no(rs.getString("mem_no"));
				ordVO.setVendor_no(rs.getString("vendor_no"));
				ordVO.setTbl_no(rs.getString("tbl_no"));
				ordVO.setParty_size(rs.getInt("party_size"));
				ordVO.setShare_mem_no1(rs.getString("share_mem_no1"));
				ordVO.setShare_mem_no2(rs.getString("share_mem_no2"));
				ordVO.setShare_amount(rs.getInt("share_amount"));
				ordVO.setOrd_time(rs.getTimestamp("ord_time"));
				ordVO.setBooking_date(rs.getDate("booking_date"));
				ordVO.setBooking_time(rs.getString("booking_time"));
				ordVO.setNotes(rs.getString("notes"));
				ordVO.setTotal(rs.getInt("total"));
				ordVO.setArrival_time(rs.getString("arrival_time"));
				ordVO.setFinish_time(rs.getString("finish_time"));
				ordVO.setVerif_code(rs.getString("verif_code"));
				ordVO.setStatus(rs.getInt("status"));
				list.add(ordVO);
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
	public List<OrdVO> findBymem_no(String mem_no) {

		List<OrdVO> list = new ArrayList<OrdVO>();
		OrdVO ordVO = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection con = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ORD_FOR_MEM);

			pstmt.setString(1, mem_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// ordVO 也稱為 Domain objects
				ordVO = new OrdVO();
				ordVO.setOrd_no(rs.getString("ord_no"));
				ordVO.setMem_no(rs.getString("mem_no"));
				ordVO.setVendor_no(rs.getString("vendor_no"));
				ordVO.setTbl_no(rs.getString("tbl_no"));
				ordVO.setParty_size(rs.getInt("party_size"));
				ordVO.setShare_mem_no1(rs.getString("share_mem_no1"));
				ordVO.setShare_mem_no2(rs.getString("share_mem_no2"));
				ordVO.setShare_amount(rs.getInt("share_amount"));
				ordVO.setOrd_time(rs.getTimestamp("ord_time"));
				ordVO.setBooking_date(rs.getDate("booking_date"));
				ordVO.setBooking_time(rs.getString("booking_time"));
				ordVO.setNotes(rs.getString("notes"));
				ordVO.setTotal(rs.getInt("total"));
				ordVO.setArrival_time(rs.getString("arrival_time"));
				ordVO.setFinish_time(rs.getString("finish_time"));
				ordVO.setVerif_code(rs.getString("verif_code"));
				ordVO.setStatus(rs.getInt("status"));
				list.add(ordVO);
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
	public List<OrdVO> findByVendor_no_Date(String vendor_no, Date booking_date) {
		List<OrdVO> list = new ArrayList<OrdVO>();
		OrdVO ordVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_VENDOR_DATE_STMT);
			pstmt.setString(1, vendor_no);
			pstmt.setDate(2, booking_date);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// ordVO 也稱為 Domain objects
				ordVO = new OrdVO();
				ordVO.setOrd_no(rs.getString("ord_no"));
				ordVO.setMem_no(rs.getString("mem_no"));
				ordVO.setVendor_no(rs.getString("vendor_no"));
				ordVO.setTbl_no(rs.getString("tbl_no"));
				ordVO.setParty_size(rs.getInt("party_size"));
				ordVO.setShare_mem_no1(rs.getString("share_mem_no1"));
				ordVO.setShare_mem_no2(rs.getString("share_mem_no2"));
				ordVO.setShare_amount(rs.getInt("share_amount"));
				ordVO.setOrd_time(rs.getTimestamp("ord_time"));
				ordVO.setBooking_date(rs.getDate("booking_date"));
				ordVO.setBooking_time(rs.getString("booking_time"));
				ordVO.setNotes(rs.getString("notes"));
				ordVO.setTotal(rs.getInt("total"));
				ordVO.setArrival_time(rs.getString("arrival_time"));
				ordVO.setFinish_time(rs.getString("finish_time"));
				ordVO.setVerif_code(rs.getString("verif_code"));
				ordVO.setStatus(rs.getInt("status"));
				list.add(ordVO); // Store the row in the list
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
	public List<OrdVO> findByVerifCode(String vendor_no, String verif_code) {
		List<OrdVO> list = new ArrayList<OrdVO>();
		OrdVO ordVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_VENDOR_VERIF_STMT);
			pstmt.setString(1, vendor_no);
			pstmt.setString(2, verif_code + "%");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// ordVO 也稱為 Domain objects
				ordVO = new OrdVO();
				ordVO.setOrd_no(rs.getString("ord_no"));
				ordVO.setMem_no(rs.getString("mem_no"));
				ordVO.setVendor_no(rs.getString("vendor_no"));
				ordVO.setTbl_no(rs.getString("tbl_no"));
				ordVO.setParty_size(rs.getInt("party_size"));
				ordVO.setShare_mem_no1(rs.getString("share_mem_no1"));
				ordVO.setShare_mem_no2(rs.getString("share_mem_no2"));
				ordVO.setShare_amount(rs.getInt("share_amount"));
				ordVO.setOrd_time(rs.getTimestamp("ord_time"));
				ordVO.setBooking_date(rs.getDate("booking_date"));
				ordVO.setBooking_time(rs.getString("booking_time"));
				ordVO.setNotes(rs.getString("notes"));
				ordVO.setTotal(rs.getInt("total"));
				ordVO.setArrival_time(rs.getString("arrival_time"));
				ordVO.setFinish_time(rs.getString("finish_time"));
				ordVO.setVerif_code(rs.getString("verif_code"));
				ordVO.setStatus(rs.getInt("status"));
				list.add(ordVO); // Store the row in the list
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
	public OrdVO findOrdByVerifCode(String vendor_no, String verif_code) {
		OrdVO ordVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_VENDOR_VERIF_STMT);

			pstmt.setString(1, vendor_no);
			pstmt.setString(2, verif_code);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// ordVO 也稱為 Domain objects
				ordVO = new OrdVO();
				ordVO.setOrd_no(rs.getString("ord_no"));
				ordVO.setMem_no(rs.getString("mem_no"));
				ordVO.setVendor_no(rs.getString("vendor_no"));
				ordVO.setTbl_no(rs.getString("tbl_no"));
				ordVO.setParty_size(rs.getInt("party_size"));
				ordVO.setShare_mem_no1(rs.getString("share_mem_no1"));
				ordVO.setShare_mem_no2(rs.getString("share_mem_no2"));
				ordVO.setShare_amount(rs.getInt("share_amount"));
				ordVO.setOrd_time(rs.getTimestamp("ord_time"));
				ordVO.setBooking_date(rs.getDate("booking_date"));
				ordVO.setBooking_time(rs.getString("booking_time"));
				ordVO.setNotes(rs.getString("notes"));
				ordVO.setTotal(rs.getInt("total"));
				ordVO.setArrival_time(rs.getString("arrival_time"));
				ordVO.setFinish_time(rs.getString("finish_time"));
				ordVO.setVerif_code(rs.getString("verif_code"));
				ordVO.setStatus(rs.getInt("status"));
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
		return ordVO;
	}
	
	@Override
	public void updateTbl_no(OrdVO ordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_TBLNO);
		
			if (ordVO.getTbl_no() != null) {
				pstmt.setString(1, ordVO.getTbl_no());
			} else {
				pstmt.setNull(1, java.sql.Types.VARCHAR);
			}
			pstmt.setString(2, ordVO.getOrd_no());
			
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
	public void updateStatus(OrdVO ordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS);

		
			pstmt.setInt(1, ordVO.getStatus());			
			pstmt.setString(2, ordVO.getOrd_no());

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
	public void updateVerif_Code(OrdVO ordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_VERIF_CODE);
		
			pstmt.setString(1, ordVO.getVerif_code());
			pstmt.setString(2, ordVO.getOrd_no());
			
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
