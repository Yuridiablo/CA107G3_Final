package com.tables.controller;

public class BillFmt {
	public static String statusFmt(Integer status) {
		String fmt = null;
		switch(status) {
		case 0:
			fmt = "已驗證";
			break;
		case 1:
			fmt = "已入座";
			break;
		case 2:
			fmt = "用餐中";
			break;
		case 3:
			fmt = "已結帳";
			break;
		case 4:
			fmt = "訂位";
			break;
		case 5:
			fmt = "No Show";
			break;
		}
		return fmt;
	}
	public static String sourceFmt(Integer source, int type) {
		String fmt = null;
		if (type == 1) {
			switch(source) {
			case 1:
				fmt = "訂位";
				break;
			case 2:
				fmt = "候位";
				break;
			case 3:
				fmt = "散客";
				break;		
			}
		} else if (type == 2) {
			switch(source) {
			case 1:
				fmt = "B";
				break;
			case 2:
				fmt = "W";
				break;
			case 3:
				fmt = "WI";
				break;		
			}
		}
		
		return fmt;
	}
}
