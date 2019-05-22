package com.vendor.model;

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

public class VendorDAO implements VendorDAO_interface {

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
	private static final String INSERT_STMT = "INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),?,?,?,?,?,?,?,?,?,?,?,0,0,0,?,?,?,?,NULL,NULL,?)";
	private static final String CREAT_STMT = "INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),?,?,?,?,?,?,?,?,?,0,?,0,0,0,0,0,0,0,?,NULL,'2',0,'','')";
//	private static final String UPDATE = "UPDATE VENDOR SET V_PWD = ?, V_TEL = ?, V_N_CODE = ?, V_AD_CODE = ?, V_ADDRESS1 = ?, V_ADDRESS2 = ?, V_ADDRESS3 = ?, V_WALLET = ?, V_NAME = ?, V_START_TIME = ?, V_END_TIME = ?, V_DAY = ?, V_TURN_TIME = ?, V_STATUS = ? WHERE V_ACCOUNT=?";
	private static final String UPDATE = "UPDATE VENDOR SET v_type = ?, v_start_time = ?, v_end_time = ?, v_day = ?, v_tables = ?, v_text = ? WHERE vendor_no=?";
	private static final String UPDATE_STATU = "UPDATE VENDOR SET v_status = ? WHERE vendor_no=?";
	private static final String UPDATE_WALLET = "UPDATE VENDOR SET v_wallet = ? WHERE vendor_no=?";
	private static final String UPDATE_PIC = "UPDATE VENDOR SET v_pic = ? WHERE vendor_no=?";
	private static final String UPDATE_AD = "UPDATE VENDOR SET v_ad = ? WHERE vendor_no=?";
	private static final String UPDATE_TYPE = "UPDATE VENDOR SET v_type = ? WHERE vendor_no=?";
	private static final String UPDATE_TEXT = "UPDATE VENDOR SET v_text = ? WHERE vendor_no=?";
	private static final String UPDATE_DAY = "UPDATE VENDOR SET v_day = ? WHERE vendor_no=?";
	private static final String UPDATE_SE_TIME = "UPDATE VENDOR SET v_start_time = ?, v_end_time = ? WHERE vendor_no=?";
	private static final String UPDATE_TTIME = "UPDATE VENDOR SET v_turn_time = ? WHERE vendor_no=?";
	private static final String UPDATE_TBLS = "UPDATE VENDOR SET v_tables = ? WHERE vendor_no=?";
	private static final String DELETE = "DELETE FROM Vendor WHERE vendor_no =?";
	private static final String GET_ONE_STMT = "SELECT * FROM Vendor WHERE Vendor_NO = ?";
	private static final String GET_ACC_STMT = "SELECT * FROM Vendor WHERE v_account = ?";
	private static final String GET_TYPE_STMT = "SELECT * FROM Vendor WHERE v_type = ?";
	private static final String GET_ALL_STMT = "SELECT * FROM Vendor ";
//	private static final String SEARCH_STMT = "SELECT * FROM Vendor WHERE V_NAME like ? ";
	private static final String SEARCH_STMT = "SELECT * FROM Vendor WHERE V_NAME like ? OR V_ADDRESS1 like ? OR V_ADDRESS2 like ? OR V_ADDRESS3 like ?";



