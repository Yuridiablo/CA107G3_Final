<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.ord.model.*"%>
<%@ page import="com.vendor.model.*" %>

<%
	
%>
<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>

<html lang="en">
<head>


<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC3teApdwmpN2yUfc6dftcDkHw1dLpV2B4&callback=initMap"></script>

<!-- 提交FORM表單 -->
<script type="text/javascript">
	$(document).ready(function() {
// 		$('.date #f_date1').change(function() {
// 			$('#form1').submit();
// 		})
		$('#inlineFormCustomSelectPref').change(function() {

			$('#form1').submit();
		})
		
	})
</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>

  <script>

    $(function(){
    // 取得使用者輸入的地址
      var addr = $('#addr').val();
      // 建立 Geocoder() 物件
      var gc = new google.maps.Geocoder();
   // 用使用者輸入的地址查詢
      gc.geocode({'address': addr}, function(result, status){
        // 確認 OK
        if(status == google.maps.GeocoderStatus.OK) {
          var latlng = result[0].geometry.location;
          // 將查詢結果設為地圖的中心
          var LAT=latlng.lat(); //顯示經度
          var LNG=latlng.lng(); //顯示緯度
          
          var position = {
              lat: LAT,
              lng: LNG
            };
          
          var mymap = new google.maps.Map($('#map').get(0), {
              zoom: 15,
              center: {lat:LAT , lng:LNG}
    });
          
          var marker = new google.maps.Marker({
           position: position,
           map: mymap,
           animation: google.maps.Animation.BOUNCE
         });
          
        }
      }); 
   
    });
    </script>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 日曆樣式 -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />

 <!-- 星星圖庫來源樣式 -->
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../front-end/css/starrr.css">
<!-- 評論區樣式 -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!-- <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.1.0/css/font-awesome.min.css"/> -->


<title>餐廳首頁</title>
<jsp:useBean id="res_tboSvc" scope="page" class="com.reservation_table_ordered.model.Reservation_Table_OrderedService" />
<jsp:useBean id="rev_tSvc" scope="page" class="com.reservation_time.model.Reservation_TimeService" />
<jsp:useBean id="now" scope="page" class="java.util.Date" />
<jsp:useBean id="ordSvc" scope="page" class="com.ord.model.OrdService" />
<jsp:useBean id="exc_dateSvc" scope="page" class="com.exception_date.model.Exception_DateService" />
<jsp:useBean id="commentSvc" scope="page" class="com.comments.model.CommentsService" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemberService" />

</head>
<style>
ul, ol, dl {
	list-style-type: none
}

  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }


img {
	border: none;
}

.clearfix {
	*zoom: 1;
}

.clearfix:before, .clearfix:after {
	display: table;
	line-height: 0;
	content: "";
}

.clearfix:after {
	clear: both;
}

.p20 {
	padding: 20px;
}

.mb20 {
	margin-bottom: 20px;
}

.mr20 {
	margin-right: 20px;
}

.fl {
	float: left;
	display: block;
}

.fr {
	float: right;
	display: block;
}


body {
	margin-top: 40px;
}

.stepwizard-step p {
	margin-top: 10px;
}

.stepwizard-row {
	display: table-row;
}

.stepwizard {
	display: table;
	width: 100%;
	position: relative;
}

.stepwizard-step button {
	opacity: 1 !important;
	filter: alpha(opacity = 100) !important;
}

.stepwizard-row:before {
	top: 14px;
	bottom: 0;
	position: absolute;
	content: " ";
	width: 100%;
	height: 1px;
	background-color: #ccc;
	z-order: 0;
}

.stepwizard-step {
	display: table-cell;
	text-align: center;
	position: relative;
}

.btn-circle {
	width: 30px;
	height: 30px;
	text-align: center;
	padding: 6px 0;
	font-size: 12px;
	line-height: 1.428571429;
	border-radius: 15px;
}


.animated {
	-webkit-transition: height 0.2s;
	-moz-transition: height 0.2s;
	transition: height 0.2s;
}



.card-inner {
	margin-left: 4rem;
}

