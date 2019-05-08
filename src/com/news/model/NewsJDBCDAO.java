package com.news.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.feature.model.FeatureJDBCDAO;
import com.feature.model.FeatureVO;

public class NewsJDBCDAO implements NewsDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA107G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO news (news_no,emp_no,news_cont,news_pic,news_rea) VALUES ('N'||LPAD(to_char(NEWS_SEQ.nextval), 3, '0'),?, ?, ?,?)";
		private static final String GET_ALL_STMT = 
			"SELECT news_no,emp_no,news_cont,news_pic,news_rea FROM news order by news_no";
		private static final String GET_ONE_STMT = 
			"SELECT news_no,emp_no,news_cont,news_pic,news_rea FROM news where news_no = ?";
		private static final String GET_ALL_STMT_BY_EMPNO = 
				"SELECT news_no,emp_no,news_cont,news_pic,news_rea FROM news where emp_no = ? order by news_no";
		private static final String DELETE = 
			"DELETE FROM news where news_no = ?";
		private static final String UPDATE = 
			"UPDATE news set news_cont=? where news_no = ?";
		
		@Override
		public int insert(NewsVO newsVO) {
			int updateCount=0;
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(INSERT_STMT);
				
				pstmt.setString(1, newsVO.getEmp_no());
				pstmt.setString(2, newsVO.getNews_cont());
				pstmt.setBytes(3, newsVO.getNews_pic());
				pstmt.setDate(4, newsVO.getNews_rea());
				
				updateCount = pstmt.executeUpdate();
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
						return updateCount;
					}
		@Override
		public List<NewsVO> findByEmployeeNo(String emp_no) {
			List<NewsVO> list = new ArrayList<NewsVO>();
			NewsVO newsVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				System.out.println("findByEmployeeNamefindByEmployeeNamefindByEmployeeName");
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(GET_ALL_STMT_BY_EMPNO);
				pstmt.setString(1, emp_no);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					// empVO 也稱為 Domain objects
					newsVO = new NewsVO();
					newsVO.setNews_no(rs.getString("news_no"));
					newsVO.setEmp_no(rs.getString("emp_no"));
					newsVO.setNews_cont(rs.getString("news_cont"));
					newsVO.setNews_pic(rs.getBytes("news_pic"));
					newsVO.setNews_rea(rs.getDate("news_rea"));
					list.add(newsVO); // Store the row in the vector
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
		public int update(NewsVO newsVO) {
			int updateCount = 0;
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(UPDATE);
				
				pstmt.setString(1, newsVO.getNews_cont());
				pstmt.setString(2, newsVO.getNews_no());
				
				updateCount = pstmt.executeUpdate();
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
			return updateCount;
		}
		@Override
		public int delete(String news_no) {
			int updateCount = 0;
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {

				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(DELETE);
				
				pstmt.setString(1, news_no);
				
				updateCount = pstmt.executeUpdate();

				// Handle any driver errors
			}catch (ClassNotFoundException e) {
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
			return updateCount;
		}
		@Override
		public NewsVO findByPrimaryKey(String news_no) {
			NewsVO newsVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(GET_ONE_STMT);
				
				pstmt.setString(1, news_no);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					// empVo 也稱為 Domain objects
					newsVO = new NewsVO();
					newsVO.setNews_no(rs.getString("news_no"));
					newsVO.setEmp_no(rs.getString("emp_no"));
					newsVO.setNews_cont(rs.getString("news_cont"));
					newsVO.setNews_pic(rs.getBytes("news_pic"));
					newsVO.setNews_rea(rs.getDate("news_rea"));
				}// Handle any driver errors
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
			return newsVO;
		}
		@Override
		public List<NewsVO> getAll() {
			List<NewsVO> list = new ArrayList<NewsVO>();
			NewsVO newsVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					// empVO 也稱為 Domain objects
					newsVO = new NewsVO();
					newsVO.setNews_no(rs.getString("news_no"));
					newsVO.setEmp_no(rs.getString("emp_no"));
					newsVO.setNews_cont(rs.getString("news_cont"));
					newsVO.setNews_pic(rs.getBytes("news_pic"));
					newsVO.setNews_rea(rs.getDate("news_rea"));
					list.add(newsVO); // Store the row in the vector
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

			NewsJDBCDAO dao = new NewsJDBCDAO();

			 //新增
//			 NewsVO newsVO1 = new NewsVO();
//			 newsVO1.setEmp_no("E000000001");
//			 newsVO1.setNews_cont("跳樓大活蝦");
//			 newsVO1.setNews_rea(java.sql.Date.valueOf("2019-01-01"));
//			 int updateCount_insert = dao.insert(newsVO1);
//			 System.out.println(updateCount_insert);
					

			 //修改
//			 NewsVO newsVO2 = new NewsVO();
//			 newsVO1.setNews_cont("跳樓小活鳥");
//			 newsVO1.setNews_no("N006");
//			 int updateCount_update = dao.update(newsVO2);
//			 System.out.println(updateCount_update);
					

			 //刪除
//			 int updateCount_delete = dao.delete("N006");
//			 System.out.println(updateCount_delete);

			// 查詢
//			NewsVO newsVO3 = dao.findByPrimaryKey("N001");
//			System.out.print(newsVO3.getNews_no() + ",");
//			System.out.print(newsVO3.getEmp_no() + ",");
//			System.out.print(newsVO3.getNews_cont() + ",");
//			System.out.print(newsVO3.getNews_pic() + ",");
//			System.out.print(newsVO3.getNews_rea() );
//			System.out.println("---------------------");

			// 查詢
//			List<NewsVO> list = dao.getAll();
//			for (NewsVO aNews : list) {
//				System.out.print(aNews.getNews_no() + ",");
//				System.out.print(aNews.getEmp_no() + ",");
//				System.out.print(aNews.getNews_cont() + ",");
//				System.out.print(aNews.getNews_pic() + ",");
//				System.out.print(aNews.getNews_rea() );
//				System.out.println();
			}
		}

		
	
