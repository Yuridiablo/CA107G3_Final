package com.ord_detail.model;

import java.util.List;

import com.ord_detail.model.Order_DetailDAO_interface;
import com.ord_detail.model.Order_DetailJDBCDAO;
import com.ord_detail.model.Order_DetailVO;

public class Order_DetailService {
	private Order_DetailDAO_interface dao;
	
	public Order_DetailService() {
		dao = new Order_DetailJDBCDAO();
	}
	
	public Order_DetailVO addOrder_Detail(String ord_no, String menu_no, Integer qty, Integer price) {		 
		Order_DetailVO order_detailVO = new Order_DetailVO();
		order_detailVO.setOrd_no(ord_no);
		order_detailVO.setMenu_no(menu_no);
		order_detailVO.setQty(qty);
		order_detailVO.setPrice(price);
		dao.insert(order_detailVO);
		
		return order_detailVO;
	}

	public Order_DetailVO updateOrder_Detail(String ord_no, String menu_no, Integer qty, Integer price) {
		Order_DetailVO order_detailVO = new Order_DetailVO();
		order_detailVO.setOrd_no(ord_no);
		order_detailVO.setMenu_no(menu_no);
		order_detailVO.setQty(qty);
		order_detailVO.setPrice(price);
		dao.update(order_detailVO);
		
		return order_detailVO;
	}

	public void deleteOrder_Detail(String ord_no, String menu_no) {
		dao.delete(ord_no, menu_no);
	}

	public Order_DetailVO getOneOrder_Detail(String ord_no, String menu_no) {
		return dao.findByPrimaryKey(ord_no, menu_no);
	}

	public List<Order_DetailVO> getAll() {
		return dao.getAll();
	}
	
	  public List<Order_DetailVO> findbyOrd_no(String ord_no){
		return dao.findbyOrd_no(ord_no);
		  
	  };
	
}
