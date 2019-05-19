<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.vendor.model.*"%>
<%@ page import="com.vendor.controller.*"%>

<% 
	VendorService vendorService = new VendorService();
	VendorVO vVO = (VendorVO) session.getAttribute("vVO");
	String vendor_no = null;
	if (vVO != null && vVO.getVendor_no() != null) { // important!!!!!!!!!!!!!!!!!!!!!!!!!!
		vendor_no = vVO.getVendor_no();
	} else if (request.getParameter("vendor_no") == null) {		
		vendor_no = "V000001";			
	} else {
		vendor_no = request.getParameter("vendor_no");
	}	
	vVO = vendorService.findByPK(vendor_no);
// 	session.setAttribute("vVo", vVO);
	
	String vday = vVO.getV_day();
	if (vday == null || "0".equals(vday)) {
		vday = "0000000";
	}
	boolean d1 = String.valueOf(vday.charAt(0)).equals("1");
	boolean d2 = String.valueOf(vday.charAt(1)).equals("1");
	boolean d3 = String.valueOf(vday.charAt(2)).equals("1");
	boolean d4 = String.valueOf(vday.charAt(3)).equals("1");
	boolean d5 = String.valueOf(vday.charAt(4)).equals("1");
	boolean d6 = String.valueOf(vday.charAt(5)).equals("1");
	boolean d7 = String.valueOf(vday.charAt(6)).equals("1");
	boolean[] oday = {d1, d2, d3, d4, d5, d6, d7};
%>


