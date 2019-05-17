package com.feature_detail.model;

import java.util.List;

import com.news.model.NewsVO;

public interface Feature_detailDAO_interface {
	public int insert(Feature_detailVO feature_detailVO);
    public int delete(String emp_no);
    public Feature_detailVO findByPrimaryKey(String emp_no,String fea_no);
    public List<Feature_detailVO> findByEmp_no(String emp_no);
    public List<Feature_detailVO> getAll();
}
