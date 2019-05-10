package com.tables.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.SQLException;
import java.util.*;
import com.tables.model.*;

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
							
				String[] tbl_no_arr = req.getParameterValues("tbl_no");
				
				String[] tbl_type_arr = req.getParameterValues("tbl_type");
				
				String[] tbl_x_arr = req.getParameterValues("tbl_x");
				
				String[] tbl_y_arr = req.getParameterValues("tbl_y");
				
				for(int i = 0;  i < tbl_no_arr.length; i++) {
					TablesService tablesService = new TablesService();
					tablesService.updateTablesAxis(tbl_no_arr[i], tbl_type_arr[i] == "" ? null: Integer.valueOf(tbl_type_arr[i]), tbl_x_arr[i] == "" ? null: Integer.valueOf(tbl_x_arr[i]), tbl_y_arr[i] == "" ? null: Integer.valueOf(tbl_y_arr[i]));				
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
			

		}
		
	}
}
