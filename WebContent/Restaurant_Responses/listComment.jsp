<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*"%>
<%@page import="com.restaurant_transaction_list.model.*"%>

<jsp:useBean id="cSvc" class="com.comments.model.CommentsService" />
<jsp:useBean id="rrSvc" class="com.restaurant_responses.model.Restaurant_ResponsesService" />
<jsp:useBean id="vVO" scope="session" class="com.vendor.model.VendorVO" />
<jsp:useBean id="rrVO" class="com.restaurant_responses.model.Restaurant_ResponsesVO" />
<jsp:useBean id="cVO" class="com.comments.model.CommentsVO" />

<!doctype html>
<html lang="en">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<title>餐廳管理後台</title>
<!-- Side Nav -->
<style type="text/css">
body {
	background-color: #eee;
	font-family: "微軟正黑體";
}

#sidenavOverlay {
	display: none;
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;
	top: 0;
	z-index: 998;
	background: rgba(0, 0, 0, 0.5);
}

#sidenavOverlay.active {
	display: block;
}

#sidenav {
	position: fixed;
	top: 0;
	bottom: 0;
	width: 280px;
	left: -280px;
	z-index: 999;
	background: #fff;
	color: #000;
}

.fullbar {
	animation-name: full;
	animation-duration: 0.5s;
	animation-fill-mode: both;
}

.invibar {
	animation-name: invi;
	animation-duration: 0.5s;
	animation-fill-mode: forwards;
}

.col-form-label {
	text-align: right;
	font: 18px 微軟正黑體;
}

#refreshconfirm {
	text-align: right;
	margin-bottom: 5px;
}

.btn-primary {
	background-color: orange;
	border-color: orange;
	margin-top: 10%;
}

#topicBar {
	border: 1px;
	border: solid;
	border-color: #7c7c7c;
	background-color: #7c7c7c;
	color: white;
	text-align: center;
	font-size: 20px;
	font-weight: bold;
}

#confirmletter {
	display: inline-block;
	font: 15px/40px Helvetica;
	text-align: center;
	background: #F5F5F5;
	border: 1px solid #cccccc;
	color: #000000;
	margin: 0px 8px 0px 0px;
	position: relative;
	top: -2px; #
	top: 1px;
	cursor: pointer;
	text-decoration: none;
}

.needs-validation {
	margin-top: 15%;
}

.form-row {
	margin-top: 2%;
}

.resTitle {
	font-size: 30px;
	margin-left: 5%;
}

.nav .btn{
	margin-top:80%;
 padding-left: 123px;
 padding-right: 123px;
 box-sizing: border-box;

}

.nav .text-white:hover{
	background-color: #f00;
}

.money{
	font-size: 36px;
	
}
img {
	width: 800px;
	max-width: 500px;
}

.hiddentext, .hiddenbtn{ 
  display:none; 
 } 
 
.hiddenbtn{ 
margin-left: 7%;
 }  
 

@keyframes full {from { left:-280px;
	
}

to {
	left: 0px;
}

}
@keyframes invi {from { left:0px;
	
}

to {
	left: -280px;
}
}

/*.side-nav__section-title {
            color: #202124;
            display: block;
            font-size: 18px;
            padding-bottom: 12px;
            padding-left: 24px;
            padding-top: 40px;
        }       */
</style>
</head>
<!-- ============================================================================= -->

<body>
	<!-- Navbar -->
	
<div class="container">
		<div class="row">
		
				<!-- ===============================編輯區 開始====================================== -->
	

	<div class="list-group">  

<%-- 		<c:if test="${not empty rrVO}"> --%>
	<c:forEach var="rrMap" items="${rrMap}">

