<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ page import="com.tables.model.*" %>
<%@ page import="com.tables.controller.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.*" %>

<%
String vendor_no = null;
if (request.getParameter("vendor_no") == null) {
	vendor_no = "V000001";
} else {
	vendor_no = request.getParameter("vendor_no");
}

Map<String, Tbls> tbls_all = (Map) application.getAttribute("tbls_all"); // null ?
Tbls vendor_tbls = (Tbls) tbls_all.get(vendor_no);				
if (vendor_tbls == null) {	
	vendor_tbls = new Tbls(vendor_no);
	tbls_all.put(vendor_no, vendor_tbls);
}

Map<String, Tbl> tbls = vendor_tbls.getTbls();
LinkedHashMap<String, Bill> bills = vendor_tbls.getBills();

int tblWidth = 100;
int hrWidth = 220;
%>

<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>桌況管理</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- jQuery UI CSS -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	
	<%@ include file="navbar/nav_css.txt" %>
	
	<style>
		.divAlert {
	   		position: fixed;
	   		bottom: 0;
	   		left: 0;
	   		display: flex;
   		}
	</style>
	<style>
		#floorplan1{
			width:100%;
			height:600px;
			background-color: lightgray;
			position: relative;
		}
		
		.floorplan .tbl {
			position: absolute;
		}

		.roundTable{
			width:<%=tblWidth%>px;
			height:<%=tblWidth%>px;
			background-color: lightpink;
			border-radius: 50%;

			text-align: center;
			line-height: <%=tblWidth%>px;
		}
		
		.squareTable{
			width:<%=tblWidth%>px;
			height:<%=tblWidth%>px;
			background-color: lightpink;

			text-align: center;
			line-height: <%=tblWidth%>px;
		}
		
		.bill_img {
			max-width: 30%;
			max-height: 30%;
		}
	
	</style>
	<!-- Card -->
<style>
.cardOutline {
	box-shadow: 0 1px 1px 0 rgba(60,64,67,.08), 0 1px 3px 1px rgba(60,64,67,.16); 
	border-radius: 3px;
	padding: 5px 10px 0px 10px;
	display: flex;
}	

.cardRight {
	margin-left: 20px;
}
.name {
	margin: 0 0 0 0;
	font-size: 24px;
}
.partySize {
	margin: 0 0 5px 0;	
	display: inline-flex;
	vertical-align: middle;
	align-items: center;	
}

.cardRBottom {
	display: flex;
}

.bookingTime {
	margin-left: 30px;
	display: inline-flex;
	vertical-align: middle;
	align-items: center;
}

.cardLeft .material-icons {
	font-size: 48px;
	color: #FB8C00;
}

.cardRBottom .material-icons {
	font-size: 18px;	
}

</style>

<style type="text/css">
[draggable="true"] {
    user-select: none;
}	
</style>
  </head>

  <!-- ===================================== body ======================================== -->
  <body>
	<%@ include file="navbar/navbar.txt" %>
	<%@ include file="navbar/side_navbar.txt" %>

	<!-- Content -->
	<div class="container-fluid">
		<div class="row justify-content-around p-3">

			<!-- Bill List -->
			<div class="col-3 bg-light">
			
				<div id="accordion" class="billList">
				<% for (int i = 0; i <= 4; i++) { %>
				<% 
				String cat = null;
				switch(i) {
				case 0:cat = "已驗證";break;
				case 1:cat = "已入座";break;
				case 2:cat = "已結帳";break;
				case 3:cat = "訂位";break;
				case 4:cat = "No Show";break;
				}
				%>
				  <!-- <%= cat %>  -->
				  <div class="card">

				  	<!-- card header -->
				    <div class="card-header p-0" id="headingBillList<%= i %>">
				        <div class="btn-group w-100" role="group" aria-label="Basic example">
						  <button type="button" class="btn btn-secondary" data-toggle="collapse" data-target="#collapseBillList<%= i %>" aria-expanded="true" aria-controls="collapseBillList<%= i %>">
				          <%= cat %>				        
				          </button>				          
						</div>				        
				    </div> <!-- End of card header -->

					<!-- card body -->
				    <div id="collapseBillList<%= i %>" class="collapse show p-0" aria-labelledby="headingBillList1">
				      <div class="card-body p-0">
				      
				        
		        
				      </div>
				    </div> <!-- End of card body -->

				  </div> <!-- End of card -->	  				  				  				  
  				<% } %>
  				
				</div> <!-- End of billList -->
			</div> <!-- End of col-3 -->



			<!-- Table Floorplan -->
			<div class="col-9">
				
					<div class="floorplan dropright" id="floorplan1">
