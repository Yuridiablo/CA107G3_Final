package com.restaurant_transaction_list.model;

import java.util.*;



public interface RES_Transaction_ListDAO_Interface {

	//建立一筆交易明細(撥款) ； 建立一筆交易明細(申請提款)
	public void insert(RES_Transaction_ListVO res_transaction_listVO);
	
	//修改狀態碼：1撥款入帳 2申請提款 3提款完成(管理端)
	public void status(RES_Transaction_ListVO res_transaction_listVO);
	
	//用不到
    public void update(RES_Transaction_ListVO res_transaction_listVO);
    //用不到
    public void delete(String trst_no);
    
    //查一筆明細 應該用不到
    public RES_Transaction_ListVO findByPrimaryKey(String trst_no);

     
    //列出全部明細(管理端)
    public List<RES_Transaction_ListVO> getAll();
    
    //取單一間店的全部交易明細
    public List<RES_Transaction_ListVO> getOneVendor(String vendor_no);
}
