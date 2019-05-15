package com.tables.controller;

import java.util.PriorityQueue;
import com.tables.model.TablesVO;

public class Tbl {
	TablesVO tblVO;
	Integer status = 0;
	Bill bill;
	// PriorityQueue<Bill> schedule;
	// Timer
	public Tbl(TablesVO tblVO) {
		this.tblVO = tblVO;
	}
	
	public TablesVO getTblVO() {
		return tblVO;
	}
	public void setTblVO(TablesVO tblVO) {
		this.tblVO = tblVO;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Bill getBill() {
		return bill;
	}
	public void setBill(Bill bill) {
		this.bill = bill;
	}

	@Override
	public String toString() {
		return "Tbl [tblVO=" + tblVO + ", status=" + status + ", bill=" + bill + "]";
	}
	
	
}
