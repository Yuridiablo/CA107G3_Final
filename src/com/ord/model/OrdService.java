package com.ord.model;

import java.sql.Date;
import java.util.List;

import com.ord.model.OrdDAO_interface;
import com.ord.model.OrdDAO;
import com.ord.model.OrdVO;

public class OrdService {
	private OrdDAO_interface dao;
	
	public OrdService() {
		dao = new OrdDAO();
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
	public List<OrdVO> findBymem_no(String mem_no) {
		return dao.findBymem_no(mem_no);
	}
	public List<OrdVO> findByvendor_no(String vendor_no) {
		return dao.findByvendor_no(vendor_no);
	}
	
	public List<OrdVO> getAllVendorDate(String vendor_no, Date booking_date) {
		return dao.findByVendor_no_Date(vendor_no, booking_date);
	}
	
	public List<OrdVO> getAllVendorVerif(String vendor_no, String verif_code) {
		return dao.findByVerifCode(vendor_no, verif_code);
	}
	
	public OrdVO getOneOrdVerif(String vendor_no, String verif_code) {
		return dao.findOrdByVerifCode(vendor_no, verif_code);
	}
	
	public OrdVO updateOrdTblNo(String ord_no, String tbl_no) {
		OrdVO ordVO = new OrdVO();
		ordVO.setOrd_no(ord_no);
		ordVO.setTbl_no(tbl_no);		
		dao.updateTbl_no(ordVO);
		return ordVO;
	}
	
	public OrdVO updateOrdStatus(String ord_no, Integer status) {
		OrdVO ordVO = new OrdVO();
		ordVO.setOrd_no(ord_no);
		ordVO.setStatus(status);		
		dao.updateStatus(ordVO);
		return ordVO;
	}
}