#hotp1 {
	height: 300px;
	object-fit: cover;
}
.nav-link {
    margin-inline-start: 100px;
    margin-right: 100px;
}
</style>
<body onload="connect();" onunload="disconnect();">



	
	<div class="container">
	<div class=" col-md-12">	

	<div class="container">
		<div class="row justify-content-center"> 
			<div class="col-md-12">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
  					<li class="nav-item"><a class="nav-link" id="profile-tab"
						data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
						aria-selected="false">資訊</a></li>
					  <li class="nav-item">
					    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">訂位
					    </a></li>
					<li class="nav-item"><a class="nav-link" id="contact-tab"
						data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
						aria-selected="false">評論</a></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="container" style="margin-top: 80px">
		<div class="stepwizard">
			<div class="stepwizard-row setup-panel">
				<div class="stepwizard-step">
					<a href="#step-1" type="button" class="btn btn-primary btn-circle">1</a>
					<p>Step1 訂位</p>
				</div>
				<div class="stepwizard-step">
					<a href="#step-2" type="button" class="btn btn-default btn-circle">2</a>
					<p>Step2 訂餐</p>
				</div>
				<div class="stepwizard-step">
					<a href="#step-3" type="button" class="btn btn-default btn-circle">3</a>
					<p>Step3 結帳</p>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-12">
	
				<div class="tab-content" id="myTabContent">
				 <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
				  	<c:if test="${not empty errorMsgs}">
							<font style="color: red">請修正以下錯誤:</font>
							<ul>
								<c:forEach var="message" items="${errorMsgs}">
									<li style="color: red">${message}</li>
								</c:forEach>
							</ul>
						</c:if>	
<!-- 					  自動提交FORM開頭 -->
				<div>
					<form id="form1" action="<%=request.getContextPath()%>/ord/ord.do" method="get">
						<input type="hidden" name="action" id="action" value="updateDate">
						<input type="hidden" name="vendor_no" value="${param.vendor_no}">
						
						<div class="container">
							<div class="row justify-content-center">
								<div class="col-md-8">
										<div class="date" >	
											用餐日期<input name="booking_date" id="f_date1" type="text"
														value="${ordVO.booking_date}"  style="width: 400px;">
												
										</div>
									</div>
								</div>
							</div>
					<div class="container">
							<div class="row justify-content-center">
								<div class="col-md-12">
						人數選擇 <select class="custom-select my-1 mr-sm-4"
							id="inlineFormCustomSelectPref" style="width: 500px;"
							name="party_size">

							<option name="2" value="2">二人</option>
							<option name="3" value="3">三人</option>
							<option name="4" value="4">四人</option>
							<option name="5" value="5">五人</option>
							<option name="6" value="6">六人</option>
							<option name="7" value="7">七人</option>
							<option name="8" value="8">八人</option>
							<option name="9" value="10">十人</option>

						</select>
					</div>	
					</div>
					</div>
						
				</form>
<!-- 				自動提交結束 -->
		</div>
		<div class="container" >
			<div class="row justify-content-center">
				<div class="col-md-8">
					<FORM METHOD="get" ACTION="<%=request.getContextPath()%>/ord/ord.do" id="form2">
						<input type="hidden" name="mem_no" value="${mem_no}">	
						<input type="hidden" name="vendor_no" value="${param.vendor_no}">
						<input type="hidden" name="tbl_no" value="T000001"> 
						<input type="hidden" name="share_mem_no1" value="${ordVO.share_mem_no1}"> 
						<input type="hidden" name="share_mem_no2" value="${ordVO.share_mem_no2}">
						<input type="hidden" name="share_amount" value="0">
						<input type="hidden" name="ord_time"
								value="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/>">

						<input type="hidden" name="arrival_time" value="${ordVO.arrival_time}"> 
						<input type="hidden" name="finish_time" value="${ordVO.finish_time}"> 
						<input type="hidden" name="status" value="0"> 
						<input type="hidden" name="booking_date" value="${param.booking_date}">		
						<input type="hidden" name="party_size" value="${param.party_size}">		
						
						<div class=" btn-group-toggle" data-toggle="buttons" id="btngp">
									
										<c:forEach var="exc" items="${lhs}">	
										<input class="btn2 btn-primary" type="button" id="xx${exc.booking_time}"  value="${exc.booking_time}" onclick="sendMessage();" >

										</c:forEach>	
								</div>
						
			 	 <input type="hidden" name="booking_time"  id="realyvalue"value="">  		 
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-md-12">			
								<table>	
									<tr>
										<td>備註:</td>
										<td><input type="TEXT" name="notes" size="70" value="" />
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
						<div class="container">
							<div class="row justify-content-center">
								<div class="col-md-6">			
								<input type="hidden" name="action" value="sel_time"> 
