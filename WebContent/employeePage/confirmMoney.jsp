<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.vendor.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>廠商撥款作業</title>
</head>
<body>
<div class="container ">
        <div class="row justify-content-center">
            <div class="col-12 table-responsive">
<h1>餐廳撥款作業</h1>
<table class="table table-hover table-dark">
  <thead>
    <tr>
      <th scope="col">店家編號</th>
      <th scope="col">店家名稱</th>
      <th scope="col">申請編號</th>
      <th scope="col">申請金額</th>
      <th scope="col">申請時間</th>
      <th>狀態操作</th>
    </tr>
  </thead>
  <tbody>
  
<c:forEach var="rtl" items="${rtlMap}" varStatus="status">
    <tr>
    <fmt:parseNumber var = "i" type = "number" value = "${rtl.value.amount}" />
      <th scope="row">${rtl.key.vendor_no}</th>
      <td>${rtl.key.v_name}</td>
      <td>${rtl.value.trst_no}</td>
      <td><c:out value="${-i}" /></td>
      <td><fmt:formatDate value="${rtl.value.pay_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
      <td><button type="button" class="btn btn-warning" id="yes${rtl.key.vendor_no}">確認完成</button></td>
      
    </tr>
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
  
<c:forEach var="rtl" items="${rtlMap}">
<fmt:parseNumber var = "i" type = "number" value = "${rtl.value.amount}" />
<script>

	$('#yes${rtl.key.vendor_no}').click(function(){

		$.ajax({
    		url: "<%=request.getContextPath()%>/RES_Transaction_List/RES_Transaction_List.do",
            type : 'post',
			data: { action : 'ajaxconfirmed', status : '2' , vendor_no : '${rtl.key.vendor_no}' , amount : '<c:out value="${-i}" />' } ,
			dataType: 'json',
			async : false,//同步請求
			cache : false,//不快取頁面
			success: function(res){
				$('#yes${rtl.key.vendor_no}').attr('disabled', true);	
				$('#yes${rtl.key.vendor_no}').text(res.ok);
			}
	   	})
		
	})
	

</script>
</c:forEach>   

</body>
</html>