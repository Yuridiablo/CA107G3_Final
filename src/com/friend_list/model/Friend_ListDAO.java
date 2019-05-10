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

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Friend_ListDAO implements Friend_ListDAO_interface{

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB2");
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
	}

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
	
	private static final String GET_FRIEND_LIST=
			"SELECT * From friend_list where   frie_code=7  AND  mem_no=?";
	@Override
	public void insert(Friend_ListVO friend_listVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, friend_listVO.getMem_no());
			pstmt.setString(2, friend_listVO.getFrie_no());
			pstmt.setInt(3, friend_listVO.getFrie_code());
			
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
	public void update(Friend_ListVO friend_listVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1,friend_listVO.getFrie_code());
			pstmt.setString(2,friend_listVO.getMem_no());
			pstmt.setString(3,friend_listVO.getFrie_no());
			
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
	public void delete(String mem_no,String frie_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, mem_no);
			pstmt.setString(2, frie_no);
			
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
	public Friend_ListVO findByPrimaryKey(String mem_no) {
		Friend_ListVO friend_listVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, mem_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend_listVO = new Friend_ListVO();
				friend_listVO.setMem_no(rs.getString("MEM_NO"));
			    friend_listVO.setFrie_no(rs.getString("FRIE_NO"));
			    friend_listVO.setFrie_code(rs.getInt("FRIE_CODE"));
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
		return friend_listVO;
	}
	
	@Override
	public Friend_ListVO findByPrimaryKey2(String mem_no,String frie_no) {
		Friend_ListVO friend_listVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
			    friend_listVO = new Friend_ListVO();
			    friend_listVO.setMem_no(rs.getString("MEM_NO"));
			    friend_listVO.setFrie_no(rs.getString("FRIE_NO"));
			    friend_listVO.setFrie_code(rs.getInt("FRIE_CODE"));
				list.add(friend_listVO);
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
			con = ds.getConnection();
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

	@Override
	public List<Friend_ListVO> getfriendlist(String mem_no) {
		List<Friend_ListVO> list = new ArrayList<Friend_ListVO>();
		Friend_ListVO friend_listVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con=ds.getConnection();
			pstmt =con.prepareStatement(GET_FRIEND_LIST);
			pstmt.setString(1,mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend_listVO = new Friend_ListVO();
				friend_listVO.setMem_no(rs.getString("mem_no"));
				friend_listVO.setFrie_no(rs.getString("frie_no"));
				friend_listVO.setFrie_code(rs.getInt("frie_code"));
				list.add(friend_listVO);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
		return list;
		
	}

}
