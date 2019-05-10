package com.article_reported.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.article_published.model.Article_PublishedJDBCDAO;
import com.article_published.model.Article_PublishedVO;

public class Article_ReportedJDBCDAO implements Article_ReportedDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA107G3";
	String passwd ="123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO ARTICLE_REPORTED(ARTRE_NO,ART_NO,MEM_NO,ARTRE_CONTENT,ARTRE_TIME,ARTRE_CODE) VALUES('AR'||LPAD(to_char(ARTRE_SEQ.NEXTVAL),8,'0'),?,?,?,?,?)";
			
	private static final String GET_ALL_STMT = 
			"SELECT ARTRE_NO,ART_NO,MEM_NO,ARTRE_CONTENT,TO_CHAR(ARTRE_TIME,'yyyy-mm-dd') ARTRE_TIME,ARTRE_CODE FROM ARTICLE_REPORTED ORDER BY ARTRE_NO";
			
	private static final String GET_ONE_STMT =
			"SELECT ARTRE_NO,ART_NO,MEM_NO,ARTRE_CONTENT,TO_CHAR(ARTRE_TIME,'yyyy-mm-dd') ARTRE_TIME,ARTRE_CODE FROM ARTICLE_REPORTED WHERE ARTRE_NO=?";
			
	private static final String DELETE =
			"DELETE FROM ARTICLE_REPORTED WHERE ARTRE_NO=?";
			
	private static final String UPDATE =
			"UPDATE ARTICLE_REPORTED SET ARTRE_CONTENT=?,ARTRE_TIME=?,ARTRE_CODE=? WHERE ARTRE_NO=?";
	@Override
	public void insert(Article_ReportedVO article_reportedVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, article_reportedVO.getArt_no());
			pstmt.setString(2, article_reportedVO.getMem_no());
			pstmt.setString(3, article_reportedVO.getArtre_content());
			pstmt.setDate(4, article_reportedVO.getArtre_time());
			pstmt.setInt(5, article_reportedVO.getArtre_code());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver"+e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured"+e.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			
		}
		
	}
	@Override
	public void update(Article_ReportedVO article_reportedVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, article_reportedVO.getArtre_content());
			pstmt.setDate(2,article_reportedVO.getArtre_time());
			pstmt.setInt(3, article_reportedVO.getArtre_code());
			pstmt.setString(4,article_reportedVO.getArtre_no());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver"+e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured"+e.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	@Override
	public void delete(String artre_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, artre_no);
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver"+e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured"+e.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}
	@Override
	public Article_ReportedVO findByPrimaryKey(String artre_no) {
		Article_ReportedVO article_reportedVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, artre_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				article_reportedVO = new  Article_ReportedVO();
				article_reportedVO.setArtre_no(rs.getString("ARTRE_NO"));
				article_reportedVO.setArt_no(rs.getString("ART_NO"));
				article_reportedVO.setMem_no(rs.getString("MEM_NO"));
				article_reportedVO.setArtre_content(rs.getString("ARTRE_CONTENT"));
				article_reportedVO.setArtre_time(rs.getDate("ARTRE_TIME"));
				article_reportedVO.setArtre_code(rs.getInt("ARTRE_CODE"));
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+ e.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return article_reportedVO;
		
	}
	@Override
	public List<Article_ReportedVO> getAll() {
		
		List<Article_ReportedVO> list = new ArrayList<Article_ReportedVO>();
		Article_ReportedVO article_reportedVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				article_reportedVO = new  Article_ReportedVO();
				article_reportedVO.setArtre_no(rs.getString("ARTRE_NO"));
				article_reportedVO.setArt_no(rs.getString("ART_NO"));
				article_reportedVO.setMem_no(rs.getString("MEM_NO"));
				article_reportedVO.setArtre_content(rs.getString("ARTRE_CONTENT"));
				article_reportedVO.setArtre_time(rs.getDate("ARTRE_TIME"));
				article_reportedVO.setArtre_code(rs.getInt("ARTRE_CODE"));
				list.add(article_reportedVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+ e.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			
		}
		return list;
	}
	
	public static void main(String args[]) {
		Article_ReportedJDBCDAO dao = new Article_ReportedJDBCDAO();
		
		//新增
		Article_ReportedVO article_reportedVO1 = new Article_ReportedVO();
		article_reportedVO1.setArt_no("AP00000001");
		article_reportedVO1.setMem_no("M000006");
		article_reportedVO1.setArtre_content("蝦子太小隻，吃了滿嘴的油");
		article_reportedVO1.setArtre_time(java.sql.Date.valueOf("2018-09-23"));
		article_reportedVO1.setArtre_code(1);
		dao.insert(article_reportedVO1);
		
		//更新
		Article_ReportedVO article_reportedVO2 = new Article_ReportedVO();
		article_reportedVO2.setArtre_no("AR00000002");
		article_reportedVO2.setArtre_content("這哪是星爺，明明就是猩爺");
		article_reportedVO2.setArtre_time(java.sql.Date.valueOf("2017-03-11"));
		article_reportedVO2.setArtre_code(2);
		
		dao.update(article_reportedVO2);
		
		//刪除
		dao.delete("AR00000006");
		
		//查詢其中一個
		Article_ReportedVO article_reportedVO3 = dao.findByPrimaryKey("AR00000005");
		System.out.println(article_reportedVO3.getArtre_no()+",");
		System.out.println(article_reportedVO3.getArt_no()+",");
		System.out.println(article_reportedVO3.getMem_no()+",");
		System.out.println(article_reportedVO3.getArtre_content()+",");
		System.out.println(article_reportedVO3.getArtre_time()+",");
		System.out.println(article_reportedVO3.getArtre_code()+",");
		System.out.println("---------------------------------");
		
		//查詢所有
		List<Article_ReportedVO> list = dao.getAll();
		for(Article_ReportedVO article_reportedVO5:list) {
			System.out.println(article_reportedVO5.getArtre_no()+",");
			System.out.println(article_reportedVO5.getArt_no()+",");
			System.out.println(article_reportedVO5.getMem_no()+",");
			System.out.println(article_reportedVO5.getArtre_content()+",");
			System.out.println(article_reportedVO5.getArtre_time()+",");
			System.out.println(article_reportedVO5.getArtre_code()+",");
			System.out.println();
		}
	}
	
	
}
