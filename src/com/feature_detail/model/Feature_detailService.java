package com.feature_detail.model;

import java.util.List;

import com.feature.model.FeatureVO;

public class Feature_detailService {
	private Feature_detailDAO_interface dao;
	
	public Feature_detailService() {
		dao = new Feature_detailDAO();
	}
	
	public Feature_detailVO addFeature_detail(String fea_no,String emp_no) {
		Feature_detailVO feature_detailVO = new Feature_detailVO();
		
		feature_detailVO.setFea_no(fea_no);
		feature_detailVO.setEmp_no(emp_no);
		dao.insert(feature_detailVO);
		return feature_detailVO;
	}
    public int deleteFeature_detail(String emp_no) {
    	return dao.delete(emp_no);
    }
    public Feature_detailVO getOneFeature_detail(String emp_no,String fea_no) {
    	return dao.findByPrimaryKey(emp_no, fea_no);
    }
    
    public List<Feature_detailVO> getAllFeature_detailByEmpno(String emp_no){
    	return dao.findByEmp_no(emp_no);
    }
    public List<Feature_detailVO> getAll(){
    	return dao.getAll();
    }
}
