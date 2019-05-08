package com.feature.model;

import java.util.List;

public class FeatureService {
	private FeatureDAO_interface dao;

	public FeatureService() {
		dao = new FeatureJDBCDAO();
	}

	public FeatureVO addFeature(String fea_no, String fea_name, String fea_det) {
		FeatureVO featureVO = new FeatureVO();
		featureVO.setFea_no(fea_no);
		featureVO.setFea_name(fea_name);
		featureVO.setFea_det(fea_det);
		dao.insert(featureVO);
		return featureVO;
	}

	public FeatureVO updateFeature(String fea_no, String fea_name, String fea_det) {
		FeatureVO featureVO = new FeatureVO();
		featureVO.setFea_no(fea_no);
		featureVO.setFea_name(fea_name);
		featureVO.setFea_det(fea_det);
		dao.update(featureVO);
		return featureVO;
	}

	public int deleteFeature(String fea_no) {
		return dao.delete(fea_no);
	}

	public FeatureVO getOneFeature(String fea_no) {
		return dao.findByPrimaryKey(fea_no);
	}

	public List<FeatureVO> getAll() {
		return dao.getAll();
	}
}
