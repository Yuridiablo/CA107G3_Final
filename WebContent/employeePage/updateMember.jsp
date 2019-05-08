
<%@page import="com.employee.model.EmployeeVO"%>
<%@page import="java.util.List"%>
<%@page import="com.employee.model.EmployeeService"%>
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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/datetimepicker/jquery.datetimepicker.css" />
<title>註冊</title>
<style type="text/css">
.col-form-label {
	text-align: right;
	font: 18px 微軟正黑體;
}

.btn-primary {
	background-color: #7C7C7C;
	border-color: #7C7C7C;
}

#topicBar {
	border: 1px;
	border: solid;
	border-color: #343A40;
	background-color: #343A40;
	color: white;
	text-align: center;
	font-size: 20px;
	font-weight: bold;
}

body {
	background-color: #3E444A;
}

label {
	color: white;
}

.container {
	margin-top: 5px;
}

.buttonInTop {
	margin: 5px;
}

.serchBar {
	display: none;
}

#buttonBar {
	margin-bottom: 10px;
}

#allEmp {
	height: 38px;
}

.col-form-label {
	text-align: left;
	font: 18px 微軟正黑體;
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
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-7">
				<div class="col-12 row" id="buttonBar">
					<form method="post"
						action="${pageContext.request.contextPath}/employeePage/Employee.do">
						<input type="hidden" name="action" value="listAllMem">
						<button type="submit" class="btn btn-outline-success buttonInTop"
							id="allEmp">所有會員</button>
					</form>
					<form method="post">
						<button type="button" class="btn btn-outline-success buttonInTop"
							id="serchEmp">會員查詢</button>
					</form>
					<form method="post"
						action="${pageContext.request.contextPath}/employee/Employee.do">
						<div class="input-group mb-3 buttonInTop serchBar" id="serchBar">

							<input type="text" class="form-control" name="mem_account_name"
								placeholder="請輸入會員帳號或姓名" aria-label="Recipient's username"
								aria-describedby="button-addon2">
							<div class="input-group-append">
								<input type="hidden" name="action" value="listMemByName">
								<button class="btn btn-outline-secondary" type="submit"
									id="button-addon2">送出</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<form class="needs-validation" novalidate
		action="<%=request.getContextPath()%>/employee/Employee.do"
		method="post">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-7">

					<div class="form-row">
						<div class="col-2 col-form-label">
							<label for="validationTooltip01">會員姓名 :</label>
						</div>
						<div class="col-10 col-form-label unchange">
							<label>${memberVO.mem_name}</label>
						</div>
					</div>

					<div class="form-row">
						<div class="col-2 col-form-label">
							<label for="validationTooltip01">會員暱稱 :</label>
						</div>
						<div class="col-10">
							<input type="text" name="mem_nickname" class="form-control"
								value="${memberVO.mem_nickname}" required>
						</div>
					</div>

					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>會員帳號 :</label>
						</div>
						<div class="col-10 col-form-label unchange">
							<label>${memberVO.mem_account}</label>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>設定密碼 :</label>
						</div>
						<div class="col-10">
							<input type="text" name="mem_pwd" id="mem_pwd"
								value="${memberVO.mem_pwd}" class="form-control"
								placeholder="請填寫6-10位混和英數字,英文需區分大小寫" maxlength="10" required>
							<div class="invalid-tooltip ">請設定密碼</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>密碼確認 :</label>
						</div>
						<div class="col-10">
							<input type="text" name="mem_pwd_check" class="form-control"
								value="${memberVO.mem_pwd}" placeholder="請再輸入一次密碼"
								maxlength="10" id="emp_pwd_check" required>
							<div class="invalid-tooltip pwdtip">請輸入同上密碼</div>
						</div>
					</div>

					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>會員信箱:</label>
						</div>
						<div class="col-10">
							<input type="text" name="mem_mail" class="form-control"
								value="${memberVO.mem_mail}" required>
						</div>
					</div>

					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>會員電話:</label>
						</div>
						<div class="col-10">
							<input type="text" name="mem_tel" class="form-control"
								value="${memberVO.mem_tel}" required>
						</div>
					</div>

					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>錢包餘額:</label>
						</div>
						<div class="col-10">
							<input type="text" name="mem_balance" class="form-control"
								value="${memberVO.mem_balance}" required>
						</div>
					</div>

					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>會員狀態:</label>
						</div>
						<div class="col-10">
							<select name="mem_status" class="custom-select mr-sm-2"
								id="inlineFormCustomSelect">
								<option id="option1" value="${memberVO.mem_status}" selected>
									<c:choose>
										<c:when test="${memberVO.mem_status==1}"> 
											未認證
										</c:when>
										<c:when test="${memberVO.mem_status==2}"> 
											已認證
										</c:when>
										<c:otherwise>
											停權
										</c:otherwise>
									</c:choose>
								</option>
								<option id="option2"></option>
								<option id="option3"></option>
							</select> 
						</div>
					</div>

					<div>
						<input type="hidden" name="mem_no" value="${memberVO.mem_no}">
						<input type="hidden" name="mem_name" value="${memberVO.mem_name}">
						<input type="hidden" name="mem_account" value="${memberVO.mem_account}">
						<input type="hidden" name="action" value="updateForMem">
						<button type="submit" id="submmit" class="btn btn-primary col-12">確認送出</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->


	<script
		src="${pageContext.request.contextPath}/datetimepicker/jquery.js"></script>
	<script
		src="${pageContext.request.contextPath}/datetimepicker/jquery.datetimepicker.full.js"></script>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
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
			$("#emp_pwd_check").change(function() {
				var pwdconfirm = this.value;
				var pwd = document.getElementById("emp_pwd").value;
				if (pwd != null && pwd != pwdconfirm) {
					$(".pwdtip").show();
				} else {
					$(".pwdtip").hide();
				}
			});

			$("#fillmsg").on('click', function() {
				$("#emp_name").val("陳鶴凌");
				$("#customRadioInline1").attr("checked", "true");
				$("#emp_nickname").val("鶴凌");
				$("#emp_acc").val("c123456");
				$("#emp_pwd").val("c123456");
				$("#emp_pwd_check").val("c123456");

			});

			$("#serchEmp").on('click', function() {
				$("#serchBar").removeClass('serchBar');
			});
			$("#allEmp").on('click', function() {
				$("#serchBar").addClass('serchBar');
			});
			
			var emp_status =  $("#option1").val();
			if(emp_status==1){
				$("#option2").val("2");
				$("#option3").val("3");
				$("#option2").html("已認證");
				$("#option3").html("停權");
			}else if(emp_status==2){
				$("#option2").val("1");
				$("#option3").val("3");
				$("#option2").html("未認證");
				$("#option3").html("停權");
			}else{
				$("#option2").val("1");
				$("#option3").val("2");
				$("#option2").html("未認證");
				$("#option3").html("已認證");
			}
		});
	</script>
</body>

</html>