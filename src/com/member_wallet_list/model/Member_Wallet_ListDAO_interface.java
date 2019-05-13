package com.member_wallet_list.model;

import java.util.List;

import com.comment_reported.model.Comment_ReportedVO;

public interface Member_Wallet_ListDAO_interface {
	
	public void insert(Member_Wallet_ListVO Member_Wallet_ListVO);
	public void update(Member_Wallet_ListVO Member_Wallet_ListVO);
	public void delete(String list_no);
	public List<Member_Wallet_ListVO> findByMem(String mem_no);
	public List<Member_Wallet_ListVO> getAll();
	public void insertwithord(Member_Wallet_ListVO Member_Wallet_ListVO);
}
