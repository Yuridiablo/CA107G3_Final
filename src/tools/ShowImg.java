package tools;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
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
@WebServlet("/ShowImage")

public class ShowImg extends HttpServlet {
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
		String picName = null;
		String SQL = null;
		
		
		//抓菜單的圖
		if (req.getParameter("menu_no") != null) {
			picName = "MENU_PIC";
			SQL = "SELECT MENU_PIC FROM RESTAURANT_MENU WHERE MENU_NO = " + req.getParameter("menu_no");
		}
		
		// 抓餐廳形象圖
		if (req.getParameter("pic") != null) {
			picName = "V_PIC";
			SQL = "SELECT V_PIC FROM VENDOR WHERE VENDOR_NO = " + req.getParameter("vendor_no");
		}
		
		// 抓餐廳廣告圖
		if (req.getParameter("ad") != null) {
			picName = "V_AD";
			SQL = "SELECT V_AD FROM VENDOR WHERE VENDOR_NO = " + req.getParameter("vendor_no");
		}
		
		// 抓會員照片
		if (req.getParameter("mem_no") != null) {
			System.out.println("會員被抓圖");
			picName = "MEM_PIC";
			SQL = "SELECT MEM_PIC FROM MEMBER WHERE MEM_NO = " + req.getParameter("mem_no");
		}
		
		try {
			Statement stmt = con.createStatement();
			
//			String SQL ="SELECT MENU_PIC FROM RESTAURANT_MENU WHERE MENU_NO = 'RM00000008'";
			System.out.println(SQL);
			ResultSet rs = stmt.executeQuery(SQL);

			if (rs.next()) {
				
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream(picName));
			
				
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}

				in.close();
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.err.println(e);
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
