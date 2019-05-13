<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<%@ page import="com.ord.model.*" %>
<%@ page import="com.vendor.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.*" %>
<%@ page import="com.tables.model.*" %>


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
	
	OrdService ordService = new OrdService();
	List<OrdVO> list = ordService.getAllVendorDate(vendor_no, new java.sql.Date(System.currentTimeMillis()));
	pageContext.setAttribute("list", list);
	
	// Today text
	Locale locale = Locale.TAIWAN ;
	TimeZone tz = TimeZone.getTimeZone("Asia/Taipei");
	String[] week = { "日", "一", "二", "三", "四", "五", "六" };
	Calendar cal = new GregorianCalendar(tz, locale);

	int m = cal.get(Calendar.MONTH) + 1;
	int d = cal.get(Calendar.DATE);
	int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
	String today = m + "/" + d + " " + week[w];
	
	TablesService tablesService = new TablesService();
	List<TablesVO> tblList = tablesService.getAllByVendor_no(vendor_no);
	
%>    
<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- Icon資源池 -->
	<link rel="stylesheet" href="css/themify-icons.css">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <title>訂單管理_桌位安排</title>
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
	width: <%= (etime - stime + 1) * 220 %>px;
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


	background-size: 220px 50px;
    background-image: linear-gradient(to right, #ddd 1px, transparent 1px);
}

.tblRow {
	width: 100%;
	height: 75px;
	background-color: #F8F9FA;
	border-bottom: 1px solid #ddd;
	position: relative;


	background-size: 220px 75px;
    background-image: linear-gradient(to right, #ddd 1px, transparent 1px);
}

.timeMark {
	width: 220px;
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
}

.divRight {
width: calc(100% - 260px);
margin-left: 20px;
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
				    <div id="collapseTblSize<%= i %>" class="collapse p-0" aria-labelledby="headingTblSize<%= i %>" data-parent="#accordion">
				      <div class="card-body p-0">

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
				        <div class="cardOutline" id="<%= ordVOa.getOrd_no() %>">		
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
							<div class="tblRow tblS1" id="tblAlRow"><input type="hidden" name="tbl_no" value="<%= tblList.get(i).getTbl_no() %>"></div>
						<% } %>
	  					
	  				</div>
  			
			</div> <!-- End of timelineContainer -->				
		</div> <!-- End of Timeline col-9 -->
	</div> <!--End of outer -->
		


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	
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
<!-- Drag and Drop -->
<script type="text/javascript">
 $(document).ready(function(){
	cardEventListener()

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
	  card.addEventListener('drop', dropped);
	  card.addEventListener('dragenter', cancelDefault);
	  card.addEventListener('dragover', cancelDefault);
	});
}

function cancelDefault (e) {
  e.preventDefault();
  e.stopPropagation();
  return false;
}

function dragStart (e) {  
  e.dataTransfer.setData('text/plain', e.target.id);
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
   e.target.style.backgroundColor = "";
  let id = e.dataTransfer.getData('text/plain');
  var card = document.getElementById(id);
  card.style.width = "220px";
  card.style.position = "absolute";
  card.style.backgroundColor = "#F8F9FA";
  // card.style.border = "1px solid #b7c2a1";

  var tstr1 = $(".timeMark")[0].innerHTML.split(":");
  var tstr2 = $(card).find(".bookingTime span").html().split(":");
  var dt1 = new Date(1970, 1, 1, tstr1[0], tstr1[1]);
  var dt2 = new Date(1970, 1, 1, tstr2[0], tstr2[1]);
  var diff =(dt2.getTime() - dt1.getTime()) / 1000 / 60 / 60;

  card.style.left = (diff * 220) + "px";
  card.style.top = "2px";
  e.target.appendChild(card);

  // $(".timelineContainer").scrollLeft(300);
   $(".timelineContainer").animate({scrollLeft: card.style.left}, 0);
}

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
			    url: "<%=request.getContextPath()%>/ord/ord.do",
			    type: 'post',
			    date: date,
			    data: {
			      action : "getOrdByDate",
			      vendor_no : "<%= vendor_no %>",
			      date : date
			    },
			    dataType: "json",
			    success: function(response) {
			    	console.log(response);
				    var cardBody = $(".card-body");
				    for(var i = 0; i < cardBody.length; i++) {
				    	$(cardBody).eq(i).empty();
				    }
			    	var len = response.length;
			    	
			    	if (len != 0) {
			    		for (var i = 0; i < len; i++) {
				    		$(cardBody).eq(Math.ceil(response[i].party_size / 2)).append(
							    mkCard(response[i].ord_no, response[i].mem_no, response[i].party_size, timeFmt(response[i].booking_time))
		    		 		);
				    	}
			    		cardEventListener();			    		
			    		
			    	} else {
			    		//var coln = $("#reservation-list thead th").length;
			    		//$(tbody).append("<tr><td colspan='" + coln + "'>查無資料</td></tr>");
			    	}
			    	
			    	setDateNow(this.date);
			    },	    
			    error: function(xhr) {
			    	//var coln = $("#reservation-list thead th").length;
			    	//var tbody = $("#reservation-list tbody");
			    	//$(tbody).append("<tr><td colspan='" + coln + "'>查無資料</td></tr>");
			    }

			});	
        } // End of getOrdByDate

function mkCard(ord_no, mem_no, party_size, booking_time) {
str =	      
'<div class="cardOutline" id="' + ord_no + '">' +		
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
  </body>
</html>