<%
Collection<Tbl> tblColl = tbls.values();

for (Tbl tbl : tblColl) {
	TablesVO tblVO = tbl.getTblVO();
	
	Integer tblStatus = tbl.getStatus();
	Integer billStatus = null;
	if (tbl.getBill() != null) {
		billStatus = tbl.getBill().getStatus();
	}
	String color = TblFmt.colorFmt(tblStatus, billStatus);
	
	if (tblVO.getTbl_x() != null && tblVO.getTbl_y() != null) {
		String tblType = tblVO.getTbl_type() == 1 ? "square" : "round";
%>
						<div class="<%= tblType %>Table tbl" id="<%= tblVO.getTbl_no() %>" data-tbl_status="<%= tbl.getStatus() %>" data-bill_no="<%= tbl.getBill() != null ? tbl.getBill().getSource() : "" %>" data-bill_status="<%= tbl.getBill() != null ? tbl.getBill().getStatus() : "" %>" style="left: <%= tblVO.getTbl_x() %>px; top: <%= tblVO.getTbl_y() %>px; background-color:<%= color %> ;"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<%= tblVO.getTbl_name() %>
							<%if(tbl.getBill() != null) { %>	
							<img class="bill_img" src="images/bill.png">
							<% } %>						
						</div>		
<%
	}
}
%>						<!-- dropdown menu tblDM -->
						<div id="tblDM" class="dropdown-menu">
						  <button class="dropdown-item" type="button" data-toggle="modal" data-target="#newWIModal">新增客人</button>
						  <div class="dropdown-divider"></div>
						  <h6 class="dropdown-header">桌況變更</h6>
						  <button id="btnTblStat_empty" class="dropdown-item" type="button">空桌</button>
						  <!-- <button id="btnTblStat_seated" class="dropdown-item" type="button">已入座</button> -->
						  <button id="btnTblStat_dining" class="dropdown-item" type="button">用餐中</button>
						  <button id="btnTblStat_clean" class="dropdown-item" type="button">清潔中</button>
						  <button id="btnTblStat_keep" class="dropdown-item" type="button">保留中</button>
						  <!-- <a class="dropdown-item disabled" href="#">Another action</a> -->		  
						</div> <!-- End of tblDM -->
						
						<!-- Modal newWI -->
						<div class="modal fade" id="newWIModal" tabindex="-1" role="dialog" aria-labelledby="newWIModal" aria-hidden="true">
						  <div class="modal-dialog modal-dialog-centered" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="exampleModalLongTitle">新增客人</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div> <!-- End of modal-header -->
						      <div class="modal-body">
						      
						        <div class="input-group mb-3">
								  <div class="input-group-prepend">
								    <label class="input-group-text" for="newWI_party_size">人數</label>
								  </div>
								  <select class="custom-select" id="newWI_party_size">
								    <option value="1" selected>1</option>
								    <option value="2">2</option>
								    <option value="3">3</option>
								    <option value="4">4</option>
								    <option value="5">5</option>
								    <option value="6">6</option>
								    <option value="7">7</option>
								    <option value="8">8</option>
								    <option value="9">9</option>
								    <option value="10">10</option>
								  </select>
								</div> <!-- End of input-group -->
								
						      </div> <!-- End of modal-body -->
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
						        <button type="button" id="btnNewWI" class="btn btn-primary">新增</button>
						      </div> <!-- End of modal-footer -->
						    </div> <!-- End of modal-content -->
						  </div> <!-- End of modal-dialog -->
						</div> <!-- End of modal -->
																
					</div>	<!-- End of floorplan1 -->
		
			</div>	<!-- End of col-9 -->

		</div>	<!-- End of row -->
	</div>	<!-- End of container-fluid -->

	<!-- alert -->
	<div id="result" class="divAlert"></div>
	
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
    <script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<!-- jQuery UI -->
	<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
    <!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->

<!-- initialize bills --> 
<script>
var bills = [];
</script>

<!-- Card list -->
<script type="text/javascript">
function mkCard(ord_no, mem_no, party_size, booking_time) {
	
	str =	      
	'<div class="cardOutline" id="' + ord_no + '" style="left:' + calcCardLeft(booking_time) + '">' +		
		'<div class="cardLeft"><i class="material-icons">account_circle</i>	</div>' +
		'<div class="cardRight">' +
			'<div class="name">' + mem_no + '</div>' +
			'<div class="cardRBottom">'	 +
				'<div class="partySize"><i class="material-icons">group</i>&nbsp;<span>' + party_size + '</span></div>' +
				'<div class="bookingTime"><i class="material-icons">access_time</i>&nbsp;<span>' + booking_time + '</span></div>' +
			'</div>' +		
		'</div>' +	
	'</div>';
	return str;
	} // End of mkCard

	function timeFmt(time) {
		return time.substr(0, 2) + ":" + time.substr(2, 2);
	}
