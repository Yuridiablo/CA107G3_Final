package com.article_reported.model;

import java.util.List;

public interface Article_ReportedDAO_interface {
	public void insert(Article_ReportedVO article_reportedVO);
	public void update(Article_ReportedVO article_reportedVO);
	public void delete(String artre_no);
	public  Article_ReportedVO findByPrimaryKey(String artre_no);
	public List<Article_ReportedVO> getAll();
}
