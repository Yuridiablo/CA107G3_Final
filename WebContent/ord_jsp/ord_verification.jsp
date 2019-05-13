<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<%@ page import="com.ord.model.*" %>
<%@ page import="java.util.*" %>

<%	
	String vendor_no = null;
	if (request.getParameter("vendor_no") != null) {
		vendor_no = request.getParameter("vendor_no");
	} else {
		vendor_no = "V000001";
	}
%>    
<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


    <title>訂單序號核銷</title>
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

.nav-link .btn-primary {
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
	margin-top:80%;
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
	<!-- Side Nav -->
	<style type="text/css">
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

		    box-shadow: 8px 0 6px -6px #333;
		}
		#sidenav.active {
		    left: 0;
		}
		
		.navbar {
			box-shadow: 0 8px 6px -6px #333;
		}

		#order-detail {
			display: none;
		}

		#order-detail.active {
			display: inline-flex;
		}

	</style>
	
	<!-- jQuery UI CSS -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<style>
	  .ui-autocomplete-loading {
	    background: white url("images/ui-anim_basic_16x16.gif") right center no-repeat;
	  }
	  
	  .ord_content, #btnVerify {
	  	display: none;
	  }
    </style>
    
  </head>

  <!-- ============================================================================= -->
  <body style="background-color: gray;">


	<!-- Navbar -->
	<nav class="navbar  bg-dark navbar-dark">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#collapsibleNavbar" id="btnSidenav">
			<span class="navbar-toggler-icon"></span>
		</button>
		
		<c:if test="${vVO.v_status == 1}">
		<span class="navbar-brand resTitle">${vVO.v_name}，您好！</span>
		</c:if>
		<c:if test="${vVO.v_status == 2}">
		<span class="navbar-brand resTitle"><span style="color:orange">[審核中]</span>${vVO.v_name}，您好！</span>
		</c:if>
		<c:if test="${vVO.v_status == 3}">
		<span class="navbar-brand resTitle">${vVO.v_name}，您好！</span>
		</c:if>
		<span class="navbar-brand">Seek Food Table<a class="btn btn-danger" role="botton" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=logout">登出</a></span>
		

	</nav>
	<!-- Side Nav -->
	<div id="sidenavOverlay"></div>
	<nav class="nav navbar-nav bg-dark" id="sidenav">
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/mainVendor.jsp">概況一覽</a> 
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=upVendor">資訊修改</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/tables_jsp/table_management_list.jsp">桌型資料設定</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/tables_jsp/table_management_graph.jsp">桌位配置</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/ord_jsp/ord_management_list.jsp">訂單狀態</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/ord_jsp/ord_management_timeline.jsp">訂單安排桌位</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=listMenu">菜單管理</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=listVendor">帳戶管理</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=listComment">回應管理</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/ord_jsp/ord_verification.jsp">訂位驗證</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/wait_pos_jsp/wait_vendor.jsp">候位控制系統</a>
		
			
	</nav>
	
	<div class="container-fluid">
	
		<div class="col-12  p-5">		

		    <div class="input-group mb-3 ui-widget">
			  <input type="text" class="form-control" placeholder="請輸入驗證序號" aria-label="Verificatioin code" aria-describedby="button-addon2" id="verifCode">
			  <div class="input-group-append">
			    <button class="btn btn-secondary" type="button" id="btnSearch">搜尋</button>
			  </div>
			</div>
			
	
			<div class="ord_content">
				<table class="table table-hover table-light" id="reservation-list">
					<thead>
						<tr>
							<th scope="col">訂單狀態</th>
							<th scope="col">訂單編號</th>					      
							<th scope="col">姓名</th>
							<th scope="col">人數</th>
							<th scope="col">預約日期</th>
							<th scope="col">預約時間</th>
							<th scope="col">金額</th>
							<th scope="col">桌位</th>						  
						</tr>
					</thead>
					<tbody>				 
					
					</tbody>
				</table>
					
					<!-- order detail list -->
				<table class="table table-hover table-light" id="order-detail-list">
					 <caption class="bg-light text-dark p-3" style="caption-side: top;">
			  	   		 訂單明細 		  	   		
			  	    </caption>
					<thead>
					    <tr>
					      <th scope="col">餐點</th>					      
					      <th scope="col">數量</th>
						  <th scope="col">單價</th>					  
					    </tr>
					</thead>
					<tbody>

					</tbody>
				</table>
				
				<button type="button" class="btn btn-secondary btn-lg btn-block" id="btnVerify">核銷序號</button>	
			</div> <!-- End of ord_content -->
			
		</div> <!-- End of col-12 -->

	</div> <!-- End of container-fluid -->


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<!-- jQuery UI -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
	
	
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

