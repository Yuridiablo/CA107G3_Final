<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<%@ page import="com.ord.model.*" %>
<%@ page import="java.util.*" %>

<%	
	String vendor_no = null;
	if (request.getAttribute("vendor_no") != null) {
		vendor_no = (String)request.getAttribute("vendor_no");
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
        $(document).ready(function () {                     
            $('#btnSidenav').on('click', function () {
                $('#sidenavOverlay').addClass('active');
                $('#sidenav').addClass('active');             
            });
            $('#sidenavOverlay').on('click', function () {
                $('#sidenavOverlay').removeClass('active'); 
                $('#sidenav').removeClass('active');              
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