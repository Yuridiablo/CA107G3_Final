<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.vendor.model.*"%>

<jsp:useBean id="vVO" scope="session" class="com.vendor.model.VendorVO" />

<!doctype html>
<html lang="en">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
	
	
	
	<script src="../front-end/js/jquery-3.3.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
	<!-- Input type=number -->
	<script src="../front-end/js/bootstrap-input-spinner.js"></script>
	<!--     sweetalert -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	
<title>餐廳管理後台</title>
<!-- Side Nav -->
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

<!-- 秀圖的JS裝置 -->
<script type="text/javascript">
	function changePic(e) {		
		
  		document.getElementById("#upimg").src = URL.createObjectURL(event.target.files[0]); 		
	}
</script>


</head>
<!-- ============================================================================= -->

<body>

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
		<a class="nav-link text-white p-3" href="#">概況一覽</a> 
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=upVendor">資訊修改</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=listTableinfo">桌型資料設定</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=listTableGraph">桌位配置</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=OrdMgList">訂單狀態</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=OrdMgTimeLine">訂單安排桌位</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=listMenu">菜單管理</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=listVendor">帳戶管理</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=listComment">回應管理</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=ordConfirm">訂位驗證</a>
		<a class="nav-link text-white p-3" href="<%=request.getContextPath()%>/Vendor/Vendor.do?action=waitPos">候位控制系統</a>
		
			
	</nav>
<h1>include主頁</h1>
	<div class="container">
		<div class="row">
		
				<!-- ===============================編輯區 開始====================================== -->



<c:if test="${not empty rtllist}">
<jsp:include page="/RES_Transaction_List/listVendor.jsp" />
</c:if>

<c:if test="${not empty rrlist}">
<jsp:include page="/Restaurant_Responses/listComment.jsp" />
</c:if>

<c:if test="${not empty vlist}">
<jsp:include page="/Vendor/upVendor.jsp" />
</c:if>

<c:if test="${not empty rmlist || not empty newStore}">
<jsp:include page="/Restaurant_Menu/listMenu.jsp" />
</c:if>

<c:if test="${not empty tmlist}">
<jsp:include page="/tables_jsp/table_management_list.jsp" />
</c:if>

<c:if test="${not empty mglist}">
<jsp:include page="/tables_jsp/table_management_graph.jsp" />
</c:if>


<c:if test="${not empty watingFlag}">
<jsp:include page="/wait_pos_jsp/wait_vendor.jsp" />
</c:if>

<c:if test="${not empty ordConfirm}">
<jsp:include page="/ord_jsp/ord_verification.jsp" />
</c:if>

<c:if test="${not empty ordMgList}">
<jsp:include page="/ord_jsp/ord_management_list.jsp" />
</c:if>

<c:if test="${not empty OrdMgTimeLine}">
<jsp:include page="/ord_jsp/ord_management_timeline.jsp" />
</c:if>



</div>





			<!-- =================================編輯區 結束==================================== -->
		
	

	</div>


	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	
	<script>
    $("input[type='number']").inputSpinner()
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
    
    
<%@ page import="com.wait_pos.controller.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.collections4.map.ListOrderedMap" %>
<%@ page import="javax.websocket.Session" %>

<% 
String vendor_no = null;
if (request.getParameter("vendor_no") == null) {
	vendor_no = "V000001";
} else {
	vendor_no = request.getParameter("vendor_no");
}
Map<String, Map<Integer, Wait_Line>> wait_line_all = (Map) application.getAttribute("wait_line_all");

Map<Integer, Wait_Line> wait_line_vendor = (Map) wait_line_all.get(vendor_no);				
if (wait_line_vendor == null) {
	
	wait_line_vendor = new HashMap<Integer, Wait_Line>();
	wait_line_all.put(vendor_no, wait_line_vendor);
	
	wait_line_vendor.put(1, new Wait_Line());
	wait_line_vendor.put(2, new Wait_Line());
	wait_line_vendor.put(3, new Wait_Line());
	wait_line_vendor.put(4, new Wait_Line());
	wait_line_vendor.put(5, new Wait_Line());
}
Wait_Line wait_line;
ListOrderedMap<String, PersonInLine> wait_line_queue;

Map<String, Set<Session>> vendor_wait_sessions = (Map) application.getAttribute("vendor_wait_sessions");
Set<Session> vendor_wait_session = (Set) vendor_wait_sessions.get(vendor_no);
if (vendor_wait_session == null) {	
	vendor_wait_session = Collections.synchronizedSet(new HashSet<Session>());
	vendor_wait_sessions.put(vendor_no, vendor_wait_session);
}

%>   
    <script>
var vendorWaitMgmtWS;
	
	// connect
	window.addEventListener("load", function() {
		var MyPoint = "/VendorWS/<%= vendor_no %>"; // servlet ServerEndpoint
		var path = window.location.pathname; // /WebSocketChatWeb/index.html
		var webCtx = path.substring(0, path.indexOf('/', 1)); // /WebSocketChatWeb
		var endPointURL = "ws://" + window.location.host + webCtx + MyPoint; 
		
		// create a websocket
		vendorWaitMgmtWS = new WebSocket(endPointURL); // connect ot server ServerEndpoint servlet

		
		// onopen
		vendorWaitMgmtWS.onopen = function(event) {
			showAlert("alert-success", "Web Socket 已連線");
		};
		
		// onmessage
		vendorWaitMgmtWS.onmessage = function(event) {
			
			var jsonObj = JSON.parse(event.data);
			switch (jsonObj.action) {
				case "openWaitFun": // 變更候位功能狀態
					showAlert("alert-info", (jsonObj.tbl_size * 2) + " 人桌候位功能已" + (jsonObj.open_wait ? "開啟" : "關閉"));										
					openWaitFun(jsonObj.tbl_size, jsonObj.open_wait);
					break;
				case "setDeadline": // 叫號
					showAlert("alert-info", (jsonObj.tbl_size * 2) + " 人桌 " + jsonObj.numberPlate + " 號叫號成功");
					setDeadline(jsonObj.tbl_size, jsonObj.mem_no, jsonObj.deadline);
					break;
				case "returnZero": // 刷新隊伍
					showAlert("alert-info", (jsonObj.tbl_size * 2) + " 人桌候位號碼已歸零");										
					setNumberNow(jsonObj.tbl_size, 1);
					break;
				case "refreshLine": // 刷新隊伍
					if (jsonObj.event == "insert") {
						var jsonObj2 = JSON.parse(jsonObj.result);
						showAlert("alert-info", jsonObj2.result);
						setNumberNow(jsonObj.tbl_size, jsonObj2.number_now);
					} else {
						showAlert("alert-info", jsonObj.result);
					}															
					refreshLine(jsonObj.tbl_size, jsonObj.w_line);
					break;
				case "clearLine": // 清空隊伍
					showAlert("alert-info", (jsonObj.tbl_size * 2) + " 人桌候位列表已清空");										
					clearLine(jsonObj.tbl_size);
					break;
				//case "renewNumberNow": // 更新號碼牌
				//	setNumberNow(jsonObj.tbl_size, jsonObj.number_now);
				//	break;
					
			}
		};
		
		// onclose
		vendorWaitMgmtWS.onclose = function(event) {
			showAlert("alert-danger", "Web Socket 已斷線");
		};
	} ,false);
	
	// disconnect
	window.addEventListener("unload", function() {
		vendorWaitMgmtWS.close();
	},false);
    
    </script>	

</body>

</html>