	@Override
	public int insert(VendorVO vendorVO) {
		Connection con = null;
		PreparedStatement pstm = null;
		int rs = 0;

		try {
			con = ds.getConnection();
			System.out.println("連線成功!");
			pstm = con.prepareStatement(INSERT_STMT);
			pstm.setString(1, vendorVO.getV_account());
			pstm.setString(2, vendorVO.getV_pwd());
			pstm.setString(3, vendorVO.getV_mail());
			pstm.setString(4, vendorVO.getV_tel());
			pstm.setString(5, vendorVO.getV_n_code());
			pstm.setString(6, vendorVO.getV_ad_code());
			pstm.setString(7, vendorVO.getV_address1());
			pstm.setString(8, vendorVO.getV_address2());
			pstm.setString(9, vendorVO.getV_address3());
			pstm.setString(10, vendorVO.getV_wallet());
			pstm.setString(11, vendorVO.getV_name());
			pstm.setString(12, vendorVO.getV_start_time());
			pstm.setString(13, vendorVO.getV_end_time());
			pstm.setString(14, vendorVO.getV_day());
			pstm.setString(15, vendorVO.getV_tables());
			pstm.setString(16, vendorVO.getV_status());
			
			
			rs = pstm.executeUpdate();
			System.out.println("成功筆數 : " + rs);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rs;
	}

	@Override
	public int create(VendorVO vendorVO) {
		Connection con = null;
		PreparedStatement pstm = null;
		int rs = 0;

		try {
			con = ds.getConnection();
			System.out.println("連線成功!");
			pstm = con.prepareStatement(CREAT_STMT);
			pstm.setString(1, vendorVO.getV_account());
			pstm.setString(2, vendorVO.getV_pwd());
			pstm.setString(3, vendorVO.getV_mail());
			pstm.setString(4, vendorVO.getV_tel());
			pstm.setString(5, vendorVO.getV_n_code());
			pstm.setString(6, vendorVO.getV_ad_code());
			pstm.setString(7, vendorVO.getV_address1());
			pstm.setString(8, vendorVO.getV_address2());
			pstm.setString(9, vendorVO.getV_address3());
//			pstm.setString(10, vendorVO.getV_wallet());
			pstm.setString(10, vendorVO.getV_name());
			pstm.setBytes(11, vendorVO.getV_pic());
//			pstm.setString(13, vendorVO.getV_end_time());
//			pstm.setString(14, vendorVO.getV_day());
//			pstm.setString(15, vendorVO.getV_turn_time());
//			pstm.setString(16, vendorVO.getV_status());

			rs = pstm.executeUpdate();
			System.out.println("成功筆數 : " + rs);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rs;
	}

	@Override
	public int update(VendorVO vendorVO) {
		Connection con = null;
		PreparedStatement pstm = null;
		int rs = 0;

		try {
			con = ds.getConnection();
			System.out.println("連線成功!");
			pstm = con.prepareStatement(UPDATE);

			pstm.setString(1, vendorVO.getV_type());
			pstm.setString(2, vendorVO.getV_start_time());
			pstm.setString(3, vendorVO.getV_end_time());
			pstm.setString(4, vendorVO.getV_day());
			pstm.setString(5, vendorVO.getV_tables());
			pstm.setString(6, vendorVO.getV_text());
			pstm.setString(7, vendorVO.getVendor_no());
			
			System.out.println(vendorVO.getVendor_no());

			rs = pstm.executeUpdate();
			System.out.println("成功筆數 : " + rs);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rs;
	}

	@Override
	public int delete(String vendor_no) {
		Connection con = null;
		PreparedStatement pstm = null;
		int rs = 0;

		try {
			con = ds.getConnection();
			System.out.println("連線成功!");
			pstm = con.prepareStatement(DELETE);
			pstm.setString(1, vendor_no);
			rs = pstm.executeUpdate();
			System.out.println("成功筆數 : " + rs);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rs;
	}

	@Override
	public VendorVO findByPK(String vendor_no) {
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		VendorVO vendor = null;

		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GET_ONE_STMT);
			pstm.setString(1, vendor_no);
			rs = pstm.executeQuery();

			while (rs.next()) {
				vendor = new VendorVO();

				vendor.setVendor_no(rs.getString(1));
				vendor.setV_account(rs.getString(2));
				vendor.setV_pwd(rs.getString(3));
				vendor.setV_mail(rs.getString(4));
				vendor.setV_tel(rs.getString(5));
				vendor.setV_n_code(rs.getString(6));
				vendor.setV_ad_code(rs.getString(7));
				vendor.setV_address1(rs.getString(8));
				vendor.setV_address2(rs.getString(9));
				vendor.setV_address3(rs.getString(10));
				vendor.setV_wallet(rs.getString(11));
				vendor.setV_name(rs.getString(12));
				vendor.setV_w_no(rs.getInt(13));
				vendor.setV_n_no(rs.getInt(14));
				vendor.setV_alt_no(rs.getInt(15));
				vendor.setV_start_time(rs.getString(16));
				vendor.setV_end_time(rs.getString(17));
				vendor.setV_day(rs.getString(18));
				vendor.setV_tables(rs.getString(19));
//				vendor.setV_pic(rs.getBytes(20));
//				vendor.setV_ad(rs.getBytes(21));
				vendor.setV_status(rs.getString(22));
				vendor.setV_turn_time(rs.getInt(23));
				vendor.setV_type(rs.getString(24));
				vendor.setV_text(rs.getString(25));
				
				
				
			}
			System.out.println("VendorVO findByPK 查詢完畢");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		return vendor;
	}

	@Override
	public VendorVO findByAcc(String v_account) {
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		VendorVO vendor = null;

		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GET_ACC_STMT);
			pstm.setString(1, v_account);
			rs = pstm.executeQuery();

			while (rs.next()) {
				vendor = new VendorVO();

				vendor.setVendor_no(rs.getString(1));
				vendor.setV_account(rs.getString(2));
				vendor.setV_pwd(rs.getString(3));
				vendor.setV_mail(rs.getString(4));
				vendor.setV_tel(rs.getString(5));
				vendor.setV_n_code(rs.getString(6));
				vendor.setV_ad_code(rs.getString(7));
				vendor.setV_address1(rs.getString(8));
				vendor.setV_address2(rs.getString(9));
				vendor.setV_address3(rs.getString(10));
				vendor.setV_wallet(rs.getString(11));
				vendor.setV_name(rs.getString(12));
				vendor.setV_w_no(rs.getInt(13));
				vendor.setV_n_no(rs.getInt(14));
				vendor.setV_alt_no(rs.getInt(15));
				vendor.setV_start_time(rs.getString(16));
				vendor.setV_end_time(rs.getString(17));
				vendor.setV_day(rs.getString(18));
				vendor.setV_tables(rs.getString(19));
				vendor.setV_pic(rs.getBytes(20));
				vendor.setV_ad(rs.getBytes(21));
				vendor.setV_status(rs.getString(22));
				vendor.setV_turn_time(rs.getInt(23));
				vendor.setV_type(rs.getString(24));
				vendor.setV_text(rs.getString(25));
				
				
				
			}
			System.out.println("查詢完畢");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		return vendor;
	}

	@Override
	public int updatePic(VendorVO vendorVO) {
		Connection con = null;
		PreparedStatement pstm = null;
		int rs = 0;

		try {
			con = ds.getConnection();
			System.out.println("連線成功!更新一張圖");
			pstm = con.prepareStatement(UPDATE_PIC);
			
			
			
			pstm.setBytes(1, vendorVO.getV_pic());
			pstm.setString(2, vendorVO.getVendor_no());
	
			
			System.out.println(vendorVO.getVendor_no());

			rs = pstm.executeUpdate();
			System.out.println("成功筆數 : " + rs);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rs;
	}

	@Override
	public int updateAd(VendorVO vendorVO) {
		Connection con = null;
		PreparedStatement pstm = null;
		
		int rs = 0;

		try {
			con = ds.getConnection();
			System.out.println("連線成功!");
			pstm = con.prepareStatement(UPDATE_AD);

			pstm.setBytes(1, vendorVO.getV_ad());
			pstm.setString(2, vendorVO.getVendor_no());

			rs = pstm.executeUpdate();
			System.out.println("成功筆數 : " + rs);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rs;
	}

	@Override
	public List<VendorVO> getAll() {

		List<VendorVO> vlist = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		VendorVO vendor = null;

		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GET_ALL_STMT);
			rs = pstm.executeQuery();

			while (rs.next()) {
				vendor = new VendorVO();

				vendor.setVendor_no(rs.getString("vendor_no"));
				vendor.setV_account(rs.getString("v_account"));
				vendor.setV_pwd(rs.getString("v_pwd"));
				vendor.setV_mail(rs.getString("v_mail"));
				vendor.setV_tel(rs.getString("v_tel"));
				vendor.setV_n_code(rs.getString("v_n_code"));
				vendor.setV_ad_code(rs.getString("v_ad_code"));
				vendor.setV_address1(rs.getString("v_address1"));
				vendor.setV_address2(rs.getString("v_address2"));
				vendor.setV_address3(rs.getString("v_address3"));
				vendor.setV_wallet(rs.getString("v_wallet"));
				vendor.setV_name(rs.getString("v_name"));
				vendor.setV_w_no(rs.getInt("v_w_no"));
				vendor.setV_n_no(rs.getInt("v_n_no"));
				vendor.setV_alt_no(rs.getInt("v_alt_no"));
				vendor.setV_start_time(rs.getString("v_start_time"));
				vendor.setV_end_time(rs.getString("v_end_time"));
				vendor.setV_day(rs.getString("v_day"));
				vendor.setV_tables(rs.getString("v_tables"));
				// vendor.setV_pic();
				// vendor.setV_ad();
				vendor.setV_status(rs.getString("v_status"));
				vendor.setV_turn_time(rs.getInt("v_turn_time"));
				vendor.setV_type(rs.getString("v_type"));
				vendor.setV_text(rs.getString("v_text"));
				
				// 裝入集合
				vlist.add(vendor);
			}
			System.out.println("查詢完畢");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		return vlist;
	}

	@Override
	public List<VendorVO> search(String v_name, String address1, String address2,String address3) {
		List<VendorVO> vlist = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		VendorVO vendor = null;

		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(SEARCH_STMT);
			pstm.setString(1, "%" + v_name + "%");
			pstm.setString(2, address1 + "%");
			pstm.setString(3, address2 + "%");
			pstm.setString(4, "%" + address3 + "%");
			rs = pstm.executeQuery();
			
			while (rs.next()) {
				vendor = new VendorVO();

				vendor.setVendor_no(rs.getString("vendor_no"));
				vendor.setV_account(rs.getString("v_account"));
				vendor.setV_pwd(rs.getString("v_pwd"));
				vendor.setV_mail(rs.getString("v_mail"));
				vendor.setV_tel(rs.getString("v_tel"));
				vendor.setV_n_code(rs.getString("v_n_code"));
				vendor.setV_ad_code(rs.getString("v_ad_code"));
				vendor.setV_address1(rs.getString("v_address1"));
				vendor.setV_address2(rs.getString("v_address2"));
				vendor.setV_address3(rs.getString("v_address3"));
				vendor.setV_wallet(rs.getString("v_wallet"));
				vendor.setV_name(rs.getString("v_name"));
				vendor.setV_w_no(rs.getInt("v_w_no"));
				vendor.setV_n_no(rs.getInt("v_n_no"));
				vendor.setV_alt_no(rs.getInt("v_alt_no"));
				vendor.setV_start_time(rs.getString("v_start_time"));
				vendor.setV_end_time(rs.getString("v_end_time"));
				vendor.setV_day(rs.getString("v_day"));
				vendor.setV_tables(rs.getString("v_tables"));
				// vendor.setV_pic();
				// vendor.setV_ad();
				vendor.setV_status(rs.getString("v_status"));
				vendor.setV_turn_time(rs.getInt("v_turn_time"));
				vendor.setV_type(rs.getString("v_type"));
				vendor.setV_text(rs.getString("v_text"));
				
				vlist.add(vendor);
			}
			System.out.println("查詢完畢");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		return vlist;
	}

	// 修改狀態碼
	@Override
	public void upStatus(VendorVO vVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATU);
			

			pstmt.setString(1, vVO.getV_status());
			pstmt.setString(2, vVO.getVendor_no());
			
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
	
	//修改錢包餘額
	public void upWallet(VendorVO vVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_WALLET);
			

			pstmt.setString(1, vVO.getV_wallet());
			pstmt.setString(2, vVO.getVendor_no());
			
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
	public void upType(VendorVO vVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_TYPE);
			

			pstmt.setString(1, vVO.getV_type());
			pstmt.setString(2, vVO.getVendor_no());
			
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
	public void upText(VendorVO vVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_TEXT);
			

			pstmt.setString(1, vVO.getV_text());
			pstmt.setString(2, vVO.getVendor_no());
			
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
	public void upDay(VendorVO vVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_DAY);
			

			pstmt.setString(1, vVO.getV_day());
			pstmt.setString(2, vVO.getVendor_no());
			
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
	public void upSEtime(VendorVO vVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_SE_TIME);
			

			pstmt.setString(1, vVO.getV_start_time());
			pstmt.setString(2, vVO.getV_end_time());
			pstmt.setString(3, vVO.getVendor_no());
			
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
	public void upTtime(VendorVO vVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_TTIME);
			

			pstmt.setInt(1, vVO.getV_turn_time());
			pstmt.setString(2, vVO.getVendor_no());
			
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
	public void upTbls(VendorVO vVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_TBLS);

			pstmt.setString(1, vVO.getV_tables());
			pstmt.setString(2, vVO.getVendor_no());
			
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
	public List<VendorVO> findByType(String v_type) {
		List<VendorVO> vlist = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		VendorVO vendor = null;

		try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GET_TYPE_STMT);
			pstm.setString(1, v_type);
			rs = pstm.executeQuery();
			
			while (rs.next()) {
				vendor = new VendorVO();

				vendor.setVendor_no(rs.getString("vendor_no"));
				vendor.setV_account(rs.getString("v_account"));
				vendor.setV_pwd(rs.getString("v_pwd"));
				vendor.setV_mail(rs.getString("v_mail"));
				vendor.setV_tel(rs.getString("v_tel"));
				vendor.setV_n_code(rs.getString("v_n_code"));
				vendor.setV_ad_code(rs.getString("v_ad_code"));
				vendor.setV_address1(rs.getString("v_address1"));
				vendor.setV_address2(rs.getString("v_address2"));
				vendor.setV_address3(rs.getString("v_address3"));
				vendor.setV_wallet(rs.getString("v_wallet"));
				vendor.setV_name(rs.getString("v_name"));
				vendor.setV_w_no(rs.getInt("v_w_no"));
				vendor.setV_n_no(rs.getInt("v_n_no"));
				vendor.setV_alt_no(rs.getInt("v_alt_no"));
				vendor.setV_start_time(rs.getString("v_start_time"));
				vendor.setV_end_time(rs.getString("v_end_time"));
				vendor.setV_day(rs.getString("v_day"));
				vendor.setV_tables(rs.getString("v_tables"));
				// vendor.setV_pic();
				// vendor.setV_ad();
				vendor.setV_status(rs.getString("v_status"));
				vendor.setV_turn_time(rs.getInt("v_turn_time"));
				vendor.setV_type(rs.getString("v_type"));
				vendor.setV_text(rs.getString("v_text"));
				
				// 裝入集合
				vlist.add(vendor);
			}
			System.out.println("查詢完畢");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		return vlist;
	}

	@Override
	public void detail(VendorVO vendorVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void waitOnOff(VendorVO vendorVO) {
		// TODO Auto-generated method stub
		
	}
	
	
	public static void main(String[] args) {
			VendorDAO_interface vDAO = new VendorDAO();
			
			//新增
			VendorVO vVO = new VendorVO();
			
			vVO.setV_account("xxxzzzcc");
			vVO.setV_pwd("000000");
			vVO.setV_mail("yourmom@gmail.com");
			vVO.setV_tel("11223344");
			vVO.setV_n_code("02");
			vVO.setV_ad_code("300");
			vVO.setV_address1("台北市");
			vVO.setV_address2("信義區");
			vVO.setV_address3("中正路10號");
			vVO.setV_name("墨賞鐵板燒");
			vVO.setV_pic(null);
			
	//		vVO.setVendor_no("V000003");
	//		rm.setMenu_name("宇宙大燒賣");
	//		rm.setMenu_price("2050");
	// 		rm.setMenu_pic(null);
	// 		rm.setMenu_stat(1);		
	// 		rm.setMenu_text("居然包了一整頭豬在裡面啊");		
	 		
			vDAO.create(vVO);	
	
			// 單筆查詢
			// System.out.println(vDAO.findByPrimaryKey("V000005"));
	
			// 查詢全部
	//		 List<VendorVO> vlist = new ArrayList<>();
	//		 vlist = vDAO.getAll();
	//		 for (VendorVO v : vlist) {
	//		 System.out.println(v);
	//		 }
	
			// 新增
			// VendorVo v2 = new VendorVo("leg0543088", "leg0543088",
			// "leg0543088@gmail.com", "2165788", "08", "881", "高雄市8",
			// "前金區8", "新田路2078號", "159843152381", "辣癮食尚麻辣火鍋8", "1300", "1700", "0101010",
			// "6", "4");
			//
			// vDAO.insert(v2);
	
			// 刪除
			// vDAO.delete("V000006");
	
			// 更新
	//		VendorVO v3 = new VendorVO("leg0543088", "leg0543089", "2165789", "09", "666", "高雄9市", "前金9區", "新田路278號",
	//				"15984312381", "火鍋8", "1309", "1709", "0101011", "3", "5");
	//		vDAO.update(v3);
		}

}
