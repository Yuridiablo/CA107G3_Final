package com.comments.model;

import java.sql.Connection;
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

import com.restaurant_menu.model.Restaurant_MenuVO;

public class CommentsDAO implements CommentsDAO_interface {

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
			"INSERT INTO comments (cmnt_no, ord_no, vendor_no, score, cmnt, time, cmnt_status)" + 
			" VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?, CURRENT_TIMESTAMP, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT cmnt_no, ord_no, vendor_no, score, cmnt, time, cmnt_status FROM comments order by cmnt_no";
	private static final String GET_ONE_STMT = 
			"SELECT cmnt_no, ord_no, vendor_no, score, cmnt, time, cmnt_status FROM comments where cmnt_no = ?";
	private static final String DELETE = 
			"DELETE FROM comments where cmnt_no = ?";
	private static final String UPDATE = 
			"UPDATE comments set ord_no=?, vendor_no=?, score=?, cmnt=?, time=?, cmnt_status=? where cmnt_no = ?";
	private static final String GET_ONE_VENDOR = 
			"SELECT * FROM comments where vendor_no = ?";
	private static final String GET_BY_ORD_NO=
			"SELECT cmnt_no, ord_no, vendor_no, score, cmnt, time, cmnt_status FROM comments where ord_no = ?";
	
	
	@Override
	public void insert(CommentsVO commentsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, commentsVO.getOrd_no());
			pstmt.setString(2, commentsVO.getVendor_no());
			pstmt.setInt(3, commentsVO.getScore());
			pstmt.setString(4, commentsVO.getCmnt());
			pstmt.setInt(5, commentsVO.getCmnt_status());

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
	public void update(CommentsVO commentsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, commentsVO.getOrd_no());
			pstmt.setString(2, commentsVO.getVendor_no());
			pstmt.setInt(3, commentsVO.getScore());
			pstmt.setString(4, commentsVO.getCmnt());
			pstmt.setTimestamp(5, commentsVO.getTime());
			pstmt.setInt(6, commentsVO.getCmnt_status());
			pstmt.setString(7, commentsVO.getCmnt_no());

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
	public void delete(String cmnt_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, cmnt_no);

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
	public CommentsVO findByPrimaryKey(String cmnt_no) {
		CommentsVO commentsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, cmnt_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// tablesVO 也稱?�� Domain objects
				commentsVO = new CommentsVO();
				commentsVO.setCmnt_no(rs.getString("cmnt_no"));
				commentsVO.setOrd_no(rs.getString("ord_no"));
				commentsVO.setVendor_no(rs.getString("vendor_no"));
				commentsVO.setScore(rs.getInt("score"));
				commentsVO.setCmnt(rs.getString("cmnt"));
				commentsVO.setTime(rs.getTimestamp("time"));
				commentsVO.setCmnt_status(rs.getInt("cmnt_status"));			
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
		return commentsVO;
	}

