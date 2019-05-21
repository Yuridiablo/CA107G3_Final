package com.ord_detail.controller;

import com.ord_detail.model.Order_DetailVO;
import com.restaurant_menu.model.Restaurant_MenuService;
import com.restaurant_menu.model.Restaurant_MenuVO;

public class OdVOn {
	private String ord_no;
	private String menu_no;
	private String menu_name;
	private Integer qty;
	private Integer price;
	
	public OdVOn (Order_DetailVO odVO) {
		this.ord_no = odVO.getOrd_no();
		this.menu_no = odVO.getMenu_no();
		this.qty = odVO.getQty();
		this.price = odVO.getPrice();
		
		Restaurant_MenuService mms = new Restaurant_MenuService();
		Restaurant_MenuVO rmVO = mms.findByPK(menu_no);
		this.menu_name = rmVO.getMenu_name();
	}
}
