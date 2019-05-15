<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<%@ page import="com.ord.model.*" %>
<%@ page import="com.vendor.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.*" %>
<%@ page import="com.tables.model.*" %>
<%@ page import="java.text.*" %>


<%	
	String vendor_no = null;
	if (request.getParameter("vendor_no") != null) {
		vendor_no = request.getParameter("vendor_no");
	} else {
		vendor_no = "V000001";
	}
	
	VendorService vendorService = new VendorService();
	VendorVO vendorVO = vendorService.findByPK(vendor_no);
	
	int stime = Integer.parseInt(vendorVO.getV_start_time().substring(0,2));
	int etime = Integer.parseInt(vendorVO.getV_end_time().substring(0,2));
	
	SimpleDateFormat format = new SimpleDateFormat("HHmm");
	java.util.Date startTime = null;
	try {
		startTime = format.parse(vendorVO.getV_start_time());
	} catch (ParseException e) {
		e.printStackTrace();
	}
		
	OrdService ordService = new OrdService();
	List<OrdVO> list = ordService.getAllVendorDate(vendor_no, new java.sql.Date(System.currentTimeMillis()));
	pageContext.setAttribute("list", list);
	
	TablesService tablesService = new TablesService();
	List<TablesVO> tblList = tablesService.getAllByVendor_no(vendor_no);
	
	int hrWidth = 220;
	
	// Today text
	Locale locale = Locale.TAIWAN ;
	TimeZone tz = TimeZone.getTimeZone("Asia/Taipei");
	String[] week = { "日", "一", "二", "三", "四", "五", "六" };
	Calendar cal = new GregorianCalendar(tz, locale);

	int m = cal.get(Calendar.MONTH) + 1;
	int d = cal.get(Calendar.DATE);
	int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
	String today = m + "/" + d + " " + week[w];
	
	
	
%>    
<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<title>訂單管理_桌位安排</title>
	
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- Icon資源池 -->
	<link rel="stylesheet" href="css/themify-icons.css">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

	<%@ include file="navbar/nav_css.txt" %>

	<!-- Timeline -->
<style type="text/css">
.timelineContainer {
	width: 100%;
	height: 650px;
	background-color: #F8F9FA;
	overflow-x: auto;
	overflow-y: auto;
	position: relative;
	display: flex;
}

.tblTimeline {
	width: <%= (etime - stime + 1) * hrWidth %>px;
	position: relative;
	flex-shrink: 0;
	/*padding-left: 10px;*/
}

