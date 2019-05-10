package com.reservation_table_ordered.model;

import java.sql.Date;
import java.util.List;
import java.util.Map;


public interface Reservation_Table_OrderedDAO_interface {
	
	public void insert(Reservation_Table_OrderedVO reservation_Table_OrderedVO);
    public void update(Reservation_Table_OrderedVO reservation_Table_OrderedVO);
    public void delete(String rto_no);
    public Reservation_Table_OrderedVO findByPrimaryKey(String rto_no);
    public List<Reservation_Table_OrderedVO> getAll();
    public List<Reservation_Table_OrderedVO> getAll(Map<String, String[]> map);
    public List<Reservation_Table_OrderedVO> get2table(String vendor_no,Date booking_date);
    public List<Reservation_Table_OrderedVO> get4table(String vendor_no,Date booking_date);
    public List<Reservation_Table_OrderedVO> get6table(String vendor_no,Date booking_date);
    public List<Reservation_Table_OrderedVO> get8table(String vendor_no,Date booking_date);
    public List<Reservation_Table_OrderedVO> get10table(String vendor_no,Date booking_date);


}
