<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.vendor.model.*"%>

<jsp:useBean id="vVO" scope="session" class="com.vendor.model.VendorVO" />
<% 
	
	String vday = vVO.getV_day().equals("0") ? "0000000" : vVO.getV_day();
	boolean d1 = String.valueOf(vday.charAt(0)).equals("1") ? true : false;
	boolean d2 = String.valueOf(vday.charAt(1)).equals("1") ? true : false;
	boolean d3 = String.valueOf(vday.charAt(2)).equals("1") ? true : false;
	boolean d4 = String.valueOf(vday.charAt(3)).equals("1") ? true : false;
	boolean d5 = String.valueOf(vday.charAt(4)).equals("1") ? true : false;
	boolean d6 = String.valueOf(vday.charAt(5)).equals("1") ? true : false;
	boolean d7 = String.valueOf(vday.charAt(6)).equals("1") ? true : false;
	
	pageContext.setAttribute("d1", d1);
	pageContext.setAttribute("d2", d2);
	pageContext.setAttribute("d3", d3);
	pageContext.setAttribute("d4", d4);
	pageContext.setAttribute("d5", d5);
	pageContext.setAttribute("d6", d6);
	pageContext.setAttribute("d7", d7);
%>


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
</head>
<!-- ============================================================================= -->

<body>
<script type="text/javascript">
console.log("webContent/vendor/upvendor.jsp");
</script>
	<div class="container">
		<div class="row">
			<div class="col-6">
				<!-- ===============================編輯區 開始====================================== -->


				<form class="needs-validation" novalidate METHOD="post" ACTION="Vendor.do" name="form1">
					<div class="container">

						<div class="col-12">
							<label id="topicBar" class="col-12">餐廳營業資訊設定</label>
							<div class="form-row">
								<div class="col-4 col-form-label">
									<label for="validationTooltip01">餐廳類型 :</label>
								</div>
								
								<div class="col-8" id="selectType">
								<select class="form-control"  name="v_type">
                                
                                  <option value="中式餐廳">中式餐廳</option>
                                  <option value="日式料理">日式料理</option>
                                  <option value="泰國餐廳">泰國餐廳</option>
                                  <option value="燒烤餐廳">燒烤餐廳</option>
                                  <option value="東南亞風味">東南亞風味</option>
                                  <option value="義式料理">義式料理</option>
                                  <option value="吃到飽">吃到飽</option>
                                  <option value="美式餐廳">美式餐廳</option>
                                  <option value="火鍋店">火鍋店</option>
                                  <option value="甜點店">甜點店</option>
                                  
                                </select>
							
<%-- 									<input type="text" name="v_type" value="${vVO.v_type}" class="form-control" --%>
<!-- 										placeholder="請輸入餐廳類型" required> -->
								</div>
							</div>
							<div class="form-row">
								<div class="col-4 col-form-label">
									<label>開始營業時間 :</label>
								</div>
								<div class="col-8" id="selectOpen">
									<select class="form-control"  name="v_start_time">
	                                
	                                  <option value="0000">00:00</option>
	                              	  <option value="0100">01:00</option>
	                              	  <option value="0200">02:00</option>
	                              	  <option value="0300">03:00</option>
	                              	  <option value="0400">04:00</option>
	                              	  <option value="0500">05:00</option>
	                                  <option value="0600">06:00</option>
	                                  <option value="0700">07:00</option>
	                                  <option value="0800">08:00</option>
	                                  <option value="0900">09:00</option>
	                                  <option value="1000">10:00</option>
	                                  <option value="1100">11:00</option>
	                                  <option value="1200">12:00</option>
	                                  <option value="1300">13:00</option>
	                                  <option value="1400">14:00</option>
	                                  <option value="1500">15:00</option>
	                                  <option value="1600">16:00</option>
	                                  <option value="1700">17:00</option>
	                                  <option value="1800">18:00</option>
	                                  <option value="1900">19:00</option>
	                                  <option value="2000">20:00</option>
	                                  <option value="2100">21:00</option>
	                                  <option value="2200">22:00</option>
	                                  <option value="2300">23:00</option>
	                                  
	                                </select>
