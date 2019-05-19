<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">

<head>
<!-- Required meta tags -->
<!-- <meta charset="utf-8"> -->
<!-- <meta name="viewport" -->
<!-- 	content="width=device-width, initial-scale=1, shrink-to-fit=no"> -->
<!-- Bootstrap CSS -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" -->
<!-- 	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" -->
<!-- 	crossorigin="anonymous"> -->
<title>登入</title>
<style type="text/css">
#passwordHelp {
	padding-left: 2px;
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

.btn-primary {
	background-color: orange;
	border-color: orange;
}

#refreshconfirm {
	text-align: right;
	margin-bottom: 5px;
}

#submmit {
	margin-top: 10px;
}

</style>
</head>

<body>

	<form method="post" action="<%= request.getContextPath() %>/member/member.do" class="needs-validation"
		novalidate>
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-12">
					<label id="topicBar" class="col-12">SeakFoodTable 會員登入</label>
					<div class="form-group">
						<input type="text" name="mem_account" id="mem_account"
							class="form-control" placeholder="請輸入帳號" required>
					</div>
					<div class="form-group">
						<input type="password" name="mem_pwd" id="mem_pwd"
							class="form-control" id="exampleInputPassword1"
							placeholder="請輸入密碼" required> <small id="passwordHelp"
							class="form-text text-muted">英文字母需區分大小寫</small>
					</div>
					<div class="form-row">
						<div class="col-8">
							<input type="text" name="confirm" id="inputconfirm"
								class="form-control" placeholder="請輸入右圖數字" required>
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
					<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
					<input type="hidden" name="action" value="login">
					<input type="hidden" name="flag" class="flag" value="">
					<button type="submit" class="btn btn-primary col-12" id="submmit">登入
						Login</button>
				</div>
			</div>
		</div>
	</form>
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="<%= request.getContextPath() %>/front-end/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="<%= request.getContextPath() %>/front-end/js/popper.min.js" type="text/javascript"></script>
<!-- 	<script -->
<!-- 		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" -->
<!-- 		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" -->
<!-- 		crossorigin="anonymous"></script> -->

	<script type="text/javascript">
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
		$(document).ready(
				function() {

					var vstring = Math.floor(Math.random() * 1000000);
					$("#verification").attr(
							'src',
							"${pageContext.request.contextPath}/tools/Verification.do?vstring="
									+ vstring);

					$("#refreshconfirm").on(
							'click',
							function() {
								vstring = Math.floor(Math.random() * 1000000);
								$("#verification").attr(
										'src',
										"${pageContext.request.contextPath}/tools/Verification.do?vstring="
												+ vstring);
							});

					var inputconfirm;
					$("#inputconfirm").change(function() {
						inputconfirm = $("#inputconfirm").val();

						if (inputconfirm != "" && inputconfirm != vstring) {
							$(".confirmtip").show();
						} else {
							$(".confirmtip").hide();

						}
					});

					
						$("#submmit").on('click', function() {
								if (inputconfirm != vstring) {
									return false;
								} else {
									return true;
								}
						})
					

					$("#fillmsg").on('click', function() {
						$("#mem_account").val("qq1234");
						$("#mem_pwd").val("aa1234");
// 						$("#inputconfirm").val(vstring);
					})
					
				});
	</script>
</body>

</html>