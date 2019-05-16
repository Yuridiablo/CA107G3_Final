<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ page import="com.tables.model.*" %>
<%@ page import="com.tables.controller.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

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
<!--     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> -->
	<link rel="stylesheet" href="bootstrap/bootstrap.min.css">
	
	<link rel="stylesheet" href="fonts/Material+Icons.css">
	
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
		#accordion {
			overflow-y:auto;			
			height:600px;
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
	padding: 5px 10px 5px 10px;	
	width: 100%;
}	

.cardTop {
	display: flex;
	justify-content: space-between;	
}
.cardBottom {
	display: flex;
}

.cardRight {
	margin-left: 20px;
	width: 100%;

}
.name {
	margin: 0 0 0 0;
	font-size: 24px;
}
.source {
	font-size: 14px;
}


.cardRBottom {
	display: flex;
	justify-content: space-between;	
	padding: 4px 0 0px 0;
}
.cardRTop {
	display: flex;
	justify-content: space-between;	
	line-height: 48px;
}
.bookingTime,.totalAmount,.partySize {	
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
.billStatus {
	background-color: green;
	color: white;
	padding: 2px 0 2px 0;
	border-radius: 5px;
	font-size: 12px;
	text-align: center;
}
.diningTime {
	display: flex;
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
				    <div id="collapseBillList<%= i %>" class="collapse show p-0" aria-labelledby="headingBillList<%= i %>">
				      <div id="billList<%= i %>" class="card-body p-0">
<% for( Bill bill : bills.values()) { %>
	<% 
		boolean inList = false;
		switch(bill.getStatus()) {
		case 0:
			if (i == 0) inList = true;
			break;
		case 1:case 2:
			if (i == 1) inList = true;
			break;
		case 3:
			if (i == 2) inList = true;
			break;
		case 4:
			if (i == 3) inList = true;
			break;
		case 5:
			if (i == 4) inList = true;
			break;
		}
	%>
	<% if (inList) { %>
	<% 
		SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		Long startTime = bill.getStartTime();
		String startTimeStr = "";
		if (startTime != null) {				
			startTimeStr = format.format(startTime);
		}
		
		Long endTime = bill.getEndTime();
		String endTimeStr = "";
		if (endTime != null) {				
			endTimeStr = format.format(endTime);
		}
		
		java.util.Date bookingTime = bill.getBookingTime();
		String bookingTimeStr = "";
		if (bookingTime != null) {				
			bookingTimeStr = format.format(bookingTime.getTime());
		}	
	%>
	<div class="cardOutline" id="<%= bill.getBill_no() %>">	
		<div class="cardTop">
			<div class="diningTime" style="visibility: <%= bill.getStartTime()==null ? "hidden" : "visible" %> ">
				<div class="startTime"> <%= startTimeStr %></div>
				<div class="timeSep">-</div>
				<div class="endTime"><%= endTimeStr %> </div>
			</div>			
			<div class="source"><%= BillFmt.sourceFmt(bill.getSource(), 1) %></div>
		</div>

		<div class="cardBottom">
			<div class="cardLeft">
				<i class="material-icons">account_circle</i>
				<div class="billStatus" style="background-color:<%= BillFmt.colorFmt(bill.getStatus()) %>"><%= BillFmt.statusFmt(bill.getStatus()) %></div>
			</div>
			<div class="cardRight">
				<div class="cardRTop">
					<div class="name"> <%= bill.getMem_no()==null ? "Anonymous" : bill.getMem_no() %></div>
					<div class="tblName"> <%= bill.getTbl_no()==null ? "" : tbls.get(bill.getTbl_no()).getTblVO().getTbl_name() %> </div>
				</div>	
				<div class="cardRBottom">
					<div class="partySize"><i class="material-icons">group</i>&nbsp;<span><%= bill.getParty_size() %> </span></div>
					<div class="bookingTime" style="visibility: <%= bill.getBookingTime()==null ? "hidden" : "visible" %>"><i class="material-icons">access_time</i>&nbsp;<span><%= bookingTimeStr %></span></div>
					<div class="totalAmount" style="visibility: <%= bill.getTotal()==null ? "hidden" : "visible" %>"><i class="material-icons">attach_money</i><span>  <%= bill.getTotal() %>  </span></div>
				</div>
			</div>
		</div>
	</div> <!-- End of cardOutline -->
	<% } %>				        
<% } %>		        
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
						<div class="<%= tblType %>Table tbl" id="<%= tblVO.getTbl_no() %>" data-tbl_status="<%= tbl.getStatus() %>" data-bill_no="<%= tbl.getBill() != null ? tbl.getBill().getBill_no() : "" %>" data-bill_status="<%= tbl.getBill() != null ? tbl.getBill().getStatus() : "" %>" style="left: <%= tblVO.getTbl_x() %>px; top: <%= tblVO.getTbl_y() %>px; background-color:<%= color %> ;"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<span class="tblName"><%= tblVO.getTbl_name() %></span>
							<%if(tbl.getBill() != null) { %>	
							<img class="bill_img" src="images/bill.png">
							<% } %>						
						</div>		
<%
	}
}
%>						<!-- dropdown menu tblDM -->
						<div id="tblDM" class="dropdown-menu">
						  <button id="btnNewWIMenu" class="dropdown-item disabled" type="button" data-toggle="modal" data-target="#newWIModal">新增客人</button>
						  <div class="dropdown-divider"></div>
						  <h6 class="dropdown-header">桌況變更</h6>
						  <button id="btnTblStat_empty" class="dropdown-item disabled" type="button">空桌</button>
						  <!-- <button id="btnTblStat_seated" class="dropdown-item" type="button">已入座</button> -->
						  <button id="btnTblStat_dining" class="dropdown-item disabled" type="button">用餐中</button>
						  <button id="btnTblStat_clean" class="dropdown-item disabled" type="button">清潔中</button>
						  <button id="btnTblStat_keep" class="dropdown-item disabled" type="button">保留中</button>
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
   <script src="bootstrap/jquery-3.3.1.min.js"></script>
   <script src="bootstrap/popper.min.js"></script>
   <script src="bootstrap/bootstrap.min.js"></script>
