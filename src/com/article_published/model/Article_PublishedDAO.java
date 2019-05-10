package com.article_published.model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
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

import com.article_published.CompositeQuery.jdbcUtil_CompositeQuery_Article_Published;

public class Article_PublishedDAO implements Article_PublishedDAO_interface{

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
			"INSERT INTO ARTICLE_PUBLISHED(ART_NO,MEM_NO,ART_TITLE,ART_CONTENT,ART_TIME,ART_PIC1,ART_PIC2,ART_PIC3,ART_PIC4,ART_PIC5,ART_CODE) VALUES('AP'||LPAD(to_char(ARTPUB_SEQ.NEXTVAL),8,'0'),?,?,?,?,?,?,?,?,?,?)";
			
	private static final String GET_ALL_STMT = 
			"SELECT ART_NO,MEM_NO,ART_TITLE,ART_CONTENT,TO_CHAR(ART_TIME,'yyyy-mm-dd') ART_TIME,ART_CODE FROM ARTICLE_PUBLISHED ORDER BY ART_NO";
	
	private static final String GET_ALL_PERSONAL_STMT =
			"SELECT ART_NO,MEM_NO,ART_TITLE,ART_CONTENT,TO_CHAR(ART_TIME,'yyyy-mm-dd') ART_TIME,ART_CODE FROM ARTICLE_PUBLISHED WHERE MEM_NO=? ORDER BY ART_NO";
	
	private static final String GET_ONE_STMT =
			"SELECT ART_NO,MEM_NO,ART_TITLE,ART_CONTENT,TO_CHAR(ART_TIME,'yyyy-mm-dd') ART_TIME,ART_CODE FROM ARTICLE_PUBLISHED WHERE ART_NO=?";
			
	private static final String DELETE_ART_RE=
			"DELETE FROM ARTICLE_REPORTED WHERE ART_NO=?";
	
	private static final String DELETE_ART_PUB=
			"DELETE FROM ARTICLE_PUBLISHED WHERE ART_NO=?";
			
	private static final String UPDATE =
			"UPDATE ARTICLE_PUBLISHED SET ART_TITLE=?,ART_CONTENT=?,ART_TIME=?,ART_PIC1=?,ART_PIC2=?,ART_PIC3=?,ART_PIC4=?,ART_PIC5=? WHERE ART_NO=?";

	private static final String UPDATE_FOR_ART_CODE =
			"UPDATE ARTICLE_PUBLISHED SET ART_CODE=? WHERE ART_NO=?";
	
	private static final String SHOWPIC =
			"SELECT ART_PIC1,ART_PIC2,ART_PIC3,ART_PIC4,ART_PIC5 FROM ARTICLE_PUBLISHED WHERE ART_NO=?";
	@Override
	public void insert(Article_PublishedVO article_publishedVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, article_publishedVO.getMem_no());
			pstmt.setString(2, article_publishedVO.getArt_title());
			pstmt.setString(3, article_publishedVO.getArt_content());
			pstmt.setDate(4, article_publishedVO.getArt_time());
			pstmt.setBytes(5, article_publishedVO.getArt_pic1());
			pstmt.setBytes(6, article_publishedVO.getArt_pic2());
			pstmt.setBytes(7, article_publishedVO.getArt_pic3());
			pstmt.setBytes(8, article_publishedVO.getArt_pic4());
			pstmt.setBytes(9, article_publishedVO.getArt_pic5());
			pstmt.setInt(10, article_publishedVO.getArt_code());
			
			
			pstmt.executeUpdate();
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
	
	public static byte[] getPictureByteArray(String path) throws IOException {
		File file = new File(path);
		FileInputStream fis = new FileInputStream(file);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192];
		int i;
		while ((i = fis.read(buffer)) != -1) {
			baos.write(buffer, 0, i);
		}
		baos.close();
		fis.close();

