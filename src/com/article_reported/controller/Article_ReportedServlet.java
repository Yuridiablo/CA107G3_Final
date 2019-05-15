package com.article_reported.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.article_reported.model.*;
import com.article_published.model.*;

//參考資料：https://blog.csdn.net/qx5211258/article/details/45220135

public class Article_ReportedServlet extends HttpServlet{

	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		String action = req.getParameter("action");
		
//		if("getOne_For_Update".equals(action)) {
//			List<String> errorMsgs = new LinkedList<String>();
//			
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			try {
//				String artre_no = req.getParameter("artre_no");
//				
//				Article_ReportedService article_reportedSvc = new Article_ReportedService();
//				Article_ReportedVO article_reportedVO = article_reportedSvc.getOneArticle_Reported(artre_no);
//				
//				req.setAttribute("article_reportedVO", article_reportedVO);
//				String url = "/Article_Reported_JSP/update_article_reported_input.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);
//				successView.forward(req, res);
//				
//			}catch(Exception e) {
//				errorMsgs.add("無法取得修改的資料"+e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/Article_Reported_JSP/listAllArticle_Reported.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
		if("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs",errorMsgs );
			
			try {
				String artre_no = req.getParameter("artre_no");
				String artre_content= req.getParameter("artre_content");
				java.sql.Date artre_time = java.sql.Date.valueOf(req.getParameter("artre_time"));
				Integer artre_code = new Integer(req.getParameter("artre_code"));
				
				Article_ReportedVO article_reportedVO = new Article_ReportedVO();
				article_reportedVO.setArtre_no(artre_no);
				article_reportedVO.setArtre_content(artre_content);
				article_reportedVO.setArtre_time(artre_time);
				article_reportedVO.setArtre_code(artre_code);
				
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("article_reportedVO",article_reportedVO);
					RequestDispatcher failureView  = req.getRequestDispatcher("/Article_Reported_JSP/manage_article_reported.jsp");
					failureView.forward(req, res);
					return;
				}
				
				
				if(artre_code==2) {
					String art_no = req.getParameter("art_no");
					Integer art_code = artre_code;
					Article_PublishedService article_publishedSvc = new Article_PublishedService();
					article_publishedSvc.updateArticle_publishedforart_code(art_code, art_no);
				}
				
				Article_ReportedService article_reportedSvc = new Article_ReportedService();
				article_reportedVO = article_reportedSvc.updateArticle_Reported(artre_content, artre_time, artre_code, artre_no);
				System.out.println("123");
				String url = "/Article_Reported_JSP/manage_article_reported.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add("修改資料失敗"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Article_Reported_JSP/manage_article_reported.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("insert".equals(action)) {
			
			HttpSession session = req.getSession();
			String flag =(String) session.getAttribute("flag");
			String f = req.getParameter("flag");
			if(f.equals(flag)){
				req.getSession().removeAttribute("flag");
			} else {
				System.out.println("重複了!");
				String url = "/Article_Published_JSP/listAllArticle_Published.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				return;
			}
			
			List<String> errorMsgs = new LinkedList();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				String art_no = req.getParameter("art_no");
				String mem_no =req.getParameter("mem_no");
				String mem_noReg ="^[M(0-9)]{7}$";
				if(mem_no==null||mem_no.trim().length()==0) {
					errorMsgs.add("會員編號請勿空白");
				}else if(!mem_no.trim().matches(mem_noReg)){
					errorMsgs.add("會員編號：只能是M加六位數字");
				}
				
				String artre_content = req.getParameter("artre_content");
				if(artre_content==null||artre_content.trim().length()==0) {
					errorMsgs.add("檢舉理由請勿空白");
				}
				
				java.sql.Date artre_time = java.sql.Date.valueOf(req.getParameter("artre_time"));
				Integer artre_code = new Integer(req.getParameter("artre_code"));
				
				Article_ReportedVO article_reportedVO = new Article_ReportedVO();
				article_reportedVO.setArt_no(art_no);
				article_reportedVO.setMem_no(mem_no);
				article_reportedVO.setArtre_content(artre_content);
				article_reportedVO.setArtre_time(artre_time);
				article_reportedVO.setArtre_code(artre_code);
				
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("article_reportedVO", article_reportedVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/listAllArticle_Published.jsp");
					failureView.forward(req, res);
					return;
				}
				Article_ReportedService article_reportedSvc = new Article_ReportedService();
				article_reportedVO = article_reportedSvc.addArticle_Reported(art_no, mem_no, artre_content, artre_time, artre_code);
				
				String url = "/Article_Published_JSP/listAllArticle_Published.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add("新增資料失敗"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/listAllArticle_Published.jsp");
				failureView.forward(req, res);
			}
		}
		
//		if("delete".equals(action)) {
//			List<String> errorMsgs = new LinkedList<String>();
//			
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			try {
//				String artre_no = req.getParameter("artre_no");
//				
//				Article_ReportedService article_reportedSvc = new Article_ReportedService();
//				article_reportedSvc.deleteArticle_Reported(artre_no);
//				
//				String url = "/Article_Reported_JSP/listAllArticle_Reported.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);
//				successView.forward(req, res);
//			}catch(Exception e) {
//				errorMsgs.add("刪除資料失敗"+e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/Article_Reported_JSP/listAllArticle_Reported.jsp");
//				failureView.forward(req, res);
//			}
//		}
	}
	
}
