<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*"%>
<%@page import="com.restaurant_transaction_list.model.*"%>

<jsp:useBean id="rtlSvc" class="com.restaurant_transaction_list.model.RES_Transaction_ListService" />

<jsp:useBean id="vVO" scope="session" class="com.vendor.model.VendorVO" />
<jsp:useBean id="rtlVO" class="com.restaurant_transaction_list.model.RES_Transaction_ListVO" />

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


.swal2-range input {
width:100%;
}

.swal2-range output{
width:50%;
}

#waitmoney{
visibility : hidden;
border-radius: 5px 5px 0 0;
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
				<!-- ===============================編輯區 開始====================================== -->
<body>
<div class="col-6">
	<h1>交易明細</h1>
</div>

  
<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">時間</th>
      <th scope="col">明細編號</th>
      <th scope="col">訂單編號</th>
      <th scope="col">收入</th>
      <th scope="col">提款</th>
    </tr>
  </thead>
  <tbody>
  
  <c:forEach var="rtlVO" items="${rtlSvc.getOneVendor(vVO.vendor_no)}" varStatus="status">
<!--   交易金額格式化 -->
	<fmt:parseNumber var = "i" type = "number" value = "${rtlVO.amount}" />
	<c:if test="${rtlVO.v_wallet != 3}">
	<tr>
      <th scope="row">${ status.index + 1}</th>
      <td><fmt:formatDate value="${rtlVO.pay_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
      <td>${rtlVO.trst_no}</td>
      <td><c:out value="${rtlVO.ord_no}" default="-" /></td>
      <c:if test="${i > 0}">
      <td><c:out value="${i}" /></td>
      <td>-</td>
      </c:if>
      <c:if test="${i < 0}">
      <td>-</td>
      <td><c:out value="${-i}" /></td>
      </c:if>
     
    </tr>
	 </c:if> 
	</c:forEach>
    
   
  </tbody>
</table>

	
	<!-- Navbar -->
		<h1 class="container d-flex justify-content-end">帳戶餘額<button type="button" class="btn btn-success btn-lg" id="withdrawal">提款</button></h1>
<div class="container d-flex justify-content-end">

		<div class="row">
		
<!-- 	錢包餘額格式化 -->
	<fmt:parseNumber var = "v_wallet" type = "number" value = "${vVO.v_wallet}" />
	<div class="list-group">
	
<!-- 	那顆轉轉 -->
	<button class="btn btn-primary" type="button" disabled id="waitmoney">
	  <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
	  <span class="sr-only"></span>
	  <span id="waitres"></span>
	 <span>等待撥款中</span>
	</button>
	 
	  <a href="#" class="list-group-item list-group-item-action active money" id="balance">
	    $${v_wallet}
	  </a>
 
	
  <!-- <a href="#" class="list-group-item list-group-item-action disabled" tabindex="-1" aria-disabled="true">Vestibulum at eros</a> -->
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



<script>

$("#withdrawal").click(function(){

	Swal.fire({
	  title: '輸入提款金額',
	  input: 'range',
	  inputAttributes: {
	    min: 10000,
	    max: '${vVO.v_wallet}',
	    step: 1000
	  },
	  inputValue: '${vVO.v_wallet}'
	}).then(function(inputValue){
		
		$.ajax({
    		url: "<%=request.getContextPath()%>/RES_Transaction_List/RES_Transaction_List.do",
            type : 'post',
			data: { action : 'withdrawal', withdrawal : inputValue.value , v_statu : 3 } ,
			dataType: 'json',
			async : false,//同步請求
			cache : false,//不快取頁面
			success: function(res){
				$('#waitmoney').css('visibility','visible');
				$('#waitres').text('$' + res.withdrawal);
				$('#balance').text('$' + res.balance);
				$('#withdrawal').attr('disabled', true);
				
				console.log(res);
// 				$('#answer').text(res.answer);
// 				$('#image').attr('src', res.image).css('display', 'block');
				
			},
			
    	})
   	})
	
})

</script>

<c:if test="${ not empty rtlVO3.v_wallet }">
<script type="text/javascript">

	$( document ).ready(function() {
			
			$('#waitmoney').css('visibility','visible');
			$('#waitres').text('$'+ ${ -rtlVO3.amount });
			$('#balance').text('$'+ ${ rtlVO3.amount + v_wallet});
			$('#withdrawal').attr('disabled', true);			
		
       
    })

</script>
</c:if>

</body>

</html>