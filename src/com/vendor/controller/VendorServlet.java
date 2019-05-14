package com.vendor.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.OptionalDouble;
import java.util.OptionalInt;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.JSONObject;

import com.comments.model.CommentsService;
import com.comments.model.CommentsVO;
import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.ord.model.OrdService;
import com.ord.model.OrdVO;
import com.restaurant_menu.model.Restaurant_MenuService;
import com.restaurant_menu.model.Restaurant_MenuVO;
import com.restaurant_responses.model.Restaurant_ResponsesService;
import com.restaurant_responses.model.Restaurant_ResponsesVO;
import com.restaurant_transaction_list.model.RES_Transaction_ListService;
import com.restaurant_transaction_list.model.RES_Transaction_ListVO;
import com.tables.model.TablesService;
import com.tables.model.TablesVO;
import com.vendor.model.*;

//@WebServlet("/VendorServlet")
@MultipartConfig
public class VendorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public VendorServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		JSONObject obj = new JSONObject();
		//System.out.println(req.getParameter("file"));

		// 登入
		if ("login".equals(action)) {
			HttpSession se = req.getSession();
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String v_account = req.getParameter("v_account");
				String v_accountReg = "^[0-9a-zA-z]{1,10}$";
				if (v_account == null || (v_account.trim()).length() == 0) {
					errorMsgs.add("請輸入帳號");
				} else if (!v_account.trim().matches(v_accountReg)) {
					errorMsgs.add("帳號只能輸入數字及大小寫英文");
				}

				String v_pwd = req.getParameter("v_pwd");
				String v_pwdReg = "^[0-9a-zA-z]{1,10}$";
				if (v_pwd == null || (v_pwd.trim()).length() == 0) {
					errorMsgs.add("請輸入密碼");
				} else if (!v_pwd.trim().matches(v_pwdReg)) {
					errorMsgs.add("密碼只能輸入數字及大小寫英文");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/V_FrontPage.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				VendorService vendorSvc = new VendorService();
				System.out.println(v_account);
				VendorVO vVO = vendorSvc.findByAcc(v_account);

				if (vVO == null) {
					errorMsgs.add("無此帳號");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/V_FrontPage.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String v_pwdConfirm = vVO.getV_pwd();

				System.out.println(v_pwdConfirm);

				if (!v_pwd.equals(v_pwdConfirm)) {
					errorMsgs.add("密碼錯誤");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/V_FrontPage.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				
				se.setAttribute("v_account", req.getParameter("v_account"));
				se.setAttribute("vVO", vVO);
				
				String url = "/Vendor/mainVendor.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				System.out.println(se.toString());
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/V_FrontPage.jsp");
				failureView.forward(req, res);

			}
		}
		//System.out.println("----WW!---");
		//註冊
		if ("insert".equals(action)) {
			HttpSession se = req.getSession();
			
			boolean newAcc = false;
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				String v_name = req.getParameter("v_name");
//				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
//				if (ename == null || ename.trim().length() == 0) {
//					errorMsgs.add("員工姓名: 請勿空白");
//				} else if(!ename.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//	            }

				String v_account = req.getParameter("v_account").trim();
				if (v_account == null || v_account.trim().length() == 0) {
					errorMsgs.add("帳號請勿空白");
				}

//				java.sql.Date hiredate = null;
//				try {
//					hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
//				} catch (IllegalArgumentException e) {
//					hiredate=new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}

				String v_pwd = req.getParameter("v_pwd").trim();
				String v_mail = req.getParameter("v_mail").trim();
				String v_n_code = req.getParameter("v_n_code").trim();
				String v_tel = req.getParameter("v_tel").trim();
				String v_ad_code = req.getParameter("v_ad_code").trim();
				String v_address1 = req.getParameter("v_address1").trim();
				String v_address2 = req.getParameter("v_address2").trim();
				String v_address3 = req.getParameter("v_address3").trim();

			

//				Double comm = null;
//				try {
//					comm = new Double(req.getParameter("comm").trim());
//				} catch (NumberFormatException e) {
//					comm = 0.0;
//					errorMsgs.add("獎金請填數字.");
//				}

				VendorVO vVO = new VendorVO();

				// 上傳圖片
				byte[] v_pic = null;
				Collection<Part> pps = req.getParts();
				for (Part part : pps) {
					if (part.getName().equals("v_pic")) {
						if (part.getSize() != 0) {

							InputStream in = part.getInputStream();
							ByteArrayOutputStream output = new ByteArrayOutputStream();
							v_pic = new byte[in.available()];
							for (int length = 0; (length = in.read(v_pic)) > 0;)
								output.write(v_pic, 0, length);
						} else {
							System.out.println("提醒：該廠商註冊時沒有選擇圖片");
//							errorMsgs.add("圖片請勿空白");

						}
					}
				}

				vVO.setV_name(v_name);
				vVO.setV_account(v_account);
				vVO.setV_pwd(v_pwd);
				vVO.setV_mail(v_mail);
				vVO.setV_n_code(v_n_code);
				vVO.setV_tel(v_tel);
				vVO.setV_ad_code(v_ad_code);
				vVO.setV_address1(v_address1);
				vVO.setV_address2(v_address2);
				vVO.setV_address3(v_address3);
				vVO.setV_pic(v_pic);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("vVO", vVO); // 含有輸入格式錯誤的VO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/Vendor/addVendor.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/

				VendorService vSvc = new VendorService();
				vVO = vSvc.addV(v_account, v_pwd, v_mail, v_tel, v_n_code, v_ad_code, v_address1, v_address2, v_address3, v_name, v_pic);
//				List<Restaurant_MenuVO> vlist = rmSvc.getVendor(vendor_no);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("vVO", vVO); // 資料庫update成功後,正確的的VO物件,存入req
				newAcc = true;
				se.setAttribute("newAcc", newAcc);
//				req.setAttribute("vlist", vlist);
				String url = "/front-end/V_FrontPage.jsp";
//				res.sendRedirect(url);
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
				se.invalidate();
				

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Vendor/listAll.jsp");
				failureView.forward(req, res);
			}
		}
		
		//修改餐廳資訊
//		if ("getOne_For_Update".equals(action)) {
//			System.out.println("到了");
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/*************************** 1.接收請求參數 ****************************************/
//				String vendor_no = "V000001";
////				String vendor_no = req.getParameter("vendor_no");
//				System.out.println(vendor_no);
//
//				/*************************** 2.開始查詢資料 ****************************************/
//				VendorService vSvc = new VendorService();
//				VendorVO vVO = vSvc.findByPK(vendor_no);
//				System.out.println(vVO.getV_name());
//				
//
//				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
//				req.setAttribute("vVO", vVO); // 資料庫取出的empVO物件,存入req
//				String url = "/Vendor/upVendor.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
//				successView.forward(req, res);
//
//				/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/Restaurant_Menu/listAllMenus.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
		//更改店家資料
		if ("Update".equals(action)) {
			HttpSession se = req.getSession();
			System.out.println("更新的頭");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				
				VendorVO vVO = (VendorVO) se.getAttribute("vVO");
				String vendor_no = vVO.getVendor_no();
				String v_type = req.getParameter("v_type");
//				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
//				if (ename == null || ename.trim().length() == 0) {
//					errorMsgs.add("員工姓名: 請勿空白");
//				} else if(!ename.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//	            }

				String v_start_time = req.getParameter("v_start_time").trim();
//				if (v_account == null || v_account.trim().length() == 0) {
//					errorMsgs.add("帳號請勿空白");
//				}

//				java.sql.Date hiredate = null;
//				try {
//					hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
//				} catch (IllegalArgumentException e) {
//					hiredate=new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}

				String v_end_time = req.getParameter("v_end_time").trim();
				String v_day = req.getParameter("v_day").trim();
				String v_tables = req.getParameter("v_tables").trim();

				String v_text = req.getParameter("v_text").trim();
				

			

//				Double comm = null;
//				try {
//					comm = new Double(req.getParameter("comm").trim());
//				} catch (NumberFormatException e) {
//					comm = 0.0;
//					errorMsgs.add("獎金請填數字.");
//				}


				// 上傳圖片
//				byte[] v_pic = null;
//				Collection<Part> pps = req.getParts();
//				for (Part part : pps) {
//					if (part.getName().equals("v_pic")) {
//						if (part.getSize() != 0) {
//
//							InputStream in = part.getInputStream();
//							ByteArrayOutputStream output = new ByteArrayOutputStream();
//							v_pic = new byte[in.available()];
//							for (int length = 0; (length = in.read(v_pic)) > 0;)
//								output.write(v_pic, 0, length);
//						} else {
//							errorMsgs.add("圖片請勿空白");
//
//						}
//					}
//				}

				vVO.setV_type(v_type);
				vVO.setV_start_time(v_start_time);
				vVO.setV_end_time(v_end_time);
				vVO.setV_day(v_day);
				vVO.setV_tables(v_tables);
				vVO.setV_text(v_text);
				vVO.setVendor_no(vendor_no);

				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("vVO", vVO); // 含有輸入格式錯誤的VO物件,也存入req
//					RequestDispatcher failureView = req.getRequestDispatcher("/Restaurant_Menu/addMenu.jsp");
//					failureView.forward(req, res);
//					return; // 程式中斷
//				}

				/*************************** 2.開始修改資料 *****************************************/

				VendorService vSvc = new VendorService();
				vVO = vSvc.update(v_type, v_start_time, v_end_time, v_day, v_tables, v_text, vendor_no);
//				List<Restaurant_MenuVO> vlist = rmSvc.getVendor(vendor_no);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//				req.setAttribute("vVO", vVO); // 資料庫update成功後,正確的的VO物件,存入req
//				req.setAttribute("vlist", vlist);
//				String url = req.getParameter("requestURL");
				
				String url = "/Vendor/Vendor.do?action=upVendor";
				System.out.println(url);
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Vendor/listAll.jsp");
				failureView.forward(req, res);
			}
		}
		
			if ("logout".equals(action)) {
			System.out.println("成功登出");
			HttpSession se = req.getSession();
				
			try {
				/*************************** 1.接收請求參數 ****************************************/
	
				se.invalidate();
				System.out.println(se.toString());
				
			
	
				/*************************** 2.開始查詢資料 ****************************************/
		
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				boolean newAcc = false;
				req.setAttribute("newAcc", newAcc);
				String url = req.getContextPath()+"/front-end/V_FrontPage.jsp";
				res.sendRedirect(url);
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
//				successView.forward(req, res);
//	
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			
			if ("upPic".equals(action)) {
				System.out.println("進入了UP");
				HttpSession se = req.getSession();
					
				try {
					/*************************** 1.接收請求參數 ****************************************/
					VendorVO vVO = (VendorVO) se.getAttribute("vVO");
					String vendor_no = vVO.getVendor_no();

			
					// 上傳圖片
					byte[] v_pic = null;
//					v_pic = ByteConvert.Base64Decode(req.getParameter("file"));
					String base64 = req.getParameter("file");
					
					v_pic = Base64.getMimeDecoder().decode(base64.split(",")[1]);
					
					vVO.setV_pic(v_pic);
					System.out.println(vendor_no);
					vVO.setVendor_no(vendor_no);
					
					System.out.println(v_pic);
					
					VendorService vSvc = new VendorService();
					vVO = vSvc.updatePic(v_pic, vendor_no);

					

					/*************************** 2.開始查詢資料 ****************************************/
			
					/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
					String url = "/Vendor/V_frontPage.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
					successView.forward(req, res);
		
					/*************************** 其他可能的錯誤處理 **********************************/
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			if ("upAd".equals(action)) {
				System.out.println("進入了Ad");
				HttpSession se = req.getSession();
					
				try {
					/*************************** 1.接收請求參數 ****************************************/
					VendorVO vVO = (VendorVO) se.getAttribute("vVO");
					String vendor_no = vVO.getVendor_no();

			
					// 上傳圖片
					byte[] v_ad = null;
//					v_pic = ByteConvert.Base64Decode(req.getParameter("file"));
					String base64 = req.getParameter("file");
					
					v_ad = Base64.getMimeDecoder().decode(base64.split(",")[1]);
					
					vVO.setV_ad(v_ad);
					System.out.println(vendor_no);
					vVO.setVendor_no(vendor_no);
					
					System.out.println(v_ad);
					
					VendorService vSvc = new VendorService();
					vVO = vSvc.updateAd(v_ad, vendor_no);

					

					/*************************** 2.開始查詢資料 ****************************************/
			
					/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
					String url = "/front-end/V_FrontPage.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
					successView.forward(req, res);
		
					/*************************** 其他可能的錯誤處理 **********************************/
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			if ("listVendor".equals(action)) {
				
				HttpSession se = req.getSession();
				VendorVO vVO = (VendorVO)se.getAttribute("vVO");
				VendorService vSvc = new VendorService();
				String vendor_no = vVO.getVendor_no();
				vVO =vSvc.findByPK(vendor_no);
				
				String xxx = "good";
				try {
					/*************************** 1.接收請求參數 ****************************************/
					
					req.setAttribute("rtllist", xxx);
					System.out.println("有跑listVendor");
					RES_Transaction_ListVO rtlVO3 =  new RES_Transaction_ListVO();
					RES_Transaction_ListService rtlSvc = new RES_Transaction_ListService();
					List<RES_Transaction_ListVO> rtllist = new ArrayList<>();
					rtllist = rtlSvc.getOneVendor(vendor_no);
					for (RES_Transaction_ListVO rtlVO : rtllist) {
						if( rtlVO.getV_wallet() == 3 )
							rtlVO3 = rtlVO;	
						
					}
					
					req.setAttribute("rtlVO3", rtlVO3);
					se.setAttribute("vVO", vVO);
					System.out.println(rtlVO3.getV_wallet());					
					/*************************** 2.開始查詢資料 ****************************************/
			
					/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
					String url = "/Vendor/mainVendor.jsp";
//					res.sendRedirect(url);
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
					successView.forward(req, res);
		
					/*************************** 其他可能的錯誤處理 **********************************/
				} catch (Exception e) {
					e.printStackTrace();
				}
			
			}
			
		if ("listComment".equals(action)) {
				HttpSession se = req.getSession();
				
				String xxx = "good2";
				try {
					/*************************** 1.接收請求參數 ****************************************/
					VendorVO vVO = (VendorVO) se.getAttribute("vVO");
					String vendor_no = vVO.getVendor_no();
					CommentsService cSvc = new CommentsService();
					
					List<CommentsVO> clist = cSvc.getOneVendor(vendor_no);
					Collections.reverse(clist);
					Restaurant_ResponsesService rrSvc = new Restaurant_ResponsesService();
					List<Restaurant_ResponsesVO> rrlist = new ArrayList<>();
					Map<CommentsVO,Restaurant_ResponsesVO> rrMap = new LinkedHashMap<>();
					
				
					for (CommentsVO cVO : clist) {
						
					Restaurant_ResponsesVO rrVO = new Restaurant_ResponsesVO();
					String aaa = cVO.getCmnt_no();
					System.out.println(aaa);
					rrVO = (Restaurant_ResponsesVO)rrSvc.findPk(aaa);			
					rrlist.add(rrVO); 					
					rrMap.put(cVO, rrVO);
					
					}
					
					
							
							System.out.println("餐廳回應評論" + rrMap);
					req.setAttribute("rrlist", rrlist);
					req.setAttribute("clist", clist);
					req.setAttribute("rrMap", rrMap);
				
		
					/*************************** 2.開始查詢資料 ****************************************/
			
					/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
					String url = "/Vendor/mainVendor.jsp";
//					res.sendRedirect(url);
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
					successView.forward(req, res);
		
					/*************************** 其他可能的錯誤處理 **********************************/
				} catch (Exception e) {
					e.printStackTrace();
				}
			
			}
		
		if ("listStatus".equals(action)) {

			
			try {
				/*************************** 1.接收請求參數 ****************************************/
//				VendorVO vVO = (VendorVO) se.getAttribute("vVO");
				VendorService vSvc = new VendorService();
				
				List<VendorVO> vlistConfirm = vSvc.getAll();
				
				req.setAttribute("vlistConfirm", vlistConfirm);
			
				/*************************** 2.開始查詢資料 ****************************************/
		
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				// 要改成員工主頁面
				String url = "/back-end/employeeScreen.jsp";
//				res.sendRedirect(url);
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
	
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}
		
		if ("ajaxUpStatus".equals(action)) {
//			HttpSession se = req.getSession();
		
			String vendor_no = req.getParameter("vendor_no");
			String v_status = req.getParameter("status");
			JSONObject jobj = new JSONObject();
			
			try {
				/*************************** 1.接收請求參數 ****************************************/
//				VendorVO vVO = (VendorVO) se.getAttribute("vVO");
				VendorService vSvc = new VendorService();
				vSvc.upStatus(v_status, vendor_no);
				
				jobj.accumulate("ok", "已同意申請");
				jobj.accumulate("notok", "已婉拒申請");
				/*************************** 2.開始查詢資料 ****************************************/
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				
				PrintWriter out = res.getWriter();
				out.write(jobj.toString());
				out.flush();
				out.close();
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				// 要改成員工主頁面
//				String url = "/Vendor/mainVendor.jsp";
//				res.sendRedirect(url);
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
//				successView.forward(req, res);
	
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}
		
		
		
		if ("upVendor".equals(action)) {
			
			String xxx = "good3";
			try {
				/*************************** 1.接收請求參數 ****************************************/
				
				req.setAttribute("vlist", xxx);
				System.out.println("有跑upVendor");
	
				/*************************** 2.開始查詢資料 ****************************************/
		
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				String url = "/Vendor/mainVendor.jsp";
//				res.sendRedirect(url);
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
	
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}
		
		if ("listMenu".equals(action)) {
			HttpSession se = req.getSession();
			
			try {
				/*************************** 1.接收請求參數 ****************************************/
				VendorVO vVO = (VendorVO) se.getAttribute("vVO");
				String vendor_no = vVO.getVendor_no();
				Restaurant_MenuService rmSvc = new Restaurant_MenuService();
				List<Restaurant_MenuVO> rmlist = rmSvc.getVendor(vendor_no);
				req.setAttribute("rmlist", rmlist);
				System.out.println("有跑rmList");
				
				if (rmlist.size() == 0) {
					String newStore = "新開張";
					req.setAttribute("newStore", newStore);
				}
	
				/*************************** 2.開始查詢資料 ****************************************/
		
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				String url = "/Vendor/mainVendor.jsp";
//				res.sendRedirect(url);
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
	
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}
		
		if ("search".equals(action)) {
			
			System.out.println("開始查詢");
			String v_name = req.getParameter("v_name");

			System.out.println(v_name + "我在這");
			VendorService vSvc = new VendorService();
			CommentsService cSvc = new CommentsService();
			OrdService oSvc = new OrdService();
			MemberService mSvc = new MemberService();
			String scoreWant = req.getParameter("scoreSelect");
			
			
			try {
				/*************************** 1.接收請求參數 ****************************************/
				
				List<VendorVO> searchlist = vSvc.search(v_name);
				List<VendorVO> alllist = vSvc.getAll().stream().filter(v -> v.getV_status().equals("1")).collect(Collectors.toList());
				List<CommentsVO> allComList = cSvc.getAll();
				
			
					
				
				
				//廠商大打包
				Map<VendorVO, ArrayList<String>> searchMap = new LinkedHashMap<>();
				
				
				for (VendorVO vVO : searchlist) {
				
				if (vVO.getV_status().equals("1")) {	
					ArrayList<String> infoString = new ArrayList<>();
					
					OptionalDouble avgscore = allComList.stream()
						.filter(v -> v.getVendor_no().equals(vVO.getVendor_no()))
						.mapToDouble(v -> v.getScore())
						.average();
	
					long sumcomm = allComList.stream()
							.filter(v -> v.getVendor_no().equals(vVO.getVendor_no()))
							.count();
							
					
					if (avgscore.isPresent()) {
						
						String result = String.format("%.1f", avgscore.getAsDouble());
						// 0 1 
						infoString.add(result);
						infoString.add(String.valueOf(sumcomm));
						
						
					} else {
						infoString.add("0");
						infoString.add("0");
					}
					
					/*    字串集合用途
					   [ 0 	平均評價 
						 1	總評論數         
						 2	評論內容
						 3	評論分數    
						 4	會員編號(照片用)   
						 5	評論編號          
						 6	切出來的標題 ]
						 7	會員暱稱
					*/
					Optional<CommentsVO> comm = allComList.stream()
							.filter(v -> v.getVendor_no().equals(vVO.getVendor_no()))
							.reduce((first, second) -> second);
							
					
					if (comm.isPresent()) {
						// 2 3
						infoString.add(comm.map(v -> v.getCmnt()).get());
						infoString.add(comm.map(v -> v.getScore()).get().toString());
						OrdVO oVO = oSvc.getOneOrd(comm.get().getOrd_no());
						MemberVO mVO = mSvc.getOneMember(oVO.getMem_no());
						infoString.add(mVO.getMem_no());
						
						// 4 5
						infoString.add(comm.map(v -> v.getCmnt_no()).get());
						
						String forSub = comm.map(v -> v.getCmnt()).get();
						//切出標題用文字
						
						int cut = forSub.indexOf("，", 0);
						
						if (cut < 0) {
							cut = forSub.indexOf(",", 0);
						}
						if (cut < 0) {
							cut = 6;
						}
						String title = forSub.substring(0,cut);
						// 6
						infoString.add(title);
						// 7
						infoString.add(mVO.getMem_nickname());
						
						
						
					} else {
						infoString.add("尚無評論！");
					}
					
					if(Double.parseDouble(infoString.get(0)) >= Double.parseDouble(scoreWant)) {
						searchMap.put(vVO, infoString);
					}
					
					
					
					
					System.out.println("平均分數：" + infoString.get(0));
					System.out.println("總評論篇數：" + infoString.get(1));
						
					}
				}
//				List<CommentsVO> oneComment = cSvc.getOneVendor(vendor_no);
				
				req.setAttribute("searchlist", searchlist);
				req.setAttribute("alllist", alllist);
				req.setAttribute("searchMap", searchMap);
								
				/*************************** 2.開始查詢資料 ****************************************/
		
				
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				String url = "/Vendor/search_result.jsp";
//				res.sendRedirect(url);
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
	
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}
		
		

	}

}
