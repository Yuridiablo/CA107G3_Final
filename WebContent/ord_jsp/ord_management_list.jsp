<%@page import="com.tables.model.TablesVO"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.tables.model.TablesService"%>
<%@page import="com.member.model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<%@ page import="com.ord.model.*" %>
<%@ page import="com.ord.controller.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.vendor.model.*" %>

<%
VendorVO vVO = (VendorVO) session.getAttribute("vVO");
String vendor_no = null;
if (vVO != null) {
	vendor_no = vVO.getVendor_no();
} else if (request.getParameter("vendor_no") == null) {
	vendor_no = "V000001";
} else {
	vendor_no = request.getParameter("vendor_no");
}
	
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
%>    
<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="bootstrap/bootstrap.min.css">

    <!-- Icon資源池 -->
    <link rel="stylesheet" href="css/themify-icons.css">

    <title>桌位管理_列表</title>

<%@ include file="/ord_jsp/navbar/nav_css.txt" %>

	<style type="text/css">
		#order-detail {
			display: none;
		}

		#order-detail.active {
			display: inline-flex;
		}

	</style>

  </head>

  <!-- ============================================================================= -->
  <body>
<%@ include file="/ord_jsp/navbar/navbar.txt" %>
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
<%@ include file="/ord_jsp/navbar/side_navbar.txt" %>	
	
	<div class="container-fluid">
		<div class="row  p-3">			

			<!-- Order List -->
			<div class="col-12 flex-column" id="order-list">
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
<% if (list.size() != 0) { %>				  
<%-- <c:forEach var="ordVO" items="${list}"> --%>
<%
MemberService ms = new MemberService();
TablesService ts = new TablesService();
%>
<% for (int i = 0; i < list.size(); i++) { 
	OrdVO ordVO = list.get(i);
	MemberVO memVO = ms.getOneMember(ordVO.getMem_no());
	TablesVO tblVO = ts.getOneTables(ordVO.getTbl_no());
	String tblName = null;
	if (ordVO.getTbl_no() == null) {
		tblName = "";
	} else {
		tblName = tblVO.getTbl_name();
	}
	%>				  
					    <tr>
					      <input type="hidden" name="ord_no" value="<%= ordVO.getOrd_no()%>">					      
					      <td><%= OrdFmt.OrdStatus(ordVO.getStatus())%></td>
					      <td><%= ordVO.getOrd_no()%></td>
					      <td><%= memVO.getMem_name() %></td>
					      <td><%= ordVO.getParty_size()%></td>
					      <td><%= ordVO.getBooking_date()%></td>	
					      <td><%= ordVO.getBooking_time().substring(0,2).concat(":").concat(ordVO.getBooking_time().substring(2,4)) %></td>
					      <td><%= ordVO.getTotal()%></td>
					      <td><%= tblName%></td>						     
					    </tr>
<% } %>
<%-- </c:forEach> --%>
<% } else { %>
						<tr>
					      <td colspan="6">查無資料</td>						     
					    </tr>
<% } %>		   
					  </tbody>
					</table>

				
								
			</div>
			



			<!-- order detail -->
			<div class="col-5 flex-column" id="order-detail">
						  	   
				<table class="table table-hover table-light" id="order-detail-list">
					 <caption class="bg-light text-dark p-3" style="caption-side: top;">
			  	   		 訂單明細 <span class="ord_no"></span>
			  	   		<button type="button" class="navbar-toggler ml-auto close" aria-label="Close" id="btn-ordDetail-close">
					      <span aria-hidden="true">&times;</span>
				  	    </button>
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
			</div>	
					
		</div>

			


		

	</div>


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="bootstrap/jquery-3.3.1.min.js"></script>
	<script src="bootstrap/popper.min.js"></script>
	<script src="bootstrap/bootstrap.min.js"></script>
	