<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<title>餐廳基本資料</title>

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Vendor/bootstrap/bootstrap.min.css">
	<!-- Sweetalert2 CSS -->
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Vendor/sweetalert2/sweetalert2.min.css">
	<!-- jQuery UI CSS -->
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Vendor/jquery-ui-1.12.1/jquery-ui.css">
    <!-- google icon -->
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Vendor/fonts/Material+Icons.css">
	
	<%@ include file="navbar/nav_css.txt" %>
	
	<!-- card -->
    <style type="text/css">
    	.vInfoCard {
    		background-color: #f8f9ff;
    		/*#f8f9fa*/
    		box-shadow: 0 3px 5px 0 rgba(0,0,0,0.15);
    		padding: 20px;
    		margin-bottom: 50px;
    	}
    	.vInfoCard-header {
    		padding: 10px;
    		font-size:24px;
    		font-weight:bold;
    	}
    	.vInfoCard-item {
    		padding: 10px;
    		border-bottom:#ddd 1px solid;  
    	}
    	.vItem-title {
    		font-size:18px;
    		font-weight:bold;
    		margin-bottom: 10px;
    	}
    	.vItem-content {
    		font-size:16px;
    		padding-left: 40px;
    	}
   	
    </style>

    <!-- slider -->
    <style type="text/css">
    	.ui-slider-horizontal {
    		height: 20px;
    	}

    	.ui-slider .ui-slider-handle {
    		height: 40px;
    	}
		
		.ui-slider-horizontal .ui-slider-handle {
			top: -10px;
		}
    	.ui-slider-range {
    		background-color: #ccccff;
    	}
    	.slider-tick-mark .tick {
    		width: calc(100% / 12);
    		margin-top: 10px;
    		border-left: 1px solid #aaa;
    	}
    </style>
	
	<!-- open time -->
    <style type="text/css">
    	.openTrue,.openFalse {
			display: inline-block;
		    font-weight: 400;		 
		    text-align: center;
		    vertical-align: middle;
		    user-select: none;
		    background-color: transparent;
		    border: 1px solid transparent;
		    padding: .375rem .75rem;
		    font-size: 1rem;
		    line-height: 1.5;
		    border-radius: .25rem;	    		
    	}
    	.openTrue {
    		color: #fff;
		    background-color: #28a745;
		    border-color: #28a745;
	    
    	}
    	.openFalse {
    		color: #28a745;
		    border-color: #28a745;
    	}
    </style>
    <style>
	    .divAlert {
	   		position: fixed;
	   		bottom: 0;
	   		left: 0;
	   		display: flex;
	   	}
    </style>

    <!-- edit -->
    <style type="text/css">
    	#basic-left .vItem-content, .edit-container, #v_pic .vItem-title, #openTime, .d-f-sb {
    		display: flex;
    		justify-content: space-between;
    	}
    	#basic-left .vItem-content i, .vItem-content-edit, #v_pic i, #v_ad i {
    		display: none;    		
    	}
    	i {
    		cursor: pointer;
    	}

    </style>
    <!-- load -->
    <style type="text/css">
       .item-edit {
         position:relative;
       }
       .editLoad {
       	display: none;
         position:absolute;
          z-index: 30; 
          background-color:  
          rgba(217, 215, 215, 0.7); 
          width: 100%; 
          height: 100%; 
          top:0; 
          left:0; 
          text-align: center;
       }
     </style>
  </head>
  <body>
  
	<%@ include file="navbar/navbar.txt" %>
	<%@ include file="navbar/side_navbar.txt" %>
	
    <div class="container mt-4">
  	  
  	  <!-- 基本資料 -->
  	  <div class="vInfoCard">
  	  	<div class="vInfoCard-header">
  	  		<div class="vInfoCard-title">基本資料</div>  	  		
  	  	</div>
  	  	<div class="vInfoCard-body row">

  	  		<div class="vInfoCard-block col" id="basic-left">
  	  			<div class="vInfoCard-item  ">
  	  				<div class="vItem-title">餐廳名稱</div>
  	  				<div class="vItem-content">
  	  					<%= vVO.getV_name() %>
  	  					<i class="material-icons">edit</i>  	  					
  	  				</div>
  	  				<div class="vItem-content-edit item-edit" data-cnt="<%= vVO.getV_name() %>">
  	  					<div class="edit-container">
	  	  					<input class="form-control" type="text" value="<%= vVO.getV_name() %>">
	  	  					<i class="material-icons">cancel</i>
	  	  					<i class="material-icons">check</i>
  	  					</div>
  	  				</div>
  	  			</div>
  	  			<div class="vInfoCard-item  ">
  	  				<div class="vItem-title">電話</div>
  	  				<div class="vItem-content">
  	  					<%= vVO.getV_n_code()+ " " + vVO.getV_tel() %>
  	  					<i class="material-icons">edit</i> 
  	  				</div>
  	  				<div class="vItem-content-edit item-edit" data-cnt="<%= vVO.getV_n_code()+ " " + vVO.getV_tel() %>">
  	  					<div class="edit-container">
	  	  					<input class="form-control" type="text" value="<%= vVO.getV_n_code()+ " " + vVO.getV_tel() %>">
	  	  					<i class="material-icons">cancel</i>
	  	  					<i class="material-icons">check</i>
  	  					</div>
  	  				</div>

  	  			</div>
  	  			<div class="vInfoCard-item  ">
  	  				<div class="vItem-title">地址</div>
  	  				<div class="vItem-content">
  	  					<%= vVO.getV_address1() + vVO.getV_address2() +vVO.getV_address3() %>
  	  					<i class="material-icons">edit</i> 
  	  				</div>
  	  				<div class="vItem-content-edit item-edit" data-cnt="<%= vVO.getV_address1() + vVO.getV_address2() +vVO.getV_address3() %>">
  	  					<div class="edit-container">
	  	  					<input class="form-control" type="text" value="<%= vVO.getV_address1() + vVO.getV_address2() +vVO.getV_address3() %>">
	  	  					<i class="material-icons">cancel</i>
	  	  					<i class="material-icons">check</i>
  	  					</div>
  	  				</div>
  	  			</div>
  	  			<div class="vInfoCard-item">
  	  				<div class="vItem-title">餐廳類型</div>
  	  				<div class="vItem-content item-show">
  	  					<%= vVO.getV_type()==null ? "無" :vVO.getV_type() %>
  	  					<i class="material-icons">edit</i> 
  	  				</div>
  	  				<div class="vItem-content-edit item-edit" data-cnt="<%= vVO.getV_type() %>">
  	  					<div class="editLoad"><img src="images/ui-anim_basic_16x16.gif"></div>
  	  					<div class="edit-container">
							<select class="form-control inputVal"  name="v_type">
							  <option value="請選擇" <%= vVO.getV_type()==null ? "selected" : "" %>>請選擇</option>                          
                              <option value="中式餐廳" <%= vVO.getV_type().equals("中式餐廳") ? "selected" : "" %>>中式餐廳</option>
                              <option value="日式料理"<%= vVO.getV_type().equals("日式料理") ? "selected" : "" %>>日式料理</option>
                              <option value="泰國餐廳"<%= vVO.getV_type().equals("泰國餐廳") ? "selected" : "" %>>泰國餐廳</option>
                              <option value="燒烤餐廳"<%= vVO.getV_type().equals("燒烤餐廳") ? "selected" : "" %>>燒烤餐廳</option>
                              <option value="東南亞風味"<%= vVO.getV_type().equals("東南亞風味") ? "selected" : "" %>>東南亞風味</option>
                              <option value="義式料理"<%= vVO.getV_type().equals("義式料理") ? "selected" : "" %>>義式料理</option>
                              <option value="吃到飽"<%= vVO.getV_type().equals("吃到飽") ? "selected" : "" %>>吃到飽</option>
                              <option value="美式餐廳"<%= vVO.getV_type().equals("美式餐廳")? "selected" : "" %>>美式餐廳</option>
                              <option value="火鍋店"<%= vVO.getV_type().equals("火鍋店") ? "selected" : "" %>>火鍋店</option>
                              <option value="甜點店"<%= vVO.getV_type().equals("甜點店") ? "selected" : "" %>>甜點店</option>                              
                            </select>	  	  					
	  	  					<i class="material-icons">cancel</i>
	  	  					<i id="v_type" class="material-icons">check</i>
  	  					</div>
  	  				</div>
  	  			</div>
  	  			<div class="vInfoCard-item  " style="border-bottom: none;">
  	  				<div class="vItem-title">餐廳說明</div>
  	  				<div class="vItem-content item-show">
  	  					<%= vVO.getV_text()==null ? "" : vVO.getV_text()%>
  	  					<i class="material-icons">edit</i> 
  	  				</div>
  	  				<div class="vItem-content-edit item-edit" data-cnt="<%= vVO.getV_text()==null ? "" : vVO.getV_text()%>">
  	  					<div class="editLoad"><img src="images/ui-anim_basic_16x16.gif"></div>
  	  					<div class="edit-container">
	  	  					<textarea rows="6" cols="50" name="v_text" class="form-control inputVal" aria-label="v_text"><%= vVO.getV_text()==null ? "" : vVO.getV_text()%></textarea>
	  	  					<i class="material-icons">cancel</i>
	  	  					<i id="v_text" class="material-icons">check</i>
  	  					</div>
  	  				</div>
  	  			</div>
  	  		</div>

  	  		<div class="vInfoCard-block col">
  	  			<div id="v_pic" class="vInfoCard-item show-editPen" style="border-bottom: none;">
  	  				<div class="vItem-title">
  	  					店家形象
  	  					<i id="v_pic_btn" class="material-icons">edit</i>
  	  				</div>
  	  				<div class="vItem-content">
  	  					<img id="pic1" src="<%= request.getContextPath()%>/ShowImg.do?vendor_no='<%= vendor_no %>'&pic=1" onerror="this.src='<%= request.getContextPath() %>/front-end/images/SeeKFoodA.png'"  style="max-width: 500px;">
  	  				</div>
  	  			</div> 			
  	  		</div>

  	  	</div> <!-- End of vInfoCard-body -->
  	  </div> <!-- End of 基本資料 -->


  	  <!-- 目前宣傳 -->
  	  <div class="vInfoCard">
  	  	<div class="vInfoCard-header">
  	  		<div class="vInfoCard-title">目前宣傳</div>
  	  	</div> <!-- End of vInfoCard-header -->
  	  	<div class="vInfoCard-body" style="text-align: center;">
  			<div id="v_ad" class="vInfoCard-item show-editPen" style="border-bottom: none;">  				
  				<div class="vItem-title" style="text-align: right; height: 10px;">
  					<i id="v_ad_btn" class="material-icons">edit</i>
  				</div>  				
  				<div class="vItem-content">
  					<img id="ad1" src="<%= request.getContextPath()%>/ShowImg.do?vendor_no='<%= vendor_no %>'&ad=1" onerror="this.src='<%= request.getContextPath() %>/front-end/images/SeeKFoodA.png'"  style="max-width: 500px;">
  				</div>
  			</div> <!-- End of vInfoCard-item -->  	  			
  	  	</div> <!-- End of vInfoCard-body -->
  	  </div> <!-- End of 目前宣傳 -->


  	  <!-- 營業時間 -->
  	  <div class="vInfoCard">
  	  	<div class="vInfoCard-header">
  	  		<div class="vInfoCard-title">營業時間</div>
  	  	</div> <!-- End of vInfoCard-header -->
  	  	<div class="vInfoCard-body">
  	  		
  			<div id="openDayDiv" class="vInfoCard-item  " style="border-bottom: none;">
  				<div class="vItem-title">星期</div>	
  				<div class="vItem-content item-show" style="display: flex">
					<div>
					<%
						String[] week = { "日", "一", "二", "三", "四", "五", "六" };
						for (int i = 0; i < 7; i++) { %>
							<label class="<%= oday[i] ? "openTrue" : "openFalse"%>">
							<%= week[i] %>
							</label>
					<%	}%>
					
 					
					</div> 
					<i class="material-icons" style="padding-left: 20px; display: none;">edit</i>
				</div> 							
  				<div class="vItem-content-edit item-edit" data-cnt="<%= vVO.getV_day() %>">
					<div class="editLoad"><img src="images/ui-anim_basic_16x16.gif"></div>
					<div style="display: inline-flex;">
						<div class="btn-group-toggle inputVal" data-toggle="buttons">
					<%
						for (int i = 0; i < 7; i++) { %>
							<label class="btn btn-outline-success <%= oday[i] ? "active" : ""%>">							
								<input type="checkbox" autocomplete="off" <%= oday[i] ? "checked" : ""%>>
								<span class="week"><%= week[i] %></span>
							</label>
					<%	}%>
					
						</div>
	  					<i class="material-icons" style="padding-left: 20px; ">cancel</i>
	  					<i id="v_day" class="material-icons">check</i>	
	  				</div>		
  				</div>
  			</div> <!-- End of vInfoCard-item -->

  			<div id="openTimeDiv" class="vInfoCard-item" style="border-bottom: none;">
  				<div class="vItem-title">時間</div> 	

  				<div class="vItem-content item-show" style="display: flex;">
  					<div style="display: flex; padding-bottom: 10px; font-size: 20px;">  						
  						<div id="startTimeDiv"><%= TimeFmt.addSep(vVO.getV_start_time()) %></div>
  						<div>-</div>
  						<div id="endTimeDiv"><%= TimeFmt.addSep(vVO.getV_end_time()) %></div> 						
  					</div>
  					<i class="material-icons" style="padding-left: 20px; display: none;">edit</i> 
  				</div>

 				<div class="vItem-content-edit item-edit" data-cnt1="<%= TimeFmt.text2minute(vVO.getV_start_time()) %>" data-cnt2="<%= TimeFmt.text2minute(vVO.getV_end_time()) %>">
					<div class="editLoad"><img src="images/ui-anim_basic_16x16.gif"></div>
  					<div id="openTime" style="padding-bottom: 10px; font-size: 20px;">
  						<div style="display: flex;">  						
	  						<div id="startTime" class="inputVal"><%= TimeFmt.addSep(vVO.getV_start_time()) %></div>
	  						<div>-</div>
	  						<div id="endTime" class="inputVal"><%= TimeFmt.addSep(vVO.getV_end_time()) %></div>
  						</div>
						<div>
	  						<i class="material-icons">cancel</i>
		  					<i id="v_start_end_time" class="material-icons">check</i>
	  					</div>
  					</div>
  					<div class="slider">
  						<div id="openTime-slider-range"></div>
  						<div class="slider-tick-mark" style="display: flex">
  							<div class="tick">00:00</div>
  							<div class="tick">02:00</div>
  							<div class="tick">04:00</div>
  							<div class="tick">06:00</div>
  							<div class="tick">08:00</div>
  							<div class="tick">10:00</div>
  							<div class="tick">12:00</div>
  							<div class="tick">14:00</div>
  							<div class="tick">16:00</div>
  							<div class="tick">18:00</div>
  							<div class="tick">20:00</div>
  							<div class="tick">22:00</div>
  						</div>
  					</div>
  					
  				</div>

  			</div> <!-- End of vInfoCard-item -->  			

  	  	</div> <!-- End of vInfoCard-body -->
  	  </div> <!-- End of 營業時間 -->


  	  <!-- 用餐時間限制 -->
  	  <div class="vInfoCard">
  	  	<div class="vInfoCard-header">
  	  		<div class="vInfoCard-title">用餐時間限制</div>
  	  	</div> <!-- End of vInfoCard-header -->
  	  	<div class="vInfoCard-body">
  	  		
  			<div id="turnTimeDiv" class="vInfoCard-item  " style="border-bottom: none;">

  				<div class="vItem-content item-show" style="padding-bottom: 10px; font-size: 20px;">
  					<div class="row">
						<div>
							<%= vVO.getV_turn_time()==null ? "無" : TimeFmt.min2time(vVO.getV_turn_time()) %>
						</div>
						
						<i class="material-icons" style="padding-left: 20px; display: none;">edit</i>				  				
  					</div>
  				</div>

  				<div class="vItem-content-edit item-edit" data-cnt="<%= vVO.getV_turn_time() %>">
  					<div class="editLoad"><img src="images/ui-anim_basic_16x16.gif"></div>
  					<div style="padding-bottom: 10px; font-size: 20px;"  class="d-f-sb">
						<div id="turnTime"><%= vVO.getV_turn_time()==null ? "無" : TimeFmt.min2time(vVO.getV_turn_time()) %></div>
						<div>
	  					  	<i class="material-icons">cancel</i>
			  				<i id="v_turn_time" class="material-icons">check</i>
		  				</div>
  					</div>
  					<div class="slider">
  						<div id="turnTime-slider-range" class="inputVal"></div>
  						<div class="slider-tick-mark" style="display: flex">
  							<div class="tick">00:00</div>
  							<div class="tick">02:00</div>  							
  							<div class="tick">04:00</div>
  							<div class="tick">06:00</div>
  							<div class="tick">08:00</div>
  							<div class="tick">10:00</div>
  							<div class="tick">12:00</div>
  							<div class="tick">14:00</div>
  							<div class="tick">16:00</div>
  							<div class="tick">18:00</div>
  							<div class="tick">20:00</div>
  							<div class="tick">22:00</div>
  						</div>
  					</div>
  					
  				</div>
  			</div> <!-- End of vInfoCard-item -->			

  	  	</div> <!-- End of vInfoCard-body -->
  	  </div> <!-- End of 用餐時間限制 -->


  	  <!-- 桌位數 -->
  	  <div class="vInfoCard">
  	  	<div class="vInfoCard-header">
  	  		<div class="vInfoCard-title">桌位數</div>
  	  	</div> <!-- End of vInfoCard-header -->
  	  	<div class="vInfoCard-body">
  	  		
  			<div id="v_tablesDiv" class="vInfoCard-item  " style="border-bottom: none; ">
  				<div class="vItem-content item-show" style="font-size: 20px">
  					<div class="row">
						<div id="v_tables_d"><%= vVO.getV_tables() %></div>
						<i class="material-icons" style="padding-left: 20px; display: none;">edit</i>
  					</div>
  				</div>			
  				<div class="vItem-content-edit item-edit" data-cnt="<%= vVO.getV_tables() %>">
					<div class="editLoad"><img src="images/ui-anim_basic_16x16.gif"></div>
					<div class="row pl-3">
						<input type="number" class="inputVal" name="v_tables" value="<%= vVO.getV_tables() %>" min="0"step="1" required id="v_tables" style="display: none;"/>
					
						<!-- input spinner -->
						<div class="input-group" id="v_tables-spinner" style="width: 200px">						
					        <div class="input-group-prepend">
					        	<button style="min-width:2.5rem" class="btn btn-decrement btn-outline-secondary" type="button"><strong>-</strong></button>
					        </div>
					        <input type="text" style="text-align:center" class="form-control" value="<%= vVO.getV_tables() %>"/>
					        <div class="input-group-append">
					        	<button style="min-width: 2.5rem" class="btn btn-increment btn-outline-secondary" type="button"><strong>+</strong></button>
					        </div>
				        </div>
				        <div style="padding-left: 20px;">
	  					  	<i class="material-icons">cancel</i>
			  				<i id="v_tables" class="material-icons">check</i>
		  				</div>
	  				</div>
  				</div>
  			</div> <!-- End of vInfoCard-item -->

  	  	</div> <!-- End of vInfoCard-body -->
  	  </div> <!-- End of 桌位數 -->




	</div> <!-- End of container -->

