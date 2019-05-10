package com.article_reported.model;

import java.util.List;

public class Article_ReportedService {
	private Article_ReportedDAO_interface dao;
	
	public Article_ReportedService() {
		dao = new Article_ReportedDAO();
	}
	
	public Article_ReportedVO addArticle_Reported(String art_no,String mem_no,
		String	artre_content,java.sql.Date artre_time,Integer artre_code) {
		Article_ReportedVO article_reportedVO = new Article_ReportedVO();
		
		article_reportedVO.setArt_no(art_no);
		article_reportedVO.setMem_no(mem_no);
		article_reportedVO.setArtre_content(artre_content);
		article_reportedVO.setArtre_time(artre_time);
		article_reportedVO.setArtre_code(artre_code);
		dao.insert(article_reportedVO);
		
		return article_reportedVO;
	}
	
	public Article_ReportedVO updateArticle_Reported(String artre_content,java.sql.Date artre_time,
		Integer artre_code,String artre_no) {
		Article_ReportedVO article_reportedVO = new Article_ReportedVO();
		
		article_reportedVO.setArtre_content(artre_content);
		article_reportedVO.setArtre_time(artre_time);
		article_reportedVO.setArtre_code(artre_code);
		article_reportedVO.setArtre_no(artre_no);
		dao.update(article_reportedVO);
		
		return article_reportedVO;
	}
	
	public void deleteArticle_Reported(String artre_no) {
		dao.delete(artre_no);
	}
	
	public Article_ReportedVO getOneArticle_Reported(String artre_no) {
		return dao.findByPrimaryKey(artre_no);
	}
	
	public List<Article_ReportedVO> getAll(){
		return dao.getAll();
	}
}
