package com.feature.model;

import java.util.List;

import com.news.model.NewsVO;

public interface FeatureDAO_interface {
	public int insert(FeatureVO featureVO);
    public int update(FeatureVO featureVO);
    public int delete(String fea_no);
    public FeatureVO findByPrimaryKey(String fea_no);
    public List<FeatureVO> getAll();
}
