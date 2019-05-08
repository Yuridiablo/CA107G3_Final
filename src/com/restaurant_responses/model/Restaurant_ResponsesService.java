package com.restaurant_responses.model;

import java.util.List;

public class Restaurant_ResponsesService {
	
	private Restaurant_ResponsesDAO_interface dao;
	
	public Restaurant_ResponsesService() {
		dao = new Restaurant_ResponsesJDBCDAO();
	}

	public Restaurant_ResponsesVO addRR(String cmnt_no, String res_text) {
		Restaurant_ResponsesVO rrVO = new Restaurant_ResponsesVO();
		
		rrVO.setCmnt_no(cmnt_no);
		rrVO.setRes_text(res_text);
		
		dao.insert(rrVO);
		return rrVO;
	}
	
	public Restaurant_ResponsesVO findPk(String cmnt_no) {
		
		return dao.findPK(cmnt_no);
	}
	
	public List<Restaurant_ResponsesVO> getAll(){
		return dao.getAll();
		 
	}
	
	public List<Restaurant_ResponsesVO> getOneVendor(String vendor_no){
		return dao.getOneVendor(vendor_no);
		 
	}
	
	public void deleteRR(String res_no) {
		dao.delete(res_no);
	}
}