<!-- alert -->
<div id="result" class="divAlert"></div>


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
   <script src="<%= request.getContextPath() %>/Vendor/bootstrap/jquery-3.3.1.min.js"></script>
    <script src="<%= request.getContextPath() %>/Vendor/bootstrap/popper.min.js"></script>
    <script src="<%= request.getContextPath() %>/Vendor/bootstrap/bootstrap.min.js"></script>

	<script src="<%= request.getContextPath() %>/Vendor/sweetalert2/sweetalert2.min.js"></script>

    <script src="<%= request.getContextPath() %>/Vendor/jquery-ui-1.12.1/jquery-ui.min.js"></script>
	
	<script src="<%= request.getContextPath() %>/Vendor/bootstrap-input-spinner.js"></script>
	
	
	<!-- turn time and open time -->
	<script>
		var turnTime = <%= vVO.getV_turn_time()==null ? "30" : vVO.getV_turn_time() %>;
		var openTimeSpan= <%= TimeFmt.text2minute(vVO.getV_end_time()) - TimeFmt.text2minute(vVO.getV_start_time()) %>;
	</script>
	<!-- open time -->
	<script type="text/javascript">
	  $( function() {

	    $( "#openTime-slider-range" ).slider({
	      range: true,
	      min: 0,
	      max: 1440,
	      step: 30,
	      values: [ <%= TimeFmt.text2minute(vVO.getV_start_time()) %>, <%= TimeFmt.text2minute(vVO.getV_end_time()) %> ],
	      slide: function( event, ui ) {
          
          if ((ui.values[ 1 ] - ui.values[ 0 ]) < turnTime ) {
              $(this).value(1, ui.turnTime);
          } else if ((ui.values[ 1 ] - ui.values[ 0 ]) < 30 ) {
              $(this).value(1, ui.values[ 0 ] + 30);
          }
	      	var startTime = minToTime(ui.values[ 0 ]);	      	
	      	var endTime = minToTime(ui.values[ 1 ]);
	      	if (endTime == "24:00") endTime = "23:59";
	      	
	        $( "#startTime" ).html(startTime);
	        $( "#endTime" ).html(endTime);
	      }
	    });

	    $( "#startTime" ).html(minToTime($( "#openTime-slider-range" ).slider( "values", 0 )));
	         
	    $( "#endTime" ).html(minToTime($( "#openTime-slider-range" ).slider( "values", 1 ) ));


	  } );	

	  function minToTime(min) {
	  	 return pad(Math.floor(min/60) ,2) + ":" + pad(min%60, 2);
	  }
	  function pad(n, width, z) {
	    z = z || '0';
	    n = n + '';
		return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
	  }	  
	</script>
	
	<!-- turn time -->
	<script type="text/javascript">
	  $( function() {

	    $( "#turnTime-slider-range" ).slider({
	      range: "min",
	      min: 0,
	      max: 1440,
	      step: 30,
	      value: <%= vVO.getV_turn_time()==null ? "30" : vVO.getV_turn_time() %>,
	      slide: function( event, ui ) {
	      	if(ui.value < 30) {
	      		$(this).value(30); // error
	      		
	      	}
	      	if(ui.value > openTimeSpan) {
	      		$(this).value(openTimeSpan);
	      	}
	      	var turnMin = ui.value;
	      	if (turnMin == 1440) turnMin = 1439;
	      	var turnTime = minToTime(turnMin);
	      	
	        $( "#turnTime" ).html(turnTime);
	        $( "#turnTime" ).attr("data-turnTime", turnMin);

	      }
	    });
	         
	    $( "#turnTime" ).html(minToTime($( "#turnTime-slider-range" ).slider( "value") ));


	  } );	

	</script>

	<!-- input spinner -->
	<script>		
		$(document).ready(function(){
			$("#v_tables").inputSpinner($("#v_tables-spinner"));
		});	    
	</script>
	<!-- edit -->
	<script type="text/javascript">
		$(document).ready(function(){
			$('.item-show').click(function () {
			    $(this).parents(".vInfoCard-item").find(".item-edit").show();
			    $(this).parents(".vInfoCard-item").find(".item-show").hide();
			 });
			$("i:contains('cancel')").click(function () {
				$(this).parents(".vInfoCard-item").find(".item-edit").hide();
			    $(this).parents(".vInfoCard-item").find(".item-show").show();
			 });
			$("i:contains('check')").click(function (e) {
				var item = $(this).parents(".vInfoCard-item");
				
// 				console.log(e.target.id);
				var tar = e.target.id;
				var inputVal1;
				var inputVal2;
				switch(tar) {
				case "v_type":
					inputVal1 = $(item).find(".inputVal").val();
					if (inputVal1 == "請選擇") return;
// 					console.log(inputVal1);
					break;
				case "v_text":
					inputVal1 = $(item).find(".inputVal").val();
// 					console.log(inputVal1);					
					break;
				case "v_day":
					inputVal1 = "";
					$(item).find('input:checkbox').each(function(i) { 
						inputVal1 += $(this).prop("checked") ? "1" : "0"; 
					});
// 					console.log(inputVal1);
					break;
				case "v_start_end_time":
					inputVal1 = $(item).find(".inputVal").eq(0).html();
					inputVal2 = $(item).find(".inputVal").eq(1).html();
// 					console.log(inputVal1);
// 					console.log(inputVal2);
					break;
				case "v_turn_time":
					inputVal1 = $("#turnTime-slider-range").slider( "value" );
// 					console.log(inputVal1);
					break;
				case "v_tables":
					inputVal1 = $(item).find(".inputVal").val();
// 					console.log(inputVal1);
					break;
				}
// 				$(item).find(".editLoad").show();
				sendReq(tar, inputVal1, inputVal2, item);
			 });

			$('.show-editPen').hover(
				function () {
				   $(this).find("i:contains('edit')").show();
				 }, 
				 function () {
				   $(this).find("i:contains('edit')").hide();
				 }
			);
		});
	</script>	
	<script>
		function sendReq(tar, inputVal1, inputVal2, item) {
			$.ajax({
			    url: "<%=request.getContextPath()%>/Vendor/Vendor_v.do",
			    type: 'post',
			    data: {
			      action : "updateVendorInfo",
			      tar : tar,
			      inputVal1 : inputVal1,
			      inputVal2 : inputVal2,
			      vendor_no : "<%= vendor_no %>"
			    },
			    tar : tar,
			    inputVal1 : inputVal1,
			    inputVal2 : inputVal2,
			    dataType: "text",
			    item: item,
			    beforeSend : function() {
			    	console.log("beforeSend ");
			    	$(item).find(".editLoad").show();
			    },
			    complete  :function() {
			    	console.log("ajaxComplete");
			    	$(item).find(".editLoad").hide();
			    },
			    success: function(response) {
			    	console.log(response);
			    	showAlert("alert-success", "更新資料成功");
					$(item).find(".item-edit").hide();
				    $(item).find(".item-show").show();
				    successAction(this.tar, this.inputVal1, this.inputVal2, this.item)
			    },	    
			    error: function(xhr) {
			    	showAlert("alert-danger", "更新資料失敗");
			    }

			});	
		}
		function successAction(tar, inputVal1, inputVal2, item) {
			
			switch(tar) {
			case "v_type":
				$(item).find(".item-show").html(inputVal1);
				break;
			case "v_text":
				$(item).find(".item-show").html(inputVal1);				
				break;
			case "v_day":
				$(item).find('label').each(function(i) { 					
					$(this).attr("class", inputVal1.charAt(i) == '1' ? "openTrue" : "openFalse")					 
				});
				break;
			case "v_start_end_time":
				$("#startTimeDiv").html(inputVal1);
				$("#endTimeDiv").html(inputVal2);
				openTimeSpan = $( "#openTime-slider-range" ).slider( "values", 1 ) - $( "#openTime-slider-range" ).slider( "values", 0 );
				break;
			case "v_turn_time":
				$(item).find(".item-show").html(minToTime(parseInt(inputVal1)));
				turnTime = parseInt(inputVal1);
				break;
			case "v_tables":
				$(item).find(".item-show").html(inputVal1);
				break;
			}
		}
		 
	</script>
	<!-- upload image -->
 	<script type="text/javascript">
