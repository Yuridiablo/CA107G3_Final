package com.article_published.model;

import java.util.List;
import java.util.Map;

public class Article_PublishedService {
	private Article_PublishedDAO_interface dao;

	public	Article_PublishedService() {
		dao = new Article_PublishedDAO();
	}
	
	public Article_PublishedVO addArticle_Published(String mem_no,String art_title,
		String	art_content,java.sql.Date art_time,byte[] art_pic1,byte[] art_pic2,
		byte[] art_pic3,byte[] art_pic4,byte[] art_pic5,Integer art_code) {
		Article_PublishedVO article_publishedVO = new Article_PublishedVO();
		
		article_publishedVO.setMem_no(mem_no);
		article_publishedVO.setArt_title(art_title);
		article_publishedVO.setArt_content(art_content);
		article_publishedVO.setArt_time(art_time);
		article_publishedVO.setArt_pic1(art_pic1);
		article_publishedVO.setArt_pic2(art_pic2);
		article_publishedVO.setArt_pic3(art_pic3);
		article_publishedVO.setArt_pic4(art_pic4);
		article_publishedVO.setArt_pic5(art_pic5);
		article_publishedVO.setArt_code(art_code);
		dao.insert(article_publishedVO);
		
		return article_publishedVO;
	}
	
	public Article_PublishedVO updateArticle_Published(String art_title,String art_content,
		java.sql.Date art_time,byte[] art_pic1,byte[] art_pic2,byte[] art_pic3,byte[] art_pic4,
		byte[] art_pic5,String art_no) {
		Article_PublishedVO article_publishedVO = new Article_PublishedVO();
		
		article_publishedVO.setArt_title(art_title);
		article_publishedVO.setArt_content(art_content);
		article_publishedVO.setArt_time(art_time);
		article_publishedVO.setArt_pic1(art_pic1);
		article_publishedVO.setArt_pic2(art_pic2);
		article_publishedVO.setArt_pic3(art_pic3);
		article_publishedVO.setArt_pic4(art_pic4);
		article_publishedVO.setArt_pic5(art_pic5);
		article_publishedVO.setArt_no(art_no);
		dao.update(article_publishedVO);
		
		return article_publishedVO;
	}
	
	public void updateArticle_publishedforart_code(Integer art_code,String art_no) {
		Article_PublishedVO article_publishedVO = new Article_PublishedVO();
		
		article_publishedVO.setArt_code(art_code);
		article_publishedVO.setArt_no(art_no);
		dao.updateforart_code(article_publishedVO);
		
	}
	
	public void  deleteArticle_Published(String art_no) {
		dao.delete(art_no);
	}
	
	public Article_PublishedVO getOneArticle_Published(String art_no) {
		return dao.findByPrimaryKey(art_no);
	}
	
	public List<Article_PublishedVO> getAll(){
		return dao.getAll();
	}
	
	
	
	public List<Article_PublishedVO> getAll(String mem_no){
		return dao.getAll(mem_no);
	}
	
	public List<Article_PublishedVO> getAll(Map<String,String[]> map){
		return dao.getAll(map);
	}

	public List<Article_PublishedVO> getAllforrep(){
		return dao.getAllforrep();
	}
	
	public Article_PublishedVO showPicArticle_Published_Information(String art_no) {
		return dao.showpic(art_no);
	}
}
