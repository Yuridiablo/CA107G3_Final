package android.ord.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class OrdDAO implements OrdDAO_interface {

	private static DataSource ds = null;

	// SQL
	private static final String GET_ONE_STMT = "SELECT * FROM ORD WHERE  ord_no = ? AND mem_no = ? AND vendor_no= ? AND verif_code= ?";
	private static final String GET_ORD = "SELECT * FROM ORD WHERE  mem_no = ?";
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {

			e.printStackTrace();
		}
	}

	@Override
	public boolean isOrd(String ord_no, String MEM_NO, String vendor_no, String VERIF_CODE) {
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		boolean isOrd = false;

		try {

			con = ds.getConnection();
			pstm = con.prepareStatement(GET_ONE_STMT);
			pstm.setString(1, ord_no);
			pstm.setString(2, MEM_NO);
			pstm.setString(3, vendor_no);
			pstm.setString(4, VERIF_CODE);

			rs = pstm.executeQuery();
			isOrd = rs.next();
			return isOrd;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pstm != null) {
				try {
					pstm.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return isOrd;
	}

	@Override
	public List<OrdVO> getord(String MEM_NO) {
		OrdVO ordVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrdVO> list = new ArrayList<OrdVO>();

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ORD);

			pstmt.setString(1, MEM_NO);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// ordVO 也稱為 Domain objects
				ordVO = new OrdVO();
				ordVO.setOrd_no(rs.getString("ord_no"));
				ordVO.setMem_no(rs.getString("mem_no"));
				ordVO.setVendor_no(rs.getString("vendor_no"));
				ordVO.setTbl_no(rs.getString("tbl_no"));
				ordVO.setParty_size(rs.getInt("party_size"));
				ordVO.setShare_mem_no1(rs.getString("share_mem_no1"));
				ordVO.setShare_mem_no2(rs.getString("share_mem_no2"));
				ordVO.setShare_amount(rs.getInt("share_amount"));
//				ordVO.setOrd_time(rs.getTimestamp("ord_time"));
//				ordVO.setBooking_date(rs.getDate("booking_date"));
				ordVO.setBooking_time(rs.getString("booking_time"));
				ordVO.setNotes(rs.getString("notes"));
				ordVO.setTotal(rs.getInt("total"));
				ordVO.setArrival_time(rs.getString("arrival_time"));
				ordVO.setFinish_time(rs.getString("finish_time"));
				ordVO.setVerif_code(rs.getString("verif_code"));
				ordVO.setStatus(rs.getInt("status"));
				list.add(ordVO);

			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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

}
