package com.reservation_table_number.model;

import java.util.List;
import java.util.Map;



public interface Reservation_Table_NumberDAO_interface {
	

	public void insert(Reservation_Table_NumberVO reservation_table_numberVO);
    public void update(Reservation_Table_NumberVO reservation_table_numberVO);
    public void update_t1(Reservation_Table_NumberVO reservation_table_numberVO);
    public void update_t2(Reservation_Table_NumberVO reservation_table_numberVO);
    public void update_t3(Reservation_Table_NumberVO reservation_table_numberVO);
    public void update_t4(Reservation_Table_NumberVO reservation_table_numberVO);
    public void update_t5(Reservation_Table_NumberVO reservation_table_numberVO);
    public void delete(String rtn_no);
    public void deleteV_no(String vendor_no);
    public Reservation_Table_NumberVO findByPrimaryKey(String rtn_no);
    public Reservation_Table_NumberVO findByV_no(String vendor_no);
    public List<Reservation_Table_NumberVO> getAll();
    public List<Reservation_Table_NumberVO> getAll(Map<String, String[]> map);
    public List<Reservation_Table_NumberVO>findBy_vendor(String vendor_no);
	
}