$(document).ready(function(){
$("#v_pic_btn").click(async function(event) {
    
const {value: file} = await Swal.fire({
  title: '請選擇圖片',
  input: 'file',
  animation: false,
  inputAttributes: {
    input: 'file',
    'aria-label': 'Upload your profile picture'
  }
})

if (file) {
  const reader = new FileReader;
  reader.onload = (e) => {
    Swal.fire({
      title: '圖片已變更為',
      animation: false,
      imageUrl: e.target.result,
      imageAlt: 'The uploaded picture'
        
    }).then(function(file){
    	console.log(file);
    	console.log(e.target.result);
    	$.ajax({
    		url: "<%=request.getContextPath()%>/Vendor/Vendor_v.do",
            type : 'post',
			data: { action: 'upPic', file: e.target.result, vendor_no: "<%= vendor_no %>"},
			dataType: 'json',
			async : false,//同步請求
			cache : false,//不快取頁面
			
    	})
    })
    $('#pic1').attr('src', e.target.result);
  }
  
  reader.readAsDataURL(file)
}
});

$("#v_ad_btn").click(async function(event) {
    
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
    		url: "<%= request.getContextPath() %>/Vendor/Vendor_v.do",
            type : 'post',
			data: { action: 'upAd', file: e.target.result, vendor_no: "<%= vendor_no %>"},
			dataType: 'json',
			async : false,
			cache : false,//不快取頁面			
    	})
    })
    $('#ad1').attr('src', e.target.result);
  }
  
  reader.readAsDataURL(file)
}
})
}); // End of document.ready
    </script>  

