package com.ord.model;

import java.util.List;

import com.ord_detail.model.Order_DetailVO;



public interface OrdDAO_interface {
	public void insert(OrdVO OrdVO);
    public void update(OrdVO OrdVO);
    public void delete(String ord_no);
    public OrdVO findByPrimaryKey(String ord_no);
    public List<OrdVO> getAll();
    public List<OrdVO>findByvendor_no(String vendor_no);
    public List<OrdVO>findBymem_no(String mem_no);
    
    
    
    public OrdVO insertWithOrd_detail(OrdVO OrdVO , List<Order_DetailVO> list);
}
