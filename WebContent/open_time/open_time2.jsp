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
    <!-- open table number -->
    <style type="text/css">
		.hItem .vInfoCard-item {
			border-right: 2px solid #eee;
			width: calc(100%/5);
		}
		.hItem .vItem-title {
			font-weight: normal;
		}
		.hItem .tblNum {
			font-size: 50px;
		}
		.hItem .vItem-content {
			text-align: center;
		}
		.hItem .tblUnit {
			font-size: 30px
		}

		.vInfoCard-body {
			padding: 20px;
		}
		.tblSpinnerDiv {
			padding: 20px 10px 20px 10px;
		}
		.hItem .btn-outline-primary, .hItem .vItem-footer .btn-outline-secondary {
			border: none;
		}
		.hItem .vItem-footer div {
			display: flex;
			justify-content: space-around;
		}

		.item-edit {
			display: none;
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
  	  
  	  <!-- 開放訂位時段 -->
  	  <div class="vInfoCard">
  	  	<div class="vInfoCard-header">
  	  		<div class="vInfoCard-title">開放訂位時段</div>
  	  	</div> <!-- End of vInfoCard-header -->
  	  	<div class="vInfoCard-body">
  	  		
  			<div id="openDayDiv" class="vInfoCard-item">
  				<!-- <div class="vItem-title">星期</div>	 -->
  										
  				<div class="vItem-content">
				<% 
					String sTimeStr = vVO.getV_start_time();
					String eTimeStr = vVO.getV_end_time();
					Integer turnTime = vVO.getV_turn_time();
				%>
						<div class="btn-group-toggle" data-toggle="buttons">
						  <label class="btn btn-outline-success">
						    <input type="checkbox" autocomplete="off"> 08:00
						  </label>					
						  <label class="btn btn-outline-success active">
						    <input type="checkbox" checked autocomplete="off"> 09:00
						  </label>
						  <label class="btn btn-outline-success active">
						    <input type="checkbox" checked autocomplete="off"> 10:00
						  </label>
						  <label class="btn btn-outline-success active">
						    <input type="checkbox" checked autocomplete="off"> 11:00
						  </label>
						  <label class="btn btn-outline-success active">
						    <input type="checkbox" checked autocomplete="off"> 12:00
						  </label>
						  <label class="btn btn-outline-success active">
						    <input type="checkbox" checked autocomplete="off"> 13:00
						  </label>
						  <label class="btn btn-outline-success">
						    <input type="checkbox" autocomplete="off"> 14:00
						  </label>
						</div> <!-- End of btn-group -->

	  				
  				</div> <!-- End of vItem-content -->
  			</div> <!-- End of vInfoCard-item -->  						

  	  	</div> <!-- End of vInfoCard-body -->
  	  </div> <!-- End of 開放訂位時段 -->

		



  	  <!-- 開放桌位數 -->
  	  <div class="vInfoCard">

  	  	<div class="vInfoCard-header">
  	  		<div class="vInfoCard-title">開放桌位數</div>
  	  	</div> <!-- End of vInfoCard-header -->

  	  	<div class="vInfoCard-body row hItem">
  	  		
  			<div id="" class="vInfoCard-item">

				<div class="vItem-title">
					2&nbsp;人桌
				</div> <!-- End of vItem-title -->
				<div class="vItem-content item-show">
					<span class="tblNum">12</span>						
					<span class="tblUnit">張</span>
	  				
  				</div> <!-- End of vItem-content -->
  				<div class="vItem-content item-edit tblSpinnerDiv">
					
						<!-- input spinner -->
						<input type="number" name="v_tables" value="0" min="0"step="1" required id="v_tables" style="display: none;"/>
						<div class="input-group" id="v_tables-spinner">						
					        <div class="input-group-prepend">
					        	<button style="min-width:2.5rem" class="btn btn-decrement btn-outline-secondary" type="button"><strong>-</strong></button>
					        </div>
					        <input type="text" style="text-align:center" class="form-control" value="0"/>
					        <div class="input-group-append">
					        	<button style="min-width: 2.5rem" class="btn btn-increment btn-outline-secondary" type="button"><strong>+</strong></button>
					        </div>
				        </div> <!-- End of input spinner -->
	  				
  				</div> <!-- End of vItem-content -->
				<div class="vItem-footer item-edit">
					<div>
					<button type="button" class="btn btn-outline-primary btnSave">儲存</button>
					<button type="button" class="btn btn-outline-secondary btnCancel">取消</button>
					</div>
				</div> <!-- End of vItem-footer -->
  			</div> <!-- End of vInfoCard-item -->


  	  	</div> <!-- End of vInfoCard-body -->
  	  </div> <!-- End of 開放桌位數 -->




	</div> <!-- End of container -->

<!-- alert -->
<div id="result" class="divAlert"></div>


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
   <script src="<%= request.getContextPath() %>/Vendor/bootstrap/jquery-3.3.1.min.js"></script>
    <script src="<%= request.getContextPath() %>/Vendor/bootstrap/popper.min.js"></script>
    <script src="<%= request.getContextPath() %>/Vendor/bootstrap/bootstrap.min.js"></script>
	
	<script src="<%= request.getContextPath() %>/Vendor/bootstrap-input-spinner.js"></script>
	
	
	
	 <script type="text/javascript">
	$(document).ready(function(){
		$('.item-show').click(function () {
		    $(this).parents(".vInfoCard-item").find(".item-edit").show();
		    $(this).parents(".vInfoCard-item").find(".item-show").hide();
		 });
		$('.btnCancel').click(function () {
			$(this).parents(".vInfoCard-item").find(".item-edit").hide();
		    $(this).parents(".vInfoCard-item").find(".item-show").show();
		 });		
	});	
	</script>
	<!-- edit -->
	<script type="text/javascript">
		$(document).ready(function(){

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