<script>
$( function() {
 
    $( "#verifCode" ).autocomplete({
    	minLength: 3,
        source: function( request, response ) {
        	$.ajax({
			    url: "<%= request.getContextPath() %>/ord/ord.do",
			    type: 'post',
			    data: {
			      action : "getOrdListByVerifCode",
			      vendor_no : "<%= vendor_no %>",
			      verif_code : request.term
			    },
			    dataType: "json",			    
			    success: function(data) {
			    	response($.map(data, function(item){
			    		return {
			    			label: item.ord_no + " | "+ item.mem_no + " | "+ item.verif_code,
			    			value: item.verif_code
			    		};
			    	}));
			    },	    
			    error: function(xhr) {
			    	alert("autocomplete source Ajax Error");
			    }

			});	// End of Ajax
        }, // End of source
        select: function(event, ui) {
            $.ajax({
			    url: "<%= request.getContextPath() %>/ord/ord.do",
			    type: 'post',
			    data: {
			      action : "getOrdByVerifCode",
			      vendor_no : "<%= vendor_no %>",
			      verif_code : ui.item.value
			    },
			    dataType: "json",			    
			    success: function(data) {
			    	$(".ord_content").css("display", "block");
			    	if (data.ord.status == 1) $("#btnVerify").css("display", "block");
			    	showOrd(data.ord);
			    	showOrdDetail(data.ord_detail);
			    },	    
			    error: function(xhr) {
			    	alert("autocomplete source Ajax Error");
			    }

			});	// End of Ajax
        } // End of select
    }); // End of autocomplete
    
    $("#btnVerify").click(function(){
    	var ord_no = $("#reservation-list tbody input[name=ord_no]").val();
    	$.ajax({
		    url: "<%= request.getContextPath() %>/ord/ord.do",
		    type: 'post',
		    data: {
		      action : "ordVerify",
		      ord_no : ord_no
		    },
		    dataType: "json",			    
		    success: function(data) {			    	
		    	alert(data.result);
		    	if (data.status != null) renewStatus(data.status);
		    },	    
		    error: function(xhr) {
		    	alert("verify Ajax Error");
		    }

		});	// End of Ajax
    });
} );
  </script>

<script>

function showOrd(response) {
	var tbody = $("#reservation-list tbody");
	$(tbody).empty();	
	
	if (response) {		
  		$(tbody).append(
			"<tr>" +
		      "<input type='hidden' name='ord_no' value='" + response.ord_no + "'>" +				      
		      "<td>" + OrdStatus(response.status) + "</td>" +
		      "<td>" + response.ord_no + "</td>" +
		      "<td>" + response.mem_no + "</td>" +
		      "<td>" + response.party_size + "</td>" +
		      "<td>" + response.booking_date + "</td>" +	
		      "<td>" + timeFmt(response.booking_time) + "</td>" +
		      "<td>" + response.total + "</td>" +
		      "<td>" + response.tbl_no + "</td>" +					     
		    "</tr>" 		 			
		);    	
	} else {
		var coln = $("#reservation-list thead th").length;
		$(tbody).append("<tr><td colspan='" + coln + "'>查無資料</td></tr>");
	}
}

function showOrdDetail(response) {	
	var odTbody = $("#order-detail-list tbody");
	$(odTbody).empty();
	var len = response.length;
	if (len != 0) {
		for (var i = 0; i < len; i++) {
    		$(odTbody).append(
	 			"<tr><td>"+response[i].menu_no+"</td><td>"+response[i].qty+"</td><td>"+response[i].price+"</td></tr>" 		 			
	 		);
    	}  	
	} else {
		var coln = $("#order-detail-list thead th").length;
		$(odTbody).append("<tr><td colspan='" + coln + "'>查無資料</td></tr>");
	}
		 			
}

function OrdStatus(status) {
	var ordStatus = null;
	switch (status) {
	case 1:
		ordStatus = "已付款";
		break;
	case 2:
		ordStatus = "已取消";
		break;
	case 3:
		ordStatus = "待付款";
		break;
	case 4:
		ordStatus = "已核銷";
		break;
	case 5:
		ordStatus = "已失效";
		break;
	default:
		ordStatus = "未定義";
	}
	
	return ordStatus;
}

function renewStatus(status){
	var tStatus = $("#reservation-list tbody td")[0];
	$(tStatus).html(OrdStatus(status));
}

function timeFmt(time) {
	return time.substr(0, 2) + ":" + time.substr(2, 2);
}

</script>     
  </body>
</html>