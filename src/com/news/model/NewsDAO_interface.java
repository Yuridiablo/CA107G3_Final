package com.news.model;

import java.util.List;

public interface NewsDAO_interface {
	public int insert(NewsVO newsVO);
    public int update(NewsVO newsVO);
    public int delete(String news_no);
    public NewsVO findByPrimaryKey(String news_no);
    public NewsVO findLatest();
    public List<NewsVO> findByEmployeeNo(String emp_no);
    public List<NewsVO> getAll();
}
