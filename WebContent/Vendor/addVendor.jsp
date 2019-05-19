<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.vendor.model.*"%>

<%
	// 	VendorVO vVO = (VendorVO)request.getAttribute("vVO"); 
	// 	out.print(vVO);
%>
<jsp:useBean id="vVO" class="com.vendor.model.VendorVO" />
<!doctype html>
<html lang="en">

<head>


<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/front-end/css/bootstrap-4.3.1.min.css">

<script src="<%= request.getContextPath() %>/front-end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="<%= request.getContextPath() %>/front-end/js/bootstrap-4.3.1.min.js" type="text/javascript"></script>
<script src="<%= request.getContextPath() %>/front-end/js/popper.min.js" type="text/javascript"></script>
<script src="<%= request.getContextPath() %>/front-end/js/address.js" type="text/javascript"
	language="javascript" src="output.js" charset="UTF-8"></script>
	
<script type="text/javascript">
	$(function() {
		$('.address-zone').ajaddress({
			city : "桃園市",
			county : "中壢區"
		});
	});
</script>
<script type="text/javascript">
	function changePic(e) {

		document.getElementsByTagName("img")[0].src = URL
				.createObjectURL(event.target.files[0]);
	}
</script>

<title>店家會員註冊</title>
<style type="text/css">
body {
	background-color: #eee;
	font-family: "微軟正黑體";
}

.col-form-label {
	text-align: right;
	font: 18px 微軟正黑體;
}

