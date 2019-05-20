package com.vendor.model;

import java.text.DecimalFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeFmt {
// 1000 to 10:00
	public static String addSep(String t) {
		return t.substring(0,2).concat(":").concat(t.substring(2,4));
	}
// 10:00 to 1000
	public static String removeSep(String t) {
		return t.substring(0,2).concat(t.substring(3,5));
	}
// 1000 to minutes
	public static int text2minute(String t) {
		int hr = Integer.parseInt(t.substring(0,2));
		int min = Integer.parseInt(t.substring(2,4));
		return hr * 60 + min;
	}
	public static Date text2date(String t) {
		SimpleDateFormat format = new SimpleDateFormat("HHmm");
		java.util.Date time = null;
		try {
			time = format.parse(t);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return time;
	}	
// minute to 01:00
	public static String min2time(Integer t) {
		// 數字
		Format dfm = new DecimalFormat("00");
		return dfm.format(t/60) + ":" + dfm.format(t%60);
	}	
	
}
