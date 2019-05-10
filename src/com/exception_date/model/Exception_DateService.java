package com.exception_date.model;

import java.util.List;

import com.reservation_time.model.Reservation_TimeVO;



public class Exception_DateService {
	
	
	private Exception_DateDAO dao;
	
	public Exception_DateService() {
		dao = new Exception_DateDAO()
;	}
	
	public Exception_DateVO addException_date(String vendor_no ,java.sql.Date exc_date) {

		Exception_DateVO edVO = new Exception_DateVO();

		edVO.setVendor_no(vendor_no);
		
		edVO.setExc_date(exc_date);
		
		dao.insert(edVO);

		return edVO;
	}
	
	
	public Exception_DateVO updateException_date(String exc_no, String vendor_no, java.sql.Date exc_date) {
		Exception_DateVO edVO = new Exception_DateVO();

		edVO.setExc_no(exc_no);
		edVO.setVendor_no(vendor_no);
		edVO.setExc_date(exc_date);
		
		dao.update(edVO);

		return edVO;
	}
	
	
	public void deleteException_date(String exc_no) {
		dao.delete(exc_no);
	}

	public Exception_DateVO getOneException_date(String exc_no) {
		return dao.findByPrimaryKey(exc_no);
	}

	public List<Exception_DateVO> getAll() {
		return dao.getAll();
	}

	public List<Exception_DateVO> getdate(String vendor_no){
		return dao.getdate(vendor_no);
	}
	public List<Exception_DateVO>find_by_vendor_no(String vendor_no){
		return dao.find_by_vendor(vendor_no);
	}
	
	
}
