

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@page import="com.member.model.MemberVO"%> --%>
<%-- <%@page import="com.tools.OutImg"%> --%>


<!doctype html>
<html lang="en">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" -->
<!-- 	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" -->
<!-- 	crossorigin="anonymous"> -->
<title>會員資料修改</title>
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
	display: none;
	font: 15px/40px Helvetica bold;
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

.btn1 {
	display: inline-block;
	box-sizing: border-box;
	font: 15px/40px Helvetica bold;
	color: #fff;
	text-align: center;
	background: orange;
	border: 2px solid orange;
	margin: 15px 0px 10px 0px;
	position: relative;
	top: -2px; #
	top: 1px;
	cursor: pointer;
	text-decoration: none;
}

.btn2 {
	display: inline-block;
	box-sizing: border-box;
	font: 15px/40px Helvetica;
	text-align: center;
	background: #fff;
	border: 2px solid orange;
	color: #000000;
	margin: 15px 0px 10px 0px;
	position: relative;
	top: -2px; #
	top: 1px;
	cursor: pointer;
	text-decoration: none;
}

#confirmletter.confirmchange {
	display: inline-block;
}

.unchange {
	text-align: left;
}

.none {
	display: none;
}

#submmit{
	margin-top:25px;
}
.updateContainer{
	height: 700px;
}
</style>
</head>

<body>

	<div class="form-row justify-content-center">
		<div class="col-1 btn1" id="btn1">
			<label>會員資料修改</label>
		</div>
		<div class="col-1 btn2" id="btn2">
			<label>密碼修改</label>
		</div>
	</div>
	<form class="needs-validation baseform" novalidate
		enctype="multipart/form-data" method="post" action="member.do">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-6 updateContainer">
					<label id="topicBar" class="col-12">SeakFoodTable 會員資料維護</label>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label for="validationTooltip01">姓名 :</label>
						</div>
						<div class="col-10 col-form-label unchange">
							<label>${memberVO.mem_name}</label>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>會員暱稱 :</label>
						</div>
						<div class="col-10">
							<input type="text" class="form-control" name="mem_nickname"
								value="${memberVO.mem_nickname}">
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>信箱 :</label>
						</div>
						<div class="col-7">
							<input type="email" name="mem_mail"
								value="${memberVO.mem_mail}" id="email" class="form-control "
								placeholder="請填寫有效的email" required>
						</div>
						<div class="col">
							<a href="#" id="confirmletter" class="col-12">寄發驗證信</a>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>手機 :</label>
						</div>
						<div class="col-10">
							<input type="tel" name="mem_tel" value="${memberVO.mem_tel}"
								class="form-control" required>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>確認修改 :</label>
						</div>
						<div class="col-10">
							<input type="text" name="mem_pwd" class="form-control"
								placeholder="請輸入密碼" maxlength="10" required>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>會員照片 :</label>
						</div>
						<div class="col-6">
							<input type="file" class="form-control-file" name="mem_pic"
								onchange="loadFile(event)">
						</div>
						<div class="col">
							<img src="<%= request.getContextPath() %>/tools/OutImg.do?mem_no='${memberVO.mem_no}'" id="output" class="col-12">
						</div>
					</div>
					<div>
						<input type="hidden" name="update_detail" value="update_detail">
						<input type="hidden" name="action" value="update">
						<button type="submmit" class="btn btn-primary col-12" id="submmit">確認送出</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	<form class="needs-validation numform none" novalidate
		action="member.do">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-6 updateContainer">
					<label id="topicBar" class="col-12">SeakFoodTable 會員密碼修改</label>
					<div class="form-row">
						<div class="col-4 col-form-label">
							<label>輸入舊密碼:</label>
						</div>
						<div class="col-8">
							<input type="password" name="mem_pwd" class="form-control"
								required>
						</div>
					</div>
					<div class="form-row">
						<div class="col-4 col-form-label">
							<label>輸入新密碼:</label>
						</div>
						<div class="col-8">
							<input type="password" id="pwd" name="mem_pwd_new"
								class="form-control" placeholder=" 請填寫6-10位混和英數字,英文需區分大小寫"
								maxlength="10" required>
							<div class="invalid-tooltip">請輸入符合格式的密碼</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-4 col-form-label">
							<label>新密碼確認:</label>
						</div>
						<div class="col-8">
							<input type="password" id="pwdconfirm"
								class="form-control" required>
							<div class="invalid-tooltip pwdtip">請輸入同上密碼</div>
						</div>
					</div>
					<div>
						<input type="hidden" name="update_pwd" value="update_pwd">
						<input type="hidden" name="action" value="update_mem_pwd">
						<button type="submit" class="btn btn-primary col-12" id="updatePwdBut">確認送出</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<!-- 	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" -->
<!-- 		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" -->
<!-- 		crossorigin="anonymous"></script> -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
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
		$(document).ready(function() {
			
			var email = document.getElementById("email").value;
			$('#email').on('blur', function() {
				$('#email').change(function() {
					var newemail = document.getElementById("email").value;
					if (email != newemail) {
						$('#confirmletter').addClass('confirmchange');
					} else {
						$('#confirmletter').removeClass('confirmchange');
					}
				});
			});
			$('#btn2').on('click', function() {
				$('#btn1').removeClass('btn1');
				$('#btn1').addClass('btn2');
				$('#btn2').removeClass('btn2');
				$('#btn2').addClass('btn1');
				$('.baseform').addClass('none');
				$('.numform').removeClass('none');
			});
			$('#btn1').on('click', function() {
				$('#btn2').removeClass('btn1');
				$('#btn2').addClass('btn2');
				$('#btn1').removeClass('btn2');
				$('#btn1').addClass('btn1');
				$('.numform').addClass('none');
				$('.baseform').removeClass('none');
			});
			$("#pwdconfirm").change(function() {
				var pwd = document.getElementById("pwd").value;
				var pwdconfirm = this.value;
				if (pwd != null && pwd != pwdconfirm) {
					$(".pwdtip").show();
					
				} else {
					$(".pwdtip").hide();
					$("#updatePwdBut").on('click',function(){
						return true;
					})
				}

			});
			
			$("#updatePwdBut").on('click',function(){
				if($(".pwdtip").css('display')!="none"){
					return false;
				}else{
					return true;
				}
					
			})
			
			if($('#output').width()<=20){
				$('#output').css('display','none');
			}
			
		});
		var loadFile = function(e) {
			var output = document.getElementById('output');
			$('#output').css('display','');
			output.src = URL.createObjectURL(event.target.files[0]);
		};
	</script>
</body>

</html>