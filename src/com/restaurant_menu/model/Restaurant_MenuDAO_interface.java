package com.restaurant_menu.model;

import java.util.List;

import com.member_wallet_list.model.Member_Wallet_ListVO;

public interface Restaurant_MenuDAO_interface {
	
	public void insert(Restaurant_MenuVO Restaurant_MenuVO);
	public void update(Restaurant_MenuVO Restaurant_MenuVO);
	public void delete(String menu_no);
	public Restaurant_MenuVO findByPK(String menu_no);
	public int upPic(Restaurant_MenuVO Restaurant_MenuVO);
	
	public void up3info(Restaurant_MenuVO Restaurant_MenuVO);
	public void upStatu(Restaurant_MenuVO Restaurant_MenuVO);
	
	public List<Restaurant_MenuVO> getVendor(String vendor_no);
	public List<Restaurant_MenuVO> getAll();
	
	public List<Restaurant_MenuVO>getm_name(String vendor_no);

}
