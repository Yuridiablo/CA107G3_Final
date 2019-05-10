package com.comments.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comments.model.CommentsJDBCDAO;
import com.comments.model.CommentsService;
import com.comments.model.CommentsVO;
import com.member.model.MemberService;
import com.ord.model.OrdService;
import com.ord.model.OrdVO;


public class Comments_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");
		
		if ("insert_comments".equals(action)) {
			try {
				// Retrieve form parameters.
				String ord_no = req.getParameter("ord_no");
//				
				CommentsVO C_VO=new CommentsVO();		
				OrdService OSvc=new OrdService();
				OrdVO OrdVO=OSvc.getOneOrd(ord_no);
				
				String vendor_no=OrdVO.getVendor_no();
				CommentsService C_Svc=new CommentsService();
				
				
//				C_Svc.addComments(ord_no, vendor_no, score, cmnt, cmnt_status);

//				req.setAttribute("CommentsVO", C_VO); // 資料庫取出的empVO物件,存入req
				req.setAttribute("ord_no", ord_no);
				req.setAttribute("vendor_no", vendor_no);
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				// 取出的empVO送給listOneEmp.jsp
				RequestDispatcher successView = req
						.getRequestDispatcher("/front-end/ord/list_for_mem.jsp");
				successView.forward(req, res);
				return;

				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		
		
		if ("get_one_insert".equals(action)) {
			
			try {
				
				String vendor_no=req.getParameter("vendor_no");
				String ord_no = req.getParameter("ord_no");
				Integer score=Integer.valueOf(req.getParameter("score"));
				String cmnt =req.getParameter("cmnt");
				java.sql.Timestamp time=new java.sql.Timestamp(System.currentTimeMillis());
				Integer cmnt_status=1;
			
				CommentsVO C_VO=new CommentsVO();
				C_VO.setCmnt(cmnt);
				C_VO.setCmnt_status(cmnt_status);
				C_VO.setOrd_no(ord_no);
				C_VO.setScore(score);
				C_VO.setTime(time);
				C_VO.setVendor_no(vendor_no);
			
				CommentsService C_Svc=new CommentsService();
				CommentsJDBCDAO C_dao =new CommentsJDBCDAO();
				C_dao.insert(C_VO);
				
//				C_Svc.addComments(ord_no, vendor_no, score, cmnt, cmnt_status);

				req.setAttribute("CommentsVO", C_VO); // 資料庫取出的empVO物件,存入req
				// 取出的VO送給listOneEmp.jsp
				RequestDispatcher successView = req
						.getRequestDispatcher("/front-end/ord/list_for_mem.jsp");
				successView.forward(req, res);
				return;

				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		
		
		
		if ("get_mem_display".equals(action)) {
					
					try {
						//從訂單編號去查到會員編號
						String ord_no= req.getParameter("ord_no");
						OrdService ordSvc=new OrdService();
						OrdVO o_vo=ordSvc.getOneOrd(ord_no);
						//取得會員編號
//						String mem_no=req.getParameter("mem_no");
						String mem_no = o_vo.getMem_no();
						
						
						//宣告一個集合來裝等等查出的訂單編號集合
						
						List ord_list=new ArrayList();
						//拿會員編號去查到所有的訂單,裝到集合
							List<OrdVO> ordlist=ordSvc.findBymem_no(mem_no);
							for(int i =0;i<ordlist.size();i++) {
								OrdVO ordVO=ordlist.get(i);
								ordVO.getOrd_no();
								ord_list.add(ordVO.getOrd_no());
							}
							
							
							//取出每一個編號來查出每一個評論
							CommentsService C_Svc=new CommentsService();
							List<CommentsVO> c_VOlist=new ArrayList();
							//拿到所有評論的集合
							for(int i=0;i<ord_list.size();i++) {
								String.valueOf(ord_list.get(i));
								c_VOlist.add(C_Svc.findByord_no(String.valueOf(ord_list.get(i))));
							}
						
						
						String vendor_no=req.getParameter("vendor_no");
						
						Integer score=Integer.valueOf(req.getParameter("score"));
						String cmnt =req.getParameter("cmnt");
						java.sql.Timestamp time=new java.sql.Timestamp(System.currentTimeMillis());
						Integer cmnt_status=1;
//					
						CommentsVO C_VO=new CommentsVO();
						C_VO.setCmnt(cmnt);
						C_VO.setCmnt_status(cmnt_status);
						C_VO.setOrd_no(ord_no);
						C_VO.setScore(score);
						C_VO.setTime(time);
						C_VO.setVendor_no(vendor_no);
//					
						
						CommentsJDBCDAO C_dao =new CommentsJDBCDAO();
						C_dao.insert(C_VO);
						
						C_Svc.addComments(ord_no, vendor_no, score, cmnt, cmnt_status);
							
						req.setAttribute("c_VOlist", c_VOlist); // 資料庫取出的empVO物件,存入req
						// 取出的VO送給listOneEmp.jsp
						System.out.println("我在");
						RequestDispatcher successView = req
								.getRequestDispatcher("/front-end/comments/get_mem_All_comment.jsp");
						successView.forward(req, res);
						
						return;
		
						// Handle any unusual exceptions
					} catch (Exception e) {
						throw new ServletException(e);
					}
				}
				
		
		
		
		}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		doGet(req, res);
	}

}
