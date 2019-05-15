package com.article_published.model;

import java.util.List;
import java.util.Map;

public interface Article_PublishedDAO_interface {
	public void insert(Article_PublishedVO article_publishedVO);
	public void update(Article_PublishedVO article_publishedVO);
	public void updateforart_code(Article_PublishedVO article_publishedVO);
	public void delete(String art_no);
	public Article_PublishedVO findByPrimaryKey(String art_no);
	public List<Article_PublishedVO> getAll();
	public List<Article_PublishedVO> getAllforrep();
	public List<Article_PublishedVO> getAll(String mem_no);
	public List<Article_PublishedVO> getAll(Map<String,String[]> map);
	public Article_PublishedVO showpic(String art_no);
}