	@Override
	public List<CommentsVO> getAll() {
		List<CommentsVO> list = new ArrayList<CommentsVO>();
		CommentsVO commentsVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// tablesVO 也稱?�� Domain objects
				commentsVO = new CommentsVO();
				commentsVO.setCmnt_no(rs.getString("cmnt_no"));
				commentsVO.setOrd_no(rs.getString("ord_no"));
				commentsVO.setVendor_no(rs.getString("vendor_no"));
				commentsVO.setScore(rs.getInt("score"));
				commentsVO.setCmnt(rs.getString("cmnt"));
				commentsVO.setTime(rs.getTimestamp("time"));
				commentsVO.setCmnt_status(rs.getInt("cmnt_status"));
				list.add(commentsVO); // Store the row in the list
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
		CommentsDAO dao = new CommentsDAO();

		// ?���?
		CommentsVO commentsVO1 = new CommentsVO();
		commentsVO1.setOrd_no("20190401-000001");
		commentsVO1.setVendor_no("V000001");
		commentsVO1.setScore(new Integer(4));
		commentsVO1.setCmnt("good");
		commentsVO1.setCmnt_status(new Integer(1));

		dao.insert(commentsVO1);

		// 修改
		CommentsVO commentsVO2 = new CommentsVO();
		commentsVO2.setCmnt_no("C000007");
		commentsVO2.setOrd_no("20190401-000001");
		commentsVO2.setVendor_no("V000001");
		commentsVO2.setScore(new Integer(4));
		commentsVO2.setTime(new java.sql.Timestamp(new java.util.Date().getTime()));
		commentsVO2.setCmnt("bad");
		commentsVO2.setCmnt_status(new Integer(1));
		dao.update(commentsVO2);

		// ?��?��
		dao.delete("C000007");

		// ?���?
		CommentsVO commentsVO3 = dao.findByPrimaryKey("C000001");
		System.out.print(commentsVO3.getCmnt_no() + ",");
		System.out.print(commentsVO3.getOrd_no() + ",");
		System.out.print(commentsVO3.getVendor_no() + ",");
		System.out.print(commentsVO3.getScore() + ",");
		System.out.print(commentsVO3.getCmnt() + ",");
		System.out.print(commentsVO3.getTime() + ",");
		System.out.println(commentsVO3.getCmnt_status());
		System.out.println("---------------------");

		// ?���?
		List<CommentsVO> list = dao.getAll();
		for (CommentsVO aTables : list) {
			System.out.print(aTables.getCmnt_no() + ",");
			System.out.print(aTables.getOrd_no() + ",");
			System.out.print(aTables.getVendor_no() + ",");
			System.out.print(aTables.getScore() + ",");
			System.out.print(aTables.getCmnt() + ",");
			System.out.print(aTables.getTime() + ",");
			System.out.println(aTables.getCmnt_status());
			System.out.println();
		}
	}

	@Override
	public List<CommentsVO> getVendor(String vendor_no) {
		List<CommentsVO> list = new ArrayList<CommentsVO>();
		CommentsVO cm = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_VENDOR);
			pstmt.setString(1, vendor_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cm = new CommentsVO();
				
				cm.setVendor_no(rs.getString("vendor_no"));
				cm.setOrd_no(rs.getString("ord_no"));
				cm.setCmnt_no(rs.getString("cmnt_no"));
				cm.setScore(rs.getInt("score"));
				cm.setCmnt(rs.getString("cmnt"));
				cm.setTime(rs.getTimestamp("time"));
				cm.setCmnt_status(rs.getInt("cmnt_status"));
				
				list.add(cm);
				
			}
		} catch (SQLException se) {
			
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}

	@Override
	public CommentsVO findByord_no(String ord_no) {
		
			CommentsVO commentsVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_BY_ORD_NO);

				pstmt.setString(1, ord_no);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					// tablesVO 也稱?�� Domain objects
					commentsVO = new CommentsVO();
					commentsVO.setCmnt_no(rs.getString("cmnt_no"));
					commentsVO.setOrd_no(rs.getString("ord_no"));
					commentsVO.setVendor_no(rs.getString("vendor_no"));
					commentsVO.setScore(rs.getInt("score"));
					commentsVO.setCmnt(rs.getString("cmnt"));
					commentsVO.setTime(rs.getTimestamp("time"));
					commentsVO.setCmnt_status(rs.getInt("cmnt_status"));			
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
			return commentsVO;
		}
	

	@Override
	public List<CommentsVO> getOneVendor(String vendor_no) {
		List<CommentsVO> list = new ArrayList<CommentsVO>();
		CommentsVO commentsVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_VENDOR);
			pstmt.setString(1, vendor_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// tablesVO 也稱為 Domain objects
				commentsVO = new CommentsVO();
				commentsVO.setCmnt_no(rs.getString("cmnt_no"));
				commentsVO.setOrd_no(rs.getString("ord_no"));
				commentsVO.setVendor_no(rs.getString("vendor_no"));
				commentsVO.setScore(rs.getInt("score"));
				commentsVO.setCmnt(rs.getString("cmnt"));
				commentsVO.setTime(rs.getTimestamp("time"));
				commentsVO.setCmnt_status(rs.getInt("cmnt_status"));
				list.add(commentsVO); // Store the row in the list
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
