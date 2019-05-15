package com.tables.controller;

import com.ord_detail.model.Order_DetailVO;

public class Bill_item {
	String menu_no;
	Integer qty;
	Integer unitPrice;
	
	// from 訂位
	public Bill_item(Order_DetailVO order_DetailVO) {
		this.menu_no = order_DetailVO.getMenu_no();
		this.qty = order_DetailVO.getQty();
		this.unitPrice = order_DetailVO.getPrice();
	}
	
	// from 候位 散客
	public Bill_item(String menu_no, Integer qty, Integer unitPrice) {
		this.menu_no = menu_no;
		this.qty = qty;
		this.unitPrice = unitPrice;
	}

	public Bill_item() {
		super();
	}

	public String getMenu_no() {
		return menu_no;
	}

	public void setMenu_no(String menu_no) {
		this.menu_no = menu_no;
	}

	public Integer getQty() {
		return qty;
	}

	public void setQty(Integer qty) {
		this.qty = qty;
	}

	public Integer getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}

	@Override
	public String toString() {
		return "Bill_item [menu_no=" + menu_no + ", qty=" + qty + ", unitPrice=" + unitPrice + "]";
	}
	 
	
}