<!-- 								<input type="submit" value="送出新增"> -->
								</div>
							</div>
						</div>
					</FORM>

								
				</div>
			</div>
		</div>	  
	
				  <jsp:useBean id="venSvc" scope="page" class="com.vendor.model.VendorService" />
				  
				  
				  </div>
				  <div class="tab-pane fade " id="profile" role="tabpanel" aria-labelledby="profile-tab">
				  	<div class="container">
						<div class="row">
							<div class="col-md-10">
								<div class="find-place-img_wrap">
									<div class="grid">
										<figure class="effect-ruby">
											<img src="<%= request.getContextPath()%>/ShowImg.do?vendor_no='${param.vendor_no}'&pic=1"/>
											<figcaption>
													<h5></h5>
	
											</figcaption>
										</figure>
									</div>
								</div>
								<c:set  var="vendorVO" value="${venSvc.findByPK(param.vendor_no)}" /> 
          <div class="container">
								<dl data-v-2ee1f21e="" class="info-list reset-list">
								<dt data-v-2ee1f21e="">餐廳位置</dt>
								<hr>
								<dd data-v-2ee1f21e="">${vendorVO.v_address1}${vendorVO.v_address2}${vendorVO.v_address3}</dd>
								<hr>
									<input type="hidden" id="addr" value=" ${vendorVO.v_address1}${vendorVO.v_address2}${vendorVO.v_address3}">
									      <div id="map" style="width:850px; height:400px; margin:0px auto;" ></div>
								<hr>
								<dt data-v-2ee1f21e="">餐廳E-mail</dt>
								<hr>
								<dd data-v-2ee1f21e="">${ vendorVO.v_mail}</dd>
								<!---->
								<hr>
								<dt data-v-2ee1f21e="">店家電話</dt>
								<hr>
								<dd data-v-2ee1f21e="">
									<a data-v-2ee1f21e="" href="tel:02-8786-7588">${vendorVO.v_tel}</a>
								</dd>
								<hr>
								<dt data-v-2ee1f21e="">營業時間</dt>
								<hr>
								<dd data-v-2ee1f21e="">${vendorVO.v_start_time}~${vendorVO.v_end_time}</dd>
								<hr>
								<dt data-v-2ee1f21e="">可接受付款方式</dt>
								<hr>
								<dd data-v-2ee1f21e="">現金、禮券(禮券、商品禮券、電子券類、餘代卡)、信用卡 (VISA、
									MASTERCARD、 JCB、 AE、銀聯卡、晶片金融卡、Apple Pay 、Android Pay、Samsung
									Pay )、LINE Pay 、微信支付、支付寶</dd>
								<hr>
							</dl>
							</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
			
					<div class="container">
					    <div class="row">
					        <div class="col-xs-12 col-md-12">
					            <div class="well well-sm">
					                <div class="row">
					                    <div class="col-xs-12 col-md-4 text-right">
					                        <h1 class="rating-num">
					                            ${avgscore}</h1>
					                        <div class="rating">
					                        <div class='starrr' id="avgscore"></div>
					                            
					                        </div>
					                        <div>
					                            <span class="glyphicon glyphicon-user"></span>1,050,008 total
					                        </div>
					                    </div>
					                    <div class="col-xs-12 col-md-8">
					                        <div class="row rating-desc">
					                            <div class="col-xs-3 col-md-3 text-right">
					                                <span class="glyphicon glyphicon-star"></span>很棒
					                            </div>
					                            <div class="col-xs-8 col-md-9">
					                                <div class="progress progress-striped">
					                                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="20"
					                                        aria-valuemin="0" aria-valuemax="100" style="width: ${E}%">
					                                        <span class="sr-only">80%</span>
					                                    </div>
					                                </div>
					                            </div>
					                            <!-- end 5 -->
					                            <div class="col-xs-3 col-md-3 text-right">
					                                <span class="glyphicon glyphicon-star"></span>非常好
					                            </div>
					                            <div class="col-xs-8 col-md-9">
					                                <div class="progress">
					                                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="20"
					                                        aria-valuemin="0" aria-valuemax="100" style="width: ${D}%">
					                                        <span class="sr-only">60%</span>
					                                    </div>
					                                </div>
					                            </div>
					                            <!-- end 4 -->
					                            <div class="col-xs-3 col-md-3 text-right">
					                                <span class="glyphicon glyphicon-star"></span>一般
					                            </div>
					                            <div class="col-xs-8 col-md-9">
					                                <div class="progress">
					                                    <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20"
					                                        aria-valuemin="0" aria-valuemax="100" style="width: ${C}%">
					                                        <span class="sr-only">40%</span>
					                                    </div>
					                                </div>
					                            </div>
					                            <!-- end 3 -->
					                            <div class="col-xs-3 col-md-3 text-right">
					                                <span class="glyphicon glyphicon-star"></span>不好
					                            </div>
					                            <div class="col-xs-8 col-md-9">
					                                <div class="progress">
					                                    <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="20"
					                                        aria-valuemin="10" aria-valuemax="100" style="width: ${B}%">
					                                        <span class="sr-only">20%</span>
					                                    </div>
					                                </div>
					                            </div>
					                            <!-- end 2 -->
					                            <div class="col-xs-3 col-md-3 text-right">
					                                <span class="glyphicon glyphicon-star"></span>很差
					                            </div>
					                            <div class="col-xs-8 col-md-9">
					                                <div class="progress">
					                                    <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80"
					                                        aria-valuemin="0" aria-valuemax="100" style="width: ${A}%">
					                                        <span class="sr-only">15%</span>
					                                    </div>
					                                </div>
					                            </div>
					                            <!-- end 1 -->
					                        </div>
					                        <!-- end row -->
					                    </div>
					                </div>
					            </div>
					        </div>
					    </div>
					</div>
					<div class="container">
						<div class="row ">
								<c:forEach var="cmapVO" items="${cMap}">
								  <div class="well">
								      <div class="media">
								      	<a class="pull-left" href="#">
								  <img src="<%= request.getContextPath()%>/ShowImg.do?mem_no='${cmapVO.key.mem_no}'"class="mr-3 memshow" alt="...">
								 
								  		</a>
								  		<div class="media-body">
								    		<h4 class="media-heading">標題</h4>
								          <h4><p class="text-left">${cmapVO.key.mem_name}</p></h4>
								         <h4> <p>${cmapVO.value.cmnt}</p></h4>
								          <ul class="list-inline list-unstyled">
								           <li>
								             <div class='starrr' id="s${cmapVO.value.cmnt_no}"></div>
								            </li>
								            <li>|</li>
								  			<li><span><i class="glyphicon glyphicon-calendar"></i> 
								  			<fmt:formatDate type="both"  value="${cmapVO.value.time}" /> </span></li>
								            <li>|</li>
								            
								           
								            <li>
								            <!-- Use Font Awesome http://fortawesome.github.io/Font-Awesome/ -->
								              <span> <a href="https://www.facebook.com/search/top/?q=wang%20lee&epa=SEARCH_BOX" ><i class="fa fa-facebook-square"></i></a></span>	
								              <span><a href="https://www.instagram.com/?hl=zh-tw"><i class="fa fa-twitter-square"></i></a></span>
								              <span><a href="https://drive.google.com/drive/my-drive"><i class="fa fa-google-plus-square"></i></a></span>
								              
								            </li>
											</ul>
								       </div>
								       
								    </div>
								    <div class="media-body">
				            	    <div class="card-body">
				            	        <div class="row">
				                    	    <div class="col-md-8">
