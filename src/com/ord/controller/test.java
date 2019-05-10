package com.ord.controller;

public class test {

	public static void main(String[] args) {
		
		
		System.out.println(randomString(10)); 
		System.out.println(randomString(9)); 
		System.out.println(randomString(8)); 
		
		
		
			} 
	

	private static String randomString(int xxx) {
		String str = "0123456789abcdefghijklmnopqrstuvwxyz"; 
		StringBuffer sb = new StringBuffer(); 
		for (int i = 0; i < xxx; i++) { 
		int idx = (int)(Math.random() * str.length()); 
		sb.append(str.charAt(idx)); 
		
	}
		return  sb.toString(); 
}
}
