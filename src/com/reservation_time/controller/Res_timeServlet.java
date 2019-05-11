package com.reservation_time.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.exception_date.model.Exception_DateDAO;
import com.exception_date.model.Exception_DateService;
import com.exception_date.model.Exception_DateVO;
import com.reservation_table_number.model.Reservation_Table_NumberService;
import com.reservation_table_number.model.Reservation_Table_NumberVO;
import com.reservation_time.model.Reservation_TimeDAO;
import com.reservation_time.model.Reservation_TimeService;
import com.reservation_time.model.Reservation_TimeVO;


public class Res_timeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				String vendor_no = req.getParameter("vendor_no");
				
				/***************************2.開始刪除資料***************************************/
				Reservation_TimeService res_timeSvc = new Reservation_TimeService();
				Exception_DateService exception_dateSvs = new Exception_DateService();
				Reservation_Table_NumberService res_t_nSvc=new Reservation_Table_NumberService();
				
				
				String rt_no[]=req.getParameterValues("rt_no");
				String exc_no[]=req.getParameterValues("exc_no");
				String rtn_no= req.getParameter("rtn_no").trim();
				
				for(int i =0;i<rt_no.length;i++) {
					res_timeSvc.deleteReservation_timeDAO(rt_no[i]);
				}
				for(int i =0;i<exc_no.length;i++) {
					exception_dateSvs.deleteException_date(exc_no[i]);
				}
				
				res_t_nSvc.deleteReservation_Table_Number(rtn_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/emp/listAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				System.out.println("url="+url);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/emp/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		//新增廠商可預訂時段/不可訂位日期/可訂位桌數
		if ("get_vendor_insert".equals(action)) {
			
//			Reservation_TimeVO res_timeVO = new Reservation_TimeVO();
			Reservation_TimeService res_timeSvc = new Reservation_TimeService();
			
//			Exception_DateVO exception_dateVO = new Exception_DateVO();
			Exception_DateService exception_dateSvs = new Exception_DateService();
			
			Reservation_Table_NumberService res_t_nSvc=new Reservation_Table_NumberService();
			
			String vendor_no=req.getParameter("vendor_no");
		
			//取得廠商輸入的開放訂位時段,並且過濾重複的以及空值
			LinkedHashSet<String> rt_list =new LinkedHashSet<String>();
			String open_hours[]=req.getParameterValues("open_hours");
			if(open_hours.length==0) {
				
			}
			for(int i= 0;i<open_hours.length;i++) {
				if(open_hours[i].length()!=0&&open_hours[i]!="")
				rt_list.add(open_hours[i]);
			}
			for(String rt_time:rt_list ) {
				res_timeSvc.addReservation_time(vendor_no, rt_time);
			}		
			
			//取得廠商輸入的不開放訂位日期,並且過濾重複的以及空值insert到資料庫
			LinkedHashSet<String> exc_list =new LinkedHashSet<String>();
			String exc_date[]=req.getParameterValues("exc_date");
			for(int i=0;i<exc_date.length;i++) {
				if(exc_date[i].length()!=0&&exc_date[i]!="") {
					exc_list.add(exc_date[i]);
				}
				for(String exc_date1 :exc_list) {
					exception_dateSvs.addException_date(vendor_no,java.sql.Date.valueOf(exc_date1));
				}
				
			}
			
			//取得廠商輸入的桌位數量，並且insert到資料庫
			
			Integer rtbl_o_num1=null;
			Integer rtbl_o_num2=null;
			Integer rtbl_o_num3=null;
			Integer rtbl_o_num4=null;
			Integer rtbl_o_num5=null;
			
			try {
				rtbl_o_num1 = Integer.valueOf((req.getParameter("rtbl_o_num1")).trim());
			} catch (Exception e) {
				rtbl_o_num1=0;
			}
			
			try {
				rtbl_o_num2 = Integer.valueOf((req.getParameter("rtbl_o_num2")).trim());
			} catch (Exception e) {
				rtbl_o_num2=0;
			}
			
			try {
				rtbl_o_num3 = Integer.valueOf((req.getParameter("rtbl_o_num3")).trim());
			} catch (Exception e) {
				rtbl_o_num3=0;
			}	 
			 
			try {
				rtbl_o_num4 = Integer.valueOf((req.getParameter("rtbl_o_num4")).trim());
			} catch (Exception e) {
				rtbl_o_num4=0;
			}
			try {
				rtbl_o_num5 = Integer.valueOf((req.getParameter("rtbl_o_num5")).trim());
			} catch (Exception e) {
				rtbl_o_num5=0;
			}
			
			
			res_t_nSvc.addReservation_Table_Number(vendor_no, rtbl_o_num1, rtbl_o_num2, rtbl_o_num3, rtbl_o_num4, rtbl_o_num5);
			
		}
		
		
		
		//更新廠商可預訂時段/不可訂位日期/可訂位桌數
				if ("get_vendor_update".equals(action)) {
						List<String> errorMsgs = new LinkedList<String>();
						// Store this set in the request scope, in case we need to
						// send the ErrorPage view.
						req.setAttribute("errorMsgs", errorMsgs);

						try {
							/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
							String vendor_no = req.getParameter("vendor_no");
							if (vendor_no == null || (vendor_no.trim()).length() == 0) {
								errorMsgs.add("請輸入廠商編號");
							}
							// Send the use back to the form, if there were errors
							if (!errorMsgs.isEmpty()) {
								RequestDispatcher failureView =
		req.getRequestDispatcher("/emp/select_page.jsp");//設定到首頁
								failureView.forward(req, res);
								return;//程式中斷
							}
							
							// Send the use back to the form, if there were errors
							if (!errorMsgs.isEmpty()) {
								RequestDispatcher failureView = 
		req.getRequestDispatcher("/emp/select_page.jsp");//跳轉回首頁
								failureView.forward(req, res);
								return;//程式中斷
							}
							
							/***************************2.開始查詢資料*****************************************/
							//Reservation_Time
							Reservation_TimeService res_timeSvc = new Reservation_TimeService();
							List<Reservation_TimeVO> reservation_TimeVO  = res_timeSvc.finby_v_no(vendor_no);
							if (reservation_TimeVO == null) {
								errorMsgs.add("查無資料");
							}
							// Send the use back to the form, if there were errors
							if (!errorMsgs.isEmpty()) {
								RequestDispatcher failureView = 
	req.getRequestDispatcher("/emp/select_page.jsp");//轉回首頁
								failureView.forward(req, res);
								return;//程式中斷
							}
							
							//Exception_Date
							Exception_DateService exception_dateSvc=new Exception_DateService()	;
							List<Exception_DateVO> exception_dateVO  = exception_dateSvc.find_by_vendor_no(vendor_no);
							if (exception_dateVO == null) {
								errorMsgs.add("查無資料");
							}
							// Send the use back to the form, if there were errors
							if (!errorMsgs.isEmpty()) {
								RequestDispatcher failureView = 
	req.getRequestDispatcher("/emp/select_page.jsp");//轉回首頁
								failureView.forward(req, res);
								return;//程式中斷
							}
							
							//reservation_Table_Number
							Reservation_Table_NumberService res_t_nSvc=new Reservation_Table_NumberService();
							List<Reservation_Table_NumberVO>reservation_Table_NumberVO = res_t_nSvc.findBy_vendor(vendor_no);
							if (reservation_Table_NumberVO == null) {
								errorMsgs.add("查無資料");
							}
							// Send the use back to the form, if there were errors
							if (!errorMsgs.isEmpty()) {
								RequestDispatcher failureView = 
	req.getRequestDispatcher("/emp/select_page.jsp");//轉回首頁
								failureView.forward(req, res);
								return;//程式中斷
							}	
									
									
							/***************************3.查詢完成,準備轉交(Send the Success view)*************/
							req.setAttribute("exception_dateVO", exception_dateVO);
							req.setAttribute("reservation_TimeVO", reservation_TimeVO); // 資料庫取出的empVO物件,存入req
							req.setAttribute("reservation_Table_NumberVO", reservation_Table_NumberVO);
							String url = "/open_time/update_time.jsp";
							RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
							successView.forward(req, res);

							/***************************其他可能的錯誤處理*************************************/
						} catch (Exception e) {
							errorMsgs.add("無法取得資料:" + e.getMessage());
							RequestDispatcher failureView = 
req.getRequestDispatcher("/emp/select_page.jsp");//回首頁
							failureView.forward(req, res);
						}
					}
					
				
				
				
				if ("update_open_time".equals(action)) { // 來自update_emp_input.jsp的請求
					
					List<String> errorMsgs = new LinkedList<String>();
					// Store this set in the request scope, in case we need to
					// send the ErrorPage view.
					req.setAttribute("errorMsgs", errorMsgs);
				
					try {
						/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
						String  vendor_no = req.getParameter("vendor_no").trim();

//						Reservation_TimeVO reservation_timeVO=new Reservation_TimeVO();

						//取得廠商輸入的開放訂位時段,並且過濾重複的以及空值
						//=====可訂時段=======
						LinkedHashSet<String> rt_list =new LinkedHashSet<String>();
						String open_hours[]=req.getParameterValues("open_hours");
						String rt_no[]=req.getParameterValues("rt_no");
						
						/***************************2.開始修改資料*****************************************/
						for(int i =0;i<rt_no.length;i++) {
							for(int j=0;j<open_hours.length;j++) {
								System.out.println("open_hours[j]========="+open_hours[j]);
								Reservation_TimeVO reservation_timeVO=new Reservation_TimeVO();
								reservation_timeVO.setR_time(open_hours[i]);
								reservation_timeVO.setRt_no(rt_no[i]);
								reservation_timeVO.setVendor_no(vendor_no);
								Reservation_TimeDAO r_tDAO=new Reservation_TimeDAO();
								r_tDAO.update(reservation_timeVO);
//								Reservation_TimeService res_timeSvc = new Reservation_TimeService();
//								reservation_timeVO=res_timeSvc.updateReservation_timeDAO(rt_no[i], vendor_no, open_hours[j]);
							}
						}	
						
						
						//=======不營業日期=======
						LinkedHashSet<String> exc_list =new LinkedHashSet<String>();
						String exc_no[]=req.getParameterValues("exc_no");
						String exc_date[]=req.getParameterValues("exc_date");
						/***************************2.開始修改資料*****************************************/
						for(int j=0;j<exc_no.length;j++) {
							for(int i=0;i<exc_date.length;i++) {
								Exception_DateVO exception_dateVO = new Exception_DateVO();
								exception_dateVO.setExc_date(java.sql.Date.valueOf(exc_date[j]));
								exception_dateVO.setExc_no(exc_no[j]);
								exception_dateVO.setVendor_no(vendor_no);
								Exception_DateDAO e_dDAO=new Exception_DateDAO();
								e_dDAO.update(exception_dateVO);
//								Exception_DateService exception_dateSvs = new Exception_DateService();	
//							exception_dateSvs.updateException_date(exc_no[i], vendor_no, java.sql.Date.valueOf(exc_date[i]));
							}
						}
						
						//=========可訂桌數==========
						Reservation_Table_NumberService res_t_nSvc=new Reservation_Table_NumberService();
						String rtn_no= req.getParameter("rtn_no").trim();
						
						Integer rtbl_o_num1=null;
						Integer rtbl_o_num2=null;
						Integer rtbl_o_num3=null;
						Integer rtbl_o_num4=null;
						Integer rtbl_o_num5=null;
						
						try {
							rtbl_o_num1 = Integer.valueOf((req.getParameter("rtbl_o_num1")).trim());
						} catch (Exception e) {
							rtbl_o_num1=0;
						}
						
						try {
							rtbl_o_num2 = Integer.valueOf((req.getParameter("rtbl_o_num2")).trim());
						} catch (Exception e) {
							rtbl_o_num2=0;
						}
						
						try {
							rtbl_o_num3 = Integer.valueOf((req.getParameter("rtbl_o_num3")).trim());
						} catch (Exception e) {
							rtbl_o_num3=0;
						}	 
						 
						try {
							rtbl_o_num4 = Integer.valueOf((req.getParameter("rtbl_o_num4")).trim());
						} catch (Exception e) {
							rtbl_o_num4=0;
						}
						try {
							rtbl_o_num5 = Integer.valueOf((req.getParameter("rtbl_o_num5")).trim());
						} catch (Exception e) {
							rtbl_o_num5=0;
						}
						/***************************2.開始修改資料*****************************************/
						
						res_t_nSvc.updateReservation_Table_Number(rtn_no, vendor_no, rtbl_o_num1, rtbl_o_num2, rtbl_o_num3, rtbl_o_num4, rtbl_o_num5);
						
					
//						String ename = req.getParameter("ename");
//						String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
//						if (ename == null || ename.trim().length() == 0) {
//							errorMsgs.add("員工姓名: 請勿空白");
//						} else if(!ename.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//							errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//			            }
//						
//						String job = req.getParameter("job").trim();
//						if (job == null || job.trim().length() == 0) {
//							errorMsgs.add("職位請勿空白");
//						}	
//						
//						java.sql.Date hiredate = null;
//						try {
//							hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
//						} catch (IllegalArgumentException e) {
//							hiredate=new java.sql.Date(System.currentTimeMillis());
//							errorMsgs.add("請輸入日期!");
//						}
//
//						Double sal = null;
//						try {
//							sal = new Double(req.getParameter("sal").trim());
//						} catch (NumberFormatException e) {
//							sal = 0.0;
//							errorMsgs.add("薪水請填數字.");
//						}
//
//						Double comm = null;
//						try {
//							comm = new Double(req.getParameter("comm").trim());
//						} catch (NumberFormatException e) {
//							comm = 0.0;
//							errorMsgs.add("獎金請填數字.");
//						}
//
//						Integer deptno = new Integer(req.getParameter("deptno").trim());
//
//						EmpVO empVO = new EmpVO();
//						empVO.setEmpno(empno);
//						empVO.setEname(ename);
//						empVO.setJob(job);
//						empVO.setHiredate(hiredate);
//						empVO.setSal(sal);
//						empVO.setComm(comm);
//						empVO.setDeptno(deptno);
//
//						// Send the use back to the form, if there were errors
						if (!errorMsgs.isEmpty()) {
//							req.setAttribute("empVO", empVO); // 含有輸入格式錯誤的empVO物件,也存入req
							RequestDispatcher failureView = req
									.getRequestDispatcher("/emp/update_emp_input.jsp");
							failureView.forward(req, res);
							return; //程式中斷
						}
//						
//						
//						EmpService empSvc = new EmpService();
//						empVO = empSvc.updateEmp(empno, ename, job, hiredate, sal,comm, deptno);
//						
						/***************************3.修改完成,準備轉交(Send the Success view)*************/
//					req.setAttribute("empVO", empVO); // 資料庫update成功後,正確的的empVO物件,存入req
					String url = "/emp/listOneEmp.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
						successView.forward(req, res);
//
//						/***************************其他可能的錯誤處理*************************************/
					} catch (Exception e) {
						errorMsgs.add("修改資料失敗:"+e.getMessage());
						RequestDispatcher failureView = 
req.getRequestDispatcher("/ord/update_emp_input.jsp");//導回
						failureView.forward(req, res);
					}
				}	
					
}
				
		

		
		
	


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		doGet(req, res);
	}

}
