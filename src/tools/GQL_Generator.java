package tools;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class GQL_Generator {
	// 關鍵字搜尋
	private static final String TEXT_SEARCH_URL = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
			+ "query=高雄+龍蝦" 
			+ "&language=zh-TW" 
			+ "&key=AIzaSyCmWtV4d_p--xPdfSbOpQ9CvG3JHoXqI4s";
	
	private static final String TEXT_SEARCH_DETAIL_URL = "https://maps.googleapis.com/maps/api/place/details/json?"
			+ "placeid=ChIJRXVv-Qo9aTQR9usep0C10Gw" 
//			+ "&fields=formatted_phone_number"
			+ "&language=zh-TW" 
			+ "&key=AIzaSyCmWtV4d_p--xPdfSbOpQ9CvG3JHoXqI4s";
	
	private static final String TEXT_SEARCH_FINDPLACEFROMTEXT_URL = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?"
			+ "input=龍蝦" 
			+ "&inputtype=textquery"
			+ "&fields=photos,formatted_address,name,rating,opening_hours,geometry"
			+ "&language=zh-TW" 
			+ "&key=AIzaSyCmWtV4d_p--xPdfSbOpQ9CvG3JHoXqI4s";



	@SuppressWarnings("unchecked")
	public static void main(String[] args) throws Exception {
//		Gson gson = new Gson();
//		// 讀回json字串
//		InputStream is = new URL(TEXT_SEARCH_URL).openStream();
//		BufferedReader br = new BufferedReader(new InputStreamReader(is));
//		StringBuilder sb = new StringBuilder();
//		String str;
//		while ((str = br.readLine()) != null)
//			sb.append(str);
//		br.close();
//		System.out.println(sb);
		
		String wholeCityArray[] = {"基隆","台北","桃園","新竹","苗栗","新北","台中","彰化","南投","雲林","嘉義","台南","高雄","屏東","宜蘭","花蓮","台東"};	
		List<String> wholeCityList =  Arrays.asList(wholeCityArray);

		
		Set repeatCheckSet = new HashSet();
		Gson gson = new Gson();
		
	for(int j=0;j<wholeCityList.size();j++) {



		String sb = jsonDataFactory(wholeCityList.get(j),"龍蝦");

		

		// 解析json內容
		try {
			if (sb.length() > 0) {
				JsonObject jObj = gson.fromJson(sb, JsonObject.class);
				String nextPageToken=null;
				while(nextPageToken!="end"||nextPageToken.equals("lastTime")) {
					JsonArray jArray = jObj.get("results").getAsJsonArray();
					for (int i = 0; i < jArray.size(); i++) {

						JsonObject obj = jArray.get(i).getAsJsonObject();
						String id = obj.get("place_id").getAsString();
						String detailData = detailDataFactory(id);
						JsonObject detailObj = gson.fromJson(detailData, JsonObject.class);
						String status = detailObj.get("status").getAsString();
						while(!status.equals("OK")) {
							 Thread.sleep(10000);
							 detailData = detailDataFactory(id);
							 detailObj = gson.fromJson(detailData, JsonObject.class);
							 status = detailObj.get("status").getAsString();
						}

							JsonObject resultObj = detailObj.get("result").getAsJsonObject();
							JsonArray addressArray = resultObj.get("address_components").getAsJsonArray();
							
							String v_address1 = addressArray.get(3).getAsJsonObject().get("long_name").getAsString();
							String v_address2 = null;
							String v_address3 = null;
							if(v_address1.contains("台灣")) {
								v_address1 = addressArray.get(2).getAsJsonObject().get("long_name").getAsString();
								v_address2 = addressArray.get(1).getAsJsonObject().get("long_name").getAsString();
								v_address3 = addressArray.get(0).getAsJsonObject().get("long_name").getAsString();
							}else if(v_address1.contains("區")){
								v_address1 = addressArray.get(4).getAsJsonObject().get("long_name").getAsString();
								v_address2 = addressArray.get(3).getAsJsonObject().get("long_name").getAsString();
								v_address3 = addressArray.get(1).getAsJsonObject().get("long_name").getAsString()+
										addressArray.get(0).getAsJsonObject().get("long_name").getAsString();
							}else{ 
								v_address2 = addressArray.get(2).getAsJsonObject().get("long_name").getAsString();
								v_address3 = addressArray.get(1).getAsJsonObject().get("long_name").getAsString()+
										addressArray.get(0).getAsJsonObject().get("long_name").getAsString();
							}
							

//							if(v_address3.lastIndexOf("號")==-1) {
//								v_address3 = v_address3+"號";
//							}
							String v_name = resultObj.get("name").getAsString();
							if(v_name.contains("'")) {
								v_name=v_name.replaceAll("'", "");
							}
							String v_type = randType();
							
							String v_account=null;
							int preLength = repeatCheckSet.size();
							while(repeatCheckSet.size()<=preLength) {
								String repeatTestCode = returnRandCode();
								repeatCheckSet.add(repeatTestCode);
								v_account=repeatTestCode;
							}
							
							String v_mail = v_account+"@gmail.com"; 
							
							String insertSql = sqlFactory(v_account, v_mail, v_address1, v_address2, v_address3, v_name, v_type);
							System.out.println(insertSql);


					}
					if(jObj.has("next_page_token")) {
						nextPageToken = jObj.get("next_page_token").getAsString();
						String nextSb = nextDataFactory(nextPageToken);
						jObj = gson.fromJson(nextSb, JsonObject.class);

					}else if(nextPageToken!=null&&!nextPageToken.equals("lastTime")) {
						nextPageToken="lastTime";
					}else {
						nextPageToken="end";
					}
				}

			}
		}catch(Exception e){
			
		}

	}
}
	
	public static String sqlFactory(String v_account,String v_mail,String v_address1,String v_address2,String v_address3,String v_name,String v_type) {
		StringBuilder sb = new StringBuilder();
		String sqlHead = "INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0')"; 
		String v_pwd = ",'fake123456'";
		String v_tel = ",'0987987987'";
		String v_n_code = ",'07'";
		String v_ad_code = ",'801'";
		String v_wallet = ",'100'";
		String v_w_no = ",'55'";
		String v_n_no = ",'66'";
		String v_alt_no = ",'77'";
		String v_start_time = ",'0900'";
		String v_end_time = ",'2000'";
		String v_day = ",'1111111'";
		String v_tables = ",'202'";
		String v_pic = ",Null";
		String v_ad = ",Null";
		String v_status = ",'1'";
		String v_wait_status = ",'0'";
		String v_text = ",Null";
		sb.append(sqlHead);
		sb.append(","+"'"+v_account+"'");
		sb.append(v_pwd);
		sb.append(","+"'"+v_mail+"'");
		sb.append(v_tel);
		sb.append(v_n_code);
		sb.append(v_ad_code);
		sb.append(","+"'"+v_address1+"'");
		sb.append(","+"'"+v_address2+"'");
		sb.append(","+"'"+v_address3+"'");
		sb.append(v_wallet);
		sb.append(","+"'"+v_name+"'");
		sb.append(v_w_no);
		sb.append(v_n_no);
		sb.append(v_alt_no);
		sb.append(v_start_time);
		sb.append(v_end_time);
		sb.append(v_day);
		sb.append(v_tables);
		sb.append(v_pic);
		sb.append(v_ad);
		sb.append(v_status);
		sb.append(v_wait_status);
		sb.append(","+"'"+v_type+"'");
		sb.append(v_text+");");
		
		
		String sql = sb.toString();
		return sql;
		
		
		
	}
	
	private static String returnRandCode() {
		StringBuilder sb = new StringBuilder();
		for (int i = 1; i <= 8; i++) {
			int condition = (int) (Math.random() * 3) + 1;
			switch (condition) {
			case 1:
				char c1 = (char)((int)(Math.random() * 26) + 65);
				sb.append(c1);
				break;
			case 2:
				char c2 = (char)((int)(Math.random() * 26) + 97);
				sb.append(c2);
				break;
			case 3:
				sb.append((int)(Math.random() * 10));
			}
		}
		return sb.toString();
	}
	
	public static String jsonDataFactory(String position,String type) throws IOException {
		String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
				+ "query="+position+"+"+type
				+ "&language=zh-TW" 
				+ "&key=AIzaSyCmWtV4d_p--xPdfSbOpQ9CvG3JHoXqI4s";
		Gson gson = new Gson();
		// 讀回json字串
		InputStream is = new URL(url).openStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(is));
		StringBuilder sb = new StringBuilder();
		String str;
		while ((str = br.readLine()) != null)
			sb.append(str);
		br.close();
		
		return sb.toString();
	}
	
	public static String detailDataFactory(String id) throws IOException {
		String url = "https://maps.googleapis.com/maps/api/place/details/json?"
				+ "placeid="+id 
//				+ "&fields=formatted_phone_number"
				+ "&language=zh-TW" 
				+ "&key=AIzaSyCmWtV4d_p--xPdfSbOpQ9CvG3JHoXqI4s";
		
		Gson gson = new Gson();
		// 讀回json字串
		InputStream is = new URL(url).openStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(is));
		StringBuilder sb = new StringBuilder();
		String str;
		while ((str = br.readLine()) != null)
			sb.append(str);
		br.close();
		
		return sb.toString();
	}
	
	public static String randType() {
		String randType[] = {"中式料理","美式餐廳","日式料理","義式料理","東南亞風味"};
		Random random = new Random();
		int randIndex = random.nextInt(4)+1;
		
		String type = randType[randIndex];
		
		return type;
		
	}
	
	public static String nextDataFactory(String pageToken) throws IOException {
		String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
					+"pagetoken="+pageToken
					+ "&key=AIzaSyCmWtV4d_p--xPdfSbOpQ9CvG3JHoXqI4s";
		
	
		Gson gson = new Gson();
		// 讀回json字串
		InputStream is = new URL(url).openStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(is));
		StringBuilder sb = new StringBuilder();
		String str;
		while ((str = br.readLine()) != null)
			sb.append(str);
		br.close();
		
		return sb.toString();
	}

}
