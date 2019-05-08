package com.restaurant_transaction_list.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;




public  class RES_Transaction_ListDAO implements RES_Transaction_ListDAO_Interface {
	final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	final String USER = "CA107G3";
	final String PASSWORD = "123456";
	
	
	
	private static final String INSERT_STMT = "INSERT INTO RES_TRANSACTION_LIST VALUES('RTL'||LPAD(to_char(RES_T_L_SEQ.NEXTVAL), 7, '0'),?,?,sysdate,?,?)";
			
	private static final String GET_ALL_STMT = 
			"SELECT TRST_NO, VENDOR_NO, AMOUNT,PAY_DATE, ORD_NO,v_wallet FROM RES_TRANSACTION_LIST order by trst_no";
	
	private static final String GET_ONE_STMT = 
			"SELECT TRST_NO, VENDOR_NO, AMOUNT,PAY_DATE, ORD_NO, V_WALLET FROM RES_TRANSACTION_LIST WHERE TRST_NO =?";
	private static final String GET_ONE_VENDOR = 
			"SELECT * FROM res_transaction_list WHERE VENDOR_NO =?";
	private static final String STATUS = 
			"UPDATE res_transaction_list set V_WALLET=? where vendor_no = ?";
	private static final String DELETE = 
			"DELETE FROM res_transaction_list where trst_no = ?";
	private static final String UPDATE = 
			"UPDATE res_transaction_list set vendor_no=?, amount=?,	pay_date=?,	ord_no=?, v_wallet=? where trst_no=?";
	@Override
	public void insert(RES_Transaction_ListVO res_transaction_listVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, res_transaction_listVO.getVendor_no());
			pstmt.setDouble(2, res_transaction_listVO.getAmount());
			pstmt.setString(3, res_transaction_listVO.getOrd_no());
			pstmt.setInt(4, res_transaction_listVO.getV_wallet());

