package com.ord.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.LinkedList;
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
import com.ord.model.OrdDAO;
import com.ord.model.OrdService;
import com.ord.model.OrdVO;
import com.ord_detail.controller.OdVOn;
import com.ord_detail.model.Order_DetailService;
import com.ord_detail.model.Order_DetailVO;
import com.restaurant_menu.model.Restaurant_MenuService;
import com.restaurant_menu.model.Restaurant_MenuVO;
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
			List<OrdVOn> list2 = new LinkedList<OrdVOn>();
			for(int i = 0; i < list.size(); i++) {
				list2.add(new OrdVOn(list.get(i)));
			}
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
			String jsonStr = gson.toJson(list2);
			out.println(jsonStr);			
		}
		
		if ("getOrdListByVerifCode".equals(action)) {
			String vendor_no = req.getParameter("vendor_no");
			String verif_code = req.getParameter("verif_code");
			OrdService ordService = new OrdService();
			List<OrdVO> list = ordService.getAllVendorVerif(vendor_no, verif_code);
			List<OrdVOn> list2 = new LinkedList<OrdVOn>();
			for(int i = 0; i < list.size(); i++) {
				list2.add(new OrdVOn(list.get(i)));
			}			
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
			String jsonStr = gson.toJson(list2);
			out.println(jsonStr);
		}
		
		if ("getOrdByVerifCode".equals(action)) {
			String vendor_no = req.getParameter("vendor_no");
			String verif_code = req.getParameter("verif_code");
			
			OrdService ordService = new OrdService();
			OrdVO ordVO = ordService.getOneOrdVerif(vendor_no, verif_code);
			OrdVOn ordVOn = new OrdVOn(ordVO);
			
			Order_DetailService ord_DetailService = new Order_DetailService();
			List<Order_DetailVO> list =  ord_DetailService.findbyOrd_no(ordVO.getOrd_no());
			List<OdVOn> list2 = new LinkedList<OdVOn>();
			for (int i = 0; i < list.size(); i++) {
				list2.add(new OdVOn(list.get(i)));
			}			
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
				
			JsonElement jeOrd = gson.toJsonTree(ordVOn);
			JsonElement jeOrdDetail = gson.toJsonTree(list2);
			
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
				long tlim = 2 * 24 * 60 * 60 * 1000;
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
						if (vendor_tbls == null) {	
							vendor_tbls = new Tbls(vendor_no);
							tbls_all.put(vendor_no, vendor_tbls);
						}
						Bill bill = new Bill(ordVO);					
						synchronized(vendor_tbls) {
							vendor_tbls.getBills().put(bill.getBill_no(), bill);
							// push to vendor
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
				String emsg = e.getMessage();
				if (emsg.contains("ORA-00001")) emsg = "該時段已安排訂單";
				result = "訂單桌位修改失敗: "+emsg;
				status = 0;
			}
			
			jbMsg.addProperty("result", result);
			jbMsg.addProperty("status", status);
			String jsonStr = jbMsg.toString();
			out.print(jsonStr);
			
			
			
			
		}
		
		if ("insertOrder".equals(action)) {
			String vendor_no = req.getParameter("vendor_no");

			
			List<Order_DetailVO> odList = new ArrayList<Order_DetailVO>();
			Integer total = 0;

			Restaurant_MenuService mms = new Restaurant_MenuService();
			List<Restaurant_MenuVO> mList = mms.getVendor(vendor_no);
			if (mList.size() == 0) {
				out.print("沒有菜，無法新增訂單");
				return;
			} 
			
			for (int i = 0; i < 3 && i < mList.size(); i++) {
				Restaurant_MenuVO rmVO = mList.get(i);
				Order_DetailVO odVO = new Order_DetailVO();
				odVO.setMenu_no(rmVO.getMenu_no());
				odVO.setPrice(Integer.parseInt(rmVO.getMenu_price()));
				odVO.setQty(1);
				odList.add(odVO);
				total += Integer.parseInt(rmVO.getMenu_price());
			}
			SimpleDateFormat format = new SimpleDateFormat("HHmm");
			OrdVO ordVO1 = new OrdVO();
			ordVO1.setMem_no("M000001");
			ordVO1.setVendor_no(vendor_no);
			ordVO1.setParty_size(new Integer(3));
			ordVO1.setOrd_time(new java.sql.Timestamp(System.currentTimeMillis()));
			ordVO1.setBooking_date(new java.sql.Date(System.currentTimeMillis()));
			ordVO1.setBooking_time(format.format(new java.util.Date()));
			ordVO1.setTotal(total);
			ordVO1.setVerif_code("qL62THYwvZuVkka2aDTt");
			ordVO1.setStatus(new Integer(1));
			
			Base64.Encoder be = Base64.getEncoder();
			OrdDAO ordDAO = new OrdDAO();			
			ordVO1 = ordDAO.insertWithOrd_detail(ordVO1, odList);
			String verif_code = be.encodeToString(ordVO1.getVerif_code().getBytes());
			verif_code = verif_code.substring(verif_code.length()-20, verif_code.length());
			ordVO1.setVerif_code(verif_code);
			ordDAO.updateVerif_Code(ordVO1);
			
			out.print("新增訂單成功! 驗證碼: " + verif_code);
		}
		
	}

}