<%@ include file="/ord_jsp/navbar/side_navbar_js.txt" %>
    <!-- reservation list -->
    <script type="text/javascript">
    	$(document).ready(function(){    		
    		
    	<% if (list.size() != 0) { %>
    		$('#reservation-list tbody tr').on('click', function(){
    			getOrdDetail(this);
    		});
    	<% } %>
    		
   		
    		$('#btn-ordDetail-close').on('click', function(){
    			$('#order-detail').removeClass('active');    			
    			$('#order-list').removeClass('col-7');
    			$('#order-list').addClass('col-12');
    		});

    		
    	});
    	
    	function getOrdDetail(ord_row) {
    		$('#order-detail').addClass('active');
			$('#order-list').removeClass('col-12');
			$('#order-list').addClass('col-7');
			$.ajax({
			    url: "<%=request.getContextPath()%>/o_detail/o_detail.do",
			    type: 'post',
			    data: {
			      action : "getOrdDetail",
			      ord_no : $(ord_row).find("input[name=ord_no]").val()
			    },
			    dataType: "json",
			    ord_no : $(ord_row).find("input[name=ord_no]").val(),
			    success: function(response) {
			    	console.log(response);
			    	var spanOrd_no = $("#order-detail-list caption span.ord_no");
			    	$(spanOrd_no).empty();
			    	$(spanOrd_no).append(" (" + this.ord_no + ")");
			    	var odTbody = $("#order-detail-list tbody");
			    	$(odTbody).empty();
			    	var len = response.length;
			    	if (len != 0) {
			    		for (var i = 0; i < len; i++) {
				    		$(odTbody).append(
		    		 			"<tr><td>"+response[i].menu_name+"</td><td>"+response[i].qty+"</td><td>"+response[i].price+"</td></tr>" 		 			
		    		 		);
				    	}  	
			    	} else {
			    		var coln = $("#order-detail-list thead th").length;
			    		$(odTbody).append("<tr><td colspan='" + coln + "'>查無資料</td></tr>");
			    	}
			    		 			
			    },	    
			    error: function(xhr) {
			    	var coln = $("#order-detail-list thead th").length;
			    	var odTbody = $("#order-detail-list tbody");
			    	$(odTbody).empty();
			    	$(odTbody).append("<tr><td colspan='" + coln + "'>查無資料</td></tr>");
			    }

			});	
    	}
    	
    	function setDateNow(date_now) {
    		//var date = new Date(Number.parseInt($("#inputDate_now").val()));
    		$("#inputDate_now").val(date_now);
    		var date = new Date(date_now);
    		var day = ["日", "一", "二", "三", "四", "五", "六"];
    		var str = (date.getMonth() + 1) + "/" + date.getDate() + "&nbsp;" + day[date.getDay()];
    		$("#spanDate_now").html(str);
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
        
        
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.以下為某一天之後的日期無法選擇
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
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
			    	var tbody = $("#reservation-list tbody");
			    	$(tbody).empty();
			    	var len = response.length;
			    	
			    	if (len != 0) {
			    		for (var i = 0; i < len; i++) {
				    		$(tbody).append(
			    				"<tr>" +
							      "<input type='hidden' name='ord_no' value='" + response[i].ord_no + "'>" +				      
							      "<td>" + OrdStatus(response[i].status) + "</td>" +
							      "<td>" + response[i].ord_no + "</td>" +
							      "<td>" + response[i].mem_name + "</td>" +
							      "<td>" + response[i].party_size + "</td>" +
							      "<td>" + response[i].booking_date + "</td>" +	
							      "<td>" + timeFmt(response[i].booking_time) + "</td>" +
							      "<td>" + response[i].total + "</td>" +
							      "<td>" + response[i].tbl_name + "</td>" +
							    "</tr>" 		 			
		    		 		);
				    	}
			    		
			    		$('#reservation-list tbody tr').on('click', function(){
			    			getOrdDetail(this);
			    		});
			    		
			    	} else {
			    		var coln = $("#reservation-list thead th").length;
			    		$(tbody).append("<tr><td colspan='" + coln + "'>查無資料</td></tr>");
			    	}
			    	
			    	setDateNow(this.date);
			    },	    
			    error: function(xhr) {
			    	var coln = $("#reservation-list thead th").length;
			    	var tbody = $("#reservation-list tbody");
			    	$(tbody).append("<tr><td colspan='" + coln + "'>查無資料</td></tr>");
			    }

			});	
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
        function timeFmt(time) {
        	return time.substr(0, 2) + ":" + time.substr(2, 2);
        }
</script>
  </body>
</html>