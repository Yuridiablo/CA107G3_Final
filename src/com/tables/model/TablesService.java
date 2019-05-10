package com.tables.model;

import java.util.List;

import com.tables.model.TablesDAO_interface;
import com.tables.model.TablesJDBCDAO;
import com.tables.model.TablesVO;

public class TablesService {
	private TablesDAO_interface dao;
	
	public TablesService() {
		dao = new TablesJDBCDAO();
	}
	
	public TablesVO addTables(String vendor_no, String tbl_name, Integer tbl_size, Integer tbl_type, Integer tbl_x, Integer tbl_y) {
		TablesVO tablesVO = new TablesVO();
		tablesVO.setVendor_no(vendor_no);
		tablesVO.setTbl_name(tbl_name);
		tablesVO.setTbl_size(tbl_size);
		tablesVO.setTbl_type(tbl_type);
		tablesVO.setTbl_x(tbl_x);
		tablesVO.setTbl_y(tbl_y);
		dao.insert(tablesVO);
		return tablesVO;
		
		 
	}

	public TablesVO updateTables(String tbl_no, String vendor_no, String tbl_name, Integer tbl_size, Integer tbl_type, Integer tbl_x, Integer tbl_y) {
		TablesVO tablesVO = new TablesVO();
		tablesVO.setTbl_no(tbl_no);
		tablesVO.setVendor_no(vendor_no);
		tablesVO.setTbl_name(tbl_name);
		tablesVO.setTbl_size(tbl_size);
		tablesVO.setTbl_type(tbl_type);
		tablesVO.setTbl_x(tbl_x);
		tablesVO.setTbl_y(tbl_y);
		dao.update(tablesVO);
		return tablesVO;
	}
	
	public void updateTablesBasic(String tbl_no, String tbl_name, Integer tbl_size) {
		TablesVO tablesVO = new TablesVO();
		tablesVO.setTbl_no(tbl_no);
		tablesVO.setTbl_name(tbl_name);
		tablesVO.setTbl_size(tbl_size);
		dao.updateBasic(tablesVO);
	}
	
	public void updateTablesAxis(String tbl_no, Integer tbl_type, Integer tbl_x, Integer tbl_y) {
		TablesVO tablesVO = new TablesVO();
		tablesVO.setTbl_no(tbl_no);
		tablesVO.setTbl_type(tbl_type);
		tablesVO.setTbl_x(tbl_x);
		tablesVO.setTbl_y(tbl_y);
		dao.updateAxis(tablesVO);
	}

	public void deleteTables(String tbl_no) {
		dao.delete(tbl_no);
	}

	public TablesVO getOneTables(String tbl_no) {
		return dao.findByPrimaryKey(tbl_no);
	}

	public List<TablesVO> getAll() {
		return dao.getAll();
	}
	
	public List<TablesVO> getAllByVendor_no(String vendor_no) {
		return dao.getAllByVendor_no(vendor_no);
	}
	
	public static void main(String[] args) {
		TablesService ts = new TablesService();
		ts.addTables("V000001", "T1", 1, 1, 500, 500);
		ts.getAllByVendor_no("V000001");
		
	}
}
