package android.ord.controller;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

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

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.tables.controller.Bill;
import com.tables.controller.Tbls;

import android.member.Util.ImageUtil;
import android.ord.model.OrdService;
import android.vendor.model.*;

//@WebServlet("/VendorServlet")
//@MultipartConfig
public class OrdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		System.out.println("doPost");

		req.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		BufferedReader br = req.getReader();
		StringBuilder jsonIn = new StringBuilder();
		String line = null;
		while ((line = br.readLine()) != null) {
			jsonIn.append(line);
		}
		System.out.println("input: " + jsonIn);

		OrdService ordSvc = new OrdService();

		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);

		String ord_no = jsonObject.get("ord_no").getAsString();
		String mem_no = jsonObject.get("mem_no").getAsString();
		String vendor_no = jsonObject.get("vendor_no").getAsString();
		String verif_code = jsonObject.get("verif_code").getAsString();



		if (ordSvc.isOrd(ord_no, mem_no, vendor_no, verif_code)) {
			writeText(res, String.valueOf(ordSvc.isOrd(ord_no, mem_no, vendor_no, verif_code)));
			
			
			
			com.ord.model.OrdService oscv = new com.ord.model.OrdService();
			com.ord.model.OrdVO ordVO = oscv.getOneOrd(ord_no);
			oscv.updateOrdStatus(ord_no, 4);
			
			// 轉至桌位
			Map<String, Tbls> tbls_all = (Map) getServletContext().getAttribute("tbls_all");
			
			
			if (tbls_all != null) {
				System.out.println("------");
				
				Tbls vendor_tbls = (Tbls) tbls_all.get(vendor_no);
				if (vendor_tbls == null) {
					vendor_tbls = new Tbls(vendor_no);
					tbls_all.put(vendor_no, vendor_tbls);
				}
				Bill bill = new Bill(ordVO);
				synchronized (vendor_tbls) {
					vendor_tbls.getBills().put(bill.getBill_no(), bill);
					// push to vendor
				}

			} else {
				System.out.println("####");
				System.out.println(vendor_no + " server 桌位管理功能未初始化");
			}

			
			
			
			
		} else {
			writeText(res, String.valueOf("false"));
		}

//		if (action.equals("checkok")) {
//
//			com.ord.model.OrdService oscv = new com.ord.model.OrdService();
//			String ord_no = jsonObject.get("ord_no").getAsString();
//			String vendor_no = jsonObject.get("vendor_no").getAsString();
//			com.ord.model.OrdVO ordVO = oscv.getOneOrd(ord_no);
//
//			// 轉至桌位
//			Map<String, Tbls> tbls_all = (Map) getServletContext().getAttribute("tbls_all");
//			if (tbls_all != null) {
//				Tbls vendor_tbls = (Tbls) tbls_all.get(vendor_no);
//				if (vendor_tbls == null) {
//					vendor_tbls = new Tbls(vendor_no);
//					tbls_all.put(vendor_no, vendor_tbls);
//				}
//				Bill bill = new Bill(ordVO);
//				synchronized (vendor_tbls) {
//					vendor_tbls.getBills().put(bill.getBill_no(), bill);
//					// push to vendor
//				}
//
//			} else {
//				System.out.println(vendor_no + " server 桌位管理功能未初始化");
//			}
//
//		}

	}

	private void writeText(HttpServletResponse res, String outText) throws IOException {
		res.setContentType(CONTENT_TYPE);
		PrintWriter out = res.getWriter();
		out.print(outText);
		out.close();
		System.out.println("outText: " + outText);
	}

}