<!--     <script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script> -->
<!--     <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script> -->
<!--     <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script> -->
	

<!-- initialize bills --> 
<script>
// var bills = [];
</script>


<!-- Drag and Drop -->
<script type="text/javascript">
$(document).ready(function(){
	let cards = document.querySelectorAll('#billList0 .cardOutline');
	cards.forEach(card => {
	  $(card).prop('draggable', true);
	  card.addEventListener('dragstart', dragStart);
	  card.addEventListener('drop', cancelDefault);
	  card.addEventListener('dragenter', cancelDefault);
	  card.addEventListener('dragover', cancelDefault);
	});	

	let tbls = document.querySelectorAll('.tbl');
	tbls.forEach(tbl => {
		if ($(tbl).attr("data-tbl_status") == 0) {
			tbl.addEventListener('drop', dropped);
			tbl.addEventListener('dragenter', dragEnter);
			tbl.addEventListener('dragover', cancelDefault);
			tbl.addEventListener('dragleave', dragLeave);  
		}
		
		$(tbl).find("*").on("drop", cancelDefault);
		$(tbl).find("*").on("dragenter", cancelDefault);
		$(tbl).find("*").on("dragover", cancelDefault);
		$(tbl).find("*").on("dragleave", cancelDefault);
	});

});

 
function tblAddListener(tbl) {
	tbl.addEventListener('drop', dropped);
	tbl.addEventListener('dragenter', dragEnter);
	tbl.addEventListener('dragover', cancelDefault);
	tbl.addEventListener('dragleave', dragLeave);
}

function tblRemoveListener(tbl) {
	tbl.removeEventListener('drop', dropped);
	tbl.removeEventListener('dragenter', dragEnter);
	tbl.removeEventListener('dragover', cancelDefault);
	tbl.removeEventListener('dragleave', dragLeave);
}

function cancelDefault (e) {
  e.preventDefault();
  e.stopPropagation();
  return false;
}

function dragStart (e) {
	// set drag image
	var img = document.createElement("img"); 
	img.src = 'images/bill-small.png';
	e.dataTransfer.setDragImage(img, 0, 0);
	
	var jsonobj = {id : e.target.id, parent : e.target.parentNode.id};
	e.dataTransfer.setData('text/plain', JSON.stringify(jsonobj));

}

function dragEnter (e) {  
  cancelDefault(e);
  e.target.style.backgroundColor = "#9696c0";
}
function dragLeave (e) {  
  cancelDefault(e);
  e.target.style.backgroundColor = "#5c5c8a";
}

