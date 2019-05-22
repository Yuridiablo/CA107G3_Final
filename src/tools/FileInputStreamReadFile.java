package tools;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.news.model.NewsVO;

public class FileInputStreamReadFile {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA107G3";
	private static final String PASSWORD = "123456";
	private static final String INSERT_MEM_PIC = "UPDATE MEMBER SET MEM_PIC=? WHERE MEM_NO = ?";
	private static final String INSERT_NEWS_PIC = "UPDATE NEWS SET NEWS_PIC=? WHERE NEWS_NO = ?";
	private static final String SELECT_ALL_MENU = "SELECT MENU_NO,MENU_NAME FROM RESTAURANT_MENU order by MENU_NO";
	private static final String INSERT_MENU_PIC = "UPDATE RESTAURANT_MENU SET MENU_PIC=? WHERE MENU_NAME = ?";
	
	
	public static void main(String args[]) throws IOException, InterruptedException {
		insertPic("member",INSERT_MEM_PIC);
		insertPic("news",INSERT_NEWS_PIC);
		insertPicForMenu("restaurant_menu",INSERT_MENU_PIC);
	}
	
	public static void insertPic(String tableName,String sql) throws IOException, InterruptedException {
		Connection con = null;
		PreparedStatement pstmt = null;
		File dir = new File("c:\\picture\\"+tableName);
		File[] picArray = dir.listFiles();
		System.out.println();
		int picLength = picArray.length;
		System.out.println("picLength="+picLength);
		List<byte[]> picList = picStreamFactory(tableName);
		
		
		for(int i=0;i<picLength;i++) {
			if(picArray[i].isFile()) {
				String fileName = picArray[i].getName();
				fileName = fileName.substring(0, fileName.lastIndexOf("."));
				System.out.println("fileName="+fileName);
				try {
					Class.forName("oracle.jdbc.driver.OracleDriver");
					con = DriverManager.getConnection(URL, USER, PASSWORD);

					pstmt = con.prepareStatement(sql);
					pstmt.setBytes(1, picList.get(i));
					pstmt.setString(2, fileName);

					int rowCount = pstmt.executeUpdate();
					System.out.println("更新圖片 " + rowCount + " 筆資料");
					
				} catch (ClassNotFoundException ce) {
					System.out.println(ce);
				} catch (SQLException se) {
					System.out.println(se);
				} finally {

					// 依建立順序關閉資源 (越晚建立越早關閉)
					if (pstmt != null) {
						try {
							pstmt.close();
						} catch (SQLException se) {
							System.out.println(se);
						}
					}

					if (con != null) {
						try {
							con.close();
						} catch (SQLException se) {
							System.out.println(se);
						}
					}
				}
			}

		}
	}
	
	public static void insertPicForMenu(String tableName,String sql) throws IOException, InterruptedException {
		Connection con = null;
		PreparedStatement pstmt = null;
		File dir = new File("c:\\picture\\"+tableName);
		File[] picArray = dir.listFiles();
		int picLength = picArray.length;
		System.out.println("picLength="+picLength);
		Map<String,byte[]> picMap = picStreamFactoryForMenu(tableName);
		
		
		for(int i=0;i<picLength;i++) {
			if(picArray[i].isFile()) {
				String fileName = picArray[i].getName();
				fileName = fileName.substring(0, fileName.lastIndexOf("."));
				System.out.println("fileName="+fileName);
				try {
					Class.forName("oracle.jdbc.driver.OracleDriver");
					con = DriverManager.getConnection(URL, USER, PASSWORD);

					pstmt = con.prepareStatement(sql);
					pstmt.setBytes(1, picMap.get(fileName));
					System.out.println(picMap.get(fileName));
					pstmt.setString(2, fileName);
					System.out.println("fileName="+fileName);

					int rowCount = pstmt.executeUpdate();
					Thread.sleep(500);
					System.out.println("更新菜單圖片 " + rowCount + " 筆資料");

				} catch (ClassNotFoundException ce) {
					System.out.println(ce);
				} catch (SQLException se) {
					System.out.println(se);
				} finally {

					// 依建立順序關閉資源 (越晚建立越早關閉)
					if (pstmt != null) {
						try {
							pstmt.close();
						} catch (SQLException se) {
							System.out.println(se);
						}
					}

					if (con != null) {
						try {
							con.close();
						} catch (SQLException se) {
							System.out.println(se);
						}
					}
				}
			}

		}
	}
	

	
	public static List<byte[]> picStreamFactory(String picType) throws IOException {
		File dir = new File("c:\\picture\\"+picType);
		File[] picArray = dir.listFiles();
		List<byte[]> picList = new ArrayList<byte[]>();
		
		for(int j =0;j<picArray.length;j++) {
			if(picArray[j].isFile()) {
				String picAbsolutePath = picArray[j].getAbsolutePath();
				byte[] pic = null;
				FileInputStream in = new FileInputStream(picAbsolutePath);
				ByteArrayOutputStream output = new ByteArrayOutputStream();
				pic = new byte[in.available()];
				for (int length = 0; (length = in.read(pic)) > 0;) {
					output.write(pic, 0, length);
					picList.add(pic);
				}
				output.close();
				in.close();
			}

		}
		
		return picList;
	}
	
	public static Map<String,byte[]> picStreamFactoryForMenu(String picType) throws IOException {
		File dir = new File("c:\\picture\\"+picType);
		File[] picArray = dir.listFiles();
		Map<String,byte[]> picMap = new HashMap<String,byte[]>();
		
		for(int j =0;j<picArray.length;j++) {
			if(picArray[j].isFile()) {
				String picAbsolutePath = picArray[j].getAbsolutePath();
				String fileName = picArray[j].getName();
				fileName = fileName.substring(0, fileName.lastIndexOf("."));
				byte[] pic = null;
				FileInputStream in = new FileInputStream(picAbsolutePath);
				ByteArrayOutputStream output = new ByteArrayOutputStream();
				pic = new byte[in.available()];
				for (int length = 0; (length = in.read(pic)) > 0;) {
					output.write(pic, 0, length);
					System.out.println("picLength="+pic.length);
					picMap.put(fileName, pic);
					System.out.println("fileName="+fileName);
				}
				output.close();
				in.close();
			}

		}
		
		return picMap;
	}
	

	
//	public static Map<String,String> menuMapFactory() throws IOException, InterruptedException {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		Map<String,String> menuMap = new HashMap<String,String>();
//		ResultSet rs = null;
//		
//				try {
//					Class.forName("oracle.jdbc.driver.OracleDriver");
//					con = DriverManager.getConnection(URL, USER, PASSWORD);
//
//					pstmt = con.prepareStatement(SELECT_ALL_MENU);
//
//					rs = pstmt.executeQuery();
//					
//					while (rs.next()) {
//						menuMap.put(rs.getString("menu_no"), rs.getString("news_no"))
//					}
//
//				} catch (ClassNotFoundException ce) {
//					System.out.println(ce);
//				} catch (SQLException se) {
//					System.out.println(se);
//				} finally {
//
//					// 依建立順序關閉資源 (越晚建立越早關閉)
//					if (pstmt != null) {
//						try {
//							pstmt.close();
//						} catch (SQLException se) {
//							System.out.println(se);
//						}
//					}
//
//					if (con != null) {
//						try {
//							con.close();
//						} catch (SQLException se) {
//							System.out.println(se);
//						}
//					}
//				}
//		
//
//		
//	}
}
