package com.friend_list.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.friend_list.model.Friend_ListService;
import com.friend_list.model.Friend_ListVO;

public class Friend_ListServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		String action = req.getParameter("action");
		
		if("getOne_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("mem_no");
				if(str==null || (str.trim()).length()==0) {
					errorMsgs.add("請輸入會員編號");
				}
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/Friend_List_JSP/select_pageforFriend_List.jsp");
					failureView.forward(req, res);
					return;
				}
				String mem_no = new String(str);
				
				/***************************2.開始查詢資料*****************************************/
				Friend_ListService friend_listSvc = new Friend_ListService();
				Friend_ListVO friend_listVO = friend_listSvc.getOneFriend_List(mem_no);
				if(friend_listVO == null) {
					errorMsgs.add("查無資料");
				}
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_pageforFriend_List.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("friend_listVO", friend_listVO);
				String url = "/Friend_List_JSP/listOneFriend_List.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			}catch(Exception e) {
				errorMsgs.add("無法取得資料"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Friend_List_JSP/select_pageforFriend_List.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("getOne_For_Search".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("frie_no");
				if(str==null || (str.trim()).length()==0) {
					errorMsgs.add("請輸入朋友編號");
				}
				String mem_no = new String(req.getParameter("mem_no"));
				if(str.equals(mem_no)) {
					errorMsgs.add("請不要搜尋自己");
				}
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/Friend_List_JSP/searchforFriend_List.jsp");
					failureView.forward(req, res);
					return;
				}
				String frie_no = new String(str);
				
				
				/***************************2.開始查詢資料*****************************************/
				Friend_ListService friend_listSvc = new Friend_ListService();
				Friend_ListVO friend_listVO = friend_listSvc.getOneFriend_List2(mem_no, frie_no);
				
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				if(friend_listVO==null) {
					req.setAttribute("mem_no", mem_no);
					req.setAttribute("frie_no", frie_no);
					String url = "/Friend_List_JSP/listOneFriend_Listfor_nobody.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
				}else {
				req.setAttribute("friend_listVO", friend_listVO);
				String url = "/Friend_List_JSP/listOneFriend_List.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				}
				
				/***************************其他可能的錯誤處理*************************************/
			}catch(Exception e) {
				errorMsgs.add("無法取得資料"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Friend_List_JSP/searchforFriend_List.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String mem_no = req.getParameter("mem_no");
				String frie_no =req.getParameter("frie_no");
				Integer frie_code = new Integer(req.getParameter("frie_code"));
				
				
				/***************************2.開始查詢資料****************************************/
				Friend_ListService friend_listSvc = new Friend_ListService();
				Friend_ListVO friend_listVO = friend_listSvc.getOneFriend_List2(mem_no,frie_no);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("friend_listVO", friend_listVO);
				String url ="/Friend_List_JSP/update_friend_list_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			}catch(Exception e){
				errorMsgs.add("無法取得要修改的資料"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Friend_List_JSP/listAllFriend_List.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mem_no = req.getParameter("mem_no");
				String frie_no = req.getParameter("frie_no");
				Integer frie_code = new Integer(req.getParameter("frie_code"));
				Friend_ListVO friend_listVO = new Friend_ListVO();
				
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("friend_listVO", friend_listVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/Friend_List_JSP/update_friend_list_input.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始修改資料*****************************************/
				Integer frie_code2=null;
				if(frie_code==1) {
					frie_code=3;
					frie_code2=4;
				}else if(frie_code==2) {
					frie_code=4;
					frie_code2=3;
				}else if(frie_code==3||frie_code==4) {
					frie_code=7;
					frie_code2=7;
				}else if(frie_code==5) {
					frie_code=7;
					frie_code2=7;
				}else if(frie_code==7) {
					frie_code=5;
					frie_code2=6;
				}
				String mem_no2=frie_no;
				String frie_no2=mem_no;
				Friend_ListVO friend_listVO2 = new Friend_ListVO();
				friend_listVO.setMem_no(mem_no);
				friend_listVO.setFrie_no(frie_no);
				friend_listVO.setFrie_code(frie_code);
				friend_listVO2.setMem_no(mem_no2);
				friend_listVO2.setFrie_no(frie_no2);
				friend_listVO2.setFrie_code(frie_code2);
				Friend_ListService friend_listSvc = new Friend_ListService();
				friend_listVO = friend_listSvc.updateFriend_List(mem_no, frie_no,frie_code);
				Friend_ListService friend_listSvc2 = new Friend_ListService();
				friend_listVO2 = friend_listSvc2.updateFriend_List(mem_no2,frie_no2, frie_code2);
				req.setAttribute("friend_listVO", friend_listVO);
				String url = "/Friend_List_JSP/listOneFriend_List.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			}catch(Exception e) {
				errorMsgs.add("修改資料失敗"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Friend_List_JSP/update_friend_list_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String mem_no = req.getParameter("mem_no");
				String frie_no =req.getParameter("frie_no");
				String mem_noReg ="^[M(0-9)]{7}$";
				String frie_noReg ="^[M(0-9)]{7}$";
				if(mem_no==null||mem_no.trim().length()==0) {
					errorMsgs.add("會員編號請勿空白");
				}else if(!mem_no.trim().matches(mem_noReg)){
					errorMsgs.add("會員編號：只能是M加六位數字");
				}
				if(frie_no==null||frie_no.trim().length()==0) {
					errorMsgs.add("朋友編號請勿空白");
				}else if(!frie_no.trim().matches(frie_noReg)){
					errorMsgs.add("朋友編號：只能是M加六位數字");
				}
				
				Integer frie_code  = new Integer(req.getParameter("frie_code").trim());
	
				Friend_ListVO friend_listVO = new Friend_ListVO();
				friend_listVO.setMem_no(mem_no);
				friend_listVO.setFrie_no(frie_no);
				friend_listVO.setFrie_code(frie_code);
				
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("friend_listVO", friend_listVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/Friend_List_JSP/addFriend_List.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				try {
					Friend_ListService friend_listSvc = new Friend_ListService();
					friend_listVO = friend_listSvc.addFriend_List(mem_no, frie_no, frie_code);
				}catch(Exception e) {
					errorMsgs.add("查無該會員資料或紀錄已存在");
				}
				Integer frie_code2=null;
				if(frie_code==1) {
					frie_code2=2;
				}else if(frie_code==3) {
					frie_code2=4;
				}
				String mem_no2=frie_no;
				String frie_no2=mem_no;
				Friend_ListVO friend_listVO2 = new Friend_ListVO();
				friend_listVO2.setMem_no(mem_no2);
				friend_listVO2.setFrie_no(frie_no2);
				friend_listVO2.setFrie_code(frie_code2);
				Friend_ListService friend_listSvc2 = new Friend_ListService();
				friend_listVO2 = friend_listSvc2.addFriend_List(mem_no2,frie_no2, frie_code2);
				
				
				
				
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("friend_listVO", friend_listVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/Friend_List_JSP/addFriend_List.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/Friend_List_JSP/listAllFriend_List.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Friend_List_JSP/addFriend_List.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("delete".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數***************************************/
				String mem_no = req.getParameter("mem_no");
				String frie_no =req.getParameter("frie_no");
				
				/***************************2.開始刪除資料***************************************/
				Friend_ListService friend_listSvc = new Friend_ListService();
				friend_listSvc.deleteFriend_List(mem_no, frie_no);
				friend_listSvc.deleteFriend_List(frie_no, mem_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/Friend_List_JSP/listAllFriend_List.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			}catch(Exception e) {
				errorMsgs.add("刪除資料失敗"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Friend_List_JSP/listAllFriend_List.jsp");
				failureView.forward(req, res);
			}
		}
		if("listfriend_listByfrie_code".equals(action)) {
			try {
				Integer frie_code = new Integer(req.getParameter("frie_code"));
				
				Friend_ListService friend_listSvc = new Friend_ListService();
				Set<Friend_ListVO> set = friend_listSvc.getFriend_ListByFrie_code(frie_code);
				
				req.setAttribute("listfriend_listByfrie_code", set);
				String url ="/Friend_List_JSP/listfriend_listByfrie_code.jsp";
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
	}
}