<!-- alert -->
<script type="text/javascript">

//alert-primary
//alert-secondary
//alert-success
//alert-danger
//alert-warning
//alert-info
//alert-light
//alert-dark
//showAlert("alert-info", msg)
function showAlert(alertType, msg) {
	var divAlert = createAlert(alertType, msg);
    $("#result").prepend(divAlert);

    window.setTimeout(function() {
        $(divAlert).fadeTo(500, 0, function(){
            $(this).remove(); 
        });
            
    }, 4000);
}

function createAlert(alertType, msg) {
	var divAlert = document.createElement("div");
	
	divAlert.className = "alert alert-dismissible fade show";
	divAlert.classList.add(alertType);
	divAlert.setAttribute("role", "alert");

	var textMsg = document.createTextNode(msg);

	var btnClose = document.createElement("button");
	btnClose.setAttribute("type", "button");
	btnClose.setAttribute("class", "close");
	btnClose.setAttribute("data-dismiss", "alert");
	btnClose.setAttribute("aria-label", "Close");
	
	var spanClose = document.createElement("span");
	spanClose.setAttribute("aria-hidden","true");
	spanClose.innerHTML = "&times;";

	btnClose.appendChild(spanClose);

	divAlert.appendChild(textMsg);
	divAlert.appendChild(btnClose);

	return divAlert;
}

</script>    
    <%@ include file="navbar/side_navbar_js.txt" %>    
  </body>
</html>	