package com.member_wallet_list.model;

import java.util.List;

public class Member_Wallet_ListService {
	
	private  Member_Wallet_ListDAO_interface dao;
	
	public  Member_Wallet_ListService() {
		dao = new  Member_Wallet_ListDAO();
	}
	
	//新增一條錢包明細-支付個人訂單或好友訂單 (stat在SQL句中會寫死 自己支付是1，支付好友訂單是2，提款是3)
	public  Member_Wallet_ListVO addMWL(String mem_no, String list_wit, int list_stat,String list_dep) {
		
		Member_Wallet_ListVO mwlVO = new  Member_Wallet_ListVO();
		
		mwlVO.setMem_no(mem_no);
		mwlVO.setList_wit(list_wit);
		mwlVO.setList_stat(list_stat);
		mwlVO.setList_dep(list_dep);
		dao.insert(mwlVO);
		
		return mwlVO;
	}
	
	//查單一會員錢包紀錄
	public List<Member_Wallet_ListVO> findByMem(String mem_no){
		return dao.findByMem(mem_no);
	}
	
	//查全站會員錢包紀錄
	public List<Member_Wallet_ListVO> getAll(){
		return dao.getAll();
	}
	
}