.tblHeadRight {
	/*width: 100%;*/
	height: 40px;
	background-color: #F8F9FA;
	z-index: 550;
	display: flex;


	background-size: <%= hrWidth%>px 50px;
    background-image: linear-gradient(to right, #ddd 1px, transparent 1px);
}

.tblRow {
	width: 100%;
	height: 75px;
	background-color: #F8F9FA;
	border-bottom: 1px solid #ddd;
	position: relative;


	background-size: <%= hrWidth%>px 75px;
    background-image: linear-gradient(to right, #ddd 1px, transparent 1px);
}

.timeMark {
	width: <%= hrWidth%>px;
	line-height: 40px;
	padding-left: 10px;

	border-bottom: 1px solid #ddd;
	box-shadow: 0 2px 4px #ddd;
}
/*===========================================================*/
.tblLeft {
	width: 100px;
	flex-shrink: 0;
	z-index: 600;
	position: relative;
}
.tblHeadLeft {
	width: 100%;
	height: 40px;
	background-color: #F8F9FA;
	z-index: 600;
	padding: 0 0 0 10px;
	line-height: 40px;

	border-bottom: 1px solid #ddd;
	box-shadow: 0 2px 4px #ddd;
}
.tblRowName {
	width: 100%;
	height: 75px;
	background-color: #F8F9FA;
	padding: 10px 0 0 10px;

	border-bottom: 1px solid #ddd;
	box-shadow: 2px 0 4px #ddd;
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


/**/
.timelineContainer .cardOutline {
	position: absolute;
	top: 2px;
	width: <%= hrWidth %>px;
	background-color: ##F8F9FA;
}
</style>

<style type="text/css">
[draggable="true"] {
    /*
   To prevent user selecting inside the drag source
  */
    user-select: none;

}	
</style>
<style>
.ordList {
	width: 220px;
}
.outer {
display: flex;
padding: 20px;
}
.divLeft {
width: 260px;
display: flex;
padding: 0 10px;
overflow: auto;	
}

.divRight {
width: calc(100% - 260px);
margin-left: 20px;
}

.divAlert {
	position: fixed;
	bottom: 0;
	left: 0;
	display: flex;
	z-index: 900;
}
</style>
  </head>

  <!-- ============================================================================= -->
  <body>

  	<%@ include file="navbar/navbar.txt" %>

	<!-- sub Navbar -->
	<nav class="navbar bg-light navbar-light subNavbar justify-content-center">
	  <button class="navbar-toggler mr-2" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" id="btnBack">
	    <span class="ti-angle-left"></span>
	  </button>

	  <button class="navbar-toggler mr-2" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" id="btnSelDate">
	    <span class="ti-calendar"></span>
	  </button>
	  
	  <button class="navbar-toggler mr-2" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" id="btnToday">
	    <span class="ti-control-record"></span>
	  </button>
		
	   <div style="width: 110px">
		  <span class="navbar-toggler mr-2" id="spanDate_now">
		 	 <%= today %>	 	 
		  </span>
	  </div>
	  <input type="hidden" id="inputDate_now" name="date" value="<%= System.currentTimeMillis() %>">

	  
	  <button class="navbar-toggler mr-2" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" id="btnForward">
	    <span class="ti-angle-right"></span>
	  </button>

	 
	</nav>
	
	<%@ include file="navbar/side_navbar.txt" %>
	
	<!-- Content -->
		<div class="outer">
			<!-- Ord List -->
			<div class="bg-light divLeft">
				<div id="accordion" class="ordList">
				
				
				<% for(int i = 1; i <=5; i++) { %>
					<% int tblSize = i * 2; %>
				   <!-- <%= tblSize %>人桌 -->
				  <div class="card">

				  	<!-- card header -->
				    <div class="card-header p-0" id="headingTblSize<%= i %>">
				        

				        <div class="btn-group w-100" role="group" aria-label="Basic example">
						  <button class="btn btn-secondary" data-toggle="collapse" data-target="#collapseTblSize<%= i %>" aria-expanded="true" aria-controls="collapseTblSize<%= i %>">
				          <%= tblSize %>人桌				        
				          </button>
		
						</div>
				        
				    </div>

					<!-- card body -->
				    <div id="collapseTblSize<%= i %>" class="collapse show p-0" aria-labelledby="headingTblSize<%= i %>">
				      <div class="card-body p-0" id="card-body<%= i %>">

						<% 
							List<OrdVO> newList = new ArrayList<>();
							newList = list.stream()
									.filter(e -> e.getParty_size() <= tblSize  && e.getParty_size() >= tblSize - 1)
									.sorted(Comparator.comparing(OrdVO::getBooking_time))
									.collect(Collectors.toList());
						%>
						<% if (newList != null) { %>
							<% for(int j = 0 ; j < newList.size(); j++) { %>
								<% OrdVO ordVOa = newList.get(j); %>
									<% if (ordVOa.getTbl_no() == null) { %>
										<% 
										java.util.Date bookingTime = null;
										try {
											bookingTime = format.parse(ordVOa.getBooking_time());
										} catch (ParseException e) {
											e.printStackTrace();
										}
										
										long left = (bookingTime.getTime() - startTime.getTime()) / 1000 / 60 / 60 * hrWidth;													
										
										%>
									
				        <div class="cardOutline" id="<%= ordVOa.getOrd_no() %>" style="left: <%= left %>px;">		
							<div class="cardLeft"><i class="material-icons">account_circle</i>	</div>
							<div class="cardRight">
								<div class="name"><%= ordVOa.getMem_no() %></div>
								<div class="cardRBottom">	
									<div class="partySize"><i class="material-icons">group</i>&nbsp;<span><%= ordVOa.getParty_size() %></span></div>
									<div class="bookingTime"><i class="material-icons">access_time</i>&nbsp;<span><%= ordVOa.getBooking_time().substring(0,2).concat(":").concat(ordVOa.getBooking_time().substring(2,4)) %></span></div>
								</div>		
							</div>	
						</div>
								<% } %>
							<% } %>	
						<% } %>	
						

				       
				      </div>
				    </div>

				  </div>
				<% } %>				 
				  				  				  				  
  
				</div>
			</div>

			<!-- Table Timeline -->
			<div class="divRight">
				<div class="timelineContainer">
					<div class="tblLeft">
						<div class="tblHeadLeft">桌位名稱</div>
					<% for(int i = 0; i < tblList.size(); i++) { %>
						<div class="tblRowName"><div class="tbl_name"><%= tblList.get(i).getTbl_name() %></div><div class="tbl_size"><%= tblList.get(i).getTbl_size() * 2 %>&nbsp;人桌</div></div>
					<% } %>
					</div>

	  			
	  				<div class="tblTimeline">
	  					<div class="tblHeadRight">
						<% for(int i = Integer.parseInt(vendorVO.getV_start_time().substring(0,2)); i <= Integer.parseInt(vendorVO.getV_end_time().substring(0,2)); i++ ) { %>
							<div class="timeMark"><%= i %>:00</div>		
						<% } %>
	  					</div>
	  					<% for(int i = 0; i < tblList.size(); i++) { %>
							<div class="tblRow" id="<%= tblList.get(i).getTbl_no() %>">								
								<% for(int j = 0 ; j < list.size(); j++) { %>
									<% OrdVO ordVOa = list.get(j); %>
									<% if (tblList.get(i).getTbl_no().equals(ordVOa.getTbl_no())) { %>
										<% 
										java.util.Date bookingTime = null;
										try {
											bookingTime = format.parse(ordVOa.getBooking_time());
										} catch (ParseException e) {
											e.printStackTrace();
										}
										
										long left = (bookingTime.getTime() - startTime.getTime()) / 1000 / 60 / 60 * hrWidth;													
										
										%>
																		
						        <div class="cardOutline" id="<%= ordVOa.getOrd_no() %>" style="left: <%= left %>px;">		
									<div class="cardLeft"><i class="material-icons">account_circle</i>	</div>
									<div class="cardRight">
										<div class="name"><%= ordVOa.getMem_no() %></div>
										<div class="cardRBottom">	
											<div class="partySize"><i class="material-icons">group</i>&nbsp;<span><%= ordVOa.getParty_size() %></span></div>
											<div class="bookingTime"><i class="material-icons">access_time</i>&nbsp;<span><%= ordVOa.getBooking_time().substring(0,2).concat(":").concat(ordVOa.getBooking_time().substring(2,4)) %></span></div>
										</div>		
									</div>	
								</div>
									<% } %>
								<% } %>
							</div>
						<% } %>
	  					
	  				</div>
  			
			</div> <!-- End of timelineContainer -->				
		</div> <!-- End of Timeline col-9 -->
	</div> <!--End of outer -->
		
<!-- alert -->
<div id="result" class="divAlert"></div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	

<!-- Drag and Drop -->
<script type="text/javascript">
$(document).ready(function(){
	cardEventListener();

	let tblRows = document.querySelectorAll('.tblRow');
	tblRows.forEach(tblRow => {
	  tblRow.addEventListener('drop', dropped);
	  tblRow.addEventListener('dragenter', dragEnter);
	  tblRow.addEventListener('dragover', cancelDefault);
	  tblRow.addEventListener('dragleave', dragLeave);   
	});

});

function cardEventListener() {
	let cards = document.querySelectorAll('.cardOutline');
	cards.forEach(card => {
	  $(card).prop('draggable', true);
	  card.addEventListener('dragstart', dragStart);
	  card.addEventListener('drop', cancelDefault);
	  card.addEventListener('dragenter', cancelDefault);
	  card.addEventListener('dragover', cancelDefault);
	});
	
	let cardsInGraph = document.querySelectorAll('.timelineContainer .cardOutline');
	cardsInGraph.forEach(card => {	  
	  card.addEventListener('dblclick', updateTbl_no_null);	 
	});
}

function cancelDefault (e) {
  e.preventDefault();
  e.stopPropagation();
  return false;
}

function dragStart (e) {
	var jsonobj = {id : e.target.id, parent : e.target.parentNode.id};
	e.dataTransfer.setData('text/plain', JSON.stringify(jsonobj));
}

function dragEnter (e) {  
  cancelDefault(e);
  e.target.style.backgroundColor = "#f6f1f9";
}
function dragLeave (e) {  
  cancelDefault(e);
  e.target.style.backgroundColor = "";
}

function dropped (e) {
	cancelDefault(e);
	if (e.target.classList.contains("tblRow")) {
		var tblRow = e.target;
		tblRow.style.backgroundColor = "";
		var jsonObj = JSON.parse(e.dataTransfer.getData('text/plain'));
		var id = jsonObj.id;
		var parentId = jsonObj.parent;
		// update tbl_no ajax
		var ord_no = id; // ord_no is save in id
		var tbl_no = tblRow.id;
		$.ajax({
			url: "<%=request.getContextPath()%>/ord/ord_vendor.do",
		    type: 'post',
		    data: {
		      action : "updateTbl_no",
		      ord_no : ord_no,
		      tbl_no : tbl_no
		    },
		    dataType: "json",
		    ord_no: ord_no,
		    tbl_no : tbl_no,
		    parentId: parentId,
		    success: function(response) {
		    	
		    	//alert(response.result);
		    	if (response.status == 1) {
		    		showAlert("alert-success", response.result);
		    		
		    		var card = document.getElementById(this.ord_no);
		    		document.getElementById(this.tbl_no).appendChild(card);
			  		  
			  		if (document.getElementById(this.parentId).classList.contains("card-body")) {
			  			card.addEventListener('dblclick', updateTbl_no_null);
			  			// $(".timelineContainer").scrollLeft(300);
			  			$(".timelineContainer").animate({scrollLeft: card.style.left}, 0);  
			  		}
		    	} else {
		    		showAlert("alert-danger", response.result);
		    	}
			    
		    },	    
		    error: function(xhr) {	    		    	
		    	//alert("updateTbl_no Error");
		    	showAlert("alert-danger", "updateTbl_no Error");
		    	
		    }			    
		});	
		
	}
  
}

// set to null
function updateTbl_no_null() {
	var ord_no = this.id;
	$.ajax({
	    url: "<%=request.getContextPath()%>/ord/ord_vendor.do",
	    type: 'post',
	    data: {
	      action : "updateTbl_no",
	      ord_no : ord_no	      
	    },
	    dataType: "json",
	    ord_no: ord_no,
	    success: function(response) {
	    	
	    	if (response.status == 1) {
	    		showAlert("alert-success", response.result);
	    		
	    		var cardBody = $(".card-body");
	    		
	    		document.getElementById(this.ord_no).removeEventListener('dblclick', updateTbl_no_null);	
	    		var card = $("#" + this.ord_no);
	    		var party_size = parseInt($(card).find(".partySize span").html());
	    		$(card).detach();
	    		
	    		$(cardBody).eq(Math.ceil(party_size / 2) - 1).prepend(card);
	    	} else {
	    		showAlert("alert-danger", response.result);
	    	}
		    
	    },	    
	    error: function(xhr) {	    		    	
	    	showAlert("alert-danger", "updateTbl_no_null Error");	    	
	    }

	});	
} // End of updateTbl_no_null
</script>	
	
 


<!--=============================== datetimepicker ======================================-->

<!-- 參考網站: https://xdsoft.net/jqplugins/datetimepicker/ -->
<link   rel="stylesheet" type="text/css" href="datetimepicker/jquery.datetimepicker.css" />
<!--  <script src="datetimepicker/jquery.js"></script>-->
<script src="datetimepicker/jquery.datetimepicker.full.js"></script>

<script>
$(document).ready(function(){
	$.datetimepicker.setLocale('zh'); // kr ko ja en
    $('#btnSelDate').datetimepicker({
       theme: '',          //theme: 'dark',
       timepicker: false,   //timepicker: false,
       step: 1,            //step: 60 (這是timepicker的預設間隔60分鐘)
       format: 'Y-m-d', // Y-m-d H:i:s
       value: new Date(),
       onChangeDateTime:function(dp,$input){
    	    getOrdByDate(dp.getTime());
    	  }
       //disabledDates:    ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
       //startDate:	        '2017/07/10',  // 起始日
       //minDate:           '-1970-01-01', // 去除今日(不含)之前
       //maxDate:           '+1970-01-01'  // 去除今日(不含)之後
    });
	
    $('#btnBack').click(function(){
    	var back = $("#inputDate_now").val() - 24 * 60 * 60 * 1000;
    	getOrdByDate(back);
    });
    
	$('#btnForward').click(function(){
		var next = Number.parseInt($("#inputDate_now").val()) + 24 * 60 * 60 * 1000;
		getOrdByDate(next);
    });
	
	$('#btnToday').click(function(){		
		getOrdByDate(new Date().getTime());
    });
	
});
        
        
function setDateNow(date_now) {
	//var date = new Date(Number.parseInt($("#inputDate_now").val()));
	$("#inputDate_now").val(date_now);
	var date = new Date(date_now);
	var day = ["日", "一", "二", "三", "四", "五", "六"];
	var str = (date.getMonth() + 1) + "/" + date.getDate() + "&nbsp;" + day[date.getDay()];
	$("#spanDate_now").html(str);
}        
   
     
        
function getOrdByDate(date) {
	$.ajax({
	    url: "<%=request.getContextPath()%>/ord/ord_vendor.do",
	    type: 'post',
	    date: date,
	    data: {
	      action : "getOrdByDate",
	      vendor_no : "<%= vendor_no %>",
	      date : date
	    },
	    dataType: "json",
	    success: function(response) {
		    var cardBody = $(".card-body");
		    for(var i = 0; i < cardBody.length; i++) {
		    	$(cardBody).eq(i).empty();
		    }
		    var tblRow = $(".tblRow");
		    for(var i = 0; i < tblRow.length; i++) {
		    	$(tblRow).eq(i).empty();
		    }
		    
	    	var len = response.length;
	    	
	    	if (len != 0) {
	    		for (var i = 0; i < len; i++) {
	    			var newCard = mkCard(response[i].ord_no, response[i].mem_no, response[i].party_size, timeFmt(response[i].booking_time));
	    			if (response[i].tbl_no) {
	    				$("#" + response[i].tbl_no).append(newCard);
	    			} else {
	    				$(cardBody).eq(Math.ceil(response[i].party_size / 2) - 1).append(newCard);
	    			}		    		
		    	}
	    		cardEventListener();			    		
	    		
	    	} else {
	    		showAlert("alert-info", "查無資料");
	    	}
	    	
	    	setDateNow(this.date);
	    },	    
	    error: function(xhr) {
	    	showAlert("alert-danger", "getOrdByDate Error");
	    	//var coln = $("#reservation-list thead th").length;
	    	//var tbody = $("#reservation-list tbody");
	    	//$(tbody).append("<tr><td colspan='" + coln + "'>查無資料</td></tr>");
	    }

	});	
} // End of getOrdByDate

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

function calcCardLeft(bookingTimeStr) {
	var tstr1 = $(".timeMark")[0].innerHTML.split(":");
	var tstr2 = bookingTimeStr.split(":");
	var dt1 = new Date(1970, 1, 1, tstr1[0], tstr1[1]);
	var dt2 = new Date(1970, 1, 1, tstr2[0], tstr2[1]);
	var diff =(dt2.getTime() - dt1.getTime()) / 1000 / 60 / 60;
	
	return (diff * <%= hrWidth %>) + "px";
}

function timeFmt(time) {
	return time.substr(0, 2) + ":" + time.substr(2, 2);
}
</script>

<!--  Timeline -->
<script type="text/javascript">
$(document).ready(function(){
	document.querySelector(".timelineContainer").onscroll = function() {scrollFunction()};
});


function scrollFunction() {

  if (document.querySelector(".timelineContainer").scrollTop > 0 ) {

  	

    document.querySelector(".tblHeadRight").style.position = "absolute";
    document.querySelector(".tblHeadRight").style.top = document.querySelector(".timelineContainer").scrollTop + "px";

    document.querySelector(".tblHeadLeft").style.position = "absolute";
    document.querySelector(".tblHeadLeft").style.top = document.querySelector(".timelineContainer").scrollTop + "px";
  } else {

  	document.querySelector(".tblHeadLeft").style.position = "static";
  	document.querySelector(".tblHeadRight").style.position = "static";
  
  }

    document.querySelector(".tblLeft").style.left = document.querySelector(".timelineContainer").scrollLeft + "px";

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
//showAlert("alert-success", msg)
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