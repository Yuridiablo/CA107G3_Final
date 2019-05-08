<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.restaurant_menu.model.*" %>
<%@ page import="com.vendor.model.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<meta charset="UTF-8">
<title>選擇一家廠商</title>
</head>
<body>

<h3>挑選一家廠商開始操作</h3>

<%--   <jsp:useBean id="rmSvc" scope="page" class="com.restaurant_menu.model.Restaurant_MenuService" /> --%>
  <jsp:useBean id="vSvc" scope="session" class="com.vendor.model.VendorService" />
     <FORM METHOD="post" ACTION="Restaurant_Menu.do" >
       <b>廠商編號:</b>
       <select size="1" name="vendor_no">
         <c:forEach var="vVO" items="${vSvc.all}" > 
<%--           <option value="${vVO.vendor_no}">${vVO.vendor_no} --%>
<!-- EL傳參數取值  -->
          <option value="${vVO.vendor_no}">${vSvc.findByPK(vVO.vendor_no).v_name}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_List">
<%--        <input type="hidden" name="vendor_no" value="${vVO.vendor_no}"> --%>
       <input type="submit" value="送出">
    </FORM>
<br><br><br><br><br>
<h3>直接列出資料庫全部清單</h3>
<a href='listAllMenus.jsp'>列出全部</a>
</body>
</html>