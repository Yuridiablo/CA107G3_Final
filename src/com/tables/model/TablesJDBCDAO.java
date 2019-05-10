package com.tables.model;

import java.util.*;
import java.sql.*;

public class TablesJDBCDAO implements TablesDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA107G3";
	String passwd = "123456";

	private static final String INSERT_STMT = 
			"INSERT INTO tables (tbl_no, vendor_no, tbl_name, tbl_size, tbl_type, tbl_x, tbl_y)" + 
			" VALUES ('T'||LPAD(to_char(tables_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT tbl_no, vendor_no, tbl_name, tbl_size, tbl_type, tbl_x, tbl_y FROM tables order by tbl_no";
	private static final String GET_ONE_STMT = 
			"SELECT tbl_no, vendor_no, tbl_name, tbl_size, tbl_type, tbl_x, tbl_y FROM tables where tbl_no = ?";
	private static final String GET_ALL_BY_VENDOR_NO_STMT = 
	"SELECT tbl_no, vendor_no, tbl_name, tbl_size, tbl_type, tbl_x, tbl_y FROM tables WHERE vendor_no = ? ORDER by tbl_no";
	private static final String DELETE = 
			"DELETE FROM tables where tbl_no = ?";
	private static final String UPDATE = 
			"UPDATE tables set tbl_name=?, tbl_size=?, tbl_type=?, tbl_x=?, tbl_y=? where tbl_no = ?";
	private static final String UPDATE_BASIC = 
			"UPDATE tables set tbl_name=?, tbl_size=? where tbl_no = ?";
	private static final String UPDATE_AXIS = 
			"UPDATE tables set tbl_type=?, tbl_x=?, tbl_y=? where tbl_no = ?";
	@Override
	public void insert(TablesVO tablesVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, tablesVO.getVendor_no());
			pstmt.setString(2, tablesVO.getTbl_name());
			pstmt.setInt(3, tablesVO.getTbl_size());
			
			if (tablesVO.getTbl_type() != null) {
				pstmt.setInt(4, tablesVO.getTbl_type());
			} else {
				pstmt.setNull(4, java.sql.Types.INTEGER);
			}
			
			if (tablesVO.getTbl_x() != null) {
				pstmt.setInt(5, tablesVO.getTbl_x());
			} else {
				pstmt.setNull(5, java.sql.Types.INTEGER);
			}
			
			if (tablesVO.getTbl_y() != null) {
				pstmt.setInt(6, tablesVO.getTbl_y());
			} else {
				pstmt.setNull(6, java.sql.Types.INTEGER);
			}
			
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
	public void update(TablesVO tablesVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, tablesVO.getTbl_name());
			pstmt.setInt(2, tablesVO.getTbl_size());
			pstmt.setInt(3, tablesVO.getTbl_type());
			pstmt.setInt(4, tablesVO.getTbl_x());
			pstmt.setInt(5, tablesVO.getTbl_y());
			pstmt.setString(6, tablesVO.getTbl_no());


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
	public void updateBasic(TablesVO tablesVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_BASIC);

			pstmt.setString(1, tablesVO.getTbl_name());
			pstmt.setInt(2, tablesVO.getTbl_size());
			pstmt.setString(3, tablesVO.getTbl_no());


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
	public void updateAxis(TablesVO tablesVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_AXIS);

			
			if (tablesVO.getTbl_type() != null) {
				pstmt.setInt(1, tablesVO.getTbl_type());
			} else {
				pstmt.setNull(1, java.sql.Types.INTEGER);
			}
			
			if (tablesVO.getTbl_x() != null) {
				pstmt.setInt(2, tablesVO.getTbl_x());
			} else {
				pstmt.setNull(2, java.sql.Types.INTEGER);
			}
			
			if (tablesVO.getTbl_y() != null) {
				pstmt.setInt(3, tablesVO.getTbl_y());
			} else {
				pstmt.setNull(3, java.sql.Types.INTEGER);
			}
			
			pstmt.setString(4, tablesVO.getTbl_no());

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
	public void delete(String tbl_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, tbl_no);

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
	public TablesVO findByPrimaryKey(String tbl_no) {
		TablesVO tablesVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, tbl_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// tablesVO 也稱為 Domain objects
				tablesVO = new TablesVO();
				tablesVO.setTbl_no(rs.getString("tbl_no"));
				tablesVO.setVendor_no(rs.getString("vendor_no"));
				tablesVO.setTbl_name(rs.getString("tbl_name"));
				tablesVO.setTbl_size(rs.getInt("tbl_size"));
				tablesVO.setTbl_type(rs.getInt("tbl_type"));
				tablesVO.setTbl_x(rs.getInt("tbl_x"));
				tablesVO.setTbl_y(rs.getInt("tbl_y"));
			
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
		return tablesVO;
	}

	@Override
	public List<TablesVO> getAll() {
		List<TablesVO> list = new ArrayList<TablesVO>();
		TablesVO tablesVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// tablesVO 也稱為 Domain objects
				tablesVO = new TablesVO();
				tablesVO.setTbl_no(rs.getString("tbl_no"));
				tablesVO.setVendor_no(rs.getString("vendor_no"));
				tablesVO.setTbl_name(rs.getString("tbl_name"));
				tablesVO.setTbl_size(rs.getInt("tbl_size"));
				tablesVO.setTbl_type(rs.getInt("tbl_type"));
				if (rs.getObject("tbl_x") != null) tablesVO.setTbl_x(rs.getInt("tbl_x"));
				if (rs.getObject("tbl_y") != null) tablesVO.setTbl_y(rs.getInt("tbl_y"));
				list.add(tablesVO); // Store the row in the list
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
	public List<TablesVO> getAllByVendor_no(String vendor_no) {
		List<TablesVO> list = new ArrayList<TablesVO>();
		TablesVO tablesVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_BY_VENDOR_NO_STMT);
			pstmt.setString(1, vendor_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// tablesVO 也稱為 Domain objects
				tablesVO = new TablesVO();
				tablesVO.setTbl_no(rs.getString("tbl_no"));
				tablesVO.setVendor_no(rs.getString("vendor_no"));
				tablesVO.setTbl_name(rs.getString("tbl_name"));
				tablesVO.setTbl_size(rs.getInt("tbl_size"));
				if (rs.getObject("tbl_type") != null) tablesVO.setTbl_type(rs.getInt("tbl_type"));
				if (rs.getObject("tbl_x") != null) tablesVO.setTbl_x(rs.getInt("tbl_x"));
				if (rs.getObject("tbl_y") != null) tablesVO.setTbl_y(rs.getInt("tbl_y"));				
				list.add(tablesVO); // Store the row in the list
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
			TablesJDBCDAO dao = new TablesJDBCDAO();
	
			// 新增
	//		TablesVO tablesVO1 = new TablesVO();
	//		tablesVO1.setVendor_no("V000001");
	//		tablesVO1.setTbl_name("A1");
	//		tablesVO1.setTbl_size(new Integer(1));
	//		tablesVO1.setTbl_type(new Integer(1));
	//		tablesVO1.setTbl_x(new Integer(200));
	//		tablesVO1.setTbl_y(new Integer(200));
	//		dao.insert(tablesVO1);
	
			// 修改
	//		TablesVO tablesVO2 = new TablesVO();
	//		tablesVO2.setTbl_no("T000001");
	//		tablesVO2.setTbl_name("A1");
	//		tablesVO2.setTbl_size(new Integer(1));
	//		tablesVO2.setTbl_type(new Integer(1));
	//		tablesVO2.setTbl_x(new Integer(500));
	//		tablesVO2.setTbl_y(new Integer(500));
	//		dao.update(tablesVO2);
	
			// 刪除
	//		dao.delete("T000011");
	
			// 查詢
	//		TablesVO tablesVO3 = dao.findByPrimaryKey("T000002");
	//		System.out.print(tablesVO3.getTbl_no() + ",");
	//		System.out.print(tablesVO3.getVendor_no() + ",");
	//		System.out.print(tablesVO3.getTbl_name() + ",");
	//		System.out.print(tablesVO3.getTbl_size() + ",");
	//		System.out.print(tablesVO3.getTbl_type() + ",");
	//		System.out.print(tablesVO3.getTbl_x() + ",");
	//		System.out.println(tablesVO3.getTbl_y());
	//		System.out.println("---------------------");
	
			// 查詢
	//		List<TablesVO> list = dao.getAll();
	//		for (TablesVO aTables : list) {
	//			System.out.print(aTables.getTbl_no() + ",");
	//			System.out.print(aTables.getVendor_no() + ",");
	//			System.out.print(aTables.getTbl_name() + ",");
	//			System.out.print(aTables.getTbl_size() + ",");
	//			System.out.print(aTables.getTbl_type() + ",");
	//			System.out.print(aTables.getTbl_x() + ",");
	//			System.out.print(aTables.getTbl_y());
	//			System.out.println();
	//		}
			
			// 查詢 by vendor_no
			List<TablesVO> list2 = dao.getAllByVendor_no("V000001");
			for (TablesVO aTables : list2) {
				System.out.print(aTables.getTbl_no() + ",");
				System.out.print(aTables.getVendor_no() + ",");
				System.out.print(aTables.getTbl_name() + ",");
				System.out.print(aTables.getTbl_size() + ",");
				System.out.print(aTables.getTbl_type() + ",");
				System.out.print(aTables.getTbl_x() + ",");
				System.out.print(aTables.getTbl_y());
				System.out.println();
			}
		}

}
