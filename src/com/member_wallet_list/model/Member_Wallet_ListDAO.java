package com.member_wallet_list.model;

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

import com.comment_reported.model.Comment_ReportedVO;

public class Member_Wallet_ListDAO implements Member_Wallet_ListDAO_interface {
	
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
//			('MWL'||LPAD(to_char(MEMBER_WALLET_LIST_SEQ.NEXTVAL), 7, '0'),'M000001',sysdate,'5566',1,null,'20190330-000001'
			"INSERT INTO Member_Wallet_list (list_no,mem_no,list_time,list_wit,list_stat,list_dep,pay_for) VALUES ('MWL'||LPAD(to_char(MEMBER_WALLET_LIST_SEQ.NEXTVAL), 7, '0'),?,sysdate,?,?,?,null)";	
	private static final String UPDATE_STMT =
			"UPDATE Member_Wallet_list set list_wit=? where list_no = ?";
	private static final String DELETE = 
			"DELETE FROM Member_Wallet_list where list_no = ?";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM Member_Wallet_list where mem_no = ?";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM Member_Wallet_list order by list_no";
	private static final String INSERT2_STMT = 
//			('MWL'||LPAD(to_char(MEMBER_WALLET_LIST_SEQ.NEXTVAL), 7, '0'),'M000001',sysdate,'5566',1,null,'20190330-000001'
			"INSERT INTO Member_Wallet_list (list_no,mem_no,list_time,list_wit,list_stat,list_dep,pay_for) VALUES ('MWL'||LPAD(to_char(MEMBER_WALLET_LIST_SEQ.NEXTVAL), 7, '0'),?,sysdate,?,?,null,?)";

	@Override
	//支付紀錄的insert
	public void insert(Member_Wallet_ListVO Member_Wallet_ListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, Member_Wallet_ListVO.getMem_no());
			pstmt.setString(2, Member_Wallet_ListVO.getList_wit());
			pstmt.setInt(3, Member_Wallet_ListVO.getList_stat());
			pstmt.setString(4, Member_Wallet_ListVO.getList_dep());
//			pstmt.setString(3, Member_Wallet_ListVO.getPay_for());
			
			pstmt.executeUpdate();
			
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
	public void update(Member_Wallet_ListVO Member_Wallet_ListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);
			

			pstmt.setString(1, Member_Wallet_ListVO.getList_wit());
			pstmt.setString(2,Member_Wallet_ListVO.getList_no());
			
			pstmt.executeUpdate();
			
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
	public void delete(String list_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, list_no);
			
			pstmt.executeUpdate();
			
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
	public List<Member_Wallet_ListVO> findByMem(String mem_no) {
		// TODO Auto-generated method stub
		List<Member_Wallet_ListVO> list = new ArrayList<Member_Wallet_ListVO>();
		Member_Wallet_ListVO mwl = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				mwl = new Member_Wallet_ListVO();
				mwl.setList_no(rs.getString("list_no"));
				System.out.println(rs.getString("list_no"));
				mwl.setMem_no(rs.getString("mem_no"));
				mwl.setList_time(rs.getDate("list_time"));
				mwl.setList_wit(rs.getString("list_wit"));
				mwl.setList_stat(rs.getInt("list_stat"));
				mwl.setList_dep(rs.getString("list_dep"));
				mwl.setPay_for(rs.getString("pay_for"));
				list.add(mwl);
				
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
	public List<Member_Wallet_ListVO> getAll() {
		// TODO Auto-generated method stub
		List<Member_Wallet_ListVO> list = new ArrayList<Member_Wallet_ListVO>();
		Member_Wallet_ListVO mwl = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				mwl = new Member_Wallet_ListVO();
				mwl.setList_no(rs.getString("list_no"));
				mwl.setMem_no(rs.getString("mem_no"));
				mwl.setList_time(rs.getDate("list_time"));
				mwl.setList_wit(rs.getString("list_wit"));
				mwl.setList_stat(rs.getInt("list_stat"));
				mwl.setList_dep(rs.getString("list_dep"));
				mwl.setPay_for(rs.getString("pay_for"));
				list.add(mwl);
				
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

	public static void main(String[] args) {
		Member_Wallet_ListDAO dao = new Member_Wallet_ListDAO();	
		
		//新增
		Member_Wallet_ListVO mwl = new Member_Wallet_ListVO();
		
		mwl.setMem_no("M000001");
		mwl.setList_wit("689");
//		mwl.setList_stat(1);
// 		mwl.setList_dep(null);
		mwl.setPay_for("20190330-000005");		
		dao.insert(mwl);		
		
		//修改
		Member_Wallet_ListVO mwl2 = new Member_Wallet_ListVO();
		mwl.setList_wit("8000");
		mwl.setList_no("MWL0000002");
		dao.update(mwl2);
		
		//刪除
//		dao.delete("MWL0000004");
		
		//查某個會員的錢包明細
		List<Member_Wallet_ListVO> list1 = dao.findByMem("M000001");
		for (Member_Wallet_ListVO mwlVO : list1) {
			System.out.println(mwlVO.getList_no());
			System.out.println(mwlVO.getMem_no());
			System.out.println(mwlVO.getList_time());
			System.out.println(mwlVO.getList_wit());			
			System.out.println(mwlVO.getList_stat());
			System.out.println(mwlVO.getList_dep());
			System.out.println(mwlVO.getPay_for());
			System.out.println("--------");
		}
		
		
		//查全部
		List<Member_Wallet_ListVO> list = dao.getAll();
		for (Member_Wallet_ListVO mwlVO : list) {
			System.out.println(mwlVO.getList_no());
			System.out.println(mwlVO.getMem_no());
			System.out.println(mwlVO.getList_time());
			System.out.println(mwlVO.getList_wit());			
			System.out.println(mwlVO.getList_stat());
			System.out.println(mwlVO.getList_dep());
			System.out.println(mwlVO.getPay_for());
			System.out.println("--------");
		}
	}

	@Override
	//支付訂單時一併新增錢包支付明細
	public void insertwithord(Member_Wallet_ListVO Member_Wallet_ListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT2_STMT);
			
			pstmt.setString(1, Member_Wallet_ListVO.getMem_no());
			pstmt.setString(2, Member_Wallet_ListVO.getList_wit());
			pstmt.setInt(3, Member_Wallet_ListVO.getList_stat());
			pstmt.setString(4, Member_Wallet_ListVO.getPay_for());

			
			pstmt.executeUpdate();
			
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
	
}
