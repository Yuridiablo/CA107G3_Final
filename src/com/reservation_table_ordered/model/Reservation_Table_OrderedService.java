package com.reservation_table_ordered.model;

import java.sql.Date;
import java.util.List;



public class Reservation_Table_OrderedService {

	private Reservation_Table_OrderedDAO dao;

	public Reservation_Table_OrderedService() {
		dao = new Reservation_Table_OrderedDAO();
	}

	public Reservation_Table_OrderedVO addEmp(String vendor_no, Date booking_date ,  String booking_time,
		Integer	tbl_o_num1,Integer tbl_o_num2,Integer tbl_o_num3,Integer tbl_o_num4,Integer	tbl_o_num5,Integer	tbl_ordered1,Integer	tbl_ordered2,Integer tbl_ordered3,Integer tbl_ordered4,Integer tbl_ordered5) {

		Reservation_Table_OrderedVO rtoVO = new Reservation_Table_OrderedVO();

		rtoVO.setVendor_no(vendor_no);
		rtoVO.setBooking_date(booking_date);
		rtoVO.setBooking_time(booking_time);
		rtoVO.setTbl_o_num1(tbl_o_num1);
		rtoVO.setTbl_o_num2(tbl_o_num2);
		rtoVO.setTbl_o_num3(tbl_o_num3);
		rtoVO.setTbl_o_num4(tbl_o_num4);
		rtoVO.setTbl_o_num5(tbl_o_num5);
		rtoVO.setTbl_ordered1(tbl_ordered1);
		rtoVO.setTbl_ordered2(tbl_ordered2);
		rtoVO.setTbl_ordered3(tbl_ordered3);
		rtoVO.setTbl_ordered4(tbl_ordered4);
		rtoVO.setTbl_ordered5(tbl_ordered5);
			
		dao.insert(rtoVO);

		return rtoVO;
	}

	public Reservation_Table_OrderedVO updateeservation_Table_Ordered(String rto_no, String vendor_no, Date booking_date ,  String booking_time,
			Integer	tbl_o_num1,Integer tbl_o_num2,Integer tbl_o_num3,Integer tbl_o_num4,Integer	tbl_o_num5,Integer	tbl_ordered1,Integer	tbl_ordered2,Integer tbl_ordered3,Integer tbl_ordered4,Integer tbl_ordered5) {

		Reservation_Table_OrderedVO rtoVO = new Reservation_Table_OrderedVO();

		rtoVO.setRto_no(rto_no);
		rtoVO.setVendor_no(vendor_no);
		rtoVO.setBooking_date(booking_date);
		rtoVO.setBooking_time(booking_time);
		rtoVO.setTbl_o_num1(tbl_o_num1);
		rtoVO.setTbl_o_num2(tbl_o_num2);
		rtoVO.setTbl_o_num3(tbl_o_num3);
		rtoVO.setTbl_o_num4(tbl_o_num4);
		rtoVO.setTbl_o_num5(tbl_o_num5);
		rtoVO.setTbl_ordered1(tbl_ordered1);
		rtoVO.setTbl_ordered2(tbl_ordered2);
		rtoVO.setTbl_ordered3(tbl_ordered3);
		rtoVO.setTbl_ordered4(tbl_ordered4);
		rtoVO.setTbl_ordered5(tbl_ordered5);
		dao.update(rtoVO);

		return rtoVO;
	}

	public void deleteReservation_Table_Ordered(String rto_no) {
		dao.delete(rto_no);
	}

	public Reservation_Table_OrderedVO getOneReservation_Table_Ordered(String rto_no) {
		return dao.findByPrimaryKey(rto_no);
	}

	public List<Reservation_Table_OrderedVO> getAll() {
		return dao.getAll();
	}
	public List<Reservation_Table_OrderedVO> get2table(String vendor_no, Date booking_date){
		return dao.get2table(vendor_no, booking_date);
	}
	public List<Reservation_Table_OrderedVO> get4table(String vendor_no, Date booking_date){
		return dao.get4table(vendor_no, booking_date);
	}
	public List<Reservation_Table_OrderedVO> get6table(String vendor_no, Date booking_date){
		return dao.get6table(vendor_no, booking_date);
	}
	public List<Reservation_Table_OrderedVO> get8table(String vendor_no, Date booking_date){
		return dao.get8table(vendor_no, booking_date);
	}
	public List<Reservation_Table_OrderedVO> get10table(String vendor_no, Date booking_date){
		return dao.get10table(vendor_no, booking_date);
	}
	
}