</script>
	
<!-- floorplan -->    
<script type="text/javascript">
$(document).ready(function(){
	
$('.tbl').dropdown();

$(".floorplan").on('show.bs.dropdown', function (e) {
	$("#tblDM").attr("data-tbl_no",e.relatedTarget.id);
});

$("#btnNewWI").click(function(){
	newWI();
	$('#newWIModal').modal('hide');
});

  
// 桌況設定
$("#btnTblStat_empty").click(function(){
	setTblStatus(0, null);
});
//$("#btnTblStat_seated").click(function(){
//	setTblStatus(1, 1);
//});
$("#btnTblStat_dining").click(function(){
	setTblStatus(1, 2);
});
$("#btnTblStat_clean").click(function(){
	setTblStatus(2, null);
});
$("#btnTblStat_keep").click(function(){
	setTblStatus(3, null);
});

}); // End of $(document).ready


// set table status
function setTblStatus(tbl_status, bill_status) {
	$.ajax({
	    url: "<%=request.getContextPath()%>/tables/tables.do",
	    type: 'post',
	    data: {
	      action : "setTblStatus",
	      vendor_no : "<%= vendor_no %>",
	      tbl_no : $("#tblDM").attr("data-tbl_no"),
	      tbl_status : tbl_status,
	      bill_status : bill_status
	    },
	    dataType: "json",
	    tbl_no : $("#tblDM").attr("data-tbl_no"),
	    tbl_status : tbl_status,
	    bill_status : bill_status,
	    success: function(response) {
	    	if (response.status == 1) {
	    		showAlert("alert-success", response.result);
	    		var tbl = $("#" + this.tbl_no);
	    		$(tbl).attr("data-tbl_status", this.tbl_status);
	    		$(tbl).attr("data-bill_status", this.bill_status);
	    		$(tbl).css("background-color", colorFmt(this.tbl_status, this.bill_status));
	    		
	    		if(this.bill_status == null) {
	    			$(tbl).find(".bill_img").remove();
	    		}
	    		
	    	} else if (response.status == 0) {
	    		showAlert("alert-danger", response.result);
	    	}
	    	
	    },	    
	    error: function(xhr) {
	    	showAlert("alert-danger", "變更桌況失敗");
	    }

	});		
}


function newWI() {
	$.ajax({
	    url: "<%=request.getContextPath()%>/tables/tables.do",
	    type: 'post',
	    data: {
	      action : "newWI",
	      vendor_no : "<%= vendor_no %>",
	      tbl_no : $("#tblDM").attr("data-tbl_no"),
	      party_size : $("#newWI_party_size").val()
	    },
	    dataType: "json",
	    tbl_no : $("#tblDM").attr("data-tbl_no"),
	    success: function(response) {
	    	if (response.status == 1) {
	    		showAlert("alert-success", response.result);
	    		putBill(this.tbl_no, 1, response.bill_no, 1);
	    		bills.push(response.bill);
	    	} else if (response.status == 0) {
	    		showAlert("alert-danger", response.result);
	    	}
	    	
	    },	    
	    error: function(xhr) {
	    	showAlert("alert-danger", "新增客人失敗");
	    }

	});	
} // End of newWI

// 在桌位上顯示帳單
function putBill(tbl_no, tbl_status, bill_no, bill_status) {
	var tbl = $("#" + tbl_no);
	$(tbl).append('<img class="bill_img" src="images/bill.png">');
	$(tbl).attr("data-tbl_status", tbl_status);
	$(tbl).attr("data-bill_no", bill_no);
	$(tbl).attr("data-bill_status", bill_status);
	$(tbl).css("background-color", colorFmt(tbl_status, bill_status));	
}

// 桌位顏色
function colorFmt(tbl_status, bill_status) {
	var fmt = null;
	switch(tbl_status) {
	case 0:
		fmt = "#5c5c8a";
		break;
	case 1:
		switch(bill_status) {
		case 1:
			fmt = "#668cff";
			break;
		case 2:
			fmt = "#d966ff";
			break;	
		}
		break;
	case 2:
		fmt = "#71da71";
		break;
	case 3:
		fmt = "#b8b894"; // for Ord
		
		break;		
	}
	return fmt;
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