<%-- 									<input type="text" name="v_start_time" value="${vVO.v_start_time}" class="form-control" --%>
<!-- 										placeholder="開店時間" required> -->
<!-- 									<div class="invalid-tooltip">請輸入正確格式</div> -->
								</div>
							</div>
							<div class="form-row">
								<div class="col-4 col-form-label">
									<label>結束營業時間 :</label>
								</div>
								<div class="col-8" id="selectColse">
									<select class="form-control"  name="v_end_time">
	                              	  <option value="0000">00:00</option>
	                              	  <option value="0100">01:00</option>
	                              	  <option value="0200">02:00</option>
	                              	  <option value="0300">03:00</option>
	                              	  <option value="0400">04:00</option>
	                              	  <option value="0500">05:00</option>
	                                  <option value="0600">06:00</option>
	                                  <option value="0700">07:00</option>
	                                  <option value="0800">08:00</option>
	                                  <option value="0900">09:00</option>
	                                  <option value="1000">10:00</option>
	                                  <option value="1100">11:00</option>
	                                  <option value="1200">12:00</option>
	                                  <option value="1300">13:00</option>
	                                  <option value="1400">14:00</option>
	                                  <option value="1500">15:00</option>
	                                  <option value="1600">16:00</option>
	                                  <option value="1700">17:00</option>
	                                  <option value="1800">18:00</option>
	                                  <option value="1900">19:00</option>
	                                  <option value="2000">20:00</option>
	                                  <option value="2100">21:00</option>
	                                  <option value="2200">22:00</option>
	                                  <option value="2300">23:00</option>
	                                  
	                                </select>
									
<%-- 									<input type="text" name="v_end_time" value="${vVO.v_end_time}" class="form-control" id="pwd" --%>
<!-- 										placeholder="打烊時間" maxlength="10" required -->
<!-- 										pattern="^(?=.*\d)(?=.*[A-za-z]).{6,10}$"> -->

								</div>
							</div>
							<div class="form-row">
								<div class="col-4 col-form-label">
									<label>定期休假 :</label>
								</div>
								<div class="col-7">
								
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="checkbox" id="inlineCheckbox1" name="d1" value="1">
								  <label class="form-check-label" for="inlineCheckbox1">一</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="checkbox" id="inlineCheckbox2" name="d2" value="1">
								  <label class="form-check-label" for="inlineCheckbox2">二</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="checkbox" id="inlineCheckbox3" name="d3" value="1">
								  <label class="form-check-label" for="inlineCheckbox3">三</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="checkbox" id="inlineCheckbox4" name="d4" value="1">
								  <label class="form-check-label" for="inlineCheckbox4">四</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="checkbox" id="inlineCheckbox5" name="d5" value="1">
								  <label class="form-check-label" for="inlineCheckbox5">五</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="checkbox" id="inlineCheckbox6" name="d6" value="1">
								  <label class="form-check-label" for="inlineCheckbox6">六</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="checkbox" id="inlineCheckbox7" name="d7" value="1">
								  <label class="form-check-label" for="inlineCheckbox7">日</label>
								</div>
						
<%-- 									<input type="text" name="v_day" value="${vVO.v_day}" class="form-control" --%>
<!-- 										placeholder="選擇星期" maxlength="10" id="pwdconfirm" required -->
<!-- 										pattern="^(?=.*\d)(?=.*[A-za-z]).{6,10}$"> -->

								</div>
							</div>
							<div class="form-row">
								<div class="col-4 col-form-label">
									<label>店內總桌數 :</label>
								</div>
								<div class="col-8">
									<input type="text" name="v_tables" value="${vVO.v_tables}" class="form-control"
										placeholder="數字" required>
									<div class="invalid-tooltip">請輸入有效信箱</div>
								</div>
							</div>
				
							<div class="form-row">
								<div class="col-4 col-form-label">
									<label>餐廳說明 :</label>
								</div>
								<div class="col-8">
									<textarea rows="6" cols="50" name="v_text" class="form-control"
										aria-label="With textarea">${vVO.v_text}</textarea>


								</div>

							</div>

