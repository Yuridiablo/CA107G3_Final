package com.feature_detail.model;

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

import com.feature.model.FeatureDAO;
import com.feature.model.FeatureVO;
import com.news.model.NewsVO;

public class Feature_detailDAO implements Feature_detailDAO_interface {
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
		"INSERT INTO feature_detail (fea_no,emp_no) VALUES (?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT fea_no,emp_no FROM feature_detail order by emp_no";
	private static final String GET_ALL_STMT_ByEmpno = 
			"SELECT fea_no,emp_no FROM feature_detail where emp_no = ? order by emp_no";
	private static final String GET_ONE_STMT = 
			"SELECT fea_no,emp_no FROM feature_detail where emp_no = ? and fea_no= ?";
	private static final String DELETE = 
			"DELETE FROM feature_detail where emp_no = ? and fea_no= ?";
	
	@Override
	public List<Feature_detailVO> findByEmp_no(String emp_no) {
		List<Feature_detailVO> list = new ArrayList<Feature_detailVO>();
		Feature_detailVO feature_detailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT_ByEmpno);
			pstmt.setString(1, emp_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				feature_detailVO = new Feature_detailVO();
				feature_detailVO.setEmp_no(rs.getString("emp_no"));
				feature_detailVO.setFea_no(rs.getString("fea_no"));
				list.add(feature_detailVO); // Store the row in the vector
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
	public int insert(Feature_detailVO feature_detailVO) {
		int updateCount=0;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			
			pstmt.setString(1, feature_detailVO.getFea_no());
			pstmt.setString(2, feature_detailVO.getEmp_no());
			
			updateCount = pstmt.executeUpdate();
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
					return updateCount;
				}
	@Override
	public int delete(String emp_no,String fea_no) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, emp_no);
			pstmt.setString(2, fea_no);
			
			updateCount = pstmt.executeUpdate();

			// Handle any driver errors
		}catch (SQLException se) {
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
	public Feature_detailVO findByPrimaryKey(String emp_no,String fea_no) {
		Feature_detailVO feature_detailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, emp_no);
			pstmt.setString(2, fea_no);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				feature_detailVO = new Feature_detailVO();
				feature_detailVO.setEmp_no(rs.getString("emp_no"));
				feature_detailVO.setFea_no(rs.getString("fea_no"));
			}// Handle any driver errors
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
		return feature_detailVO;
	}
	@Override
	public List<Feature_detailVO> getAll() {
		List<Feature_detailVO> list = new ArrayList<Feature_detailVO>();
		Feature_detailVO feature_detailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				feature_detailVO = new Feature_detailVO();
				feature_detailVO.setEmp_no(rs.getString("emp_no"));
				feature_detailVO.setFea_no(rs.getString("fea_no"));
				list.add(feature_detailVO); // Store the row in the vector
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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

		Feature_detailDAO dao = new Feature_detailDAO();

		 //新增
//		 Feature_detailVO feadetVO1  = new Feature_detailVO();
//		 feadetVO1.setEmp_no("E000000001");
//		 feadetVO1.setFea_no("F008");
//		 int updateCount_insert = dao.insert(feadetVO1);
//		 System.out.println(updateCount_insert);
				
				

		 //刪除
//		 int updateCount_delete = dao.delete("E000000002","F002");
//		 System.out.println(updateCount_delete);

		// 查詢
//		Feature_detailVO feadetVO2 = dao.findByPrimaryKey("E000000001","F003");
//		System.out.print(feadetVO2.getEmp_no() + ",");
//		System.out.println(feadetVO2.getFea_no());
//		System.out.println("---------------------");

		// 查詢
//		List<Feature_detailVO> list = dao.getAll();
//		for (Feature_detailVO aFeadet : list) {
//			System.out.print(aFeadet.getEmp_no() + ",");
//			System.out.print(aFeadet.getFea_no());
//			System.out.println();
//		}
	}
}
