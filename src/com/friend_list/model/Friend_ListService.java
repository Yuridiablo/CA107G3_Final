package com.friend_list.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class Friend_ListService {
	private Friend_ListDAO_interface dao;
	
	public Friend_ListService() {
		dao = new Friend_ListJDBCDAO();
	}
	
	public Friend_ListVO addFriend_List(String mem_no,String frie_no,
	Integer frie_code) {
		Friend_ListVO friend_listVO = new Friend_ListVO();
		
		friend_listVO.setMem_no(mem_no);
		friend_listVO.setFrie_no(frie_no);
		friend_listVO.setFrie_code(frie_code);
		dao.insert(friend_listVO);
		
		return friend_listVO;
	}
	
	public Friend_ListVO updateFriend_List(String mem_no,
	String frie_no,Integer frie_code) {
		Friend_ListVO friend_listVO = new Friend_ListVO();
		
		friend_listVO.setMem_no(mem_no);
		friend_listVO.setFrie_no(frie_no);
		friend_listVO.setFrie_code(frie_code);
		dao.update(friend_listVO);
		
		return friend_listVO;
	}
	
	public void deleteFriend_List(String mem_no,String frie_no) {
		dao.delete(mem_no,frie_no);
	}
	
	public Friend_ListVO getOneFriend_List(String mem_no) {
		return dao.findByPrimaryKey(mem_no);
	}
	
	public Friend_ListVO getOneFriend_List2(String mem_no,String frie_no) {
		return dao.findByPrimaryKey2(mem_no,frie_no);
	}
	
	public List<Friend_ListVO> getAll(){
		return dao.getAll();
	}
	
	public Set<Friend_ListVO> getFriend_ListByFrie_code(Integer frie_code) {
		return dao.getFriend_ListByFrie_code(frie_code);
	}
	
	public List<Friend_ListVO> getfriendlist(String mem_no)  {
		return dao.getfriendlist(mem_no);
		
	}
}
