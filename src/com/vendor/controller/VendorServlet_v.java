package com.vendor.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vendor.model.VendorService;
import com.vendor.model.VendorVO;


public class VendorServlet_v extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession se = req.getSession();
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		String vendor_no = req.getParameter("vendor_no");
		
		System.out.println(action);
		if ("upPic".equals(action)) {
			System.out.println("進入了UP");
			
				
			try {
				/*************************** 1.接收請求參數 ****************************************/
				// 上傳圖片
				byte[] v_pic = null;
//				v_pic = ByteConvert.Base64Decode(req.getParameter("file"));
				String base64 = req.getParameter("file");
				
				v_pic = Base64.getMimeDecoder().decode(base64.split(",")[1]);
				
				VendorService vSvc = new VendorService();
				vSvc.updatePic(v_pic, vendor_no);

				

				/*************************** 2.開始查詢資料 ****************************************/
		
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				String url = "/Vendor/upVendor2.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
	
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if ("upAd".equals(action)) {
			System.out.println("進入了Ad");
				
			try {
				/*************************** 1.接收請求參數 ****************************************/
		
				// 上傳圖片
				byte[] v_ad = null;
//				v_pic = ByteConvert.Base64Decode(req.getParameter("file"));
				String base64 = req.getParameter("file");
				
				v_ad = Base64.getMimeDecoder().decode(base64.split(",")[1]);
				
				System.out.println(vendor_no);
				
				System.out.println(v_ad);
				
				VendorService vSvc = new VendorService();
				vSvc.updateAd(v_ad, vendor_no);

				

				/*************************** 2.開始查詢資料 ****************************************/
		
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				String url = "/Vendor/upVendor2.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
	
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