<!-- 								  ＝＝＝拿出每一篇回應,判斷評論的編號是否跟回應評論的編號一樣＝＝＝-->				                    	     
				                    	        <c:forEach var="rrVO" items="${rrlist}">
												  <c:set var="rr" value="${rrVO. cmnt_no}"></c:set>
												   <c:if test="${(rr)==(cmapVO.value.cmnt_no)}">
														<c:set var="rrtext" value="${rrVO.res_text}"></c:set>
														<c:set var="rrtime" value="${rrVO.res_time}"></c:set>
														 <h5 class="mt-0">店家回覆</h5>
														<div class="panel panel-default arrow right">
											                <div class="panel-body">
											                  <header class="text-right"></header>
											                  <div class="comment-post">
											                    <h3><p>
											                    ${rrtext }
											                    </p></h3>
											                    <span><i class="glyphicon glyphicon-calendar"></i> 
													  			<fmt:formatDate type="both"  value="${rrtime }" /> </span>
													            </div>
											                  </div>
											                  </div>
														</c:if>
												  	 </c:forEach>
				                    	    </div>
				            	        </div>
				            	    </div>
					            </div>
								  </div>
								</c:forEach>
								  </div>
								</div>
							</div>
							
						</div>
				
				
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>

	<script src="js/jquery-3.3.1.min.js"></script>
	<script src="js/popper.min.js"></script>

	<!-- 日期的ＪＳ -->
	
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>


