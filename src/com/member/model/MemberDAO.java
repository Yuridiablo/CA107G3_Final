package com.member.model;

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

public class MemberDAO implements MemberDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	// SQL
	private static final String INSERT_STMT = "INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),?,?,?,?,?,?,?,?,?,?,?)";
	private static final String UPDATE = "UPDATE MEMBER SET MEM_NAME = ?, MEM_PWD = ?, MEM_GENDER = ?, MEM_TEL = ?, MEM_STATUS = ?,MEM_PIC = ? , MEM_BALANCE = ?, MEM_NICKNAME = ? WHERE MEM_ACCOUNT = ?";
	private static final String UPDATE_WITHOUT_PIC = "UPDATE MEMBER SET MEM_NAME = ?, MEM_PWD = ?, MEM_TEL = ?, MEM_STATUS = ?, MEM_BALANCE = ?, MEM_NICKNAME = ?,MEM_ACCOUNT = ? WHERE MEM_NO = ?";
	private static final String UPDATE_BALANCE = "UPDATE MEMBER SET MEM_BALANCE = ? WHERE MEM_NO = ?";
	private static final String DELETE = "DELETE FROM MEMBER WHERE MEM_NO =?";
	private static final String GET_ONE_STMT = "SELECT * FROM MEMBER WHERE MEM_NO = ?";
	private static final String GET_ONE_STMT_BY_ACCOUNT = "SELECT * FROM MEMBER WHERE MEM_ACCOUNT = ?";
	private static final String GET_ALL_STMT_BY_NICKNAME = "SELECT * FROM MEMBER WHERE MEM_NICKNAME LIKE ?";
	private static final String GET_ALL_STMT_BY_NAME = "SELECT * FROM MEMBER WHERE MEM_NAME LIKE ?";
	private static final String GET_ALL_STMT = "SELECT * FROM MEMBER ";

	

	@Override
	public int updateWithoutPic(MemberVO memberVO) {
		Connection con = null;
		PreparedStatement pstm = null;
		int rs = 0;

		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(UPDATE_WITHOUT_PIC);
			pstm.setString(1, memberVO.getMem_name());
			pstm.setString(2, memberVO.getMem_pwd());
			pstm.setString(3, memberVO.getMem_tel());
			pstm.setString(4, memberVO.getMem_status());
			pstm.setDouble(5, memberVO.getMem_balance());
			pstm.setString(6, memberVO.getMem_nickname());
			pstm.setString(7, memberVO.getMem_account());
			pstm.setString(8, memberVO.getMem_no());
			rs = pstm.executeUpdate();

			System.out.println("更新筆數 : " + rs);

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstm != null) {
				try {
					pstm.close();
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

		return rs;
	}

	public MemberDAO() {
		
	}

	@Override
	public int updateBalance(MemberVO memberVO) {
		Connection con = null;
		PreparedStatement pstm = null;
		int rs = 0;

		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(UPDATE_BALANCE);
			pstm.setDouble(1, memberVO.getMem_balance());
			pstm.setString(2, memberVO.getMem_no());
			rs = pstm.executeUpdate();

			System.out.println("更新筆數 : " + rs);

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstm != null) {
				try {
					pstm.close();
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

		return rs;
	}

	@Override
	public int insert(MemberVO memberVO) {
		Connection con = null;
		PreparedStatement pstm = null;
		int rs = 0;

		try {

			con = ds.getConnection();
			System.out.println("連線成功!");
			pstm = con.prepareStatement(INSERT_STMT);
			pstm.setString(1, memberVO.getMem_name());
			pstm.setString(2, memberVO.getMem_account());
			pstm.setString(3, memberVO.getMem_pwd());
			pstm.setString(4, memberVO.getMem_gender());
			pstm.setString(5, memberVO.getMem_mail());
			pstm.setString(6, memberVO.getMem_id());
			pstm.setString(7, memberVO.getMem_tel());
			pstm.setBytes(9, memberVO.getMem_pic());
			pstm.setString(8, memberVO.getMem_status());
			pstm.setDouble(10, memberVO.getMem_balance());
			pstm.setString(11, memberVO.getMem_nickname());

			rs = pstm.executeUpdate();
			System.out.println("成功筆數 : " + rs);

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstm != null) {
				try {
					pstm.close();
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
		return rs;
	}

	@Override
	public MemberVO findByMem_account(String mem_account) {

		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MemberVO member = null;

		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GET_ONE_STMT_BY_ACCOUNT);
			pstm.setString(1, mem_account);
			rs = pstm.executeQuery();

			while (rs.next()) {
				member = new MemberVO();
				member.setMem_no(rs.getString("mem_no"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_account(rs.getString("mem_account"));
				member.setMem_pwd(rs.getString("mem_pwd"));
				member.setMem_gender(rs.getString("mem_gender"));
				member.setMem_mail(rs.getString("mem_mail"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_tel(rs.getString("mem_tel"));
				member.setMem_status(rs.getString("mem_status"));
				member.setMem_pic(rs.getBytes("mem_pic"));
				member.setMem_balance(rs.getDouble("mem_balance"));
				member.setMem_nickname(rs.getString("mem_nickname"));
			}
			System.out.println("查詢完畢");

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstm != null) {
				try {
					pstm.close();
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

		return member;
	}

	@Override
	public int update(MemberVO memberVO) {
		Connection con = null;
		PreparedStatement pstm = null;
		int rs = 0;

		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(UPDATE);
			pstm.setString(1, memberVO.getMem_name());
			pstm.setString(2, memberVO.getMem_pwd());
			pstm.setString(3, memberVO.getMem_gender());
			pstm.setString(4, memberVO.getMem_tel());
			pstm.setString(5, memberVO.getMem_status());
			pstm.setBytes(6, memberVO.getMem_pic());
			pstm.setDouble(7, memberVO.getMem_balance());
			pstm.setString(8, memberVO.getMem_nickname());
			pstm.setString(9, memberVO.getMem_account());
			System.out.println(memberVO.getMem_account());
			rs = pstm.executeUpdate();

			System.out.println("更新筆數 : " + rs);

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstm != null) {
				try {
					pstm.close();
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

		return rs;
	}

	@Override
	public List<MemberVO> findByMem_name(String mem_name) {
		List<MemberVO> mlist = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MemberVO member = null;
		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GET_ALL_STMT_BY_NAME);
			pstm.setString(1, "%" + mem_name + "%");
			rs = pstm.executeQuery();
			while (rs.next()) {
				member = new MemberVO();
				member.setMem_no(rs.getString("mem_no"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_account(rs.getString("mem_account"));
				member.setMem_pwd(rs.getString("mem_pwd"));
				member.setMem_gender(rs.getString("mem_gender"));
				member.setMem_mail(rs.getString("mem_mail"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_tel(rs.getString("mem_tel"));
				member.setMem_status(rs.getString("mem_status"));
				member.setMem_balance(rs.getDouble("mem_balance"));
				member.setMem_nickname(rs.getString("mem_nickname"));
				// 裝入集合
				mlist.add(member);
			}
			System.out.println("查詢完畢");
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstm != null) {
				try {
					pstm.close();
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
		return mlist;
		
	}

	@Override
	public int delete(String mem_no) {

		Connection con = null;
		PreparedStatement pstm = null;
		int rs = 0;

		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(DELETE);
			pstm.setString(1, mem_no);
			rs = pstm.executeUpdate();

			System.out.println("更新筆數 : " + rs);

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstm != null) {
				try {
					pstm.close();
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

		return rs;

	}

	@Override
	public MemberVO findByPrimaryKey(String mem_no) {

		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MemberVO member = null;

		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GET_ONE_STMT);
			pstm.setString(1, mem_no);
			rs = pstm.executeQuery();

			while (rs.next()) {
				member = new MemberVO();
				member.setMem_no(mem_no);
				member.setMem_name(rs.getString(2));
				member.setMem_account(rs.getString(3));
				member.setMem_pwd(rs.getString(4));
				member.setMem_gender(rs.getString(5));
				member.setMem_mail(rs.getString(6));
				member.setMem_id(rs.getString(7));
				member.setMem_tel(rs.getString(8));
				member.setMem_status(rs.getString(9));
				member.setMem_pic(rs.getBytes(10));
				member.setMem_balance(rs.getDouble(11));
				member.setMem_nickname(rs.getString(12));
			}
			System.out.println("查詢完畢");

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstm != null) {
				try {
					pstm.close();
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

		return member;
	}

	@Override
	public List<MemberVO> getAll() {
		List<MemberVO> mlist = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MemberVO member = null;

		try {

			con = ds.getConnection();
			pstm = con.prepareStatement(GET_ALL_STMT);
			rs = pstm.executeQuery();

			while (rs.next()) {
				member = new MemberVO();
				member.setMem_no(rs.getString("mem_no"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_account(rs.getString("mem_account"));
				member.setMem_pwd(rs.getString("mem_pwd"));
				member.setMem_gender(rs.getString("mem_gender"));
				member.setMem_mail(rs.getString("mem_mail"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_tel(rs.getString("mem_tel"));
				member.setMem_status(rs.getString("mem_status"));
				member.setMem_balance(rs.getDouble("mem_balance"));
				member.setMem_nickname(rs.getString("mem_nickname"));
				// 裝入集合
				mlist.add(member);
			}
			System.out.println("查詢完畢");

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstm != null) {
				try {
					pstm.close();
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

		return mlist;
	}

	@Override
	public List<MemberVO> findByMem_nickname(String mem_nickname) {
		List<MemberVO> mlist = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MemberVO member = null;
		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GET_ALL_STMT_BY_NICKNAME);
			pstm.setString(1, "%" + mem_nickname + "%");
			rs = pstm.executeQuery();
			while (rs.next()) {
				member = new MemberVO();
				member.setMem_no(rs.getString("mem_no"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_account(rs.getString("mem_account"));
				member.setMem_pwd(rs.getString("mem_pwd"));
				member.setMem_gender(rs.getString("mem_gender"));
				member.setMem_mail(rs.getString("mem_mail"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_tel(rs.getString("mem_tel"));
				member.setMem_status(rs.getString("mem_status"));
				member.setMem_balance(rs.getDouble("mem_balance"));
				member.setMem_nickname(rs.getString("mem_nickname"));
				// 裝入集合
				mlist.add(member);
			}
			System.out.println("查詢完畢");
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstm != null) {
				try {
					pstm.close();
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
		return mlist;
		
	}

	public static void main(String[] args) {

		MemberDAO_interface memberDAO = new MemberDAO();

		// 新增
//		MemberVO mb1 = 
//		

		// 查詢PK
//		System.out.println(memberDAO.findByPrimaryKey("M000001"));

		// 用帳號查詢一筆
//		MemberVO memvo = memberDAO.findByMem_account("qq123");
//		System.out.println(memvo.getMem_name());

		// 查詢多筆
//		List<MemberVO> allList = new ArrayList<>();
//		allList = memberDAO.getAll();
//		for (MemberVO mall : allList) {
//			System.out.println(mall);
//		}

		// 更新
//		Byte[] b = new Byte[0];
//		MemberVO mb2_up = new MemberVO("王妍熙6", "val5080809", "zld2502888", "M", "0932145698", "3", b, 700d, "小三");
//		System.out.println(mb2_up);
//		memberDAO.update(mb2_up);

		// 刪除
//		memberDAO.delete("M000007");

	}
}
