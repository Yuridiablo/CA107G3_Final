package com.employee.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;



import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;
import com.feature_detail.model.Feature_detailService;
import com.feature_detail.model.Feature_detailVO;
import com.member.model.MemberService;
import com.member.model.MemberVO;

import com.news.model.NewsService;
import com.news.model.NewsVO;

import tools.MailService;


@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class EmployeeServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");
		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String emp_name = req.getParameter("emp_name");
				String emp_nameReg = "^[\u4E00-\u9FA5]{2,3}$";
				if (emp_name == null || (emp_name.trim()).length() == 0) {
					errorMsgs.add("請輸入姓名");
				} else if (!emp_name.trim().matches(emp_nameReg)) {
					errorMsgs.add("姓名只能填入2~4個中文字");
				}
				
				String emp_sex = req.getParameter("emp_sex");
				if (emp_sex == null) {
					errorMsgs.add("請選擇稱謂");
				}
				
				String emp_acc = req.getParameter("emp_acc");
				String emp_accReg = "^(?=.*\\d)(?=.*[A-za-z]).{6,10}$";
				if (emp_acc == null || (emp_acc.trim()).length() == 0) {
					errorMsgs.add("請填寫帳號");
				} else if (!emp_acc.trim().matches(emp_accReg)) {
					errorMsgs.add("請填寫6-10位混和英數字,英文需區分大小寫");
				}
				
				String emp_mail = req.getParameter("emp_acc");
				if (emp_acc == null || (emp_acc.trim()).length() == 0) {
					errorMsgs.add("請填寫帳號");
				} 
				
				java.sql.Date emp_hire = null;
				try {
					emp_hire = java.sql.Date.valueOf(req.getParameter("emp_hire").trim());
				} catch (IllegalArgumentException e) {
					emp_hire=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				String emp_permission = req.getParameter("emp_permission");
				
				EmployeeVO employeeVO = new EmployeeVO();
				employeeVO.setEmp_acc(emp_acc);
				employeeVO.setEmp_mail(emp_mail);
				employeeVO.setEmp_hire(emp_hire);
				employeeVO.setEmp_name(emp_name);
				employeeVO.setEmp_sex(emp_sex);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("employeeVO", employeeVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/employeePage/addEmployee.jsp");
					failureView.forward(req, res);
					return;
				}
				
				//===========================產生隨機密碼======================
					Random random = new Random();
					StringBuilder sb = new StringBuilder();
					sb.append("E");
					for(int i=0;i<=5;i++) {
						sb.append(random.nextInt(10));
					}
					String emp_pwd = sb.toString();
				//===========================產生隨機密碼======================
					
				//=========================寄送郵件=============================
					String to = "ciguana1995@gmail.com";
			      
			      String subject = "密碼通知";
			      
			      String ch_name = emp_name;
			      String passRandom = emp_pwd;
			      String messageText = "Hello! " + ch_name+"\r\n" + " 請謹記此密碼: " + passRandom + "\n" +" (已經啟用)"; 
			       
			      MailService mailService = new MailService();
			      mailService.sendMail(to, subject, messageText);
				//=========================寄送郵件=============================	
				
				EmployeeService employeeSvc = new EmployeeService();
				employeeSvc.addEmployee(emp_name, emp_sex,emp_mail, emp_acc, emp_pwd, emp_hire);
				employeeVO = employeeSvc.getOneEmployeeByAccount(emp_acc);
				List<EmployeeVO> list = employeeSvc.getOneEmployeeByName(emp_name);
				
				Feature_detailService feaSvc = new Feature_detailService();
				String emp_no = employeeVO.getEmp_no();
				if(emp_permission.equals("3")||emp_permission.equals("2")||emp_permission.equals("1")) {
					
					feaSvc.addFeature_detail("F009", emp_no);
					feaSvc.addFeature_detail("F003", emp_no);
					feaSvc.addFeature_detail("F004", emp_no);
					feaSvc.addFeature_detail("F005", emp_no);
					if(emp_permission.equals("2")||emp_permission.equals("1")) {
						feaSvc.addFeature_detail("F001", emp_no);
						feaSvc.addFeature_detail("F006", emp_no);
						feaSvc.addFeature_detail("F007", emp_no);
						feaSvc.addFeature_detail("F008", emp_no);
						if(emp_permission.equals("1")) {
							feaSvc.addFeature_detail("F002", emp_no);
						}
					}
				}
				
				req.setAttribute("list", list);
				req.setAttribute("listAllEmp", "listAllEmp");
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
			}catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/employeePage/addEmployee.jsp");
				failureView.forward(req, res);
			}
		}
		if ("listAllEmp".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				
				EmployeeService employeeSvc = new EmployeeService();
				List<EmployeeVO> list = employeeSvc.getAll();
				req.setAttribute("listAllEmp", list);
				
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("listEmpByName".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				
				String emp_name = req.getParameter("emp_name");
				String emp_nameReg = "^[\u4E00-\u9FA5]{2,4}$";
				if (emp_name == null || (emp_name.trim()).length() == 0) {
					errorMsgs.add("請輸入姓名");
				} else if (!emp_name.trim().matches(emp_nameReg)) {
					errorMsgs.add("姓名只能填入2~4個中文字");
				}
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("errorPage","errorPage");
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;
				}
				
				emp_name = emp_name.trim();
				
				EmployeeService employeeSvc = new EmployeeService();
				List<EmployeeVO> list = employeeSvc.getOneEmployeeByName(emp_name);
				if(list.size()==0) {
					errorMsgs.add("無此員工");
				}
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("errorPage","errorPage");
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;
				}
				
				req.setAttribute("list", list);
				req.setAttribute("listAllEmp", "listAllEmp");
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("addEmp".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				
				req.setAttribute("addEmp","addEmp");
				
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("resignEmp".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String emp_no = req.getParameter("emp_no");
				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.getOneEmployee(emp_no);
				employeeSvc.updateEmployee(emp_no, employeeVO.getEmp_name(), employeeVO.getEmp_sex(), employeeVO.getEmp_acc()
						, employeeVO.getEmp_pwd(), employeeVO.getEmp_hire(), new java.sql.Date(System.currentTimeMillis()), 2);
				List<EmployeeVO> list = employeeSvc.getOneEmployeeByName(employeeVO.getEmp_name());
				req.setAttribute("listAllEmp", "listAllEmp");
				req.setAttribute("list", list);
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("updateEmp".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String emp_no = req.getParameter("emp_no");
				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.getOneEmployee(emp_no);
				req.setAttribute("updateEmp", "updateEmp");
				req.setAttribute("employeeVO", employeeVO);
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				
				java.sql.Date emp_resign = null;
				if(req.getParameter("emp_resign")!=null) {
				try {				
					emp_resign = java.sql.Date.valueOf(req.getParameter("emp_resign").trim());
				} catch (IllegalArgumentException e) {
					emp_resign= java.sql.Date.valueOf(req.getParameter("emp_resign_preanswer").trim());
					errorMsgs.add("日期格式錯誤!");
				}
				}
				Integer emp_stat = new Integer(req.getParameter("emp_stat".trim()));
				
				
				EmployeeVO employeeVO = new EmployeeVO();
				
				if (!errorMsgs.isEmpty()) {
					employeeVO.setEmp_resign(emp_resign);
					employeeVO.setEmp_stat(emp_stat);
					req.setAttribute("employeeVO", employeeVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/employeePage/updateEmp.jsp");
					failureView.forward(req, res);
					return;
				}
				

				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.getOneEmployee(req.getParameter("emp_no"));
				if(emp_stat==1) {
					employeeVO = employeeSvc.updateEmployee(employeeVO.getEmp_no(), employeeVO.getEmp_name(), employeeVO.getEmp_sex(), employeeVO.getEmp_acc(), employeeVO.getEmp_pwd()
							, new java.sql.Date(System.currentTimeMillis()), null, emp_stat);
				}else {
					employeeVO = employeeSvc.updateEmployee(employeeVO.getEmp_no(), employeeVO.getEmp_name(), employeeVO.getEmp_sex(), employeeVO.getEmp_acc(), employeeVO.getEmp_pwd()
							,employeeVO.getEmp_hire(), new java.sql.Date(System.currentTimeMillis()), emp_stat);
				}
				
				List<EmployeeVO> list = new ArrayList<>();
				list.add(employeeVO);
				req.setAttribute("updateForEmp","updateForEmp");
				req.setAttribute("list", list);
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("listAllMem".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				MemberService memberSvc = new MemberService();
				List<MemberVO> list = memberSvc.getAll();
				req.setAttribute("listAllMem", list);
				
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("updateMem".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String mem_no = req.getParameter("mem_no");
				MemberService memberSvc = new MemberService();
				MemberVO memberVO = memberSvc.getOneMember(mem_no);
				req.setAttribute("updateMem", "updateMem");
				req.setAttribute("memberVO", memberVO);
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("updateForMem".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				
				String mem_nickname = req.getParameter("mem_nickname");
				String mem_nicknameReg = "^[\u4e00-\u9fa5_a-zA-Z0-9_]{2,10}$";
				if (mem_nickname == null || (mem_nickname.trim()).length() == 0) {
					errorMsgs.add("請輸入暱稱");
				} else if (!mem_nickname.trim().matches(mem_nicknameReg)) {
					errorMsgs.add("暱稱只能輸入2~10碼英數或中文");
				}
				
				String mem_pwd = req.getParameter("mem_pwd");
				String mem_pwdReg = "^(?=.*\\d)(?=.*[A-za-z]).{6,10}$";
				if (mem_pwd == null || (mem_pwd.trim()).length() == 0) {
					errorMsgs.add("請填寫密碼");
				} else if (!mem_pwd.trim().matches(mem_pwdReg)) {
					errorMsgs.add("請填寫6-10位混和英數字,英文需區分大小寫");
				}
				
				String mem_mail = req.getParameter("mem_mail");
				if (mem_mail == null || (mem_mail.trim()).length() == 0) {
					errorMsgs.add("請輸入電子信箱");
				}
				
				String mem_tel = req.getParameter("mem_tel");
				String mem_telReg = "^[0][9][0-9]{8}$";
				if (mem_tel == null || (mem_tel.trim()).length() == 0) {
					errorMsgs.add("請填寫手機號碼");
				} else if (!mem_tel.trim().matches(mem_telReg)) {
					errorMsgs.add("請填寫有效的手機號碼");
				}
				
				Double mem_balance= new Double(0);
				try {
					mem_balance = new Double(req.getParameter("mem_balance"));
				}catch(NumberFormatException e) {
					errorMsgs.add("錢包餘額只能填數字且不得空白");
				}
				
				String mem_status = req.getParameter("mem_status");
				
				MemberVO memberVO = new MemberVO();
				
				if (!errorMsgs.isEmpty()) {
					memberVO.setMem_name(req.getParameter("mem_name"));
					memberVO.setMem_nickname(mem_nickname);
					memberVO.setMem_account(req.getParameter("mem_account"));
					memberVO.setMem_pwd(mem_pwd);
					memberVO.setMem_mail(mem_mail);
					memberVO.setMem_tel(mem_tel);
					memberVO.setMem_balance(mem_balance);
					memberVO.setMem_status(mem_status);
					req.setAttribute("memberVO", memberVO);
					req.setAttribute("errorPageForUpdateMem","errorPage");
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;
				}
				
				
				MemberService memberSvc = new MemberService();
				memberVO = memberSvc.updateMemberWithoutPic(req.getParameter("mem_name"), mem_pwd,mem_mail, mem_tel, mem_status,mem_balance, mem_nickname, req.getParameter("mem_account"),req.getParameter("mem_no"));
				
				List<MemberVO> list = new ArrayList<>();
				list.add(memberVO);
				req.setAttribute("listAllMem", "listAllMem");
				req.setAttribute("list", list);
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("listMemByName".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				
				String mem_account_name = req.getParameter("mem_account_name");
				if (mem_account_name == null || (mem_account_name.trim()).length() == 0) {
					errorMsgs.add("請輸入查詢內容");
				}
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("errorPageForMem","errorPageForMem");
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;
				}
				
				mem_account_name = mem_account_name.trim();
				
				MemberService memberSvc = new MemberService();
				MemberVO memberVO = memberSvc.getOneMemberByAccount(mem_account_name);
				List<MemberVO> memberList = new ArrayList<>();
				
				if(memberVO==null) {
					
					memberList = memberSvc.getOneMemberByName(mem_account_name);
					if(memberList.size()==0) {
						errorMsgs.add("查無此會員");
					}
				}else {
					memberList.add(memberVO);
				}
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("errorPageForMem","errorPageForMem");
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;
				}

				req.setAttribute("list", memberList);
				req.setAttribute("listAllMem", "listAllMem");
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("login".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				System.out.println("==================================");
				String emp_acc = req.getParameter("emp_acc");
				
				String mem_accountReg = "^[0-9a-zA-z]{6,10}$";
				if (emp_acc == null || (emp_acc.trim()).length() == 0) {
					errorMsgs.add("請輸入帳號");
				} else if (!emp_acc.trim().matches(mem_accountReg)) {
					errorMsgs.add("帳號只能輸入數字及大小寫英文");
				}
				
				emp_acc = emp_acc.trim();

				String emp_pwd = req.getParameter("emp_pwd");
				String emp_pwdReg = "^[0-9a-zA-z]{6,10}$";
				if (emp_pwd == null || (emp_pwd.trim()).length() == 0) {
					errorMsgs.add("請輸入密碼");
				} else if (!emp_pwd.trim().matches(emp_pwdReg)) {
					errorMsgs.add("密碼必須輸入數字及英文的組合");
				}
				
				emp_pwd = emp_pwd.trim();

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.getOneEmployeeByAccount(emp_acc);

				if (employeeVO == null) {
					errorMsgs.add("無此帳號");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String emp_pwdConfirm = employeeVO.getEmp_pwd();
				if (!emp_pwd.equals(emp_pwdConfirm)) {
					errorMsgs.add("密碼錯誤");
				}
			
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
	
				Feature_detailService feaSvc = new Feature_detailService();
				List<Feature_detailVO> list = feaSvc.getAllFeature_detailByEmpno(employeeVO.getEmp_no());
				HttpSession session = req.getSession();
				session.setAttribute("account", req.getParameter("emp_acc"));
				System.out.println(session.getAttribute("account"));
				session.setAttribute("employeeVO", employeeVO);
			
				session.setAttribute("featureList", list);
				session.removeAttribute("reLogin");
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
				failureView.forward(req, res);

			}
		}
		if ("logout".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				HttpSession session = req.getSession();
				session.removeAttribute("account");
				session.removeAttribute("employeeVO");
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
			}catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
				failureView.forward(req, res);

			}
		}
		if ("listAllNews".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				req.setAttribute("listAllNews", "listAllNews");
				
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("getNewsPic".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String news_no = req.getParameter("news_no");
				req.setAttribute("news_no", news_no);
				req.setAttribute("listAllNews", "listAllNews");
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("addNews".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String news_cont = req.getParameter("news_cont");
				if (news_cont == null || (news_cont.trim()).length() == 0) {
					errorMsgs.add("請輸入消息標題");
				} 
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("listAllNews","listAllNews");
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				news_cont = news_cont.trim();
				
				Collection<Part> parts = req.getParts();

				byte[] news_pic = null;
				for (Part part : parts) {
					if (part.getName().equals("news_pic")) {
						InputStream in = part.getInputStream();
						ByteArrayOutputStream output = new ByteArrayOutputStream();
						news_pic = new byte[in.available()];
						for (int length = 0; (length = in.read(news_pic)) > 0;) {
							output.write(news_pic, 0, length);
						}
						output.close();
						in.close();
					}
				}
				
				NewsService newsSvc = new NewsService();
				HttpSession session = req.getSession();
				EmployeeVO employeeVO = (EmployeeVO)session.getAttribute("employeeVO");
				String emp_no = employeeVO.getEmp_no();
				newsSvc.addNews(emp_no, news_cont, news_pic,new java.sql.Date(System.currentTimeMillis()));
				NewsVO newsVO = newsSvc.getLatestNews();
				List<NewsVO> list = new ArrayList<NewsVO>();
				list.add(newsVO);
				req.setAttribute("list", list);
				req.setAttribute("listAllNews", "listAllNews");
				
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("listNewsBySerch".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String newsSerchValue = req.getParameter("newsSerchValue");
				if (newsSerchValue == null || (newsSerchValue.trim()).length() == 0) {
					errorMsgs.add("請輸入查詢內容");
				} 
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("listAllNews","listAllNews");
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				newsSerchValue = newsSerchValue.trim();
				
				NewsService newsSvc = new NewsService();
				EmployeeService employeeSvc = new EmployeeService();
				List<NewsVO> list = new ArrayList<>();
				NewsVO newsVO = newsSvc.getOneNews(newsSerchValue);
				List<EmployeeVO> empnameList = employeeSvc.getOneEmployeeByName(newsSerchValue);
				
				if(newsVO==null&&empnameList.size()==0) {
					errorMsgs.add("查無內容");
				}
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("listAllNews","listAllNews");
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				
				
				if(newsVO!=null) {
					list.add(newsVO);
				}else {
					if(empnameList.size()>1) {
						List<String> empnoList = new ArrayList<>();
						for(EmployeeVO empno:empnameList) {
							empnoList.add(empno.getEmp_no());
						}
						//考量同姓名員工因素
						for(int i=0;i<empnoList.size();i++) {
							List<NewsVO> newsList = newsSvc.getAllByEmp_no(empnoList.get(i));
							for(int j=0;j<newsList.size();j++) {
								list.add(newsList.get(j));
							}
						}
					}else {
						String emp_no = empnameList.get(0).getEmp_no();
						List<NewsVO> newsList = newsSvc.getAllByEmp_no(emp_no);
						for(int j=0;j<newsList.size();j++) {
							list.add(newsList.get(j));
						}
					}

				}
				
				if(list.size()==0) {
					errorMsgs.add("查無內容");
				}
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("listAllNews","listAllNews");
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employeeScreen.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				
				req.setAttribute("list",list);

				req.setAttribute("listAllNews", "listAllNews");
				
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
		if ("deleteNews".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String news_no = req.getParameter("news_no");
				
				NewsService newsSvc = new NewsService();
				newsSvc.deleteNews(news_no);
		
				req.setAttribute("listAllNews", "listAllNews");
				
				String url = "/back-end/employeeScreen.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
	}	
	
}