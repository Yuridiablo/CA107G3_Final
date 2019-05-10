<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ page import="com.vendor.model.*"%>



<!DOCTYPE html>
<jsp:useBean id="vVO" scope="session" class="com.vendor.model.VendorVO" />
<jsp:useBean id="excVO" scope="page" class="com.exception_date.model.Exception_DateService" />
<jsp:useBean id="r_tVO" scope="page" class="com.reservation_time.model.Reservation_TimeService" />
<jsp:useBean id="rtnVO" scope="page" class="com.reservation_table_number.model.Reservation_Table_NumberService" />

<html>
<head>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">


<meta charset="UTF-8">
<title>修改廠商營業資訊</title>
</head>
<style>
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
	margin-top:60%;
 padding-left: 123px;
 padding-right: 123px;
 box-sizing: border-box;

}

.nav .text-white:hover{
	background-color: #f00;
}

img {
	width: 800px;
	max-width: 500px;
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
<body>


<body>
	<div class="container">
		<div class="row">
			<div class="col-6">
				<!-- ===============================編輯區 開始====================================== -->


				<form class="needs-validation" novalidate METHOD="get" ACTION="<%=request.getContextPath()%>/rtime/rtime.do" name="form1" >
					<div class="container">
<input type="hidden" name="vendor_no" value="V000001">
						<div class="col-12">
							<label id="topicBar" class="col-12">餐廳營業訂位資訊設定</label>
							
							
							
							<div class="form-row">
								<div class="col-4 col-form-label">
									<label for="validationTooltip02">設定不開放日期：</label>
								</div>
								<div class="col-8">
								<div class="input_fields_wrap01">
										    <button class="add_field_button01">增加日期</button>
										   <div class="date" >
										   <c:forEach var="exc_list" items="${excVO.find_by_vendor_no('V000001')}">
										    <input type="date" class="exc_date1" name="exc_date"  value="${ exc_list.exc_date}" required>
										    <input type="hidden" name="exc_no"  value="${ exc_list.exc_no}" required>
										   
										    </c:forEach>
										    </div>
										    
										</div>
									
									<div class="invalid-tooltip">請輸入正確格式</div>
								</div>
							</div>
							
							<div class="form-row">
								<div class="col-4 col-form-label">
									<label for="validationTooltip01">設定開放時段：</label>
								</div>
								<div class="col-8">
										<div class="input_fields_wrap">
										    <button class="add_field_button">增加時段</button>
										    <div>
										    <c:forEach var="rt_list" items="${r_tVO.finby_v_no('V000001')}">
										    <input type="text" name="open_hours" value="${rt_list.r_time}">
										    <input type="hidden" name="rt_no" value="${rt_list.rt_no }"required>
										    
										  </c:forEach>
										  </div>
										</div>
								</div>
							</div>
							
							
							
							
							<div class="form-row">
								<div class="col-4 col-form-label">
									<label for="validationTooltip01">設定開放桌位：</label>
								</div>
								<div class="col-5">
								 <c:forEach var="rtn_list" items="${ rtnVO.findBy_vendor('V000001')}">
														<input type="hidden" name="rtn_no" value="${rtn_list.rtn_no}" >
									<br>兩人桌數量：<input type="number" class="res_num" name="rtbl_o_num1" value="${rtn_list.rtbl_o_num1}" required>
									
									<br>四人桌數量：<input type="number" class="res_num" name="rtbl_o_num2" value="${rtn_list.rtbl_o_num2}"  required>
									
									<br>六人桌數量：<input type="number" class="res_num" name="rtbl_o_num3"  value="${rtn_list.rtbl_o_num3}" required>
									
									<br>八人桌數量：<input type="number" class="res_num" name="rtbl_o_num4" value="${rtn_list.rtbl_o_num4}"  required>
									
									<br>十人桌數量：<input type="number" class="res_num" name="rtbl_o_num5" value="${rtn_list.rtbl_o_num5}"  required>
									</c:forEach>
								</div>
							</div>
<!-- 							<div class="form-row"> -->
<!-- 								<div class="col-4 col-form-label"> -->
<!-- 									<label>餐廳已訂桌位數量</label> -->
<!-- 								</div> -->
<!-- 								<div class="col-8"> -->
<!-- 								</div> -->
<!-- 							</div> -->

<input type="hidden" name="action"	value="update_open_time">

<%-- <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"> --%>
							<div>
								<button type="submit" class="btn btn-primary col-12">修改</button>
							</div>
						</div>
					</div>
					</form>
			</div>
			
	
			<!-- =================================編輯區 結束==================================== -->
		</div>
	</div>

	

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

<script type="text/javascript">
	

	$(document).ready(function() {
	var max_fields      = 20; //maximum input boxes allowed
	var wrapper   		= $(".input_fields_wrap"); //Fields wrapper
	var add_button      = $(".add_field_button"); //Add button ID
	
	var wrapper01   		= $(".input_fields_wrap01"); //Fields wrapper
	var add_button01      = $(".add_field_button01");
	var x = 1; //initlal text box count
	$(add_button).click(function(e){ //on add input button click
		e.preventDefault();
		if(x < max_fields){ //max input box allowed
			x++; //text box increment
			$(wrapper).append('<div><input type="text" name="open_hours"/><a href="#" class="remove_field">移除</a></div>'); //add input box
		}
	});
	
	$(add_button01).click(function(e){ //on add input button click
		e.preventDefault();
		if(x < max_fields){ //max input box allowed
			x++; //text box increment
			$(wrapper01).append('<div><input type="date" class="exc_date1" name="exc_date" /><a href="#" class="remove_field">移除</a></div>'); //add input box
		}
	});
	
	$(wrapper).on("click",".remove_field", function(e){ //user click on remove text
		e.preventDefault(); $(this).parent('div').remove(); x--;
	})
	
	$(wrapper01).on("click",".remove_field", function(e){ //user click on remove text
		e.preventDefault(); $(this).parent('div').remove(); x--;
	})
});
</script>



</body>
</html>