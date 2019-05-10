package com.tables.model;

import java.util.*;

public interface TablesDAO_interface {
	public void insert(TablesVO tablesVO);
    public void update(TablesVO tablesVO);
    public void updateBasic(TablesVO tablesVO);
    public void updateAxis(TablesVO tablesVO);
    public void delete(String tbl_no);
    public TablesVO findByPrimaryKey(String tbl_no);
    public List<TablesVO> getAll();
    public List<TablesVO> getAllByVendor_no(String vendor_no);
}
