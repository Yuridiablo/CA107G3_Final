package com.article_published.CompositeQuery;

import java.util.Map;
import java.util.Set;

public class jdbcUtil_CompositeQuery_Article_Published {
	public static String get_aCondition_For_Oracle(String columnName,String value) {
		String aCondition = null;
		
		if("art_title".equals(columnName)||("art_content".equals(columnName))){
			aCondition = columnName + " like '%" + value +"%'";
		}
		
		return aCondition + " ";
	}
	
	public static String get_WhereCondition(Map<String,String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for(String key:keys) {
			String value = map.get(key)[0];
			if(value !=null && value.trim().length() !=0 && !"action".equals(key)) {
				count++;
				String aCondition =  get_aCondition_For_Oracle(key,value.trim());
				
				
					whereCondition.append(" and "+aCondition);
				
				System.out.println("有送出查詢資料的欄位數count = "+count);
				
			}
		}
		
		return whereCondition.toString();
	}
}
