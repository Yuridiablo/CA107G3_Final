package com.restaurant_responses.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.restaurant_menu.model.Restaurant_MenuService;
import com.restaurant_menu.model.Restaurant_MenuVO;
import com.restaurant_responses.model.Restaurant_ResponsesService;
import com.restaurant_responses.model.Restaurant_ResponsesVO;


//@WebServlet("/Restaurant_ResponsesServlet")
public class Restaurant_ResponsesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public Restaurant_ResponsesServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		HttpSession se = req.getSession();
		
		
		

		if ("ajaxInsert".equals(action)) {
			System.out.println("ajax狀態區");

			try {
				/*************************** 1.接收請求參數 ****************************************/
				
				String cmnt_no = req.getParameter("cmnt_no");
				String res_text = req.getParameter("res_text");
				
				Restaurant_ResponsesVO rrVO = new Restaurant_ResponsesVO();
				
				rrVO.setCmnt_no(cmnt_no);
				rrVO.setRes_text(res_text);
				
				System.out.println(res_text);
				
				Restaurant_ResponsesService rrSvc = new Restaurant_ResponsesService();
				
				rrSvc.addRR(cmnt_no, res_text);
				

//				/*************************** 2.開始查詢資料 ****************************************/

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
//				String url = "/Restaurant_Menu/listAllMenus.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
//				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
		

	}
}