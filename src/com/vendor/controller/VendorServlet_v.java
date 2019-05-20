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

import com.reservation_table_number.model.Reservation_Table_NumberService;
import com.reservation_table_number.model.Reservation_Table_NumberVO;
import com.vendor.model.TimeFmt;
import com.vendor.model.VendorService;
import com.vendor.model.VendorVO;


public class VendorServlet_v extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession se = req.getSession();
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		String vendor_no = req.getParameter("vendor_no");
		
//		System.out.println(action);
		if ("updateVendorInfo".equals(action)) {
			String tar = req.getParameter("tar");
			String inputVal1 = req.getParameter("inputVal1");
			String inputVal2 = req.getParameter("inputVal2");
//			System.out.println(tar);
//			System.out.println(inputVal1);
//			System.out.println(inputVal2);
			VendorService vs = new VendorService();
			switch(tar) {
			case "v_type":
				vs.upType(inputVal1, vendor_no);
				break;
			case "v_text":
				vs.upText(inputVal1, vendor_no);
				break;
			case "v_day":
				vs.upDay(inputVal1, vendor_no);
				break;
			case "v_start_end_time":
				vs.upSEtime(TimeFmt.removeSep(inputVal1), TimeFmt.removeSep(inputVal2), vendor_no);
				break;
			case "v_turn_time":
				vs.upTtime(Integer.parseInt(inputVal1), vendor_no);
				break;
			case "v_tables":
				vs.upTbls(inputVal1, vendor_no);
				break;
			}
			
		}
		if ("updateBookingSet".equals(action)) {
			String tar = req.getParameter("tar");
			String inputVal1 = req.getParameter("inputVal1");
			String inputVal2 = req.getParameter("inputVal2");
//			System.out.println(tar);
//			System.out.println(inputVal1);
//			System.out.println(inputVal2);
			Reservation_Table_NumberService rtblSvc = new Reservation_Table_NumberService();
			Reservation_Table_NumberVO rtnVO = rtblSvc.findByV_no(vendor_no);
			switch(tar) {
			case "tbl1":
				rtblSvc.update_t1(vendor_no, Integer.parseInt(inputVal1));
				break;
			case "tbl2":
				rtblSvc.update_t2(vendor_no, Integer.parseInt(inputVal1));
				break;
			case "tbl3":
				rtblSvc.update_t3(vendor_no, Integer.parseInt(inputVal1));
				break;
			case "tbl4":
				rtblSvc.update_t4(vendor_no, Integer.parseInt(inputVal1));
				break;
			case "tbl5":
				rtblSvc.update_t5(vendor_no, Integer.parseInt(inputVal1));
				break;

			}
			
		}
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
