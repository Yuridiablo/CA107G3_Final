package tools;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 資料庫顯示圖片
 */
//@WebServlet("/outImage")

public class OutImg extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		System.out.println("doGet");
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();

		try {
			System.out.println("--------------------------outoutout-----------------------------");
			Statement stmt = con.createStatement();
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
			ResultSet rs = stmt.executeQuery(SQL);

			if (rs.next()) {
				if(rs.getBinaryStream(serchData)!=null) {
					BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream(serchData));
					byte[] buf = new byte[4 * 1024]; // 4K buffer
					int len;
					while ((len = in.read(buf)) != -1) {
						out.write(buf, 0, len);
					}
					in.close();
				}
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
		}
	}

	public void init() throws ServletException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "CA107G3", "123456");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void destroy() {
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}

	}
}
