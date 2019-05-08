package com.feature.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.employee.model.EmployeeDAO_interface;
import com.employee.model.EmployeeJDBCDAO;
import com.employee.model.EmployeeVO;
import com.news.model.NewsVO;

public class FeatureJDBCDAO implements FeatureDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA107TEST";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO feature (fea_no,fea_name,fea_det) VALUES ('F'||LPAD(to_char(FEATURE_SEQ.nextval), 3, '0'), ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT fea_no,fea_name,fea_det FROM feature order by fea_no";
		private static final String GET_ONE_STMT = 
			"SELECT fea_no,fea_name,fea_det FROM feature where fea_no = ?";
		private static final String DELETE = 
			"DELETE FROM feature where fea_no = ?";
		private static final String UPDATE = 
			"UPDATE feature set fea_name=?, fea_det=? where fea_no = ?";
		
		
		@Override
		public int insert(FeatureVO featureVO) {
			int updateCount=0;
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(INSERT_STMT);
				
				
				pstmt.setString(1, featureVO.getFea_name());
				pstmt.setString(2, featureVO.getFea_det());
				
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
		public int update(FeatureVO featureVO) {
			int updateCount = 0;
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(UPDATE);
				
				pstmt.setString(1, featureVO.getFea_name());
				pstmt.setString(2, featureVO.getFea_det());
				pstmt.setString(3, featureVO.getFea_no());
				
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
		public int delete(String fea_no) {
			int updateCount = 0;
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {

				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(DELETE);
				
				pstmt.setString(1, fea_no);
				
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
		public FeatureVO findByPrimaryKey(String fea_no) {
			FeatureVO featureVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {

				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(GET_ONE_STMT);
				
				pstmt.setString(1, fea_no);
				
				rs = pstmt.executeQuery();

				while (rs.next()) {
					// empVo 也稱為 Domain objects
					featureVO = new FeatureVO();
					featureVO.setFea_no(rs.getString("fea_no"));
					featureVO.setFea_name(rs.getString("fea_name"));
					featureVO.setFea_det(rs.getString("fea_det"));
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
			return featureVO;
		}
		@Override
		public List<FeatureVO> getAll() {
			List<FeatureVO> list = new ArrayList<FeatureVO>();
			FeatureVO featureVO = null;

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
					featureVO = new FeatureVO();
					featureVO.setFea_no(rs.getString("fea_no"));
					featureVO.setFea_name(rs.getString("fea_name"));
					featureVO.setFea_det(rs.getString("fea_det"));
					list.add(featureVO); // Store the row in the vector
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

			FeatureJDBCDAO dao = new FeatureJDBCDAO();

			 //新增
//			 FeatureVO feaVO1 = new FeatureVO();
//			 feaVO1.setFea_name("刪除會員");
//			 feaVO1.setFea_det("刪除會員喇");
//			 int updateCount_insert = dao.insert(feaVO1);
//			 System.out.println(updateCount_insert);
					

			 //修改
//			 FeatureVO feaVO2 = new FeatureVO();
//			 feaVO2.setFea_name("刪除員工");
//			 feaVO2.setFea_det("刪除");
//			 feaVO2.setFea_no("F015");
//			 int updateCount_update = dao.update(feaVO2);
//			 System.out.println(updateCount_update);
					

			 //刪除
			 int updateCount_delete = dao.delete("F015");
			 System.out.println(updateCount_delete);

			// 查詢
//			FeatureVO feaVO3 = dao.findByPrimaryKey("F001");
//			System.out.print(feaVO3.getFea_no() + ",");
//			System.out.print(feaVO3.getFea_name() + ",");
//			System.out.print(feaVO3.getFea_det());
//			System.out.println("---------------------");

			// 查詢
//			List<FeatureVO> list = dao.getAll();
//			for (FeatureVO aFea : list) {
//				System.out.print(aFea.getFea_no() + ",");
//				System.out.print(aFea.getFea_name() + ",");
//				System.out.print(aFea.getFea_det());
//				System.out.println();
//			}
		}
	}
