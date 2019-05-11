package com.ord.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.reservation_time.model.Reservation_TimeDAO;
import com.reservation_time.model.Reservation_TimeVO;



/**
 * Servlet implementation class servletRes
 */
//@WebServlet("/servletRes.do")
public class servletRes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String action = req.getParameter("action");
			if("updateDate".equals(action)){
				System.out.println("有近來");

		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
//		try {
			java.sql.Date booking_date=null;
			try {
				booking_date=java.sql.Date.valueOf(req.getParameter("booking_date").trim());
				
			}catch (IllegalArgumentException e) {
				booking_date=new java.sql.Date(System.currentTimeMillis());
				errorMsgs.add("please choose date!");
			}
			
			Calendar  cal =Calendar.getInstance();
			cal.setTime(booking_date);
			cal.add(Calendar.DAY_OF_YEAR,1);
			
			java.sql.Date sqlTomorrow = new java.sql.Date(cal.getTimeInMillis());
			String vendor_no  = req.getParameter("vendor_no");
			
			 // 資料庫取出的empVO物件,存入req
			
			String url = "/ord/ord/xxx.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
			successView.forward(req, res);
			
			
//		}
		
			}
			
		
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		doGet(req, res);
	}

}