</style>
	<script>
		$.datetimepicker.setLocale('zh');
		$('#f_date1').datetimepicker({
			theme : '', //theme: 'dark',
			timepicker : false, //timepicker:true,
			step : 1, //step: 60 (這是timepicker的預設間隔60分鐘)       
			format : 'Y-m-d',
// 			value : 'new Date()',
// 			disabledDates: ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
// 	        startDate:	            '2017/07/10',  // 起始日
	           //minDate:               '-1970-01-01', // 去除今日(不含)之前
	           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
		});
		
// 		 1.以下為某一天之前的日期無法選擇
	             var somedate1 = new Date();
	             $('#f_date1').datetimepicker({
	                 beforeShowDay: function(date) {
	               	  if (  date.getYear() <  somedate1.getYear() || 
	        		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	        		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	                     ) {
	                          return [false, ""]
	                     }
	                     return [true, ""];
	             }});

	        
// 	             2.以下為某一天之後的日期無法選擇

					
				
// 	            var somedate2 = new Date();
	         
//              $('#f_date1').datetimepicker({
//                  beforeShowDay: function(date) {
//                	  if (  date.getYear() >  somedate2.getYear() || 
//         		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
//         		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
//                      ) {
//                           return [false, ""]
//                      }
//                      return [true, ""];
//              }});

	</script>
	
<script>

$(function () {
  $('#myTab li:last-child a').tab('show')
})

</script>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script
		src="http://www.5imoban.net/download/jquery/jquery-1.8.3.min.js"></script>
	<!-- 星星 -->
    <script src="../front-end/js/starrr.js"></script>
	
	<script>
		$(function() {
			//评分
			$("#score li dd").click(
					function() {
						var index = $(this).index();
						$(this).parent("dl").children("dd").removeClass("on");
						var i = index + 1;
						$(this).parent("dl").children("dd:lt(" + i + ")")
								.addClass("on");
					})
		})
	</script>

<c:forEach var="exc" items="${lhs}">
<script type="text/javascript">
$("#xx${exc.booking_time}").click(async function(event){
	
	const {value: file} = Swal.fire({
		  title: "您選擇的<br>日期：${param.booking_date}<br>人數：${param.party_size}人<br>時段：${exc.booking_time}",
		  width: 600,
		  padding: '3em',
		  background: '#fff url(https://sweetalert2.github.io/#examplesimages/trees.png)',
		  showConfirmButton:true,
		  showCancelButton: true,
		  backdrop: `
		    rgba(0,0,123,0.4)
		    url("https://sweetalert2.github.io/#examplesimages/nyan-cat.gif")
		    center left
		    no-repeat
		  `
		}).then((result) => {
			  if (result.value) {
				    Swal.fire(
				    
				    )
					var yyy=$("#xx${exc.booking_time}").val();
					$("#realyvalue").val(yyy);
					$('#form2').submit();
				  }
				})
		
		
		
		
		
})
 


</script>

</c:forEach>
<c:forEach var="exc" items="${lhs}">
<script>


var MyPoint = "/MyEchoServer/${booking_date}/${party_size}";
var host = window.location.host;
var path = window.location.pathname;
var webCtx = path.substring(0, path.indexOf('/', 1));
var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;

var webSocket;
var myID;


function connect() {
	// 建立 websocket 物件
	webSocket = new WebSocket(endPointURL);
	webSocket.onopen = function(event) {
// 		updateStatus("WebSocket 成功連線");
	}
	
	webSocket.onclose = function(event) {
// 		updateStatus("WebSocket 已離線");
	};
		
	webSocket.onmessage = function(event) {
		var data=event.data
		if(data=='open'){
			document.getElementById("xx${exc.booking_time}").disabled = true;
			document.getElementById("xx${exc.booking_time}").style.color="#ff0000";
			alert("${exc.booking_time}");
		}
		

	};
	};
	
	function sendMessage() {
		webSocket.send("open");
		
		
 	}
	function disconnect () {
		webSocket.close();
		
	}
	

</script>
</c:forEach>
<c:forEach var="cmapVO" items="${cMap}">
    <script type="text/javascript">
    $('#s${cmapVO.value.cmnt_no}').starrr({
    	
    	max: 5,
    	rating:${cmapVO.value.score},
    	readOnly: true,
    	emptyClass: 'fa fa-star-o',
        fullClass: 'fa fa-star'
        
      });
    
    </script>
</c:forEach>
  <script type="text/javascript">
    $('#avgscore').starrr({
    	
    	max: 5,
    	rating:${avgscore},
    	readOnly: true,
    	emptyClass: 'fa fa-star-o',
        fullClass: 'fa fa-star'
        
      });
    
    </script>
</body>
</html>
