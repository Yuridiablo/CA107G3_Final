package com.reservation_time.model;

import java.util.List;
import java.util.Map;


public interface Reservation_TimeDAO_Interface {
	public void insert(Reservation_TimeVO reservation_timeVO );
    public void update(Reservation_TimeVO reservation_timeVO);
    public void delete(String rt_no);
    public Reservation_TimeVO findByPrimaryKey(String rt_no);
    public List<Reservation_TimeVO> getAll();
   
    public List<Reservation_TimeVO> getVendor(String xxxId);
    public List<Reservation_TimeVO>finby_v_no(String vendor_no);
    
		
		
}
	