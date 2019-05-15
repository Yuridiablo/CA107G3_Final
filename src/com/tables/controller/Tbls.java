package com.tables.controller;

import java.text.DecimalFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.*;

import com.tables.model.TablesService;
import com.tables.model.TablesVO;

public class Tbls {	
	Map<String, Tbl> tbls;
	int billNo = 1;
	LinkedHashMap<String, Bill> bills;
	
	public Tbls(String vendor_no) {
		
		// initialize tbl list
		this.tbls = new HashMap<String, Tbl>();
		
		TablesService tablesService = new TablesService();
		List<TablesVO> tblList = tablesService.getAllByVendor_no(vendor_no);
		for (TablesVO tblVO : tblList) {
			Tbl tbl = new Tbl(tblVO);
			this.tbls.put(tblVO.getTbl_no(), tbl);
		}
		// if there is no table ...
 		
		
		// initialize bill list
		this.bills = new LinkedHashMap<String, Bill>();
	}

	public Integer getBillNo() {
		return billNo;
	}

	public void setBillNo(Integer billNo) {
		this.billNo = billNo;
	}

	public Map<String, Tbl> getTbls() {
		return tbls;
	}

	public void setTbls(Map<String, Tbl> tbls) {
		this.tbls = tbls;
	}

	public LinkedHashMap<String, Bill> getBills() {
		return bills;
	}

	public void setBills(LinkedHashMap<String, Bill> bills) {
		this.bills = bills;
	}
	
	// put Bill to bills
	public void putBill(Bill bill) {
		
		// 帳單日期 今天
		bill.setDate(new Date().getTime());
		
		// 帳單編號
		// 日期
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		TimeZone tz = TimeZone.getTimeZone("Asia/Taipei"); 
		format.setTimeZone(tz);
		// 數字
		Format dfm = new DecimalFormat("0000");
		
		bill.setBill_no(format.format(new Date(bill.getDate())) + "-w-" + dfm.format(this.billNo));
		this.billNo++;
		
		this.bills.put(bill.getBill_no(),bill);
	}
	
	// set bill to tbl
	public void setBillToTbl(Bill bill) {
		if (bill == null) {
			System.out.println("setBillToTbl: null Bill");
			return;
		}
		
		String tbl_no = bill.getTbl_no();
		if (tbl_no == null) {
			System.out.println("setBillToTbl: null tbl_no");
			return;
		}
		
		Tbl tbl = this.tbls.get(tbl_no);
		if (tbl == null) {
			System.out.println("setBillToTbl: null tbl");
			return;
		}
		
		tbl.setBill(bill);
		tbl.setStatus(1);
	}

	@Override
	public String toString() {
		return "Tbls [tbls=" + tbls + ", billNo=" + billNo + ", bills=" + bills + "]";
	}
	
	
	
}