		return baos.toByteArray();
	}
	@Override
	public void update(Article_PublishedVO article_publishedVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, article_publishedVO.getArt_title());
			pstmt.setString(2, article_publishedVO.getArt_content());
			pstmt.setDate(3,article_publishedVO.getArt_time());
			pstmt.setBytes(4, article_publishedVO.getArt_pic1());
			pstmt.setBytes(5, article_publishedVO.getArt_pic2());
			pstmt.setBytes(6, article_publishedVO.getArt_pic3());
			pstmt.setBytes(7, article_publishedVO.getArt_pic4());
			pstmt.setBytes(8, article_publishedVO.getArt_pic5());
			pstmt.setString(9, article_publishedVO.getArt_no());
			
			pstmt.executeUpdate();
			
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
	public void updateforart_code(Article_PublishedVO article_publishedVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_FOR_ART_CODE);
			
			pstmt.setInt(1, article_publishedVO.getArt_code());
			pstmt.setString(2, article_publishedVO.getArt_no());
			
			pstmt.executeUpdate();
			
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
	public void delete(String art_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement(DELETE_ART_RE);
			pstmt.setString(1, art_no);
			pstmt.executeUpdate();
			
			pstmt =con.prepareStatement(DELETE_ART_PUB);
			pstmt.setString(1, art_no);
			pstmt.executeUpdate();
			
			con.commit();
			con.setAutoCommit(true);
		} catch (SQLException e) {
			if(con!=null) {
				try {
					con.rollback();
				}catch(SQLException ex) {
					throw new RuntimeException("rollback error occured. "
							+ ex.getMessage());
				}
			}
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
	public Article_PublishedVO findByPrimaryKey(String art_no) {
		Article_PublishedVO article_publishedVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, art_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				article_publishedVO = new  Article_PublishedVO();
				article_publishedVO.setArt_no(rs.getString("ART_NO"));
				article_publishedVO.setMem_no(rs.getString("MEM_NO"));
				article_publishedVO.setArt_title(rs.getString("ART_TITLE"));
				article_publishedVO.setArt_content(rs.getString("ART_CONTENT"));
				article_publishedVO.setArt_time(rs.getDate("ART_TIME"));
				article_publishedVO.setArt_code(rs.getInt("ART_CODE"));
			}
			
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
		return article_publishedVO;
	}

	@Override
	public List<Article_PublishedVO> getAll() {
		List<Article_PublishedVO> list = new ArrayList<Article_PublishedVO>();
		Article_PublishedVO article_publishedVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				article_publishedVO = new  Article_PublishedVO();
				article_publishedVO.setArt_no(rs.getString("ART_NO"));
				article_publishedVO.setMem_no(rs.getString("MEM_NO"));
				article_publishedVO.setArt_title(rs.getString("ART_TITLE"));
				article_publishedVO.setArt_content(rs.getString("ART_CONTENT"));
				article_publishedVO.setArt_time(rs.getDate("ART_TIME"));
				article_publishedVO.setArt_code(rs.getInt("ART_CODE"));
				list.add(article_publishedVO);
			}
		}catch (SQLException e) {
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
	
	@Override
	public List<Article_PublishedVO> getAll(String mem_no) {
		List<Article_PublishedVO> list = new ArrayList<Article_PublishedVO>();
		Article_PublishedVO article_publishedVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_PERSONAL_STMT);
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				article_publishedVO = new  Article_PublishedVO();
				article_publishedVO.setArt_no(rs.getString("ART_NO"));
				article_publishedVO.setMem_no(rs.getString("MEM_NO"));
				article_publishedVO.setArt_title(rs.getString("ART_TITLE"));
				article_publishedVO.setArt_content(rs.getString("ART_CONTENT"));
				article_publishedVO.setArt_time(rs.getDate("ART_TIME"));
				article_publishedVO.setArt_code(rs.getInt("ART_CODE"));
				list.add(article_publishedVO);
			}
		}catch (SQLException e) {
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

	@Override
	public List<Article_PublishedVO> getAll(Map<String, String[]> map) {
		List<Article_PublishedVO> list = new ArrayList<Article_PublishedVO>();
		Article_PublishedVO article_publishedVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			String finalSQL = "select * from article_published "
					+ jdbcUtil_CompositeQuery_Article_Published.get_WhereCondition(map)
					+ "order by art_time";
			
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("finalSQL(By DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				article_publishedVO = new Article_PublishedVO();
				article_publishedVO.setArt_no(rs.getString("ART_NO"));
				article_publishedVO.setMem_no(rs.getString("MEM_NO"));
				article_publishedVO.setArt_title(rs.getString("ART_TITLE"));
				article_publishedVO.setArt_content(rs.getString("ART_CONTENT"));
				article_publishedVO.setArt_time(rs.getDate("ART_TIME"));
				article_publishedVO.setArt_code(rs.getInt("ART_CODE"));
				list.add(article_publishedVO);
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally{
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
	public Article_PublishedVO showpic(String art_no) {
		Article_PublishedVO article_publishedVO = null;
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con =ds.getConnection();
			pstmt = con.prepareStatement(SHOWPIC);
			
			pstmt.setString(1, art_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				article_publishedVO = new Article_PublishedVO();
				article_publishedVO.setArt_pic1(rs.getBytes("ART_PIC1"));
				article_publishedVO.setArt_pic2(rs.getBytes("ART_PIC2"));
				article_publishedVO.setArt_pic3(rs.getBytes("ART_PIC3"));
				article_publishedVO.setArt_pic4(rs.getBytes("ART_PIC4"));
				article_publishedVO.setArt_pic5(rs.getBytes("ART_PIC5"));
			}
		}catch(SQLException e) {
			throw new RuntimeException("A database error ocurred."+e.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return article_publishedVO;
	}

}
