package com.article_published.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.*;

import javax.naming.Context;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class DBGifReader3 extends HttpServlet{
	Connection con;
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		
		
		try {
			Statement stmt = con.createStatement();
			String art_no =req.getParameter("art_no").trim();
			
			ResultSet rs = stmt.executeQuery("SELECT ART_PIC3 FROM ARTICLE_PUBLISHED WHERE art_no='"+art_no+"'");
			if(rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("ART_PIC3"));
				byte[] buf = new byte[4*1024];
				int len;
				while((len = in.read(buf))!=-1) {
					out.write(buf,0,len);
				}
				in.close();
			}else {
				InputStream in = req.getServletContext().getResourceAsStream("/Article_Published_JSP/images/null.jpg");
				byte[] b = new byte[in.available()];
				in.read(b);
				out.write(b);
				in.close();
			}
			rs.close();
			stmt.close();
		}catch(Exception e) {
			InputStream in = req.getServletContext().getResourceAsStream("/Article_Published_JSP/images/null.jpg");
			byte[] b = new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
		}
	}
	
	public void init() {
		try {
			Context ctx = new javax.naming.InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
			con = ds.getConnection();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void destroy() {
		try {
			if(con!=null)
				con.close();
		}catch(Exception e) {
			System.out.println(e);
		}
	}
}
