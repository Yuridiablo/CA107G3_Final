package com.comment_reported.model;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class Comment_ReportedJDBCDAO implements Comment_ReportedDAO_interface {
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA107G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO COMMENT_REPORTED (rep_no,cmnt_no,mem_no,rep_for,rep_time,rep_stat) VALUES ('CR'||LPAD(to_char(COMMENT_REPORTED_SEQ.NEXTVAL), 8, '0'),?,?,?,CURRENT_TIMESTAMP,?)";	
	private static final String UPDATE_STMT =
			"UPDATE COMMENT_REPORTED set rep_stat=? where rep_no = ?";
	private static final String DELETE = 
			"DELETE FROM COMMENT_REPORTED where rep_no = ?";
	private static final String GET_ONE_STMT = 
			"SELECT rep_no,cmnt_no,mem_no,rep_for,rep_time,rep_stat FROM COMMENT_REPORTED where rep_no = ?";
	private static final String GET_ONE_STATE = 
			"SELECT rep_no,cmnt_no,mem_no,rep_for,rep_time,rep_stat FROM COMMENT_REPORTED where rep_stat = ?";
	private static final String GET_ALL_STMT = 
			"SELECT rep_no,cmnt_no,mem_no,rep_for,rep_time,rep_stat FROM COMMENT_REPORTED order by rep_no";

	@Override
	public void insert(Comment_ReportedVO Comment_ReportedVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
//			pstmt.setString(1, Comment_ReportedVO.getRep_no());
			pstmt.setString(1, Comment_ReportedVO.getCmnt_no());
			pstmt.setString(2, Comment_ReportedVO.getMem_no());
			pstmt.setString(3, Comment_ReportedVO.getRep_for());
//			pstmt.setTimestamp(4, Comment_ReportedVO.getRep_time());
			pstmt.setInt(4, Comment_ReportedVO.getRep_stat());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
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
	}

	@Override
	public void update(Comment_ReportedVO Comment_ReportedVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_STMT);
			

			pstmt.setInt(1, Comment_ReportedVO.getRep_stat());
			pstmt.setString(2,Comment_ReportedVO.getRep_no());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
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
	}

	@Override
	public void delete(String rep_no) {
	
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, rep_no);
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
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
	}

	@Override
	public List<Comment_ReportedVO> findByStat(Integer rep_stat) {
		List<Comment_ReportedVO> list = new ArrayList<Comment_ReportedVO>();
		Comment_ReportedVO crVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STATE);
			pstmt.setInt(1, rep_stat);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				crVO = new Comment_ReportedVO();
				crVO.setRep_no(rs.getString("rep_no"));
				crVO.setCmnt_no(rs.getString("cmnt_no"));
				crVO.setMem_no(rs.getString("mem_no"));
				crVO.setRep_for(rs.getString("rep_for"));
				crVO.setRep_time(rs.getTimestamp("rep_time"));
				crVO.setRep_stat(rs.getInt("rep_stat"));
				list.add(crVO);
				
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
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
	public Comment_ReportedVO findByPK(String rep_no) {
		Comment_ReportedVO crVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, rep_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				crVO = new Comment_ReportedVO();
				crVO.setRep_no(rs.getString("rep_no"));
				crVO.setCmnt_no(rs.getString("cmnt_no"));
				crVO.setMem_no(rs.getString("mem_no"));
				crVO.setRep_for(rs.getString("rep_for"));
				crVO.setRep_time(rs.getTimestamp("rep_time"));
				crVO.setRep_stat(rs.getInt("rep_stat"));
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
		return crVO;
	}
	

	@Override
	public List<Comment_ReportedVO> getAll() {
		List<Comment_ReportedVO> list = new ArrayList<Comment_ReportedVO>();
		Comment_ReportedVO crVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				crVO = new Comment_ReportedVO();
				crVO.setRep_no(rs.getString("rep_no"));
				crVO.setCmnt_no(rs.getString("cmnt_no"));
				crVO.setMem_no(rs.getString("mem_no"));
				crVO.setRep_for(rs.getString("rep_for"));
				crVO.setRep_time(rs.getTimestamp("rep_time"));
				crVO.setRep_stat(rs.getInt("rep_stat"));
				list.add(crVO);
				
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
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

	public static void main(String[] args) {
		Comment_ReportedJDBCDAO dao = new Comment_ReportedJDBCDAO();	
		
		//新增
		Comment_ReportedVO comRepVO01 = new Comment_ReportedVO();
		
		comRepVO01.setCmnt_no("C000001");
		comRepVO01.setMem_no("M000001");
		comRepVO01.setRep_for("這篇是來亂的吧?為什麼會貼別家店的東西？美式餐廳有賣小籠包喔?");
//		comRepVO01.setRep_time(new Timestamp(new Date().getTime()));
		comRepVO01.setRep_stat(1);		
		dao.insert(comRepVO01);
		
		//修改
		Comment_ReportedVO comRepVO02 = new Comment_ReportedVO();
		comRepVO02.setRep_stat(3);
		comRepVO02.setRep_no("CR00000004");
		dao.update(comRepVO02);
		
		//刪除
//		dao.delete("CR00000004");
		
		//查單筆
		Comment_ReportedVO crVO = dao.findByPK("CR00000001");
		System.out.println(crVO.getRep_no() + ",");
		System.out.println(crVO.getCmnt_no() + ",");
		System.out.println(crVO.getMem_no() + ",");
		System.out.println(crVO.getRep_for() + ",");
		System.out.println(crVO.getCmnt_no() + ",");
		System.out.println(crVO.getRep_stat() + ",");
		System.out.println("---------------------");
		
		//查某種狀態的檢舉
		List<Comment_ReportedVO> list_stat = dao.findByStat(1);
		for (Comment_ReportedVO comRep : list_stat) {
			System.out.println(comRep.getRep_no());
			System.out.println(comRep.getCmnt_no());
			System.out.println(comRep.getMem_no());
			System.out.println(comRep.getRep_for());
			System.out.println(comRep.getCmnt_no());
			System.out.println(comRep.getRep_stat());
			System.out.println("--------");
		}
		
		//查全部
//		List<Comment_ReportedVO> list = dao.getAll();
//		for (Comment_ReportedVO comRep : list) {
//			System.out.println(comRep.getRep_no());
//			System.out.println(comRep.getCmnt_no());
//			System.out.println(comRep.getMem_no());
//			System.out.println(comRep.getRep_for());
//			System.out.println(comRep.getCmnt_no());
//			System.out.println(comRep.getRep_stat());
//			System.out.println("--------");
//		}
	}

}
