package com.reservation_time.model;

import java.util.List;



public class Reservation_TimeService {

	private Reservation_TimeDAO dao;

	public Reservation_TimeService() {
		dao = new Reservation_TimeDAO();
	}

	public Reservation_TimeVO addReservation_time(String vendor_no, String r_time) {

		Reservation_TimeVO rtVO = new Reservation_TimeVO();

		rtVO.setVendor_no(vendor_no);
		rtVO.setR_time(r_time);
		dao.insert(rtVO);

		return rtVO;
	}

	public Reservation_TimeVO updateReservation_timeDAO(String rt_no, String vendor_no, String r_time) {

		Reservation_TimeVO rtVO = new Reservation_TimeVO();

		rtVO.setRt_no(rt_no);
		rtVO.setVendor_no(vendor_no);
		rtVO.setR_time(r_time);
		dao.update(rtVO);

		return rtVO;
	}

	public void deleteReservation_timeDAO(String rt_no) {
		dao.delete(rt_no);
	}

	public Reservation_TimeVO getOneReservation_timeDAO(String rt_no) {
		return dao.findByPrimaryKey(rt_no);
	}

	public List<Reservation_TimeVO> getVendor(String xxxId){
		return dao.getVendor(xxxId);
	}
	public List<Reservation_TimeVO> finby_v_no(String vendor_no) {
		return dao.finby_v_no(vendor_no);
	}
}

