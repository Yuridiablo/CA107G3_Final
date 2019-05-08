<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.restaurant_menu.model.*"%>
<%@ page import="com.vendor.model.*" %>
<%@page import="java.util.List"%>

<%
	Restaurant_MenuVO rmVO = (Restaurant_MenuVO)request.getAttribute("rmVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
	out.print(rmVO);
	List<Restaurant_MenuVO> vlist = (List<Restaurant_MenuVO>)request.getAttribute("vlist"); 
	out.print(vlist);
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function changePic(e) {		
		
  		document.getElementsByTagName("img")[0].src = URL.createObjectURL(event.target.files[0]); 		
	}
</script>
<style>
img{
max-width:300px;
}

</style>
</head>
<body>


<table id="table-1" data-toggle="table"
  data-url="data1.json"
  data-pagination="true"
  data-search="true">
	<tr><td>
		 <h3>新增一筆菜單 - addMenu.jsp</h3>
		 <h4><a href="chooseVendor.jsp">回列表</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<%-- 錯誤表列 --%>
<FORM METHOD="post" ACTION="Restaurant_Menu.do" name="form1" enctype="multipart/form-data" >
<table>
<!-- 	<tr> -->
<!-- 		<td>品項編號:<font color=red><b>*</b></font></td> -->
<%-- 		<td>${rmVO.menu_no}</td> --%>
<!-- 	</tr> -->
	<tr>
		<td>廠商編號:<font color=red><b>*</b></font></td>
		<td>${vendor_no}</td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td>廠商編號:</td> -->
<%-- 		<td><input type="TEXT" name="vendor_no" size="45" value="${rmVO.vendor_no}" /></td> --%>
<!-- 	</tr> -->
	<tr>
		<td>品名:</td>
		<td><input type="TEXT" name="menu_name" size="45"	value="${rmVO.menu_name}" /></td>
	</tr>
	<tr>
		<td>圖片:</td>
		<td><input type="file" name="menu_pic" onchange="changePic(event)"></td>
	</tr>
	<tr>
		<td>價格:</td>
		<td><input type="TEXT" name="menu_price" size="45"	value="${rmVO.menu_price}" /></td>
	</tr>
	<tr>
		<td>狀態:</td>
<%-- 		<td><input type="TEXT" name="menu_stat" size="45"	value="${rmVO.menu_stat}" /></td> --%>
		<td>
		<select name="menu_stat">
		　<option value="1">上架</option>
		　<option value="2">下架</option>
		　<option value="3">審核中</option>
		　<option value="4">黑名單</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>說明:</td>
		<td><input type="TEXT" name="menu_text" size="45"	value="${rmVO.menu_text}" /></td>
	</tr>
	
</table>
<input type="hidden" name="action" value="insertOneFood">
<input type="hidden" name="vendor_no" value="${vendor_no}">
<%-- <input type="hidden" name="menu_no" value="${rmVO.menu_no}"> --%>
<input type="submit" value="送出"></FORM>
<img src="" alt="">
</body>
</html>