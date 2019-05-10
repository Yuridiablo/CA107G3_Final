package com.friend_list.model;

import java.util.List;
import java.util.Set;

public interface Friend_ListDAO_interface {
	public void insert(Friend_ListVO friend_listVO);
    public void update(Friend_ListVO friend_listVO);
    public void delete(String mem_no,String frie_no);
    public Friend_ListVO findByPrimaryKey(String mem_no);
    public Friend_ListVO findByPrimaryKey2(String mem_no,String frie_no);
    public List<Friend_ListVO> getAll();
    public Set<Friend_ListVO> getFriend_ListByFrie_code(Integer frie_code);
    public List<Friend_ListVO>getfriendlist(String mem_no);

}
