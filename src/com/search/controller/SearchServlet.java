package com.search.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
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
import com.employee.model.EmployeeService;
import com.google.gson.Gson;
import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.member_wallet_list.model.Member_Wallet_ListService;
import com.member_wallet_list.model.Member_Wallet_ListVO;
import com.ord.model.OrdService;
import com.ord.model.OrdVO;
import com.vendor.model.VendorService;
import com.vendor.model.VendorVO;

import tools.MailService;
import tools.RedisTTL;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class SearchServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		System.out.println("controllercontroller");
		String action = req.getParameter("action");

		if ("meminfo".equals(action)) {

			try {
				HttpSession se = req.getSession();
				MemberService mSvc = new MemberService();
				MemberVO memberVO = (MemberVO) se.getAttribute("memberVO");
				OrdService oSvc = new OrdService();
				CommentsService cSvc = new CommentsService();
				VendorService vSvc = new VendorService();

				String selectmem = req.getParameter("seletcted_mem");
				MemberVO select_mVO = mSvc.getOneMember(selectmem);
				List<OrdVO> selectmemOrd = oSvc.getAll().stream().filter(o -> o.getMem_no().equals(selectmem))
						.collect(Collectors.toList());
				List<CommentsVO> selectmemComm = new ArrayList<>();
				Map<VendorVO, CommentsVO> vcMap = new LinkedHashMap<>();
				for (OrdVO oVO : selectmemOrd) {

					CommentsVO cVO = cSvc.getAll().stream().filter(c -> c.getOrd_no().equals(oVO.getOrd_no()))
							.findFirst().get();
					VendorVO vVO = vSvc.findByPK(cVO.getVendor_no());

					vcMap.put(vVO, cVO);

				}

				if (memberVO != null) {
					String mem_no = memberVO.getMem_no();
					if (mem_no.equals(selectmem)) {
						req.setAttribute("self", true);
					}
				}

				req.setAttribute("select_mVO", select_mVO);
				req.setAttribute("vcMap", vcMap);
				req.setAttribute("selectmemOrd", selectmemOrd);

				String url = "/front-end/motherboard.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_emp_input.jsp
				successView.forward(req, res);
			} catch (Exception e) {
				System.out.println("-----------------------錯誤-------------------");
				e.printStackTrace();
			}
		}
		
		
		if ("mem_result".equals(action)) {
			Gson gson = new Gson();
			List<String> errorMsgs = new LinkedList<String>();
			req.removeAttribute("errorMsgs");
			
			try {
				HttpSession session = req.getSession();
				String flag = req.getParameter("flag");
				String preFlag = (String) session.getAttribute("flag");
				
				if(flag.equals(preFlag)) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/FrontPage.jsp?");
					failureView.forward(req, res);
					return;// 程式中斷
				}else {
					session.setAttribute("flag", flag);
				}
				
				
				String mem_account_nickname = req.getParameter("mem_account_nickname");

				if (mem_account_nickname == null || (mem_account_nickname.trim()).length() == 0) {
					errorMsgs.add("請輸入會員帳號或暱稱");
				}
				if (!errorMsgs.isEmpty()) {
					String jerrorMsgs = gson.toJson(errorMsgs);
					req.setAttribute("errorMsgs", jerrorMsgs);
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/FrontPage.jsp?");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				MemberService memberSvc = new MemberService();
				MemberVO memberVO = memberSvc.getOneMemberByAccount(mem_account_nickname);
				List<MemberVO> memberList = new ArrayList<>();
				if(memberVO==null) {
					memberList = memberSvc.getOneMemberByNickname(mem_account_nickname);
					if(memberList.size()==0) {
						errorMsgs.add("查無此會員");
					}
				}else {
					memberList.add(memberVO);
				}
				
				if (!errorMsgs.isEmpty()) {
					String jerrorMsgs = gson.toJson(errorMsgs);
					req.setAttribute("errorMsgs", jerrorMsgs);
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/FrontPage.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}


				req.setAttribute("mem123", memberList);
				String url = "/front-end/motherboard.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_emp_input.jsp
				successView.forward(req, res);
				System.out.println("555");
			} catch (Exception e) {
				System.out.println("666");
				System.out.println("-----------------ssssss----錯誤-------------------");
				errorMsgs.add(e.getMessage());
				String jerrorMsgs = gson.toJson(errorMsgs);
				req.setAttribute("errorMsgs", jerrorMsgs);
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/FrontPage.jsp");
				failureView.forward(req, res);
			}
		}
		
		

	}
}