.addv .col-7{
	margin-top: 3%;
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

img {
	margin: 5%;
	object-fit: cover;
	max-height: 350px;
	width: 580px;
}

.form-control-plaintext {
	margin-left: 3%;
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
</style>
</head>

<body>



<!-- Navbar -->
	<nav class="navbar  bg-dark navbar-dark">
		
		
		
		<a class="navbar-brand" href="<%=request.getContextPath()%>/front-end/V_FrontPage.jsp"><span class="navbar-brand resTitle">歡迎使用餐廳管理畫面</span></a>
		<span class="navbar-brand">Seek Food Table</span>
	</nav>
	<!-- Side Nav -->
	<div id="sidenavOverlay"></div>


	<div class="container">
		<div class="row">
			<div class="col-12">
				<!-- ===============================編輯區 開始====================================== -->

	<form class="needs-validation addv" novalidate METHOD="post"
		ACTION="Vendor.do" name="form1" enctype="multipart/form-data">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-7">
					<label id="topicBar" class="col-12">SeakFoodTable 廠商註冊</label>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label for="validationTooltip01">餐廳名稱 :</label>
						</div>
						<div class="col-10">
							<input type="text" name="v_name" value="${vVO.v_name}"
								id="v_name" class="form-control" placeholder="請輸入餐廳名稱" required>
							<div class="invalid-tooltip">請輸入餐廳名稱!</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>帳號 :</label>
						</div>
						<div class="col-10">
							<input type="text" name="v_account" value="${vVO.v_account}"
								id="v_account" class="form-control" placeholder="請填寫帳號" required>
							<div class="invalid-tooltip">請輸入正確格式</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>設定密碼 :</label>
						</div>
						<div class="col-10">
							<input type="password" name="v_pwd" value="${vVO.v_pwd}"
								 class="form-control" id="pwd"
								placeholder="請填寫6-10位混和英數字,英文需區分大小寫" maxlength="10" required
								pattern="^(?=.*\d)(?=.*[A-za-z]).{6,10}$">
							<div class="invalid-tooltip  ">請設定密碼</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>密碼確認 :</label>
						</div>
						<div class="col-10">
							<input type="password" name="v_pwd_confirm" 
								class="form-control" placeholder="請再輸入一次密碼" maxlength="10"
								id="pwdconfirm" required
								pattern="^(?=.*\d)(?=.*[A-za-z]).{6,10}$">
							<div class="invalid-tooltip pwdtip">請輸入同上密碼</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>信箱 :</label>
						</div>
						<div class="col-10">
							<input type="email" name="v_mail" value="${vVO.v_mail}"
								id="v_mail" class="form-control" placeholder="請填寫有效的email"
								required>
							<div class="invalid-tooltip">請輸入有效信箱</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>電話 :</label>
						</div>
						<div class="col-2">
							<input type="text" name="v_n_code" value="${vVO.v_n_code}"
								id="v_n_code" class="form-control" maxlength="10" required>
							<div class="invalid-tooltip"></div>
						</div>
						<div class="col-8">
							<input type="text" name="v_tel" value="${vVO.v_tel}" id="v_tel"
								class="form-control" placeholder="請輸入正確電話格式" maxlength="10"
								required>
							<div class="invalid-tooltip">請輸入正確格式</div>
						</div>
					</div>


					<div class="address-zone form-row align-items-center">
						<div class="col-2 col-form-label">
							<label>地址 :</label>
						</div>
						<div class="col-1 zipcode form-control-plaintext"></div>
						<input class="zipcode" type="hidden" name="v_ad_code" id="zip_in"
							value=div class="zipcode" /> <select
							class="col-4 city custom-select  mr-sm-2" name="v_address1">
							<option value="${vVO.v_address1}" id="v_address1">請選擇</option>
						</select> <select class="col-4 county custom-select  mr-sm-2"
							name="v_address2">
							<option value="${vVO.v_address2}" id="v_address2">請選擇</option>
						</select>
					</div>

					<input class="zipcode" type="hidden" name="v_ad_code"
						value="${vVO.v_ad_code}"> <input class="city"
						type="hidden" name="v_address1" value="${vVO.v_address1}">
					<input class="county" type="hidden" name="v_address2"
						value="${vVO.v_address2}">

					<!-- 


					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>地址 :</label>
						</div>
						<div class="col-2" "address-zone">
							<input type="text" name="MEM_ACCOUNT" class="form-control" "zipcode"
								maxlength="10" placeholder="區號" required
								pattern="^(?=.*\d)(?=.*[A-za-z]).{6,10}$">
							<div class="invalid-tooltip">郵遞區號</div>
						</div>
						<div class="col-3">
							<input type="text" name="MEM_ACCOUNT" class="form-control" "city"
								placeholder="縣市" maxlength="10" required
								pattern="^(?=.*\d)(?=.*[A-za-z]).{6,10}$">
							<div class="invalid-tooltip">縣市</div>
						</div>
						<div class="col-3">
							<input type="text" name="MEM_ACCOUNT" class="form-control" "county"
								placeholder="行政區" maxlength="10" required
								pattern="^(?=.*\d)(?=.*[A-za-z]).{6,10}$">
							<div class="invalid-tooltip">區</div>
						</div>
					</div> -->
					<div class="form-row">
						<div class="col-2">
							<label></label>
						</div>
						<div class="col-10">
							<input type="text" name="v_address3" value="${vVO.v_address3}"
								class="form-control" id="v_address3" maxlength="10"
								placeholder="" required>
							<div class="invalid-tooltip">地址</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>店家照片 :</label>
						</div>
						<div class="col-10">
							<input type="file" class="file-field" name="v_pic"
								value="${vVO.v_pic}" onchange="changePic(event)">
						</div>
					</div>
					<div class="row">
						<div class="col-6"></div>

					</div>
					<!-- 					<div class="form-row"> -->
					<!-- 						<div class="col-2 col-form-label"> -->
					<!-- 							<label>驗證碼 :</label> -->
					<!-- 						</div> -->
					<!-- 						<div class="col-8"> -->
					<!-- 							<input type="text" name="MEM_PWD_confirm" class="form-control" -->
					<!-- 								placeholder="請輸入右方數字" maxlength="10" required> -->
					<!-- 							<div class="invalid-tooltip">請輸入驗證碼</div> -->
					<!-- 						</div> -->
					<!-- 						<div class="col"> -->

					<!-- 						</div> -->
					<!-- 					</div> -->
					<!-- 					<div> -->
					<!-- 						<a href="#"><small id="refreshconfirm" -->
					<!-- 							class="form-text text-muted">重新產生</small></a> -->
					<!-- 					</div> -->
					<input type="hidden" name="action" value="insert">
					
						<div class="container">
							<div class="form-row">
								<button type="submit" class="btn btn-primary col-11">送出審核</button>
								<button type="button" class="btn btn-danger col-1" id="magic">@</button>

							</div>
						</div>

					<div class="container">
						<div class="form-row">
							<div class="col-6">
								<img src="" alt="">
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</form>
<!-- =================================編輯區 結束==================================== -->
		</div>
	</div>

	</div>
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->

	<script>
		// Example starter JavaScript for disabling form submissions if there are invalid fields
		(function() {
			'use strict';
			window.addEventListener('load',
					function() {
						// Fetch all the forms we want to apply custom Bootstrap validation styles to
						var forms = document
								.getElementsByClassName('needs-validation');
						// Loop over them and prevent submission
						var validation = Array.prototype.filter.call(forms,
								function(form) {
									form.addEventListener('submit', function(
											event) {
										if (form.checkValidity() === false) {
											event.preventDefault();
											event.stopPropagation();
										}
										form.classList.add('was-validated');
									}, false);
								});
					}, false);
		})();

		$("#pwdconfirm").on('blur', function() {
			var pwd = document.getElementById("pwd").value;
			var pwdconfirm = this.value;
			if (pwd != null && pwd != pwdconfirm) {
				$(".pwdtip").show();
			} else {
				$(".pwdtip").hide();
			}

		});

		$("#magic").on('click', function() {
			$("#v_name").val("大衛海鮮");
			$("#v_account").val("eeeeee");
			$("#v_pwd").val("555555");
			$("#v_pwd_confirm").val("555555");
			$("#v_mail").val("adttyyuunnfasf@afsfsaf");
			$("#v_n_code").val("02");
			$("#v_tel").val("33344455");
			$("#v_address1").val("新北市");
			$("#v_address2").val("板橋區");
			$("#v_address3").val("漢生東路193巷9號");

		})
	</script>


</body>

</html>