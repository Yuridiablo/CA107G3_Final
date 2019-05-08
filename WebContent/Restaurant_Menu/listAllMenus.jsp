
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
<%@page import="com.restaurant_menu.model.*"%>


<% 
	Restaurant_MenuService rmSvc = new Restaurant_MenuService();
	List<Restaurant_MenuVO> list = rmSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<jsp:useBean id="vSvc" scope="session" class="com.vendor.model.VendorService" />

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<meta charset="UTF-8">
<title>管理員後台-全站菜單管理</title>

<style>
img{
max-width:300px;
}
</style>
</head>
<body>
 <h4><a href="chooseVendor.jsp">回選擇頁</a></h4>
<table border=1>
	<tr>

		<th>品項編號</th>
		<th>廠商編號</th>
		<th>廠商名稱</th>
		<th>品名</th>
		<th>價格</th>
		<th>圖片</th>
		<th>狀態</th>
		<th>說明文字</th>

	</tr>
	
<c:forEach var="Restaurant_MenuVO" items="${list}">

	<tr>

		<td>${Restaurant_MenuVO.menu_no}</td>
        <td>${Restaurant_MenuVO.vendor_no}</td>
        <td>${vSvc.findByPK(Restaurant_MenuVO.getVendor_no()).v_name}</td>
        <td>${Restaurant_MenuVO.menu_name}</td>
        <td>${Restaurant_MenuVO.menu_price}</td>
        
        <td><img src="<%= request.getContextPath()%>/ShowImg.do?menu_no='${Restaurant_MenuVO.menu_no}'"></td>
		
        <td>${Restaurant_MenuVO.menu_stat}</td>
        <td><textarea cols="50" rows="5">${Restaurant_MenuVO.menu_text}</textarea></td>

		<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Restaurant_Menu/Restaurant_Menu.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="menu_no" value="${Restaurant_MenuVO.menu_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Restaurant_Menu/Restaurant_Menu.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			 	 <input type="hidden" name="menu_no" value="${Restaurant_MenuVO.menu_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>

	</tr>
</c:forEach>

</table>

</body>
</html>