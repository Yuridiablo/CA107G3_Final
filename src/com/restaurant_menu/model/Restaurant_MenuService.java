package com.restaurant_menu.model;

import java.util.List;

import com.vendor.model.VendorVO;

public class Restaurant_MenuService {
	
	private Restaurant_MenuDAO_interface dao;
	
	public Restaurant_MenuService() {
		dao = new Restaurant_MenuJDBCDAO();
	}
	
	//店家新增菜單
	public Restaurant_MenuVO addRM(String vendor_no, String menu_name, String menu_price, byte[] menu_pic, Integer menu_stat, String menu_text) {
		Restaurant_MenuVO rmVO = new Restaurant_MenuVO();
		
		rmVO.setVendor_no(vendor_no);
		rmVO.setMenu_name(menu_name);
		rmVO.setMenu_price(menu_price);
		rmVO.setMenu_pic(menu_pic);
		rmVO.setMenu_stat(menu_stat);
		rmVO.setMenu_text(menu_text);
		dao.insert(rmVO);
		
		return rmVO;
	}
	
	//店家修改菜單
	public Restaurant_MenuVO updateRM(String menu_name, String menu_price, byte[] menu_pic, Integer menu_stat, String menu_text, String menu_no) {
		Restaurant_MenuVO rmVO = new Restaurant_MenuVO();
		
		
		rmVO.setMenu_name(menu_name);
		rmVO.setMenu_price(menu_price);
		rmVO.setMenu_pic(menu_pic);
		rmVO.setMenu_stat(menu_stat);
		rmVO.setMenu_text(menu_text);
		rmVO.setMenu_no(menu_no);
		dao.update(rmVO);
		
		return rmVO;
	}
	
	public void deleteMenu(String menu_no) {
		dao.delete(menu_no);

	}
	
	public Restaurant_MenuVO upPic(byte[] menu_pic,String menu_no) {
		Restaurant_MenuVO rmVO = new Restaurant_MenuVO();
		rmVO.setMenu_pic(menu_pic);
		rmVO.setMenu_no(menu_no);
		
		dao.upPic(rmVO);
		return rmVO;
	}
	
	public Restaurant_MenuVO up3info(String menu_name, String menu_price, String menu_text, String menu_no) {
		Restaurant_MenuVO rmVO = new Restaurant_MenuVO();
		rmVO.setMenu_name(menu_name);
		rmVO.setMenu_price(menu_price);
		rmVO.setMenu_text(menu_text);
		rmVO.setMenu_no(menu_no);
		
		dao.up3info(rmVO);
		return rmVO;
	}
	
	public Restaurant_MenuVO upStatu(Integer menu_stat, String menu_no) {
		Restaurant_MenuVO rmVO = new Restaurant_MenuVO();
		rmVO.setMenu_stat(menu_stat);
		rmVO.setMenu_no(menu_no);
		
		dao.upStatu(rmVO);
		return rmVO;
	}
	
	public Restaurant_MenuVO findByPK(String menu_no) {
		return dao.findByPK(menu_no);
	}
	
	public List<Restaurant_MenuVO> getVendor(String vendor_no) {
		return dao.getVendor(vendor_no);
	}
	
	public List<Restaurant_MenuVO> getAll(){
		return dao.getAll();
	}
	
	public List<Restaurant_MenuVO> getM_name(String vendor_no){
		return dao.getm_name(vendor_no);
	}
	
}
