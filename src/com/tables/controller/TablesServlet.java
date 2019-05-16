package com.tables.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.websocket.Session;

import java.io.*;
import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.tables.model.*;
import com.wait_pos.controller.Wait_Line;

public class TablesServlet extends HttpServlet {
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		PrintWriter out = res.getWriter();
		

		String action = req.getParameter("action");
		
		if ("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String vendor_no = req.getParameter("vendor_no");
				
				int tbl_number;
				try {
					tbl_number = Integer.parseInt(req.getParameter("tbl_number").trim());
				} catch (NumberFormatException e) {
					tbl_number = 1;
					errorMsgs.add("張數請填數字.");
				}
				
				String tbl_name = req.getParameter("tbl_name");
				if (tbl_number == 1) {
					if (tbl_name == null || tbl_name.trim().length() == 0) {
						errorMsgs.add("桌位名稱請勿空白");
					}
				}
								
				Integer tbl_size = Integer.parseInt(req.getParameter("tbl_size"));
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("vendor_no_add", vendor_no);
					req.setAttribute("tbl_number_add", tbl_number);
					req.setAttribute("tbl_name_add", tbl_name);
					req.setAttribute("tbl_size_add", tbl_size);
					
					RequestDispatcher failureView = req
							.getRequestDispatcher("/tables/table_management_list.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始新增資料***************************************/
				TablesService tablesService = new TablesService();
				if (tbl_number == 1) {
					TablesVO tablesVO = tablesService.addTables(vendor_no, tbl_name, tbl_size, null, null, null);
				} else {
					for (int i = 1; i <= tbl_number; i++) {
						TablesVO tablesVO = tablesService.addTables(vendor_no, tbl_name + i, tbl_size, null, null, null);
					}
				}
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/tables_jsp/table_management_list.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("新增資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/tables_jsp/table_management_list.jsp");
				failureView.forward(req, res);
			}				
		}
		if ("updateBasic".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);	
			