function dropped (e) {
	cancelDefault(e);
	if (e.target.classList.contains("tbl")) {
		var tbl = e.target;
		tbl.style.backgroundColor = "#5c5c8a";
		
		var jsonObj = JSON.parse(e.dataTransfer.getData('text/plain'));
		var id = jsonObj.id;
		var parentId = jsonObj.parent;
		
		var bill_no = id;
		var tbl_no = tbl.id;
		$.ajax({
			url: "<%=request.getContextPath()%>/tables/tables.do",
		    type: 'post',
		    data: {
		      action : "putVerifiedBill",
		      vendor_no : "<%= vendor_no %>",
		      bill_no : bill_no,
		      tbl_no : tbl_no
		    },
		    dataType: "json",
		    bill_no: bill_no,
		    tbl_no : tbl_no,
		    parentId: parentId,
		    success: function(response) {
		    	
		    	if (response.status == 1) {
		    		showAlert("alert-success", response.result);
		    		var bill_status = 1;
		    		var tbl_status = 1;
		    		
		    		var bill = document.getElementById(this.bill_no);
		    		var tbl = document.getElementById(this.tbl_no);
		    		$(bill).detach();
		    		$("#billList1").append(bill);
		    		$(bill).find(".billStatus").css("background-color", billColorFmt(bill_status));
		    		$(bill).find(".billStatus").html(billStatusFmt(bill_status));
		    		$(bill).find(".startTime").html(longToTime(response.startTime));
		    		$(bill).find(".diningTime").css("visibility", "visible");		    		
		    		$(bill).find(".tblName").html($(tbl).find(".tblName").html());
		    		$(bill).prop('draggable', false);
		    		
		    		putBill(this.tbl_no, tbl_status, this.bill_no, bill_status);
		    		tblRemoveListener(tbl);
		    	} else {
		    		showAlert("alert-danger", response.result);
		    	}
			    
		    },	    
		    error: function(xhr) {	    		    	
		    	//alert("updateTbl_no Error");
		    	showAlert("alert-danger", "putVerifiedBill Error");
		    	
		    }			    
		});	
		
	}
  
}

</script>	


