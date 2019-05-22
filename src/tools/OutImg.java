package tools;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 * 資料庫顯示圖片
 */
//@WebServlet("/outImage")

public class OutImg extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}

	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		System.out.println("doGet");
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			System.out.println("--------------------------outoutout-----------------------------");
			stmt = con.createStatement();
			String SQL=null;
			String serchData = null;
			if(req.getParameter("mem_no")!=null) {
				SQL ="SELECT MEM_PIC FROM MEMBER WHERE MEM_NO = " + req.getParameter("mem_no");
				serchData = "MEM_PIC";
			}else if(req.getParameter("news_no")!=null) {
				SQL ="SELECT NEWS_PIC FROM NEWS WHERE NEWS_NO = " + req.getParameter("news_no");
				serchData = "NEWS_PIC";
			}
			
			System.out.println(SQL);
			rs = stmt.executeQuery(SQL);

			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream(serchData));
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		
		}catch (SQLException e) {

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
	}

	public void init() throws ServletException {

	}

	public void destroy() {


	}
}
