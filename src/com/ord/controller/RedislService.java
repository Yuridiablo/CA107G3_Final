package com.ord.controller;

import javax.mail.MessagingException;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.Response;
import redis.clients.jedis.Transaction;

public class RedislService {
	
	public void insettotal(String total ,String amount) {
	
		//建立連線
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		
//		//放分攤金額及分攤會員編號
		jedis.set(total, amount);

		jedis.close();
	}
	
	public void insertshare (String share_mem,String share_amount) {
		
		//建立連線
				Jedis jedis = new Jedis("localhost", 6379);
				jedis.auth("123456");
				
				jedis.set(share_mem,share_amount);
				jedis.close();
	}
	public String gettotal(String total) {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		 
		String total_amount=(jedis.get(total));
		return total_amount;
	}
	
	public boolean forcheck(String pay_name,String pay_amount ) {
		//建立連線
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		
		//檢查金額
		String  share_amount = jedis.get(pay_name);
		if(share_amount.equals(pay_amount)) {
			return true;
		}
		
		return false;
		
	}
	
	
	
	
	// 建立連線
	public static void main(String[] args) {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
	
		jedis.rpush("1000", "500","500");
		
		
		
		
		jedis.close();
	}
	

}

