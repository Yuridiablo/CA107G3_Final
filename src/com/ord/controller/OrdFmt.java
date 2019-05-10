package com.ord.controller;

public class OrdFmt {
	public static String OrdStatus(int status) {
		String ordStatus = null;
		switch (status) {
		case 1:
			ordStatus = "已付款";
			break;
		case 2:
			ordStatus = "已取消";
			break;
		case 3:
			ordStatus = "待付款";
			break;
		case 4:
			ordStatus = "已核銷";
			break;
		case 5:
			ordStatus = "已失效";
			break;
		default:
			ordStatus = "未定義";
		}
		
		return ordStatus;
	}
	public static void main(String[] args) {
		System.out.println(OrdFmt.OrdStatus(1));
	}
}
