<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<title>註冊</title>
<style type="text/css">
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

#confirmletter:hover{
	background-color: orange;
}

#confirmrow {
	margin-top: 10px;
}
</style>
</head>

<body>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<form class="needs-validation" novalidate action="member.do"
		method="post" enctype="multipart/form-data">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-6">
					
					<label id="topicBar" class="col-12">SeakFoodTable 會員註冊</label>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label for="validationTooltip01">姓名 :</label>
						</div>
						<div class="col-8">
							<input type="text" id="mem_name" name="mem_name"
								class="form-control" placeholder="請輸入真實中文姓名" required
								pattern="^[\u4E00-\u9FA5]{2,3}$">
							<div class="invalid-tooltip">請輸入真實中文姓名</div>
						</div>
						<div class="col-2">
							<div class="custom-control custom-radio custom-control-inline">
								<input type="radio" id="customRadioInline1" name="mem_gender"
									value="M" class="custom-control-input" required> <label
									class="custom-control-label" for="customRadioInline1">先生</label>
							</div>
							<div class="custom-control custom-radio custom-control-inline">
								<input type="radio" id="customRadioInline2" name="mem_gender"
									value="F" class="custom-control-input" required> <label
									class="custom-control-label" for="customRadioInline2">女士</label>
							</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>會員暱稱 :</label>
						</div>
						<div class="col-10">
							<input type="text" name="mem_nickname" id="mem_nickname"
								class="form-control" placeholder="請輸入2~10碼英數或中文" required
								pattern="^[\u4e00-\u9fa5_a-zA-Z0-9_]{2,10}$">
							<div class="invalid-tooltip">請輸入正確格式</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>信箱 :</label>
						</div>
						<div class="col-7">
							<input type="email" name="mem_mail" id="mem_mail"
								class="form-control" placeholder="請填寫有效的email" required>
							<div class="invalid-tooltip">請輸入有效信箱</div>
						</div>
						<div class="col">
							<a href="#" id="confirmletter" data-target="#modalForconfirm" data-toggle="modal" class="col-12">寄發驗證信</a>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>身分證 :</label>
						</div>
						<div class="col-10">
							<input type="text" name="mem_id" id="mem_id" class="form-control"
								placeholder="請填寫身分字號" required pattern="^[A-Z][12][0-9]{8}$">
							<div class="invalid-tooltip">請輸入有效身分證</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>手機 :</label>
						</div>
						<div class="col-10">
							<input type="tel" name="mem_tel" id="mem_tel"
								class="form-control" placeholder="請填寫有效的手機號碼" required
								pattern="^[0][9][0-9]{8}$">
							<div class="invalid-tooltip">請輸入有效手機號碼</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>設定帳號 :</label>
						</div>
						<div class="col-10">
							<input type="text" name="mem_account" id="mem_account"
								class="form-control" placeholder="請填寫6-10位混和英數字,英文需區分大小寫"
								maxlength="10" required
								pattern="^(?=.*\d)(?=.*[A-za-z]).{6,10}$">
							<div class="invalid-tooltip">請正確格式</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>設定密碼 :</label>
						</div>
						<div class="col-10">
							<input type="password" name="mem_pwd" id="mem_pwd"
								class="form-control" placeholder="請填寫6-10位混和英數字,英文需區分大小寫"
								maxlength="10" required
								pattern="^(?=.*\d)(?=.*[A-za-z]).{6,10}$">
							<div class="invalid-tooltip  ">請設定密碼</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>密碼確認 :</label>
						</div>
						<div class="col-10">
							<input type="password" name="mem_pwd_check" class="form-control"
								placeholder="請再輸入一次密碼" maxlength="10" id="mem_pwd_check"
								required pattern="^(?=.*\d)(?=.*[A-za-z]).{6,10}$">
							<div class="invalid-tooltip pwdtip">請輸入同上密碼</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>會員照片 :</label>
						</div>
						<div class="col-6">
							<input type="file" class="form-control-file" name="mem_pic"
								id="mempic" onchange="loadFile(event)">
						</div>
						<div class="col">
							<img src="" id="output" class="col-12">
						</div>
					</div>
					<div class="form-row" id="confirmrow">
						<div class="col-2 col-form-label">
							<label>驗證碼 :</label>
						</div>
						<div class="col-8">
							<input type="text" name="mem_pwd_confirm" id="inputconfirm"
								class="form-control" placeholder="請輸入右方數字" maxlength="10"
								required>
							<div class="invalid-tooltip confirmtip">請輸入正確驗證碼</div>
						</div>
						<div class="col">
							<img src="" id="verification" class="col-12">
						</div>
					</div>
					<div class="form-row justify-content-between">
						<div class="col-2">
							<input type="button" id="fillmsg">
						</div>
						<div class="col-3">
							<a href="#"><small id="refreshconfirm"
								class="form-text text-muted">重新產生</small></a>
						</div>
					</div>
					<div>
						<input type="hidden" name="action" value="insert">
						<button type="submmit" id="sub" class="btn btn-primary col-12">立即註冊</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	