			pstmt.executeUpdate();
				System.out.println("新增了一筆資料");
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
	public void update(RES_Transaction_ListVO res_transaction_listVO) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
//			pstmt = con.prepareStatement(UPDATE);
//
//			pstmt.setString(1, res_transaction_listVO.getVendor_no() );
//			pstmt.setDouble(2, res_transaction_listVO.getAmount() );
//			pstmt.setTimestamp(3, res_transaction_listVO.getPay_date());
//			pstmt.setString(4, res_transaction_listVO.getOrd_no());
//			pstmt.setDouble(5, res_transaction_listVO.getV_wallet());
//			pstmt.setString(6, res_transaction_listVO.getTrst_no());
//
//			pstmt.executeUpdate();
//
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
	public void delete(String trst_no) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
//			pstmt = con.prepareStatement(DELETE);
//
//			pstmt.setString(1, trst_no);
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
	public void status(RES_Transaction_ListVO res_transaction_listVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
	
		try {
			
			
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(STATUS);
	
			pstmt.setInt(1, res_transaction_listVO.getV_wallet() );
			pstmt.setString(2, res_transaction_listVO.getVendor_no() );
		
	
			pstmt.executeUpdate();
			System.out.println("更新了交易明細狀態");
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
					se.printStackTrace();
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
	public List<RES_Transaction_ListVO> getOneVendor(String vendor_no) {
		List<RES_Transaction_ListVO> list = new ArrayList<RES_Transaction_ListVO>();
		RES_Transaction_ListVO rtlVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ONE_VENDOR);
			
			pstmt.setString(1, vendor_no);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				rtlVO = new RES_Transaction_ListVO();
				rtlVO.setTrst_no(rs.getString("trst_no"));
				rtlVO.setVendor_no(rs.getString("vendor_no"));
				rtlVO.setAmount(rs. getDouble("amount"));
				rtlVO.setPay_date(rs.getTimestamp("pay_date"));
				rtlVO.setOrd_no(rs.getString("ord_no"));
				rtlVO.setV_wallet(rs.getInt("v_wallet"));
				
				list.add(rtlVO); // Store the row in the list
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
	public RES_Transaction_ListVO findByPrimaryKey(String trst_no) {
		

		RES_Transaction_ListVO res_transaction_listVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				Class.forName(DRIVER);
				con = DriverManager.getConnection(URL, USER, PASSWORD);
				pstmt = con.prepareStatement(GET_ONE_STMT);

				pstmt.setString(1, trst_no);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					// empVo �]�٬� Domain objects
					res_transaction_listVO = new RES_Transaction_ListVO();
					res_transaction_listVO.setTrst_no(rs.getString("trst_no"));
					res_transaction_listVO.setVendor_no(rs.getString("vendor_no"));
					res_transaction_listVO.setAmount(rs. getDouble("amount"));
					res_transaction_listVO.setPay_date(rs.getTimestamp("pay_date"));
					res_transaction_listVO.setOrd_no(rs.getString("ord_no"));
					res_transaction_listVO.setV_wallet(rs.getInt("v_wallet"));
					
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
			
		return res_transaction_listVO;
	}

	@Override
	public List<RES_Transaction_ListVO> getAll() {
		List<RES_Transaction_ListVO> list = new ArrayList<RES_Transaction_ListVO>();
		RES_Transaction_ListVO resVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				
				resVO = new RES_Transaction_ListVO();
				resVO.setTrst_no(rs.getString("trst_no"));
				resVO.setVendor_no(rs.getString("vendor_no"));
				resVO.setAmount(rs. getDouble("amount"));
				resVO.setPay_date(rs.getTimestamp("pay_date"));
				resVO.setOrd_no(rs.getString("ord_no"));
				resVO.setV_wallet(rs.getInt("v_wallet"));
				
				list.add(resVO); // Store the row in the list
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
		RES_Transaction_ListDAO dao = new RES_Transaction_ListDAO();
//		RES_transaction_listVO resVO1 = new RES_transaction_listVO();
		
		//insert
//		resVO1.setVendor_no("V000003");
//		resVO1.setAmount(5000.0);
//		resVO1.setV_wallet(05.0);
//		
//		System.out.println(resVO1);
//		dao.insert(resVO1);
		
		//update
//		RES_transaction_listVO resVO2 = new RES_transaction_listVO();
//		resVO2 .setTrst_no("RTL0000012");
//		resVO2 .setVendor_no("V000004");
//		resVO2.setAmount(5000.0);
//		resVO2 .setPay_date(java.sql.Timestamp.valueOf("2019-04-02 16:53:15"));
//		resVO2 .setOrd_no("20190402-000005");
//		resVO2 .setV_wallet(5.0);
//		System.out.println(resVO2);
//		dao.update(resVO2);
		
		
		//delete
//		dao.delete("RTL000001");
//		System.out.println("OK");
		
		//findByPrimaryKey
		
//		RES_transaction_listVO resVO3 = dao.findByPrimaryKey("RTL0000002");
//		System.out.print(resVO3.getTrst_no() + ",");
//		System.out.print(resVO3.getVendor_no() + ",");
//		System.out.print(resVO3.getAmount() + ",");
//		System.out.print(resVO3.getPay_date() + ",");
//		System.out.print(resVO3.getOrd_no() + ",");
//		System.out.print(resVO3.getV_wallet() + ",");
//		
//		System.out.println("---------------------");
		
		//findAll
		
		List<RES_Transaction_ListVO> list = dao.getAll();
		for (RES_Transaction_ListVO res : list) {
			System.out.print(res.getTrst_no() + ",");
			System.out.print(res.getVendor_no() + ",");
			System.out.print(res.getAmount() + ",");
			System.out.print(res.getPay_date() + ",");
			System.out.print(res.getOrd_no() + ",");
			System.out.print(res.getV_wallet() + ",");
			
			System.out.println("-------------------");
		
		}
		
	}

}
