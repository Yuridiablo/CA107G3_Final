package com.member.model;

import java.util.List;

public interface MemberDAO_interface {

	public int insert(MemberVO memberVO);

	public int update(MemberVO memberVO);
	
	public int updateWithoutPic(MemberVO memberVO);
	
	public int updateBalance(MemberVO memberVO);

	public int delete(String mem_no);

	public MemberVO findByPrimaryKey(String mem_no);
	
	public MemberVO findByMem_account(String mem_account);
	
	public List<MemberVO> findByMem_name(String mem_name);
	
	public List<MemberVO> findByMem_nickname(String mem_nickname);
	
	public List<MemberVO> getAll();

}
