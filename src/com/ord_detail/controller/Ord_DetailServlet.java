package com.ord_detail.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ord.model.OrdService;
import com.ord.model.OrdVO;
import com.ord_detail.model.Order_DetailService;
import com.ord_detail.model.Order_DetailVO;
import com.vendor.model.VendorService;
import com.vendor.model.VendorVO;


public class Ord_DetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
   
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setCharacterEncoding("UTF-8");
		
	
		
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
				
				Order_DetailService odSvc=new Order_DetailService();
				List<Order_DetailVO> odVOlist=odSvc.findbyOrd_no(ord_no);
				VendorService vSvc=new VendorService();
				OrdService oSvc=new OrdService();
				OrdVO ordVO=oSvc.getOneOrd(ord_no);
				List<OrdVO> olist=oSvc.findBymem_no(ordVO.getMem_no());
				
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
				
//				Order_DetailVO o_detailVO = o_detailSvc.getOneOrder_Detail(ord_no, menu_no);
				req.setAttribute("olist", olist);
				req.setAttribute("odVOlist", odVOlist); 
				req.setAttribute("ordVO", ordVO);
				String url = "/front-end/order_detail/paid_one_mem_detail.jsp";
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
		
		//訂單完成後,瀏覽單筆訂單明細可瀏覽其他訂單資訊
		if ("get_all_ord_mem".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String ord_no = req.getParameter("ord_no");
				
				Order_DetailService odSvc=new Order_DetailService();
				List<Order_DetailVO> odVOlist=odSvc.findbyOrd_no(ord_no);
				VendorService vSvc=new VendorService();
				OrdService oSvc=new OrdService();
				OrdVO ordVO=oSvc.getOneOrd(ord_no);
				List<OrdVO> olist=oSvc.findBymem_no(ordVO.getMem_no());
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = 
					req.getRequestDispatcher("/ord/ord/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = 
//					req.getRequestDispatcher("/ord/ord/select_page.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
				
				/***************************2.開始查詢資料*****************************************/
				
//				Order_DetailVO o_detailVO = o_detailSvc.getOneOrder_Detail(ord_no, menu_no);
				req.setAttribute("olist", olist);
				req.setAttribute("odVOlist", odVOlist); 
				req.setAttribute("ordVO", ordVO);
				String url = "/front-end/ord/list_for_mem.jsp";
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
	
			
			if ("getOrdDetail".equals(action)) {
				
				PrintWriter out = res.getWriter();
				String ord_no = req.getParameter("ord_no");
				Order_DetailService ord_DetailService = new Order_DetailService();
				List<Order_DetailVO> list =  ord_DetailService.findbyOrd_no(ord_no);
				List<OdVOn> list2 = new LinkedList<OdVOn>();
				for (int i = 0; i < list.size(); i++) {
					list2.add(new OdVOn(list.get(i)));
				}
				Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
				String jsonStr = gson.toJson(list2);
				out.println(jsonStr);			
			}
			
		
	}

	

}
