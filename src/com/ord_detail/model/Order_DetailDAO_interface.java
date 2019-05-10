package com.ord_detail.model;

import java.util.List;

public interface Order_DetailDAO_interface{
	public void insert(Order_DetailVO order_detailVO);
	public void update(Order_DetailVO order_detailVO);
    public void delete(String ord_no, String menu_no);
    public Order_DetailVO findByPrimaryKey(String ord_no, String menu_no);
    public List<Order_DetailVO> getAll();
    public List<Order_DetailVO> findbyOrd_no(String ord_no);
	
}