<!-- Bill list -->
<script type="text/javascript">

	function mkCard(bill_no, name, party_size, booking_time, startTime, endTime, source, tblName, totalAmount, status) {
	
	str =	      
	'<div class="cardOutline" id="' + bill_no + '">' +	
		'<div class="cardTop">' +
			'<div class="diningTime" style="visibility:' + (startTime==null?'hidden':'visible') + '">' +
				'<div class="startTime">' + longToTime(startTime) + '</div>' +
				'<div class="timeSep">-</div>' +
				'<div class="endTime">' + (endTime==null?'':longToTime(endTime)) + '</div>' +
			'</div>' +			
			'<div class="source">' + sourceFmt(source, 1) + '</div>' +
		'</div>' +

		'<div class="cardBottom">' +
			'<div class="cardLeft">' + 
				'<i class="material-icons">account_circle</i>' + 
				'<div class="billStatus" style="background-color:' + billColorFmt(status) + '">' + billStatusFmt(status) + '</div>' + 
			'</div>' +
			'<div class="cardRight">' +
				'<div class="cardRTop">' +
					'<div class="name">' + (name==null ? 'Anonymous' : name) + '</div>' +
					'<div class="tblName">' + tblName + '</div>' +
				'</div>' +	
				'<div class="cardRBottom">'	 +
					'<div class="partySize"><i class="material-icons">group</i>&nbsp;<span>' + party_size + '</span></div>' +
					'<div class="bookingTime" style="visibility:' + (booking_time==null?'hidden':'visible') + '"><i class="material-icons">access_time</i>&nbsp;<span>' + booking_time + '</span></div>' +
					'<div class="totalAmount" style="visibility:' + (totalAmount==null?'hidden':'visible') + '"><i class="material-icons">attach_money</i><span>' + totalAmount + '</span></div>' +
				'</div>' +		
			'</div>' +	
		'</div>' +
	'</div>';
	return str;
	} // End of mkCard

	function longToTime(time) {
		var date = new Date(time);
		var str = date.toLocaleString('default', { timeZone: 'Asia/Taipei', hour12:false, hour:'2-digit', minute: '2-digit' });
// 		var str = date.getHours() + ":" + date.getMinutes();
		return str;
	}
	function billColorFmt(status) {
		var fmt = null;
		switch(status) {
		case 0:
			fmt = "#669999";
			break;
		case 1:
			fmt = "#668cff";
			break;
		case 2:
			fmt = "#d966ff";
			break;
		case 3:
			fmt = "#77773c";
			break;
		case 4:
			fmt = "#ff9933";
			break;
		case 5:
			fmt = "#ff3333";
			break;
		}
		return fmt;
	}

	function billStatusFmt(status) {
		var fmt = null;
		switch(status) {
		case 0:
			fmt = "已驗證";
			break;
		case 1:
			fmt = "已入座";
			break;
		case 2:
			fmt = "用餐中";
			break;
		case 3:
			fmt = "已結帳";
			break;
		case 4:
			fmt = "訂位";
			break;
		case 5:
			fmt = "No Show";
			break;
		}
		return fmt;
	}
	 
	function sourceFmt(source, type) {
		var fmt = null;
		if (type == 1) {
			switch(source) {
			case 1:
				fmt = "訂位";
				break;
			case 2:
				fmt = "候位";
				break;
			case 3:
				fmt = "散客";
				break;		
			}
		} else if (type == 2) {
			switch(source) {
			case 1:
				fmt = "B";
				break;
			case 2:
				fmt = "W";
				break;
			case 3:
				fmt = "WI";
				break;		
			}
		}
		
		return fmt;
	}

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
	$("#tblDM").find("button").addClass("disabled");
	var tbl = $("#" + e.relatedTarget.id);	
	var tbl_status = $(tbl).attr("data-tbl_status");
	var bill_status = $(tbl).attr("data-bill_status");
	switch(parseInt(tbl_status)) {
	case 0: $("#btnNewWIMenu").removeClass("disabled"); break;
	case 1: 
		switch(parseInt(bill_status)) {
		case 1:
			$("#btnTblStat_dining").removeClass("disabled");
			break;
		case 2:
			$("#btnTblStat_clean").removeClass("disabled");
			break;
		}		
		break;
	case 2: $("#btnTblStat_empty").removeClass("disabled"); break;
		
	}	  
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
	setTblStatus(2, 3);
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
	    	console.log(response);
	    	if (response.status == 1) {
	    		
	    		showAlert("alert-success", response.result);
	    		var tbl = $("#" + this.tbl_no);
	    		$(tbl).css("background-color", colorFmt(this.tbl_status, this.bill_status));
	    		$(tbl).attr("data-tbl_status", this.tbl_status);
	    		$(tbl).attr("data-bill_status", this.bill_status); // 沒用到
	    		
	    		if (this.tbl_status == 1 && this.bill_status == 1) {
	    			
	    		} else if (this.tbl_status == 1 && this.bill_status == 2) {
	    			var bill = $("#" + $(tbl).attr("data-bill_no"));
		    		$(bill).find(".billStatus").css("background-color", billColorFmt(this.bill_status));
		    		$(bill).find(".billStatus").html(billStatusFmt(this.bill_status));
	    		} else if (this.tbl_status == 2 && this.bill_status == 3) {
	    			var bill = $("#" + $(tbl).attr("data-bill_no"));
		    		$(bill).find(".billStatus").css("background-color", billColorFmt(this.bill_status));
		    		$(bill).find(".billStatus").html(billStatusFmt(this.bill_status));
		    		$(bill).find(".endTime").html(longToTime(response.endTime));
		    		$(bill).detach();
	    			$("#billList2").append(bill);
	    			$(tbl).find(".bill_img").remove();
	    		} else if (this.tbl_status == 0 && this.bill_status == null) {
	    			$(tbl).find(".bill_img").remove();
	    			tblAddListener(tbl[0]);
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
	    party_size : $("#newWI_party_size").val(),
	    success: function(response) {
	    	if (response.status == 1) {
	    		var bill = response.bill;
	    		console.log(response);
	    		showAlert("alert-success", response.result);
	    		putBill(bill.tbl_no, 1, bill.bill_no, 1);
	    		
	    		$("#billList1").append(mkCard(bill.bill_no, null, bill.party_size, null, bill.startTime, null, 3, $("#" + bill.tbl_no).find(".tblName").html(), null, 1));
// 	    		mkCard(bill_no, name, party_size, booking_time, startTime, endTime, source, tblName, totalAmount, status);
// 	    		bills.push(response.bill);
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