<div class="card" style="margin-top:2%">
  <div class="card-header d-flex justify-content-between">
    <span>回應編號${rrMap.key.cmnt_no}</span>
    <span><fmt:formatDate value="${rrMap.key.time}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
   	<c:if test="${rrMap.key.cmnt_no == rrMap.value.cmnt_no}"> 
    <button type="button" class="btn btn-secondary" disabled <%= "aria-disabled='true'" %>>發表回應</button>
 	</c:if>  
    <c:if test="${empty rrMap.value.cmnt_no}"> 
     <button type="button" class="btn btn-success" id="R${rrMap.key.cmnt_no}">發表回應</button>
 	</c:if>  
  </div>
  
  <div class="card-body">
    <h5 class="card-title">評分：${rrMap.key.score}</h5>
    <p class="card-text" style="word-break: break-all">${rrMap.key.cmnt}</p>
    
    
    
    <div class="media">
  
  <div class="media-body">
    <h5 class="mt-0">我的回應</h5>
    <textarea class="form-control hiddentext col-10" id="txt${rrMap.key.cmnt_no}" rows="2"></textarea>
    <button type="button" class="btn btn-info hiddenbtn col-1" id="b${rrMap.key.cmnt_no}">送出</button>
	<div id="T${rrMap.key.cmnt_no}" style="word-break: break-all">
   <c:out value="${rrMap.value.res_text}" default="尚無回應" />
   </div>
<div><fmt:formatDate value="${rrMap.value.res_time}" pattern="yyyy-MM-dd"/></div>
  </div>
</div>

    
  </div>
</div>
	  
	  
<%-- 	  <a href="#" class="list-group-item list-group-item-action">${rtlVO.trst_no}<span><fmt:formatNumber value="${rtlVO.amount}" pattern="#" type="number"/></span></a> --%>
<%-- 	  <a href="#" class="list-group-item list-group-item-action">${rtlVO.trst_no}<span><fmt:formatNumber value="${rtlVO.amount}" pattern="#" type="number"/></span></a> --%>
	  	
	  
	  </c:forEach>
	
  <!-- <a href="#" class="list-group-item list-group-item-action disabled" tabindex="-1" aria-disabled="true">Vestibulum at eros</a> -->
</div>



<div class="col-6">

</div>




			<!-- =================================編輯區 結束==================================== -->

	</div>

	</div>


	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="../front-end/js/jquery-3.3.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
	<!-- Input type=number -->
	<script src="bootstrap-input-spinner.js"></script>
	<!--     sweetalert -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<script>
    $("input[type='number']").inputSpinner()
    </script>
	<!-- Side Nav -->
	<script type="text/javascript">
    $(document).ready(function() {
        $('#btnSidenav').on('click', function(e) {
            $('#sidenav').removeClass('invibar');
            $('#sidenavOverlay').addClass('active');
            $('#sidenav').addClass('fullbar');
        });

        jQuery('#sidenavOverlay').on('click', function() {
            $('#sidenavOverlay').removeClass('active');
            $('#sidenav').removeClass('fullbar');
            $('#sidenav').addClass('invibar');
        });
    });


    </script>
	
	
	<c:forEach var="rrMap" items="${rrMap}">
	<script>

	$('#R${rrMap.key.cmnt_no}').click(function(){
		
// 		alert('${rrMap.key.cmnt_no}');
		$('#T${rrMap.key.cmnt_no}').hide();
		$('#txt${rrMap.key.cmnt_no}').show(500);
		$('#b${rrMap.key.cmnt_no}').show(500);
		$('#txt${rrMap.key.cmnt_no}').focus();
		
		
	})
	
 	
	$('#b${rrMap.key.cmnt_no}').mousedown(function(){
		
		
		$('#T${rrMap.key.cmnt_no}').text($("#txt${rrMap.key.cmnt_no}").val());
		$('#txt${rrMap.key.cmnt_no}').hide();
		$('#b${rrMap.key.cmnt_no}').hide();
		$('#R${rrMap.key.cmnt_no}').attr('disabled', 'disabled');
		$.ajax({
    		url: "<%=request.getContextPath()%>/Restaurant_Responses/Restaurant_Responses.do",
            type : 'post',
			data: { 
				action: 'ajaxInsert', 
				cmnt_no:'${rrMap.key.cmnt_no}',
				res_text: $("#txt${rrMap.key.cmnt_no}").val() 
			},
			dataType: 'json',
			async : false,//同步請求
			cache : false,//不快取頁面
			
    	})
		
	})
	
		$('#txt${rrMap.key.cmnt_no}').blur(function(){
		
		$('#T${rrMap.key.cmnt_no}').show(300);
		$('#txt${rrMap.key.cmnt_no}').hide(300);
		$('#b${rrMap.key.cmnt_no}').hide(300);
		
		
 	})
	
	</script>
	</c:forEach>
	
</body>

</html>