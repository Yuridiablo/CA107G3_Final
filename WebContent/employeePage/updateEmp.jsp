
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

.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
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
						action="${pageContext.request.contextPath}/employee/Employee.do">
						<input type="hidden" name="action" value="listAllEmp">
						<button type="submit" class="btn btn-outline-success buttonInTop"
							id="allEmp">所有員工</button>
					</form>
					<form method="post">
						<button type="submit" class="btn btn-outline-success buttonInTop"
							name="action" value="addEmp">新增員工</button>
					</form>
					<form method="post">
						<button type="button" class="btn btn-outline-success buttonInTop"
							id="serchEmp">員工查詢</button>
					</form>
					<form method="post"
						action="${pageContext.request.contextPath}/employee/Employee.do">
						<div class="input-group mb-3 buttonInTop serchBar" id="serchBar">

							<input type="text" class="form-control" name="emp_name"
								placeholder="請輸入員工姓名" aria-label="Recipient's username"
								aria-describedby="button-addon2">
							<div class="input-group-append">
								<input type="hidden" name="action" value="listEmpByName">
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
							<label for="validationTooltip01">員工姓名 :</label>
						</div>
						<div class="col-10 col-form-label unchange">
							<label>${employeeVO.emp_name}</label>
						</div>
					</div>

					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>員工帳號 :</label>
						</div>
						<div class="col-10 col-form-label unchange">
							<label>${employeeVO.emp_acc}</label>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>員工權限 :</label>
						</div>
						<div class="col-10 col-form-label unchange" >
							<select name="emp_permission" class="custom-select mr-sm-2" id="inlineFormCustomSelect">
        						<option value="3" selected>低 </option>
       						 	<option value="2">中 </option>
       						 	<option value="1">高 </option>
      						</select>
						</div>
					</div>
					
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>到職日期 :</label>
						</div>
						<div class="col-10 col-form-label unchange" >
							<label>${employeeVO.emp_hire}</label>
						</div>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>離職日期 :</label>
						</div>
						<c:choose>
						<c:when test="${employeeVO.emp_resign!=null}"> 
						<div class="col-10">
							<input type="text" name="emp_resign" id="emp_resign"
								class="form-control" required>
						</div>
						</c:when>
						<c:otherwise>
						<div class="col-10 col-form-label unchange" >
							<label>${employeeVO.emp_resign}</label>
						</div>
						</c:otherwise>
						</c:choose>
					</div>
					<div class="form-row">
						<div class="col-2 col-form-label">
							<label>在職狀態 :</label>
						</div>
						<div class="col-10 col-form-label unchange">
							 <select name="emp_stat" class="custom-select mr-sm-2" id="inlineFormCustomSelect">
        						<option value="${employeeVO.emp_stat}" selected>
        							<c:choose>
									<c:when test="${employeeVO.emp_stat==1}"> 
											在職
										</c:when>
									<c:otherwise>
											離職
										</c:otherwise>
									</c:choose>
        						</option>
       						 	<option value=
       						 		<c:choose>
									<c:when test="${employeeVO.emp_stat==1}"> 
											"2"
										</c:when>
									<c:otherwise>
											"1"
										</c:otherwise>
									</c:choose>       						 	
       						 	>
       						 		<c:choose>
									<c:when test="${employeeVO.emp_stat==1}"> 
											離職
										</c:when>
									<c:otherwise>
											在職
										</c:otherwise>
									</c:choose>
       						 	</option>
      						</select>
						
						</div>
					</div>
					<div class="form-row justify-content-start">
						<div class="col-4">
							<input type="button" id="fillmsg">
						</div>
					</div>

					<div>
						<input type="hidden" name="emp_no" value="${employeeVO.emp_no}">
						<input type="hidden" name="emp_resign_preanswer" value="${employeeVO.emp_resign}">
						<input type="hidden" name="action" value="update">
						<button type="submmit" id="submmit" class="btn btn-primary col-12">確認送出</button>
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
		});
	</script>
</body>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
	$.datetimepicker.setLocale('zh');
	$('#emp_resign').datetimepicker({
		theme : '', //theme: 'dark',
		timepicker : false, //timepicker:true,
		step : 1, //step: 60 (這是timepicker的預設間隔60分鐘)
		format : 'Y-m-d', //format:'Y-m-d H:i:s',
		value : ${employeeVO.emp_resign}
	// value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});

	// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

	//      1.以下為某一天之前的日期無法選擇
	//      var somedate1 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      2.以下為某一天之後的日期無法選擇
	//      var somedate2 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
	//      var somedate1 = new Date('2017-06-15');
	//      var somedate2 = new Date('2017-06-25');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//		             ||
	//		            date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});
</script>
</html>