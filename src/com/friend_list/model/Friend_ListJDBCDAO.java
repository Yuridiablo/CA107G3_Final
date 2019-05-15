package com.friend_list.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;


public class Friend_ListJDBCDAO implements Friend_ListDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA107G3";
	String passwd ="123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO FRIEND_LIST(MEM_NO,FRIE_NO,FRIE_CODE) VALUES(?,?,?)";
			
	private static final String GET_ALL_STMT = 
			"SELECT MEM_NO,FRIE_NO,FRIE_CODE FROM FRIEND_LIST ORDER BY MEM_NO";
			
	private static final String GET_ONE_STMT =
			"SELECT MEM_NO,FRIE_NO,FRIE_CODE FROM FRIEND_LIST WHERE MEM_NO =?";
	
	private static final String GET_ONE_STMT2 =
			"SELECT MEM_NO,FRIE_NO,FRIE_CODE FROM FRIEND_LIST WHERE MEM_NO =? AND FRIE_NO=?";
	
	private static final String GetFriend_ListByFrie_code_STMT=
			"SELECT MEM_NO,FRIE_NO,FRIE_CODE FROM FRIEND_LIST WHERE FRIE_CODE = ? ORDER BY MEM_NO";	
			
	private static final String DELETE =
			"DELETE FROM FRIEND_LIST WHERE MEM_NO =? AND FRIE_NO=?";
			
	private static final String UPDATE =
			"UPDATE FRIEND_LIST SET FRIE_CODE =? WHERE MEM_NO=? AND FRIE_NO=?";
	@Override
	public void insert(Friend_ListVO friend_listVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, friend_listVO.getMem_no());
			pstmt.setString(2, friend_listVO.getFrie_no());
			pstmt.setInt(3, friend_listVO.getFrie_code());
			
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
	public void update(Friend_ListVO friend_listVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1,friend_listVO.getFrie_code());
			pstmt.setString(2,friend_listVO.getMem_no());
			pstmt.setString(3,friend_listVO.getFrie_no());
			
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
	public void delete(String mem_no,String frie_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, mem_no);
			pstmt.setString(2, frie_no);
			
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
	public Friend_ListVO findByPrimaryKey(String mem_no) {
		Friend_ListVO friend_listVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, mem_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend_listVO = new Friend_ListVO();
				friend_listVO.setMem_no(rs.getString("MEM_NO"));
			    friend_listVO.setFrie_no(rs.getString("FRIE_NO"));
			    friend_listVO.setFrie_code(rs.getInt("FRIE_CODE"));
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
		return friend_listVO;
		
	}
	@Override
	public Friend_ListVO findByPrimaryKey2(String mem_no,String frie_no) {
		Friend_ListVO friend_listVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT2);
			
			pstmt.setString(1, mem_no);
			pstmt.setString(2, frie_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend_listVO = new Friend_ListVO();
				friend_listVO.setMem_no(rs.getString("MEM_NO"));
			    friend_listVO.setFrie_no(rs.getString("FRIE_NO"));
			    friend_listVO.setFrie_code(rs.getInt("FRIE_CODE"));
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
		return friend_listVO;
		
	}
	@Override
	public List<Friend_ListVO> getAll() {
		
		List<Friend_ListVO> list = new ArrayList<Friend_ListVO>();
		Friend_ListVO friend_listVO= null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
			    friend_listVO = new Friend_ListVO();
			    friend_listVO.setMem_no(rs.getString("MEM_NO"));
			    friend_listVO.setFrie_no(rs.getString("FRIE_NO"));
			    friend_listVO.setFrie_code(rs.getInt("FRIE_CODE"));
				
				list.add(friend_listVO);
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
	
	@Override
	public Set<Friend_ListVO> getFriend_ListByFrie_code(Integer frie_code){
		Set<Friend_ListVO> set = new LinkedHashSet<Friend_ListVO>();
		Friend_ListVO friend_listVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(GetFriend_ListByFrie_code_STMT);
			pstmt.setInt(1, frie_code);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend_listVO = new Friend_ListVO();
				friend_listVO.setMem_no(rs.getString("mem_no"));
				friend_listVO.setFrie_no(rs.getString("frie_no"));
				friend_listVO.setFrie_code(rs.getInt("frie_code"));
				set.add(friend_listVO);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}finally {
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
		return set;
	}
	
	public static void main(String args[]) {
		Friend_ListJDBCDAO dao = new Friend_ListJDBCDAO();
		
		//新增
		Friend_ListVO friend_listVO1 = new Friend_ListVO();
		friend_listVO1.setMem_no("M000004");
		friend_listVO1.setFrie_no("M000003");
		friend_listVO1.setFrie_code(3);
		dao.insert(friend_listVO1);
		
		//更新
		Friend_ListVO friend_listVO2 = new Friend_ListVO();
		friend_listVO2.setMem_no("M000001");
		friend_listVO2.setFrie_no("M000002");
		friend_listVO2.setFrie_code(7);
		dao.update(friend_listVO2);
		
		//刪除
		dao.delete("M000004","M000006");
		
		//查詢其中一個
		Friend_ListVO friend_listVO3 = dao.findByPrimaryKey("M000003");
		System.out.println(friend_listVO3.getMem_no()+",");
		System.out.println(friend_listVO3.getFrie_no()+",");
		System.out.println(friend_listVO3.getFrie_code()+",");
		System.out.println("---------------------------------");
		
		//查詢所有
		List<Friend_ListVO> list = dao.getAll();
		for(Friend_ListVO friend_listVO4:list) {
			System.out.println(friend_listVO4.getMem_no()+",");
			System.out.println(friend_listVO4.getFrie_no()+",");
			System.out.println(friend_listVO4.getFrie_code()+",");
			System.out.println();
		}
	}
	@Override
	public List<Friend_ListVO> getAll(String mem_no) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Friend_ListVO findByName(String mem_name, String mem_no) {
		// TODO Auto-generated method stub
		return null;
	}

}
