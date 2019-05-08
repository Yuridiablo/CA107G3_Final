package com.restaurant_transaction_list.model;

import java.sql.Timestamp;
import java.util.List;



public class RES_Transaction_ListService {
	private RES_Transaction_ListDAO dao;

	public RES_Transaction_ListService() {
		dao = new RES_Transaction_ListDAO();
	}

	public RES_Transaction_ListVO addList(String vendor_no, Double amount,
			String ord_no, Integer v_wallet) {

		RES_Transaction_ListVO rtlVO = new RES_Transaction_ListVO();
			
		rtlVO.setVendor_no(vendor_no);
		rtlVO.setAmount(amount);
		rtlVO.setOrd_no(ord_no);
		rtlVO.setV_wallet(v_wallet);
		
		dao.insert(rtlVO);
		return rtlVO;
	}
	
	public RES_Transaction_ListVO status(Integer v_wallet,String vendor_no) {
		RES_Transaction_ListVO rtlVO = new RES_Transaction_ListVO();
		
		rtlVO.setV_wallet(v_wallet);
		rtlVO.setVendor_no(vendor_no);
		
		dao.status(rtlVO);
		return rtlVO;
	}

//	public RES_Transaction_ListVO updateRES_Transaction_List(String trst_no, String vendor_no, Double amount, Timestamp pay_date,
//			String ord_no, Double v_wallet) {
//
//		RES_Transaction_ListVO rtlVO = new RES_Transaction_ListVO();
//			
//		
//		rtlVO.setTrst_no(trst_no);
//		rtlVO.setVendor_no(vendor_no);
//		rtlVO.setAmount(amount);
//		rtlVO.setPay_date(pay_date);
//		rtlVO.setOrd_no(ord_no);
//		rtlVO.setV_wallet(v_wallet);
//		
//		dao.update(rtlVO);
//
//		return rtlVO;
//	}

	public void deleteRES_Transaction_List(String trst_no) {
		dao.delete(trst_no);
	}

	public RES_Transaction_ListVO getOneRES_Transaction_List(String trst_no) {
		return dao.findByPrimaryKey(trst_no);
	}

	public List<RES_Transaction_ListVO> getOneVendor(String vendor_no) {
		return dao.getOneVendor(vendor_no);
	}
	
	public List<RES_Transaction_ListVO> getAll() {
		return dao.getAll();
	}

}