			try {
				
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
							
				String tbl_no = req.getParameter("tbl_no");
				
				String vendor_no = req.getParameter("vendor_no");
				
				String tbl_name = req.getParameter("tbl_name");
				if (tbl_name == null || tbl_name.trim().length() == 0) {
					errorMsgs.add("桌位名稱請勿空白");
				}
				
				Integer tbl_size = Integer.parseInt(req.getParameter("tbl_size"));
				
				TablesVO tablesVO = new TablesVO();
				tablesVO.setVendor_no(vendor_no);
				tablesVO.setTbl_no(tbl_no);
				tablesVO.setTbl_name(tbl_name);
				tablesVO.setTbl_size(tbl_size);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("tablesVO", tablesVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/tables/table_management_list.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料***************************************/
				TablesService tablesService = new TablesService();
				tablesService.updateTablesBasic(tbl_no, tbl_name, tbl_size);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/tables_jsp/table_management_list.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);	
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/tables_jsp/table_management_list.jsp");
				failureView.forward(req, res);
			}
			

		}
		if ("delete".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數***************************************/
				String tbl_no = req.getParameter("tbl_no");
				
				String vendor_no = req.getParameter("vendor_no");
				
				String tbl_name = req.getParameter("tbl_name");
				
				Integer tbl_size = Integer.parseInt(req.getParameter("tbl_size"));
				
				TablesVO tablesVO = new TablesVO();
				tablesVO.setVendor_no(vendor_no);
				tablesVO.setTbl_no(tbl_no);
				tablesVO.setTbl_name(tbl_name);
				tablesVO.setTbl_size(tbl_size);				
				/***************************2.開始刪除資料***************************************/
				TablesService tablesService = new TablesService();				
				tablesService.deleteTables(tbl_no);
	
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				String url = "/tables_jsp/table_management_list.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				

				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/tables/table_management_list.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("updateAxis".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);	
			
//			try {
				
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String vendor_no = req.getParameter("vendor_no");
			
				String[] tbl_no_arr = req.getParameterValues("tbl_no");
				
				String[] tbl_type_arr = req.getParameterValues("tbl_type");
				
				String[] tbl_x_arr = req.getParameterValues("tbl_x");
				
				String[] tbl_y_arr = req.getParameterValues("tbl_y");
				
				for(int i = 0;  i < tbl_no_arr.length; i++) {
					TablesService tablesService = new TablesService();
					tablesService.updateTablesAxis(tbl_no_arr[i], tbl_type_arr[i] == "" ? null: Integer.valueOf(tbl_type_arr[i]), tbl_x_arr[i] == "" ? null: Integer.valueOf(tbl_x_arr[i]), tbl_y_arr[i] == "" ? null: Integer.valueOf(tbl_y_arr[i]));				
				}
				
				// 修改 記憶體裡的桌位資料
				Map<String, Tbls> tbls_all = (Map) getServletContext().getAttribute("tbls_all");
				if (tbls_all != null) {
					Tbls vendor_tbls = (Tbls) tbls_all.get(vendor_no);				
					if (vendor_tbls != null) {
						synchronized(vendor_tbls) {
							for(int i = 0;  i < tbl_no_arr.length; i++) {
								TablesVO tblVO = vendor_tbls.getTbls().get(tbl_no_arr[i]).getTblVO();
								tblVO.setTbl_type(tbl_type_arr[i] == "" ? null: Integer.valueOf(tbl_type_arr[i]));
								tblVO.setTbl_x(tbl_x_arr[i] == "" ? null: Integer.valueOf(tbl_x_arr[i]));
								tblVO.setTbl_y(tbl_y_arr[i] == "" ? null: Integer.valueOf(tbl_y_arr[i]));
							}
						}				
					} else {
						System.out.println(vendor_no + " 桌位管理功能未初始化");
					}
				} else {
					System.out.println(vendor_no + " server 桌位管理功能未初始化");
				}
//				TablesVO tablesVO = new TablesVO();
//				tablesVO.setVendor_no(vendor_no);
//				tablesVO.setTbl_no(tbl_no);
//				tablesVO.setTbl_name(tbl_name);
//				tablesVO.setTbl_size(tbl_size);
				
				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("tablesVO", tablesVO); // 含有輸入格式錯誤的empVO物件,也存入req
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/tables/table_management_list.jsp");
//					failureView.forward(req, res);
//					return; //程式中斷
//				}
				
				/***************************2.開始修改資料***************************************/
//				TablesService tablesService = new TablesService();
//				tablesService.updateTablesBasic(tbl_no, tbl_name, tbl_size);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/tables_jsp/table_management_graph.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);	
				
				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/tables/table_management_list.jsp");
//				failureView.forward(req, res);
//			}
			

		} // End of updateAxis
		
		if ("newWI".equals(action)) {
			
			String tbl_no = req.getParameter("tbl_no");				
			String vendor_no = req.getParameter("vendor_no");
			Integer party_size = Integer.parseInt(req.getParameter("party_size"));			
			
			JsonObject jbMsg = new JsonObject();
			String result = null;
			Integer status = null;
			
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();			
			Bill bill = null;
			Map<String, Tbls> tbls_all = (Map) getServletContext().getAttribute("tbls_all");
			if (tbls_all != null) {
				Tbls vendor_tbls = (Tbls) tbls_all.get(vendor_no);				
				if (vendor_tbls != null) {	
					bill = new Bill(tbl_no, party_size);					
					synchronized(vendor_tbls) {
						vendor_tbls.putBill(bill);
						vendor_tbls.setBillToTbl(bill);
					}
					status = 1;
					result = "新增客人成功";					
				} else {
					System.out.println(vendor_no + " 桌位管理功能未初始化");
					status = 0;
					result = "廠商桌位管理功能未初始化";
				}
			} else {
				System.out.println(vendor_no + " server 桌位管理功能未初始化");
				status = 0;
				result = "系統桌位管理功能未初始化";
			}
			// push to vendor
			
			JsonElement jeBill = gson.toJsonTree(bill);
			
			jbMsg.addProperty("result", result);
			jbMsg.addProperty("status", status);
			jbMsg.addProperty("bill_no", bill.getBill_no());
			jbMsg.add("bill", jeBill);
			String jsonStr = gson.toJson(jbMsg);
			out.print(jsonStr);
			
		} // end of newWI
		 
		if ("putVerifiedBill".equals(action)) {
			String vendor_no = req.getParameter("vendor_no");
			String tbl_no = req.getParameter("tbl_no");
			String bill_no = req.getParameter("bill_no");
			
			
			JsonObject jbMsg = new JsonObject();
			String result = null;
			Integer status = null;
			
			Tbl tbl = null;
			Bill bill = null;
			Tbls vendor_tbls = null;
			Map<String, Tbls> tbls_all = (Map) getServletContext().getAttribute("tbls_all");
			if (tbls_all != null) {
				vendor_tbls = (Tbls) tbls_all.get(vendor_no);				
				if (vendor_tbls != null) {	
					tbl = vendor_tbls.getTbls().get(tbl_no); // null ?
					bill = vendor_tbls.getBills().get(bill_no);
					synchronized(tbl) {
						tbl.setBill(bill);
						tbl.setStatus(1);
						bill.setStatus(1);
						bill.setTbl_no(tbl_no);
						bill.setStartTime(System.currentTimeMillis());
						jbMsg.addProperty("startTime", bill.getStartTime());
					}
					status = 1;
					result = "變更桌況成功";					
				} else {
					System.out.println(vendor_no + " 桌位管理功能未初始化");
					status = 0;
					result = "廠商桌位管理功能未初始化";
				}
			} else {
				System.out.println(vendor_no + " server 桌位管理功能未初始化");
				status = 0;
				result = "系統桌位管理功能未初始化";
			}
			// push to vendor
			
			jbMsg.addProperty("result", result);
			jbMsg.addProperty("status", status);
			String jsonStr = jbMsg.toString();
			out.print(jsonStr);
			
			System.out.println(vendor_tbls);
		} // end of putVerifiedBill

		if ("setTblStatus".equals(action)) {
			
			String tbl_no = req.getParameter("tbl_no");				
			String vendor_no = req.getParameter("vendor_no");
			Integer tbl_status = Integer.parseInt(req.getParameter("tbl_status"));
			Integer bill_status = null;
			if (!"".equals(req.getParameter("bill_status")))
				bill_status = Integer.parseInt(req.getParameter("bill_status"));

			JsonObject jbMsg = new JsonObject();
			String result = null;
			Integer status = null;
			
			Tbl tbl = null;
			Bill bill = null;
			Tbls vendor_tbls = null;
			Map<String, Tbls> tbls_all = (Map) getServletContext().getAttribute("tbls_all");
			if (tbls_all != null) {
				vendor_tbls = (Tbls) tbls_all.get(vendor_no);				
				if (vendor_tbls != null) {	
					tbl = vendor_tbls.getTbls().get(tbl_no);
					bill = tbl.getBill();
					synchronized(tbl) {
						if (tbl_status == 1 && bill_status == 1) {
							tbl.setStatus(tbl_status);
//							tbl.setBill(bill);
						} else if (tbl_status == 1 && bill_status == 2) {
							tbl.setStatus(tbl_status);
							bill.setStatus(bill_status);
						} else if (tbl_status == 2 && bill_status == 3) {
							tbl.setStatus(tbl_status);
							bill.setStatus(bill_status);
							bill.setEndTime(new Date().getTime());
							tbl.setBill(null);
							jbMsg.addProperty("endTime", bill.getEndTime());
						} else if (tbl_status == 0 && bill_status == null) {
							tbl.setStatus(tbl_status);
							tbl.setBill(null);
						}
					}
					status = 1;
					result = "變更桌況成功";					
				} else {
					System.out.println(vendor_no + " 桌位管理功能未初始化");
					status = 0;
					result = "廠商桌位管理功能未初始化";
				}
			} else {
				System.out.println(vendor_no + " server 桌位管理功能未初始化");
				status = 0;
				result = "系統桌位管理功能未初始化";
			}
			// push to vendor
			
			
			
			jbMsg.addProperty("result", result);
			jbMsg.addProperty("status", status);
			String jsonStr = jbMsg.toString();
			out.print(jsonStr);
			
			System.out.println(vendor_tbls);
			
		} // end of setTblStatus
		
	} // end of doPost
	
	@Override
	public void init() throws ServletException {
		ServletContext context = getServletContext();
		context.setAttribute("tbls_all", new HashMap<String, Tbls>());
	}
}
