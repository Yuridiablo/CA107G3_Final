package com.article_published.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.article_published.model.*;
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class Article_PublishedServlet extends HttpServlet{

	public void doGet(HttpServletRequest req,HttpServletResponse res ) throws ServletException, IOException {
		doPost(req,res);
	}
	
	public void doPost(HttpServletRequest req,HttpServletResponse res ) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		String action = req.getParameter("action");
		
		if("getOne_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			try {
				String str = req.getParameter("art_no");
				if(str==null||(str.trim()).length()==0) {
					errorMsgs.add("請輸入文章編號");
				}
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/select_pageforArticle_Published.jsp");
					failureView.forward(req, res);
					return;
				}
				String art_no =  new String(str);
				
				Article_PublishedService  article_publishedSvc = new Article_PublishedService();
				Article_PublishedVO article_publishedVO = article_publishedSvc.getOneArticle_Published(art_no);
				if(article_publishedVO==null) {
					errorMsgs.add("查無資料");
				}
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/select_pageforArticle_Published.jsp");
					failureView.forward(req, res);
					return;
				}
				
				req.setAttribute("article_publishedVO",article_publishedVO);
				String url = "/Article_Published_JSP/listOneArticle_Published.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add("無法取得資料"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/select_pageforArticle_Published.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				String art_no = req.getParameter("art_no");
				
				Article_PublishedService article_publishedSvc = new Article_PublishedService();
				Article_PublishedVO article_publishedVO = article_publishedSvc.getOneArticle_Published(art_no);
				
				req.setAttribute("article_publishedVO", article_publishedVO);
				String url = "/Article_Published_JSP/update_article_published_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add("無法取得修改的資料"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/listAllArticle_Published.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String art_no = req.getParameter("art_no");
				
				String art_title =req.getParameter("art_title");
				if(art_title==null||art_title.trim().length()==0) {
					errorMsgs.add("文章標題請勿空白");
				}
				
				String art_content = req.getParameter("art_content");
				if(art_content==null|| art_content.trim().length()==0) {
					errorMsgs.add("文章內容請勿空白");
				}
				
				java.sql.Date art_time = java.sql.Date.valueOf(req.getParameter("art_time"));
				
				Article_PublishedService article_publishedSvcpic = new Article_PublishedService();
				Article_PublishedVO  article_publishedVOpic = article_publishedSvcpic.showPicArticle_Published_Information(art_no);
				
				
				byte[] art_pic1 = article_publishedVOpic.getArt_pic1();
				byte[] art_pic2 = article_publishedVOpic.getArt_pic2();
				byte[] art_pic3 = article_publishedVOpic.getArt_pic3();
				byte[] art_pic4 = article_publishedVOpic.getArt_pic4();
				byte[] art_pic5 = article_publishedVOpic.getArt_pic5();
				
				Part part1 = req.getPart("art_pic1");
				if(part1.getSize()!=0) {
					InputStream in =  part1.getInputStream();
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					byte[] buffer = new byte[in.available()];
					int i;
					while((i = in.read(buffer))!=-1) {
						baos.write(buffer,0,i);
					}
					art_pic1 = baos.toByteArray();
					baos.close();
					in.close();
				}
				
				
				Part part2 = req.getPart("art_pic2");
				if(part2.getSize()!=0) {
					InputStream in =  part2.getInputStream();
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					byte[] buffer = new byte[in.available()];
					int i;
					while((i = in.read(buffer))!=-1) {
						baos.write(buffer,0,i);
					}
					art_pic2 = baos.toByteArray();
					baos.close();
					in.close();
				}
				
				
				Part part3 = req.getPart("art_pic3");
				if(part3.getSize()!=0) {
					InputStream in =  part3.getInputStream();
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					byte[] buffer = new byte[in.available()];
					int i;
					while((i = in.read(buffer))!=-1) {
						baos.write(buffer,0,i);
					}
					art_pic3 = baos.toByteArray();
					baos.close();
					in.close();
				}
				
				
				Part part4 = req.getPart("art_pic4");
				if(part4.getSize()!=0) {
					InputStream in =  part4.getInputStream();
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					byte[] buffer = new byte[in.available()];
					int i;
					while((i = in.read(buffer))!=-1) {
						baos.write(buffer,0,i);
					}
					art_pic4 = baos.toByteArray();
					baos.close();
					in.close();
				}
				
				
				Part part5 = req.getPart("art_pic5");
				if(part5.getSize()!=0) {
					InputStream in =  part5.getInputStream();
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					byte[] buffer = new byte[in.available()];
					int i;
					while((i = in.read(buffer))!=-1) {
						baos.write(buffer,0,i);
					}
					art_pic5 = baos.toByteArray();
					baos.close();
					in.close();
				}
				
				Article_PublishedVO article_publishedVO = new Article_PublishedVO();
				article_publishedVO.setArt_no(art_no);
				article_publishedVO.setArt_title(art_title);
				article_publishedVO.setArt_content(art_content);
				article_publishedVO.setArt_time(art_time);
				article_publishedVO.setArt_pic1(art_pic1);
				article_publishedVO.setArt_pic2(art_pic2);
				article_publishedVO.setArt_pic3(art_pic3);
				article_publishedVO.setArt_pic4(art_pic4);
				article_publishedVO.setArt_pic5(art_pic5);
				
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("article_publishedVO", article_publishedVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/update_article_published_input.jsp");
					failureView.forward(req, res);
					
					return;
				}
				Article_PublishedService article_publishedSvc = new Article_PublishedService();
				article_publishedVO = article_publishedSvc.updateArticle_Published(art_title, art_content, art_time, art_pic1, art_pic2, art_pic3, art_pic4, art_pic5, art_no);
				
				String url = "/Article_Published_JSP/listAllArticle_Published.jsp";
				RequestDispatcher successView =req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add("修改資料失敗"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/update_article_published_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String mem_no = req.getParameter("mem_no");
				String mem_noReg ="^[M(0-9)]{7}$";
				if(mem_no==null||mem_no.trim().length()==0) {
					errorMsgs.add("會員編號請勿空白");
				}else if(!mem_no.trim().matches(mem_noReg)){
					errorMsgs.add("會員編號：只能是M加六位數字");
				}
				
				String art_title =req.getParameter("art_title");
				if(art_title==null||art_title.trim().length()==0) {
					errorMsgs.add("文章標題請勿空白");
				}
				
				String art_content = req.getParameter("art_content");
				if(art_content==null|| art_content.trim().length()==0) {
					errorMsgs.add("文章內容請勿空白");
				}
				
				java.sql.Date art_time = java.sql.Date.valueOf(req.getParameter("art_time"));
				
				byte[] art_pic1 = null;
				byte[] art_pic2 = null;
				byte[] art_pic3 = null;
				byte[] art_pic4 = null;
				byte[] art_pic5 = null;
				
				Part part1 = req.getPart("art_pic1");
				if(part1.getSize()!=0) {
					InputStream in =  part1.getInputStream();
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					byte[] buffer = new byte[in.available()];
					int i;
					while((i = in.read(buffer))!=-1) {
						baos.write(buffer,0,i);
					}
					art_pic1 = baos.toByteArray();
					baos.close();
					in.close();
				}
				
				
				Part part2 = req.getPart("art_pic2");
				if(part2.getSize()!=0) {
					InputStream in =  part2.getInputStream();
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					byte[] buffer = new byte[in.available()];
					int i;
					while((i = in.read(buffer))!=-1) {
						baos.write(buffer,0,i);
					}
					art_pic2 = baos.toByteArray();
					baos.close();
					in.close();
				}
				
				
				Part part3 = req.getPart("art_pic3");
				if(part3.getSize()!=0) {
					InputStream in =  part3.getInputStream();
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					byte[] buffer = new byte[in.available()];
					int i;
					while((i = in.read(buffer))!=-1) {
						baos.write(buffer,0,i);
					}
					art_pic3 = baos.toByteArray();
					baos.close();
					in.close();
				}
				
				
				Part part4 = req.getPart("art_pic4");
				if(part4.getSize()!=0) {
					InputStream in =  part4.getInputStream();
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					byte[] buffer = new byte[in.available()];
					int i;
					while((i = in.read(buffer))!=-1) {
						baos.write(buffer,0,i);
					}
					art_pic4 = baos.toByteArray();
					baos.close();
					in.close();
				}
				
				
				Part part5 = req.getPart("art_pic5");
				if(part5.getSize()!=0) {
					InputStream in =  part5.getInputStream();
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					byte[] buffer = new byte[in.available()];
					int i;
					while((i = in.read(buffer))!=-1) {
						baos.write(buffer,0,i);
					}
					art_pic5 = baos.toByteArray();
					baos.close();
					in.close();
				}
				
				Integer art_code = new Integer(req.getParameter("art_code"));
				Article_PublishedVO article_publishedVO = new Article_PublishedVO();
				article_publishedVO.setMem_no(mem_no);
				article_publishedVO.setArt_title(art_title);
				article_publishedVO.setArt_content(art_content);
				article_publishedVO.setArt_time(art_time);
				article_publishedVO.setArt_pic1(art_pic1);
				article_publishedVO.setArt_pic2(art_pic2);
				article_publishedVO.setArt_pic3(art_pic3);
				article_publishedVO.setArt_pic4(art_pic4);
				article_publishedVO.setArt_pic5(art_pic5);
				article_publishedVO.setArt_code(art_code);
				
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("article_publishedVO", article_publishedVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/addArticle_Published.jsp");
					failureView.forward(req, res);
					
					return;
				}
				Article_PublishedService article_publishedSvc = new Article_PublishedService();
				article_publishedVO = article_publishedSvc.addArticle_Published(mem_no, art_title, art_content, art_time, art_pic1, art_pic2, art_pic3, art_pic4, art_pic5, art_code);
				
				String url = "/Article_Published_JSP/listAllArticle_Published.jsp";
				RequestDispatcher successView =req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add("新增資料失敗"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/addArticle_Published.jsp");
				failureView.forward(req, res);
			}
		}
		if("delete".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs",errorMsgs );
			
			try {
				String art_no = req.getParameter("art_no");
				
				Article_PublishedService article_publishedSvc = new Article_PublishedService();
				article_publishedSvc.deleteArticle_Published(art_no);
				
				String url = "/Article_Published_JSP/listAllArticle_Published.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			}catch(Exception e) {
				errorMsgs.add("刪除資料失敗"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/listAllArticle_Published.jsp");
				failureView.forward(req, res);
			}
		}
		if("listArticle_PublishedByCompositeQuery".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String,String[]>)session.getAttribute("map");
				if(req.getParameter("whichPage")==null) {
					HashMap<String,String[]> map1 = new HashMap<String,String[]>(req.getParameterMap());
					session.setAttribute("map", map1);
					map = map1;
				}
				
				Article_PublishedService article_publishedSvc = new Article_PublishedService();
				List<Article_PublishedVO> list = article_publishedSvc.getAll(map);
				
				req.setAttribute("listArticle_PublishedByCompositeQuery", list);
				RequestDispatcher successView = req.getRequestDispatcher("/Article_Published_JSP/listArticle_PublishedByCompositeQuery.jsp");
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Article_Published_JSP/select_pageforArticle_Published.jsp");
				failureView.forward(req, res);
			}
		}
	}

}
