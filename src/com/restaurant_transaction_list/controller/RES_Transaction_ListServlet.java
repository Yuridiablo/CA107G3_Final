package com.restaurant_transaction_list.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.restaurant_transaction_list.model.RES_Transaction_ListService;
import com.restaurant_transaction_list.model.RES_Transaction_ListVO;
import com.vendor.model.VendorService;
import com.vendor.model.VendorVO;


//@WebServlet("/RES_Transaction_ListServlet")
public class RES_Transaction_ListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public RES_Transaction_ListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("withdrawal".equals(action)) {
		
			HttpSession se = req.getSession();
			JSONObject jobj = new JSONObject();
			
			
			try {
				/*************************** 1.接收請求參數 ****************************************/
				VendorVO vVO = (VendorVO) se.getAttribute("vVO");
				String vendor_no = vVO.getVendor_no();
				String v_wallet = vVO.getV_wallet();
//				RES_Transaction_ListVO rtlVO = new RES_Transaction_ListVO();
				
				String withdrawal = req.getParameter("withdrawal");
				String v_statu = req.getParameter("v_statu");
				Integer.parseInt(v_wallet);
				Integer.parseInt(withdrawal);
			
				String balance = String.valueOf(Integer.parseInt(v_wallet) -  Integer.parseInt(withdrawal));
				//餘額
				System.out.println(balance);
				System.out.println(req.getParameter("v_wallet"));
				
				jobj.accumulate("balance", balance);
				jobj.accumulate("withdrawal",withdrawal);
				
				RES_Transaction_ListService rtlSvc = new RES_Transaction_ListService();
				rtlSvc.addList(vendor_no, -Double.parseDouble(withdrawal), null, Integer.parseInt(v_statu));
			
				
				
				/*************************** 2.開始查詢資料 ****************************************/
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				
				PrintWriter out = res.getWriter();
				out.write(jobj.toString());
				out.flush();
				out.close();
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
//				String url = req.getContextPath() + "/Vendor/Vendor.do?action=listVendor";
//				res.sendRedirect(url);
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
//				successView.forward(req, res);
	
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		
		}
		if ("listStatus".equals(action)) {
			
			
			try {
				/*************************** 1.接收請求參數 ****************************************/
				RES_Transaction_ListService rtlSvc = new RES_Transaction_ListService();
				List<RES_Transaction_ListVO> rtllist =  rtlSvc.getAll().stream().filter(r -> r.getV_wallet() == 3).collect(Collectors.toList());
				Map<VendorVO, RES_Transaction_ListVO> rtlMap = new LinkedHashMap<>();	
				VendorService vSvc = new VendorService();
				
				for (RES_Transaction_ListVO rtlVO : rtllist ) {
					VendorVO vVO = vSvc.findByPK(rtlVO.getVendor_no());
					rtlMap.put(vVO, rtlVO);
				}
					
				
				req.setAttribute("rtlMap", rtlMap);	
					
				/*************************** 2.開始查詢資料 ****************************************/
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				String url = "/back-end/employeeScreen.jsp";
//				res.sendRedirect(url);
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
	
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		
		}
		
		if ("ajaxconfirmed".equals(action)) {
			
			JSONObject jobj = new JSONObject();
						
			try {
				/*************************** 1.接收請求參數 ****************************************/
			
				RES_Transaction_ListService rtlSvc = new RES_Transaction_ListService();
				VendorService vSvc = new VendorService();
					
				String vendor_no = req.getParameter("vendor_no");
				VendorVO vVO = vSvc.findByPK(vendor_no);
				String v_statu = req.getParameter("status");
				String amount = req.getParameter("amount");
					
				String v_wallet = String.valueOf(Integer.parseInt(vVO.getV_wallet()) - Integer.parseInt(amount));
				
				rtlSvc.status(Integer.parseInt(v_statu), vendor_no);
				
				vSvc.upWallet(v_wallet, vendor_no);
				
				
				
				/*************************** 2.開始查詢資料 ****************************************/
				jobj.accumulate("ok", "撥款完成");
				/*************************** 2.開始查詢資料 ****************************************/
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				
				PrintWriter out = res.getWriter();
				out.write(jobj.toString());
				out.flush();
				out.close();
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
//				String url = req.getContextPath() + "/Vendor/Vendor.do?action=listVendor";
//				res.sendRedirect(url);
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
//				successView.forward(req, res);
	
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		
		}
	}
}
