package com.comments.model;

import java.util.List;



public class CommentsService {
	private CommentsDAO_interface dao;
	
	public CommentsService() {
		dao = new CommentsDAO();
	}
	
	public CommentsVO addComments(String ord_no, String vendor_no, Integer score, String cmnt, Integer cmnt_status) {
		CommentsVO commentsVO = new CommentsVO();
		commentsVO.setOrd_no(ord_no);
		commentsVO.setVendor_no(vendor_no);
		commentsVO.setScore(score);
		commentsVO.setCmnt(cmnt);
		commentsVO.setCmnt_status(cmnt_status);
		dao.insert(commentsVO);
		return commentsVO;
	}

	public CommentsVO updateComments(String cmnt_no, String ord_no, String vendor_no, Integer score, String cmnt, java.sql.Timestamp time, Integer cmnt_status) {
		CommentsVO commentsVO = new CommentsVO();
		commentsVO.setCmnt_no(cmnt_no);
		commentsVO.setOrd_no(ord_no);
		commentsVO.setVendor_no(vendor_no);
		commentsVO.setScore(score);
		commentsVO.setCmnt(cmnt);
		commentsVO.setTime(time);
		commentsVO.setCmnt_status(cmnt_status);
		dao.update(commentsVO);
		return commentsVO;
	}

	public void deleteComments(String cmnt_no) {
		dao.delete(cmnt_no);
	}

	public CommentsVO getOneComments(String cmnt_no) {
		return dao.findByPrimaryKey(cmnt_no);
	}

	public List<CommentsVO> getAll() {
		return dao.getAll();
	}
	 
	public List<CommentsVO> getVendor(String vendor_no) {
		return dao.getVendor(vendor_no);
	}
	public CommentsVO findByord_no(String ord_no) {
		return dao.findByord_no(ord_no);
		
	}
	
	public List<CommentsVO> getOneVendor(String vendor_no) {
		return dao.getOneVendor(vendor_no);
	}
	
}
