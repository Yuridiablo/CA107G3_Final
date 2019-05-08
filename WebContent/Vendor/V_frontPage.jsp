<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.vendor.model.*"%>

<jsp:useBean id="vVO" scope="session" class="com.vendor.model.VendorVO" />

<!doctype html>
<html lang="en">

<head>
<!-- 防止快取 -->
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT"> 

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<title>餐廳後台首頁</title>
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

.btn-lg{
	font-size: 48px;
}

.needs-validation{
margin-top:0%;
}

.form-control{
margin-top:7%;
}

.d-flex .btn{
	margin-top: 15%;
}

img {

	height: 500px;
}

.errmsg{
margin-top:3%;
font-size:30px;
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
	<nav class="navbar  bg-dark navbar-dark">
		
		
		
		<span class="navbar-brand resTitle">歡迎使用餐廳管理畫面</span>
		<span class="navbar-brand">Seek Food Table</span>
	</nav>
	<!-- Side Nav -->
	<div id="sidenavOverlay"></div>


	<div class="container">
		<div class="row">
			<div class="col-12">
				<!-- ===============================編輯區 開始====================================== -->


				<div class="row justify-content-center">

			<img src="../front-end/images/SeeKFoodB.png">

				</div>	
				<div class="row  justify-content-center">
					<div class="col-2">
			<span><a href="#" class="btn btn btn-primary top-btn btn-lg" data-toggle="modal" data-target="#modalCenter">登入</a></span>
			</div>
                                    <span><a href="<%= request.getContextPath() %>/Vendor/addVendor.jsp" class="btn btn btn-primary top-btn btn-lg">註冊</a></span>
                                

				</div>
				
				<div class="row justify-content-center errmsg">
            	 <c:if test="${not empty errorMsgs}">
					<font style="color:red">登入失敗</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color:red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>
				</div>
<!-- Modal -->
<div class="modal fade" id="modalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
     <div class="modal-header">
              
                <label id="topicBar" class="col-12">SeakFoodTable 廠商登入</label>
            </div>
			
			<div class="modal-body">
<!-- ========================================BODY開始========================================== -->
              
<%--               <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<font style="color:red">請修正以下錯誤:</font> -->
<!-- 	<ul> -->
<%-- 		<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 			<li style="color:red">${message}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if> --%>
    <form method="post" action="Vendor.do" class="needs-validation" novalidate>
  
         
                   
                    <div class="form-group">
                        <input type="text" name="v_account" id="v_account" class="form-control" placeholder="請輸入帳號" required value="aaaaaa">
                  
                        <input type="password" name="v_pwd" id="v_pwd" class="form-control" id="exampleInputPassword1" placeholder="請輸入密碼" required value="111111">
                        <small id="passwordHelp" class="form-text text-muted">英文字母需區分大小寫</small>
                    </div>
             
            
                    <input type="hidden" name="action" value="login">
                    		<div class="col-12 d-flex justify-content-center">
                    <button type="submit" class="btn btn-primary d-flex justify-content-center" id="submit">登入 Login</button>
                    </div>
           
        
     
    </form>
              
              
              
              
<!-- =========================================BODY結束========================================== -->
			</div>
			
			<div class="modal-footer">
           
            </div>
      </div>
    </div>
  </div>
</div>






			<!-- =================================編輯區 結束==================================== -->
		</div>
	</div>

	</div>


	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script
	  src="https://code.jquery.com/jquery-3.4.0.min.js"
	  integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg="
	  crossorigin="anonymous"></script>
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
    
    <c:if test="${newAcc == true}">
    <script>
    Swal.fire(
    		  '申請成功!',
    		  '我們將會盡快審核您的帳戶',
    		  'success'
    		).then(function(){
    	    	$.ajax({
    	    		url: "Vendor.do",
    	            type : 'post',
    				data: { action: 'logout'},
    				dataType: 'json',
    				async : false,//同步請求
    				cache : false,//不快取頁面
    				
    	    	})
    	    })
    </script>
	</c:if>
</body>

</html>