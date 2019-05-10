package com.exception_date.model;

import java.util.List;
import java.util.Map;



public interface Exception_DateDAO_Interface {

	public void insert(Exception_DateVO exception_dateVO);
    public void update(Exception_DateVO exception_dateVO);
    public void delete(String exc_no);
    public Exception_DateVO findByPrimaryKey(String exc_no);
    public List<Exception_DateVO> getAll();
    public List<Exception_DateVO> getAll(Map<String, String[]> map);
    public List<Exception_DateVO> getdate(String vendor_no);
    public List<Exception_DateVO>find_by_vendor(String vendor_no);
	   
} 
