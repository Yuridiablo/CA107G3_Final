package com.reservation_table_number.model;

import java.util.List;



public class Reservation_Table_NumberService {

	private Reservation_Table_NumberDAO dao;

	public Reservation_Table_NumberService() {
		dao = new Reservation_Table_NumberDAO();
	}

	public Reservation_Table_NumberVO addReservation_Table_Number(String vendor_no, Integer rtbl_o_num1, Integer rtbl_o_num2,
			Integer rtbl_o_num3, Integer rtbl_o_num4, Integer rtbl_o_num5 ) {

		Reservation_Table_NumberVO rtnVO = new Reservation_Table_NumberVO();

		rtnVO.setVendor_no( vendor_no);
		rtnVO.setRtbl_o_num1( rtbl_o_num1);
		rtnVO.setRtbl_o_num2( rtbl_o_num2);
		rtnVO.setRtbl_o_num3( rtbl_o_num3);
		rtnVO.setRtbl_o_num4( rtbl_o_num4);
		rtnVO.setRtbl_o_num5( rtbl_o_num5);
		dao.insert(rtnVO);

		return rtnVO;
	}

	public Reservation_Table_NumberVO updateReservation_Table_Number(String rtn_no, String vendor_no, Integer rtbl_o_num1,
			Integer rtbl_o_num2, Integer rtbl_o_num3, Integer rtbl_o_num4, Integer rtbl_o_num5) {

		Reservation_Table_NumberVO rtnVO = new Reservation_Table_NumberVO();
		
		rtnVO.setRtn_no(rtn_no);
		rtnVO.setVendor_no( vendor_no);
		rtnVO.setRtbl_o_num1( rtbl_o_num1);
		rtnVO.setRtbl_o_num2( rtbl_o_num2);
		rtnVO.setRtbl_o_num3( rtbl_o_num3);
		rtnVO.setRtbl_o_num4( rtbl_o_num4);
		rtnVO.setRtbl_o_num5( rtbl_o_num5);
		dao.update(rtnVO);

		return rtnVO;
	}
	public Reservation_Table_NumberVO update_t1(String vendor_no, Integer rtbl_o_num1) {

		Reservation_Table_NumberVO rtnVO = new Reservation_Table_NumberVO();
		
		rtnVO.setVendor_no( vendor_no);
		rtnVO.setRtbl_o_num1( rtbl_o_num1);
		dao.update_t1(rtnVO);

		return rtnVO;
	}
	public Reservation_Table_NumberVO update_t2(String vendor_no, Integer rtbl_o_num2) {

		Reservation_Table_NumberVO rtnVO = new Reservation_Table_NumberVO();
		
		rtnVO.setVendor_no( vendor_no);
		rtnVO.setRtbl_o_num2( rtbl_o_num2);
		dao.update_t2(rtnVO);

		return rtnVO;
	}
	public Reservation_Table_NumberVO update_t3(String vendor_no, Integer rtbl_o_num3) {

		Reservation_Table_NumberVO rtnVO = new Reservation_Table_NumberVO();
		
		rtnVO.setVendor_no( vendor_no);
		rtnVO.setRtbl_o_num3( rtbl_o_num3);
		dao.update_t3(rtnVO);

		return rtnVO;
	}
	public Reservation_Table_NumberVO update_t4(String vendor_no, Integer rtbl_o_num4) {

		Reservation_Table_NumberVO rtnVO = new Reservation_Table_NumberVO();
		
		rtnVO.setVendor_no( vendor_no);
		rtnVO.setRtbl_o_num4( rtbl_o_num4);
		dao.update_t4(rtnVO);

		return rtnVO;
	}
	public Reservation_Table_NumberVO update_t5(String vendor_no, Integer rtbl_o_num5) {

		Reservation_Table_NumberVO rtnVO = new Reservation_Table_NumberVO();
		
		rtnVO.setVendor_no( vendor_no);
		rtnVO.setRtbl_o_num5( rtbl_o_num5);
		dao.update_t5(rtnVO);

		return rtnVO;
	}
	public void deleteReservation_Table_Number(String rtn_no) {
		dao.delete(rtn_no);
	}
	public void deleteV_no(String vendor_no) {
		dao.deleteV_no(vendor_no);
	}
	public Reservation_Table_NumberVO getOneReservation_Table_Number(String rtn_no) {
		return dao.findByPrimaryKey(rtn_no);
	}
	public Reservation_Table_NumberVO findByV_no(String vendor_no) {
		return dao.findByV_no(vendor_no);
	}
	public List<Reservation_Table_NumberVO> getAll() {
		return dao.getAll();
	}
	
	public List<Reservation_Table_NumberVO>findBy_vendor(String vendor_no){
		return dao.findBy_vendor(vendor_no);
	};
	
}
