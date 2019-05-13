package com.tables.controller;

public class TblFmt {
	public static String statusFmt(Integer status) {
		String fmt = null;
		switch(status) {
		case 0:
			fmt = "空桌";
			break;
		case 1:
			fmt = "已入座"; // has Bill
			break;
		case 2:
			fmt = "清潔中";
			break;
		case 3:
			fmt = "保留"; // for Ord
			
			break;		
		}
		return fmt;
	}
	
	public static String colorFmt(Integer tblStatus, Integer billStatus) {
		String fmt = null;
		switch(tblStatus) {
		case 0:
			fmt = "#5c5c8a";
			break;
		case 1:
			switch(billStatus) {
			case 1:
				fmt = "#668cff";
				break;
			case 2:
				fmt = "#d966ff";
				break;	
			}
			break;
		case 2:
			fmt = "#71da71";
			break;
		case 3:
			fmt = "#b8b894"; // for Ord
			
			break;		
		}
		return fmt;
	}	
}
