package com.restaurant_responses.model;

import java.util.List;


public interface Restaurant_ResponsesDAO_interface {
	
	public void insert(Restaurant_ResponsesVO Restaurant_ResponsesVO);
	public void update(Restaurant_ResponsesVO Restaurant_ResponsesVO);
	public void delete(String res_no);
	public Restaurant_ResponsesVO findPK(String cmnt_no);
	public List<Restaurant_ResponsesVO> getOneVendor(String vendor_no);
	public List<Restaurant_ResponsesVO> getAll();

}
