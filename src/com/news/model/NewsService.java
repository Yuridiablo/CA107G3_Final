package com.news.model;

import java.sql.Date;
import java.util.List;

public class NewsService {
	private NewsDAO_interface dao;

	public NewsService() {
		dao = new NewsDAO();
	}

	public NewsVO addNews(String emp_no, String news_cont, byte[] news_pic, Date news_rea,String news_text) {
		NewsVO newsVO = new NewsVO();
		newsVO.setEmp_no(emp_no);
		newsVO.setNews_cont(news_cont);
		newsVO.setNews_pic(news_pic);
		newsVO.setNews_rea(news_rea);
		newsVO.setNews_text(news_text);
		dao.insert(newsVO);
		return newsVO;
	}

	public NewsVO updateNews(String news_no, String emp_no, String news_cont, byte[] news_pic, Date news_rea) {
		NewsVO newsVO = new NewsVO();
		newsVO.setNews_no(news_no);
		newsVO.setEmp_no(emp_no);
		newsVO.setNews_cont(news_cont);
		newsVO.setNews_pic(news_pic);
		newsVO.setNews_rea(news_rea);
		dao.update(newsVO);
		return newsVO;
	}

	public int deleteNews(String news_no) {
		return dao.delete(news_no);
	}

	public NewsVO getOneNews(String news_no) {
		return dao.findByPrimaryKey(news_no);
	}
	
	public NewsVO getLatestNews() {
		return dao.findLatest();
	}
	
	public List<NewsVO> getAllByEmp_no(String emp_no){
		return dao.findByEmployeeNo(emp_no);
	}

	public List<NewsVO> getAll(){
		return dao.getAll();
	}
}