<!-- 	==========================modalforconfirm====================================== -->
<div class="modal fade" id="modalForconfirm" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
<!-- =================================================================================== -->
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">請於2分鐘內輸入電子郵件內驗證碼 :</label>
            <input type="text" class="form-control" placeholder="輸入驗證碼"
            name="confirmCode" id="confirmCode">
          </div>
           <div class="container">
				<button type="submit" class="btn btn-warning col submitbut" id="confirmSub">確定送出</button>
           </div>
<!-- =================================================================================== -->
			</div>
		</div>
	</div>
</div>
	
<!-- 	==========================modalforconfirm====================================== -->	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script
  		src="https://code.jquery.com/jquery-3.4.1.js"
  		integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  		crossorigin="anonymous"></script>
		
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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

		var firstconfirm = true;

		$(document).ready(
				function() {
					var passToken=null;
					var vstring = Math.floor(Math.random() * 1000000);
					$("#verification").attr('src',
							"${pageContext.request.contextPath}/tool/Verification.do?vstring=" + vstring);
					var pwd;
					var pwdconfirm;
					$("#mem_pwd_check").change(function() {
						pwdconfirm = this.value;
						pwd = document.getElementById("mem_pwd").value;
						if (pwd != null && pwd != pwdconfirm) {
							$(".pwdtip").show();
						} else {
							$(".pwdtip").hide();
						}
					});

					var mem_mail;
					
					
					$("#fillmsg").on('click', function() {
						$("#mem_name").val("陳鶴凌");
						$("#customRadioInline1").attr("checked", "true");
						$("#mem_nickname").val("鶴凌");
						$("#mem_mail").val("ciguana1995@gmail.com");
						mem_mail = $("#mem_mail").val();
						$("#mem_id").val("B123005470");
						$("#mem_tel").val("0975954467");
						$("#mem_account").val("c123456");
						$("#mem_pwd").val("c123456");
						$("#mem_pwd_check").val("c123456");
					})

					$("#refreshconfirm").on(
							'click',
							function() {
								vstring = Math.floor(Math.random() * 1000000);
								$("#verification").attr('src',
										"${pageContext.request.contextPath}/tool/Verification.do?vstring=" + vstring);
							});
					var inputconfirm
					$("#inputconfirm").change(function() {
						inputconfirm = this.value;
						if (inputconfirm != "" && inputconfirm != vstring) {
							$(".confirmtip").show();
						} else {
							$(".confirmtip").hide();
						}
					});
					
					$("#mem_mail").change(function(){
						$("#confirmletter").css('pointer-events','');
						$("#confirmCode").val("");
					})
					
					
						$("#sub").on('click', function() {
							if ($("input").val() != "") {
								if (inputconfirm != vstring || pwd != pwdconfirm) {
									return false;
								}else if(passToken!="pass") {
									alert("請點擊寄送驗證信按鈕以完成驗證");
									return false;
								}else {
									return true;
								}
							}
						})
					
						$("#confirmletter").on('click',function(){
								$("#confirmletter").css('pointer-events','none');
								$.ajax({
									url:"<%= request.getContextPath()%>/member/member.do",
									type:"post",
									data:{action:'auth',mem_mail:$("#mem_mail").val()},
									dataType:'json',
									cache:false,
								})
						});
						
						$("#confirmSub").on('click',function(){
							$("#confirmletter").css('pointer-events','');
							$.ajax({
								url:"<%= request.getContextPath()%>/member/member.do",
								type:"post",
								data:{action:'confirmJudge',mem_mail:$("#mem_mail").val(),confirmCode:$("#confirmCode").val()},
								cache:false,
								dataType: "json",
								success: function(data){
									if(data.canPass==="Yes"){
										$("#modalForconfirm").modal('hide');
										$("#confirmletter").css('pointer-events','none');
										passToken = "pass";
										swal("驗證成功", "請繼續完成註冊", "success");
									}else if(data.canPass==="overTime"){
										alert("驗證碼以逾時,請重新寄送驗證信或更換信箱");
									}else{
										alert("驗證碼錯誤");
									}
								},
							})
						});
					


				});
		var loadFile = function(e) {
			var output = document.getElementById('output');
			output.src = URL.createObjectURL(event.target.files[0]);
		};


	</script>
</body>

</html>