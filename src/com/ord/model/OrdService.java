package com.ord.model;

import java.util.List;

import com.ord.model.OrdDAO_interface;
import com.ord.model.OrdJDBCDAO;
import com.ord.model.OrdVO;

public class OrdService {
	private OrdDAO_interface dao;
	
	public OrdService() {
		dao = new OrdJDBCDAO();
	}
	
	public OrdVO addOrd(String mem_no, String vendor_no, String tbl_no, Integer party_size, String share_mem_no1, String share_mem_no2, Integer share_amount, java.sql.Timestamp ord_time, java.sql.Date booking_date, String booking_time, String notes, Integer total, String arrival_time, String finish_time, String verif_code, Integer status) {
		OrdVO ordVO = new OrdVO();
		ordVO.setMem_no(mem_no);
		ordVO.setVendor_no(vendor_no);
		ordVO.setTbl_no(tbl_no);
		ordVO.setParty_size(party_size);
		ordVO.setShare_mem_no1(share_mem_no1);
		ordVO.setShare_mem_no2(share_mem_no2);
		ordVO.setShare_amount(share_amount);
		ordVO.setOrd_time(ord_time);
		ordVO.setBooking_date(booking_date);
		ordVO.setBooking_time(booking_time);
		ordVO.setNotes(notes);
		ordVO.setTotal(total);
		ordVO.setArrival_time(arrival_time);
		ordVO.setFinish_time(finish_time);
		ordVO.setVerif_code(verif_code);
		ordVO.setStatus(status);
		dao.insert(ordVO);
		
		return ordVO;	 
	}

	public OrdVO updateOrd(String ord_no, String mem_no, String vendor_no, String tbl_no, Integer party_size, String share_mem_no1, String share_mem_no2, Integer share_amount, java.sql.Timestamp ord_time, java.sql.Date booking_date, String booking_time, String notes, Integer total, String arrival_time, String finish_time, String verif_code, Integer status) {
		OrdVO ordVO = new OrdVO();
		ordVO.setOrd_no(ord_no);
		ordVO.setMem_no(mem_no);
		ordVO.setVendor_no(vendor_no);
		ordVO.setTbl_no(tbl_no);
		ordVO.setParty_size(party_size);
		ordVO.setShare_mem_no1(share_mem_no1);
		ordVO.setShare_mem_no2(share_mem_no2);
		ordVO.setShare_amount(share_amount);
		ordVO.setOrd_time(ord_time);
		ordVO.setBooking_date(booking_date);
		ordVO.setBooking_time(booking_time);
		ordVO.setNotes(notes);
		ordVO.setTotal(total);
		ordVO.setArrival_time(arrival_time);
		ordVO.setFinish_time(finish_time);
		ordVO.setVerif_code(verif_code);
		ordVO.setStatus(status);
		dao.update(ordVO);
		return ordVO;
	}

	public void deleteOrd(String ord_no) {
		dao.delete(ord_no);
	}

	public OrdVO getOneOrd(String ord_no) {
		return dao.findByPrimaryKey(ord_no);
	}

	public List<OrdVO> getAll() {
		return dao.getAll();
	}
}