<input type="hidden" name="action"	value="Update">
<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
							<div>
								<button type="submit" class="btn btn-primary col-12">修改</button>
							</div>
						</div>
					</div>
			</div>
			
			</form>
			<div class="col-6">
				<div class="form-row">
					<div class="col-3 col-form-label">
						<label>店家形象</label>
					</div>
					<div class="col-9">
						<button id="V_PIC">更換形象</button>
					</div>
				</div>
				<img id="pic1" src="<%= request.getContextPath()%>/ShowImg.do?vendor_no='${vVO.vendor_no}'&pic=1" onerror="this.src='../front-end/images/SeeKFoodA.png'">
<!-- 				<img id="pic1" src="https://api.fnkr.net/testimg/350x200/00CED1/FFF/?text=img+placeholder"> -->
				<div class="form-row">
					<div class="col-3 col-form-label">
						<label>目前宣傳</label>
					</div>
					<div class="col-9">
						<button id="V_AD">更換宣傳</button>
					</div>
				</div>
				<img id="ad1" src="<%= request.getContextPath()%>/ShowImg.do?vendor_no='${vVO.vendor_no}'&ad=1" onerror="this.src='../front-end/images/SeeKFoodA.png'">
<!-- 				<img id="ad1" src="https://api.fnkr.net/testimg/350x200/00CED1/FFF/?text=img+placeholder"> -->
			</div>






















			<!-- =================================編輯區 結束==================================== -->
		</div>
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
	<script type="text/javascript">
$("#V_PIC").click(async function(event) {
    
const {value: file} = await Swal.fire({
  title: '請選擇圖片',
  input: 'file',
  inputAttributes: {
    'accept': 'image/*',
    'aria-label': 'Upload your profile picture'
  }
})
if (file) {
  const reader = new FileReader
  reader.onload = (e) => {
    Swal.fire({
      title: '圖片已變更為',
      imageUrl: e.target.result,
      imageAlt: 'The uploaded picture'
      
   
    }).then(function(file){
    	$.ajax({
    		url: "Vendor.do",
            type : 'post',
			data: { action: 'upPic', file: e.target.result},
			dataType: 'json',
			async : false,//同步請求
			cache : false,//不快取頁面
			
    	})
    })
    $('#pic1').attr('src', e.target.result);
  }
  
  reader.readAsDataURL(file)
}
})
$("#V_AD").click(async function(event) {
    
const {value: file} = await Swal.fire({
  title: '請選擇圖片',
  input: 'file',
  inputAttributes: {
    'accept': 'image/*',
    'aria-label': 'Upload your profile picture'
  }
})
if (file) {
  const reader = new FileReader
  reader.onload = (e) => {
    Swal.fire({
      title: '圖片已變更為',
      imageUrl: e.target.result,
      imageAlt: 'The uploaded picture'
      
   
    }).then(function(file){
    	$.ajax({
    		url: "Vendor.do",
            type : 'post',
			data: { action: 'upAd', file: e.target.result},
			dataType: 'json',
			async : false,//同步請求
			cache : false,//不快取頁面
			
    	})
    })
    $('#ad1').attr('src', e.target.result);
  }
  
  reader.readAsDataURL(file)
}
})
    </script>
    
    <script>
   
    $('#selectType select').val('${vVO.v_type}');
    $('#selectOpen select').val('${vVO.v_start_time}');
    $('#selectColse select').val('${vVO.v_end_time}');
   	
    
    $('#selectOpen select, #selectColse select').change(function() {
    	if($('#selectOpen select').val() == $('#selectColse select').val()){
    		Swal.fire({
    			
    			  type: 'info',
    			  title: '你不能一開門就關門！',
    			  
    			})
    		 $('#selectColse select').val('0000');
        }
   	});
    
    $('#inlineCheckbox1').prop("checked",${d1});
    $('#inlineCheckbox2').prop("checked",${d2});
    $('#inlineCheckbox3').prop("checked",${d3});
    $('#inlineCheckbox4').prop("checked",${d4});
    $('#inlineCheckbox5').prop("checked",${d5});
    $('#inlineCheckbox6').prop("checked",${d6});
    $('#inlineCheckbox7').prop("checked",${d7});

    
    </script>
</body>

</html>