<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.vendor.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>
<div class="container ">
        <div class="row justify-content-center">
            <div class="col-12 table-responsive">
<h1>新註冊餐廳審核</h1>
<table class="table table-hover table-dark">
  <thead>
    <tr>
      <th scope="col">店家編號</th>
      <th scope="col">申請名稱</th>
      <th scope="col">聯絡電話</th>
      <th scope="col">電子信箱</th>
      <th>狀態操作</th>
    </tr>
  </thead>
  <tbody>
  
<c:forEach var="vVO" items="${vlistConfirm}" varStatus="status">
<c:if test="${vVO.v_status == 2}">
    <tr>
    
      <th scope="row">${vVO.vendor_no}</th>
      <td>${vVO.v_name}</td>
      <td>${vVO.v_n_code}-${vVO.v_tel}</td>
      <td>${vVO.v_mail}</td>
      <td><button type="button" class="btn btn-warning" id="yes${vVO.vendor_no}">核准</button><button type="button" class="btn btn-secondary" id="no${vVO.vendor_no}">婉拒</button></td>
      
    </tr>
</c:if>
</c:forEach>    
  </tbody>
</table>
       </div>
        </div>
    </div>

<!-- <h1>餐廳檢舉審核</h1> 餐廳檢舉(不是我的)  -->
<!-- <table class="table table-hover table-dark"> -->
<!--   <thead> -->
<!--     <tr> -->
<!--       <th scope="col">店家編號</th> -->
<!--       <th scope="col">店家名稱</th> -->
<!--       <th scope="col">檢舉者</th> -->
<!--       <th scope="col">事由</th> -->
<!--       <th scope="col">時間</th> -->
<!--       <th>狀態操作</th> -->
<!--     </tr> -->
<!--   </thead> -->
<!--   <tbody> -->
 
<%-- <c:forEach var="vVO" items="${vlistConfirm}" varStatus="status"> --%>
<%-- <c:if test="${vVO.v_status == 3}"> --%>
<!--     <tr> -->
    
<%--       <th scope="row">${vVO.vendor_no}</th> --%>
<%--       <td>${vVO.v_name}</td> --%>
<%--       <td>${vVO.v_n_code}-${vVO.v_tel}</td> --%>
<%--       <td>${vVO.v_mail}</td> --%>
<%--       <td>${vVO.v_mail}</td> --%>
<!--       <td><button type="button" class="btn btn-warning">黑單</button><button type="button" class="btn btn-secondary">駁回</button></td> -->
      
<!--     </tr> -->
<%-- </c:if> --%>
<%-- </c:forEach>     --%>
<!--   </tbody> -->
<!-- </table> -->
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<c:forEach var="vVO" items="${vlistConfirm}" varStatus="status">
<c:if test="${vVO.v_status == 2}">
<script>

	$('#yes${vVO.vendor_no}').click(function(){

		$.ajax({
    		url: "<%=request.getContextPath()%>/Vendor/Vendor.do",
            type : 'post',
			data: { action : 'ajaxUpStatus', status : '1' , vendor_no : '${vVO.vendor_no}' } ,
			dataType: 'json',
			async : false,//同步請求
			cache : false,//不快取頁面
			success: function(res){
				$('#no${vVO.vendor_no}').css('display','none');
				$('#yes${vVO.vendor_no}').attr('disabled', true);	
				$('#yes${vVO.vendor_no}').text(res.ok);
			}
	   	})
		
	})
	
	$('#no${vVO.vendor_no}').click(function(){

		$.ajax({
    		url: "<%=request.getContextPath()%>/Vendor/Vendor.do",
            type : 'post',
			data: { action : 'ajaxUpStatus', status : '3' , vendor_no : '${vVO.vendor_no}' } ,
			dataType: 'json',
			async : false,//同步請求
			cache : false,//不快取頁面
			success: function(res){
				$('#yes${vVO.vendor_no}').css('display','none');
				$('#no${vVO.vendor_no}').attr('disabled', true);	
				$('#no${vVO.vendor_no}').text(res.notok);
			}
	   	})
		
	})

</script>
</c:if>
</c:forEach>   

</body>
</html>