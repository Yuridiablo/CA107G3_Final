package com.ord_detail.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Order_DetailJDBCDAO implements Order_DetailDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "WEST";
//	String passwd = "800627";
	final static String url = "jdbc:oracle:thin:@localhost:1521:XE";
	final static String userid = "CA107G3";
	final static String passwd = "123456";

	private static final String INSERT_STMT = 
			"INSERT INTO order_detail (ord_no, menu_no, qty, price)" + 
			" VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT ord_no, menu_no, qty, price FROM order_detail order by ord_no, menu_no";
	private static final String GET_ONE_STMT = 
			"SELECT ord_no, menu_no, qty, price FROM order_detail where ord_no = ? and menu_no=?";
	private static final String DELETE = 
			"DELETE FROM order_detail where ord_no = ? and menu_no=?";
	private static final String UPDATE = 
			"UPDATE order_detail set qty=?, price=? where ord_no = ? and menu_no=?";
	private static final String GET_ONE_ORDER_NO_LIST = 
			"SELECT ord_no, menu_no, qty, price FROM order_detail where ord_no = ?";
			

	@Override
	public void insert(Order_DetailVO order_detailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, order_detailVO.getOrd_no());
			pstmt.setString(2, order_detailVO.getMenu_no());
			pstmt.setInt(3, order_detailVO.getQty());
			pstmt.setInt(4, order_detailVO.getPrice());

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
	public void update(Order_DetailVO order_detailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, order_detailVO.getQty());
			pstmt.setInt(2, order_detailVO.getPrice());
			pstmt.setString(3, order_detailVO.getOrd_no());
			pstmt.setString(4, order_detailVO.getMenu_no());
			
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
	public void delete(String ord_no, String menu_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, ord_no);
			pstmt.setString(2, menu_no);

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

	public List<Order_DetailVO> findbyOrd_no(String ord_no) {
		
		List<Order_DetailVO> list = new ArrayList<Order_DetailVO>();
		Order_DetailVO order_detailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_ORDER_NO_LIST);
			pstmt.setString(1, ord_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// order_detailVO 也稱為 Domain objects
				order_detailVO = new Order_DetailVO();
				order_detailVO.setOrd_no(rs.getString("ord_no"));
				order_detailVO.setMenu_no(rs.getString("menu_no"));
				order_detailVO.setQty(rs.getInt("qty"));
				order_detailVO.setPrice(rs.getInt("price"));
				list.add(order_detailVO); // Store the row in the list
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
		return list ;
		
	}
	@Override
	public Order_DetailVO findByPrimaryKey(String ord_no, String menu_no) {
		Order_DetailVO order_detailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, ord_no);
			pstmt.setString(2, menu_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// order_detailVO 也稱為 Domain objects
				order_detailVO = new Order_DetailVO();
				order_detailVO.setOrd_no(rs.getString("ord_no"));
				order_detailVO.setMenu_no(rs.getString("menu_no"));
				order_detailVO.setQty(rs.getInt("qty"));
				order_detailVO.setPrice(rs.getInt("price"));		
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
		return order_detailVO;
	}

	@Override
	public List<Order_DetailVO> getAll() {
		List<Order_DetailVO> list = new ArrayList<Order_DetailVO>();
		Order_DetailVO order_detailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// order_detailVO 也稱為 Domain objects
				order_detailVO = new Order_DetailVO();
				order_detailVO.setOrd_no(rs.getString("ord_no"));
				order_detailVO.setMenu_no(rs.getString("menu_no"));
				order_detailVO.setQty(rs.getInt("qty"));
				order_detailVO.setPrice(rs.getInt("price"));
				list.add(order_detailVO); // Store the row in the list
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
		Order_DetailJDBCDAO dao = new Order_DetailJDBCDAO();

		// 新增
//		Order_DetailVO order_detailVO1 = new Order_DetailVO();
//		order_detailVO1.setOrd_no("20190401-000001");
//		order_detailVO1.setMenu_no("RM00000001");
//		order_detailVO1.setQty(new Integer(3));
//		order_detailVO1.setPrice(new Integer(350));
//
//		dao.insert(order_detailVO1);

		// 修改
//		Order_DetailVO order_detailVO2 = new Order_DetailVO();
//		order_detailVO2.setOrd_no("20190401-000001");
//		order_detailVO2.setMenu_no("RM00000001");
//		order_detailVO2.setQty(new Integer(4));
//		order_detailVO2.setPrice(new Integer(500));
//		dao.update(order_detailVO2);

		// 刪除
//		dao.delete("20190401-000001", "RM00000001");

//		// 查詢
		Order_DetailVO order_detailVO3 = dao.findByPrimaryKey("20190413-000005", "RM00000005");
		System.out.print(order_detailVO3.getOrd_no() + ",");
		System.out.print(order_detailVO3.getMenu_no() + ",");
		System.out.print(order_detailVO3.getQty() + ",");
		System.out.println(order_detailVO3.getPrice());
		System.out.println("---------------------");

		// 查詢
		List<Order_DetailVO> list = dao.getAll();
		for (Order_DetailVO aTables : list) {
			System.out.print(aTables.getOrd_no() + ",");
			System.out.print(aTables.getMenu_no() + ",");
			System.out.print(aTables.getQty() + ",");
			System.out.println(aTables.getPrice());
			System.out.println();
		}
	}

	public void insert2(Order_DetailVO order_detailVO, Connection con) {
		
		PreparedStatement pstmt = null;
		
		try {

     		pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, order_detailVO.getOrd_no());
			pstmt.setString(2, order_detailVO.getMenu_no());
			pstmt.setInt(3, order_detailVO.getQty());
			pstmt.setInt(4, order_detailVO.getPrice());

			pstmt.executeUpdate();
		
			// Handle any SQL errors
					} catch (SQLException se) {
						if (con != null) {
							try {
								// 3●設定於當有exception發生時之catch區塊內
								System.err.print("Transaction is being ");
								System.err.println("rolled back-由-ord_detail");
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
					}
	}
}
