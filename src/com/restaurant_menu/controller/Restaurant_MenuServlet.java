package com.restaurant_menu.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

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

import com.restaurant_menu.model.*;
import com.vendor.model.VendorService;
import com.vendor.model.VendorVO;

//@WebServlet("/Restaurant_Menu/Restaurant_Menu.do")
@MultipartConfig

public class Restaurant_MenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Restaurant_MenuServlet() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		JSONObject obj = new JSONObject();
		HttpSession se = req.getSession();

		System.out.println("觸發");

		// 取得一筆資料，可在此填寫更新
		if ("getOne_For_Update".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String menu_no = req.getParameter("menu_no");
				System.out.println(menu_no);

				/*************************** 2.開始查詢資料 ****************************************/
				Restaurant_MenuService rmSvc = new Restaurant_MenuService();
				Restaurant_MenuVO rmVO = rmSvc.findByPK(menu_no);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("rmVO", rmVO); // 資料庫取出的empVO物件,存入req
				String url = "/Restaurant_Menu/update_menu_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Restaurant_Menu/listAllMenus.jsp");
				failureView.forward(req, res);
			}
		}

		// 產生新的資料輸入欄，填寫資料
		if ("insertOneFood".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				VendorVO vVO = (VendorVO) se.getAttribute("vVO");
				String vendor_no = vVO.getVendor_no();
//				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
//				if (ename == null || ename.trim().length() == 0) {
//					errorMsgs.add("員工姓名: 請勿空白");
//				} else if(!ename.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//	            }

				String menu_name = req.getParameter("menu_name").trim();
				if (menu_name == null || menu_name.trim().length() == 0) {
					errorMsgs.add("菜名請勿空白");
				}

//				java.sql.Date hiredate = null;
//				try {
//					hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
//				} catch (IllegalArgumentException e) {
//					hiredate=new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}

				String menu_price = req.getParameter("menu_price").trim();

				try {
					if (Integer.valueOf(menu_price) <= 0)
						errorMsgs.add("價格請大於0");
				} catch (NumberFormatException e) {
					menu_price = "0";
					errorMsgs.add("價格請填數字.");
				}

//				Double comm = null;
//				try {
//					comm = new Double(req.getParameter("comm").trim());
//				} catch (NumberFormatException e) {
//					comm = 0.0;
//					errorMsgs.add("獎金請填數字.");
//				}

				Restaurant_MenuVO rmVO = new Restaurant_MenuVO();

				// 上傳圖片
				byte[] menu_pic = null;
				Collection<Part> pps = req.getParts();
				for (Part part : pps) {
					if (part.getName().equals("menu_pic")) {
						if (part.getSize() != 0) {

							InputStream in = part.getInputStream();
							ByteArrayOutputStream output = new ByteArrayOutputStream();
							menu_pic = new byte[in.available()];
							for (int length = 0; (length = in.read(menu_pic)) > 0;)
								output.write(menu_pic, 0, length);
						} else {
							errorMsgs.add("圖片請勿空白");

						}
					}
				}

				Integer menu_stat = null;
				try {
					menu_stat = Integer.valueOf(req.getParameter("menu_stat"));
				} catch (NumberFormatException ne) {
					menu_stat = 2;
					errorMsgs.add("請填上架狀態，預設為下架(2)");
				}

				String menu_text = req.getParameter("menu_text").trim();

				rmVO.setMenu_pic(menu_pic);
				rmVO.setVendor_no(vendor_no);
				rmVO.setMenu_name(menu_name);
				rmVO.setMenu_price(menu_price);
				rmVO.setMenu_pic(menu_pic);
				rmVO.setMenu_stat(menu_stat);
				rmVO.setMenu_text(menu_text);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("rmVO", rmVO); // 含有輸入格式錯誤的VO物件,也存入req
					String url = "/Vendor/Vendor.do?action=listMenu";
					RequestDispatcher failureView = req.getRequestDispatcher(url);
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/

				Restaurant_MenuService rmSvc = new Restaurant_MenuService();
				rmVO = rmSvc.addRM(vendor_no, menu_name, menu_price, menu_pic, menu_stat, menu_text);
				List<Restaurant_MenuVO> vlist = rmSvc.getVendor(vendor_no);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("rmVO", rmVO); // 資料庫update成功後,正確的的VO物件,存入req
				req.setAttribute("vlist", vlist);
				String url = req.getContextPath()+"/Vendor/Vendor.do?action=listMenu";
				res.sendRedirect(url);
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listChoosed.jsp
//				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Restaurant_Menu/addMenu.jsp");
				failureView.forward(req, res);
			}
		}

		/* ***** 修改 ****** */

		// 送出一筆填完的更新
		if ("update".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String menu_no = req.getParameter("menu_no");
				System.out.println(menu_no);

				String vendor_no = req.getParameter("vendor_no");
//				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
//				if (ename == null || ename.trim().length() == 0) {
//					errorMsgs.add("員工姓名: 請勿空白");
//				} else if(!ename.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//	            }

				String menu_name = req.getParameter("menu_name").trim();
				if (menu_name == null || menu_name.trim().length() == 0) {
					errorMsgs.add("菜名請勿空白");
				}

//				java.sql.Date hiredate = null;
//				try {
//					hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
//				} catch (IllegalArgumentException e) {
//					hiredate=new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}

				String menu_price = req.getParameter("menu_price").trim();

				try {
					if (Integer.valueOf(menu_price) <= 0)
						errorMsgs.add("價格請大於0");
				} catch (NumberFormatException e) {
					menu_price = "0";
					errorMsgs.add("價格請填數字.");
				}

//				Double comm = null;
//				try {
//					comm = new Double(req.getParameter("comm").trim());
//				} catch (NumberFormatException e) {
//					comm = 0.0;
//					errorMsgs.add("獎金請填數字.");
//				}

				Integer menu_stat = null;
				try {
					menu_stat = Integer.valueOf(req.getParameter("menu_stat"));
				} catch (NumberFormatException ne) {
					menu_stat = 2;
					errorMsgs.add("請填上架狀態，預設為下架(2)");
				}

				String menu_text = req.getParameter("menu_text").trim();

				Restaurant_MenuVO rmVO = new Restaurant_MenuVO();

				// 上傳圖片
				byte[] menu_pic = null;
				Collection<Part> pps = req.getParts();
				for (Part part : pps) {
					if (part.getName().equals("menu_pic")) {
						if (part.getSize() != 0) {

							InputStream in = part.getInputStream();
							ByteArrayOutputStream output = new ByteArrayOutputStream();
							menu_pic = new byte[in.available()];
							for (int length = 0; (length = in.read(menu_pic)) > 0;)
								output.write(menu_pic, 0, length);

						} else {

							errorMsgs.add("圖片請勿空白");

						}
					}
				}

				rmVO.setMenu_no(menu_no);
				rmVO.setVendor_no(vendor_no);
				rmVO.setMenu_name(menu_name);
				rmVO.setMenu_price(menu_price);
				rmVO.setMenu_pic(menu_pic);
				rmVO.setMenu_stat(menu_stat);
				rmVO.setMenu_text(menu_text);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("rmVO", rmVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/Restaurant_Menu/addMenu.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/

				Restaurant_MenuService rmSvc = new Restaurant_MenuService();
				rmVO = rmSvc.updateRM(menu_name, menu_price, menu_pic, menu_stat, menu_text, menu_no);
				List<Restaurant_MenuVO> vlist = rmSvc.getVendor(vendor_no);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("rmVO", rmVO); // 資料庫update成功後,正確的的empVO物件,存入req
				req.setAttribute("vlist", vlist);
				String url = "/Restaurant_Menu/listChoosed.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Restaurant_Menu/update_menu_input.jsp");
				failureView.forward(req, res);
			}
		}

		// 檢視單一店家所有菜單
		if ("getOne_List".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String vendor_no = req.getParameter("vendor_no");
				System.out.println(vendor_no);

				/*************************** 2.開始查詢資料 ****************************************/
				Restaurant_MenuService rmSvc = new Restaurant_MenuService();
				List<Restaurant_MenuVO> vlist = rmSvc.getVendor(vendor_no);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("vlist", vlist); // 資料庫取出的empVO物件,存入req
				se.setAttribute("vendor_no", vendor_no);
				String url = "/Restaurant_Menu/listChoosed.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Restaurant_Menu/listAllMenus.jsp");
				failureView.forward(req, res);
			}
		}

		// 刪除一筆資料
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				String menu_no = req.getParameter("menu_no");

				/*************************** 2.開始刪除資料 ***************************************/
				Restaurant_MenuService rmSvc = new Restaurant_MenuService();
				rmSvc.deleteMenu(menu_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/Restaurant_Menu/listAllMenus.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Restaurant_Menu/listAllMenus.jsp");
				failureView.forward(req, res);
			}
		}

		if ("upMenu".equals(action)) {
			System.out.println("控制器觸發上傳圖片");

			try {
				/*************************** 1.接收請求參數 ****************************************/
				
				
				String menu_no = req.getParameter("menu_no");
				System.out.println(menu_no);
				
				Restaurant_MenuVO rmVO = new Restaurant_MenuVO();

				
				System.out.println(rmVO);
				// 上傳圖片
				byte[] menu_pic = null;
//				v_pic = ByteConvert.Base64Decode(req.getParameter("file"));
				String base64 = req.getParameter("file");

				menu_pic = Base64.getMimeDecoder().decode(base64.split(",")[1]);

				rmVO.setMenu_pic(menu_pic);
				System.out.println(menu_no);
				rmVO.setMenu_no(menu_no);

				
				Restaurant_MenuService rmSvc = new Restaurant_MenuService();
				rmVO = rmSvc.upPic(menu_pic, menu_no);

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
		
		if ("ajaxUp".equals(action)) {
			System.out.println("啟動ajax編輯區");

			try {
				/*************************** 1.接收請求參數 ****************************************/
				
				String menu_no = req.getParameter("menu_no");
				String menu_name = req.getParameter("menu_name");
				String menu_text = req.getParameter("menu_text");
				String menu_price = req.getParameter("menu_price");
				
				Restaurant_MenuVO rmVO = new Restaurant_MenuVO();
				
				System.out.println(menu_no);
				System.out.println(menu_name);
				System.out.println(menu_text);
				System.out.println(menu_price);
			
				rmVO.setMenu_no(menu_no);
				rmVO.setMenu_name(menu_name);
				rmVO.setMenu_text(menu_text);
				rmVO.setMenu_price(menu_price);
				Restaurant_MenuService rmSvc = new Restaurant_MenuService();
				rmVO = rmSvc.up3info(menu_name, menu_price, menu_text, menu_no);

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
		
		if ("ajaxStatu".equals(action)) {
			System.out.println("ajax狀態區");

			try {
				/*************************** 1.接收請求參數 ****************************************/
				
				String menu_no = req.getParameter("menu_no");
				Integer menu_stat = Integer.parseInt(req.getParameter("menu_stat"));
				Restaurant_MenuVO rmVO = new Restaurant_MenuVO();
				
				rmVO.setMenu_no(menu_no);
				rmVO.setMenu_stat(menu_stat);
				
				System.out.println(menu_stat);
				
				Restaurant_MenuService rmSvc = new Restaurant_MenuService();
				
				rmVO = rmSvc.upStatu(menu_stat, menu_no);

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
