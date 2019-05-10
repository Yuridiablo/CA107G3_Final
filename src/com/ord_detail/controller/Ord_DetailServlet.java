package com.ord_detail.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ord.model.OrdService;
import com.ord.model.OrdVO;
import com.ord_detail.model.Order_DetailService;
import com.ord_detail.model.Order_DetailVO;


public class Ord_DetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
   
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Update".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String ord_no = req.getParameter("ord_no");
				String menu_no=req.getParameter("menu_no");
				
				/***************************2.開始查詢資料****************************************/
				Order_DetailService o_detailSvc = new Order_DetailService();
				Order_DetailVO o_detailVO = o_detailSvc.getOneOrder_Detail(ord_no, menu_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("o_detailVO", o_detailVO);         // 資料庫取出的empVO物件,存入req
				String url = "/emp/update_emp_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/emp/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		
		//從訂單編號及菜單編號查詢該筆訂單明細
		if ("getOne_ord_detail_display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String ord_no = req.getParameter("ord_no");
				String menu_no=req.getParameter("menu_no");
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("Please insert ord_no");
//					System.out.println("13");
//				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = 
					req.getRequestDispatcher("/ord/ord/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
//				String ord_no = null;
//				try {
//					ord_no = new String(str);
//				} catch (Exception e) {
//					errorMsgs.add("error ord_no");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = 
//					req.getRequestDispatcher("/ord/ord/select_page.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
				
				/***************************2.開始查詢資料*****************************************/
				Order_DetailService o_detailSvc = new Order_DetailService();
				Order_DetailVO o_detailVO = o_detailSvc.getOneOrder_Detail(ord_no, menu_no);
				req.setAttribute("o_detailVO", o_detailVO);         // 資料庫取出的empVO物件,存入req
				String url = "/front-end/order_detail/All_ord_detail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/emp/listAllOrd.jsp");
				failureView.forward(req, res);
			}
		}
		
		
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		doGet(req, res);
	}

}
