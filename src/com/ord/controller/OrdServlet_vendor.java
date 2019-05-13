package com.ord.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.ord.model.OrdService;
import com.ord.model.OrdVO;
import com.ord_detail.model.Order_DetailService;
import com.ord_detail.model.Order_DetailVO;
import com.tables.controller.Bill;
import com.tables.controller.Tbls;

public class OrdServlet_vendor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		String action = req.getParameter("action");
		
		if ("getOrdByDate".equals(action)) {
			String vendor_no = req.getParameter("vendor_no");
			long date = Long.parseLong(req.getParameter("date"));
			OrdService ordService = new OrdService();
			List<OrdVO> list = ordService.getAllVendorDate(vendor_no, new java.sql.Date(date));
			
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
			String jsonStr = gson.toJson(list);
			out.println(jsonStr);			
		}
		
		if ("getOrdListByVerifCode".equals(action)) {
			String vendor_no = req.getParameter("vendor_no");
			String verif_code = req.getParameter("verif_code");
			OrdService ordService = new OrdService();
			List<OrdVO> list = ordService.getAllVendorVerif(vendor_no, verif_code);
			
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
			String jsonStr = gson.toJson(list);
			out.println(jsonStr);
		}
		
		if ("getOrdByVerifCode".equals(action)) {
			String vendor_no = req.getParameter("vendor_no");
			String verif_code = req.getParameter("verif_code");
			
			OrdService ordService = new OrdService();
			OrdVO ordVO = ordService.getOneOrdVerif(vendor_no, verif_code);
			
			Order_DetailService ord_DetailService = new Order_DetailService();
			List<Order_DetailVO> list =  ord_DetailService.findbyOrd_no(ordVO.getOrd_no());
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
				
			JsonElement jeOrd = gson.toJsonTree(ordVO);
			JsonElement jeOrdDetail = gson.toJsonTree(list);
			
			JsonObject joOrdAll = new JsonObject();
			joOrdAll.add("ord", jeOrd);
			joOrdAll.add("ord_detail", jeOrdDetail);
			String jsonStr = gson.toJson(joOrdAll);
			out.println(jsonStr);
			
		}
		
		if ("ordVerify".equals(action)) {
			String vendor_no = req.getParameter("vendor_no");
			String ord_no = req.getParameter("ord_no");
			OrdService ordService = new OrdService();
			OrdVO ordVO = ordService.getOneOrd(ord_no);
			
			JsonObject jbMsg = new JsonObject();			
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HHmm z");
			java.util.Date bookingTimestamp = null;
			try {
				bookingTimestamp = format.parse(ordVO.getBooking_date().toString() + " " +  ordVO.getBooking_time() + " GMT+8:00");
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			String result = null;
			Integer status = null;
			
			switch (ordVO.getStatus()) {
			case 1:
//				ordStatus = "已付款";
				// 預定時間的前後 10 min 可驗證
				int tlim = 10 * 60 * 1000;
				long diff = System.currentTimeMillis() - bookingTimestamp.getTime();
				if (diff > tlim) {
					status = 5;
					ordVO.setStatus(status);
					ordService.updateOrdStatus(ordVO.getOrd_no(), status);
					
					result = "遲到超過 10 分鐘, 序號已失效";
				} else if (diff < -tlim) {
					result = "離預定時間過早, 無法核銷序號";
				} else {
					status = 4;
					ordVO.setStatus(status);
					ordService.updateOrdStatus(ordVO.getOrd_no(), status);				
					result = "核銷成功";
					
					// 轉去 桌位管理 已驗證
					Map<String, Tbls> tbls_all = (Map) getServletContext().getAttribute("tbls_all");
					if (tbls_all != null) {
						Tbls vendor_tbls = (Tbls) tbls_all.get(vendor_no);				
						if (vendor_tbls != null) {	
							Bill bill = new Bill(ordVO);					
							synchronized(vendor_tbls) {
								vendor_tbls.getBills().put(bill.getBill_no(), bill);
								// push to vendor
							}
							
						} else {
							System.out.println(vendor_no + " 桌位管理功能未初始化");
						}
					} else {
						System.out.println(vendor_no + " server 桌位管理功能未初始化");
					}
					// push to vendor
				}
				break;
			case 2:
//				ordStatus = "已取消";
				result = "訂單已取消, 序號已失效";
				break;
			case 3:
//				ordStatus = "待付款";
				result = "訂單未付款, 無法核銷";
				break;
			case 4:
//				ordStatus = "已核銷";
				result = "序號已經核銷, 無法再次核銷";
				break;
			case 5:
//				ordStatus = "已失效";
				result = "序號已失效, 無法核銷";				
				break;
			default:
//				ordStatus = "未定義";
				result = "訂單狀態不明, 無法核銷";
			}
			
			jbMsg.addProperty("result", result);
			jbMsg.addProperty("status", status);
			String jsonStr = jbMsg.toString();
			out.print(jsonStr);

		}
		
		if ("updateTbl_no".equals(action)) {
			String ord_no = req.getParameter("ord_no");
			String tbl_no = req.getParameter("tbl_no"); // null
			
			OrdService ordService = new OrdService();
			
			JsonObject jbMsg = new JsonObject();
			
			Integer status = null;
			String result = null;
			
			try {
				ordService.updateOrdTblNo(ord_no, tbl_no);				
				result = "訂單桌位修改成功";
				status = 1;
			} catch (Exception e) {
				result = "訂單桌位修改失敗:"+e.getMessage();
				status = 0;
			}
			
			jbMsg.addProperty("result", result);
			jbMsg.addProperty("status", status);
			String jsonStr = jbMsg.toString();
			out.print(jsonStr);
			
			
			
			
		}
		
	}

}