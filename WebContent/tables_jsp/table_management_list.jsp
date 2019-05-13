<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ page import="com.tables.model.*" %>
<%@ page import="java.util.*" %>

<%
	TablesService tablesService = new TablesService();
	List<TablesVO> list = tablesService.getAllByVendor_no("V000001");
	pageContext.setAttribute("list", list);
%>
 
<!DOCTYPE html>
<html>
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
		<div class="row justify-content-around p-3">

			<!-- Create Tables -->
			<div class="col-3 bg-light">
				<form method="post" action="<%=request.getContextPath()%>/tables/tables.do">
					<legend>新增桌位</legend>

					<!-- Table Size -->
					<div class="form-group">
						<label for="fciTblSize">人數</label>	
						<br>				
					    <div class="btn-group btn-group-toggle w-100" data-toggle="buttons" id="fciTblSize">
							<label class="btn btn-secondary form-control   ${(tbl_size_add ==1 || tbl_size_add ==null) ? 'active' : '' }">
								<input type="radio" name="tbl_size" value="1" id="tblSize1" autocomplete="off" ${(tbl_size_add ==1 || tbl_size_add ==null) ? "checked" : "" }> 2
							</label>
							<label class="btn btn-secondary form-control   ${tbl_size_add ==2 ? 'active' : '' }">
								<input type="radio" name="tbl_size" value="2" id="tblSize2" autocomplete="off" ${tbl_size_add ==2 ? "checked" : "" }> 4
							</label>
							<label class="btn btn-secondary form-control   ${tbl_size_add ==3 ? 'active' : '' }">
								<input type="radio" name="tbl_size" value="3" id="tblSize3" autocomplete="off" ${tbl_size_add ==3 ? "checked" : "" }> 6
							</label>
							<label class="btn btn-secondary form-control   ${tbl_size_add ==4 ? 'active' : '' }">
								<input type="radio" name="tbl_size" value="4" id="tblSize4" autocomplete="off" ${tbl_size_add ==4 ? "checked" : "" }> 8
							</label>
							<label class="btn btn-secondary form-control   ${tbl_size_add ==5 ? 'active' : '' }">
								<input type="radio" name="tbl_size" value="5" id="tblSize5" autocomplete="off"  ${tbl_size_add ==5 ? "checked" : "" }> 10
							</label>
						</div>
					</div>
					
					<br>
					<!-- Number of Tables -->

					<div class="form-group">					
						<label for="fgiTblNum">張數</label>
						<input type="number" name="tbl_number" value="${tbl_number_add == null ? '1': tbl_number_add}" min="1" max="100" step="1" required id="fgiTblNum"/>
						<div class="input-group" id="html2">						
					        <div class="input-group-prepend">
					        	<button style="min-width:2.5rem" class="btn btn-decrement btn-outline-secondary" type="button"><strong>-</strong></button>
					        </div>
					        <input type="text" style="text-align:center" class="form-control" value="1"/>
					        <div class="input-group-append">
					        	<button style="min-width: 2.5rem" class="btn btn-increment btn-outline-secondary" type="button"><strong>+</strong></button>
					        </div>
				        </div>
					
					</div>
					
				
					<br>
					<!-- Table Name / Prefix -->
					  <div class="form-group">
					    <label for="fciTblName">名稱</label>
					    <input type="text" name="tbl_name" value="${tbl_name_add}" class="form-control" id="fciTblName"/>
					  </div>
					
					<br>
					<!-- Create Tables -->
					<div class="form-group">
						<button type="submit" class="btn btn-secondary w-100" id="btnCreateTbl">新增</button>
					</div>
					<input type="hidden" name="action" value="insert">
					<input type="hidden" name="vendor_no"	value="V000001">
				</form>
			</div>

			<!-- Table List -->			
			<div class="col-6">
<%@ include file="page1.file" %>
				<table class="table table-hover table-dark">
				  <thead>
				    <tr>
				      <th scope="col">桌位編號</th>
				      <th scope="col">桌位名稱</th>
				      <th scope="col">人數</th>				      
				    </tr>
				  </thead>
				  <tbody>
<% pageContext.setAttribute("pageIndex", pageIndex); %>				  
<c:forEach var="tablesVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="s">		
					<tr class="tblObj">
						<th scope="row">${tablesVO.tbl_no}</th>
						<td>${tablesVO.tbl_name}</td>
						<td>${tablesVO.tbl_size * 2}</td>
						<input type="hidden" name="tbl_no"	value="${tablesVO.tbl_no}">
						<input type="hidden" name="vendor_no"	value="${tablesVO.vendor_no}">
						<input type="hidden" name="tbl_name"	value="${tablesVO.tbl_name}">
						<input type="hidden" name="tbl_size"	value="${tablesVO.tbl_size}">
						<input type="hidden" name="tbl_type"	value="${tablesVO.tbl_type}">
						<input type="hidden" name="tbl_x"	value="${tablesVO.tbl_x}">
						<input type="hidden" name="tbl_y"	value="${tablesVO.tbl_y}">				
					</tr>
</c:forEach>

				  </tbody>
				</table>


				<!-- Pages -->
<% if (pageNumber > 1) { %>
				<nav aria-label="...">
				  <ul class="pagination">
				  	
				  	<!-- 上一頁 -->
				 <%if(pageIndex >= rowsPerPage){%>
				    <li class="page-item">
				      <a class="page-link" href="<%=request.getRequestURI()%>?whichPage=<%=whichPage-1%>">Previous</a>
				    </li>
				 <%}%>
				    
				    <!-- 頁數 -->
				 <% for (int i = 1; i <= pageNumber; i++) { %>
				 	<li class='page-item <%= i == whichPage ? "active" : ""%>'><a class="page-link" href="<%=request.getRequestURI()%>?whichPage=<%=i%>"><%= i %></a></li>
				 <%}%>  
				    
				    
				    <!-- 下一頁 -->
				 <%if(pageIndex < pageIndexArray[pageNumber-1]){%>
				    <li class="page-item">
				      <a class="page-link" href="<%=request.getRequestURI()%>?whichPage=<%=whichPage+1%>">Next</a>
				    </li>
				 <%}%>   
				  </ul>
				</nav>
<% } %>								
			</div>

			<!-- Edit Tables -->
			<div class="col-3 bg-light">
				<form id="editTableForm" method="get" action="<%=request.getContextPath()%>/tables/tables.do">
					<legend>編輯桌位</legend>

					<!-- Table Name / Prefix -->
					  <div class="form-group">
					    <label for="fciTblNameEdit">名稱</label>
					    <input type="text" class="form-control" id="fciTblNameEdit" name="tbl_name" value="${tablesVO.tbl_name }"/>
					  </div>
					
					<br>
					<!-- Table Size -->
					<div class="form-group">
						<label for="fciTblSize">人數</label>	
						<br>				
					    <div class="btn-group btn-group-toggle w-100" data-toggle="buttons" id="fciTblSize">
							<label class="btn btn-secondary form-control  ${tablesVO.tbl_size ==1 ? 'active' : '' }">
								<input type="radio" name="tbl_size" value="1" id="tblSize1" autocomplete="off" ${tablesVO.tbl_size ==1 ? "checked" : "" }> 2
							</label>
							<label class="btn btn-secondary form-control ${tablesVO.tbl_size ==2 ? 'active' : '' }">
								<input type="radio" name="tbl_size" value="2" id="tblSize2" autocomplete="off" ${tablesVO.tbl_size ==2 ? "checked" : "" }> 4
							</label>
							<label class="btn btn-secondary form-control ${tablesVO.tbl_size ==3 ? 'active' : '' }">
								<input type="radio" name="tbl_size" value="3" id="tblSize3" autocomplete="off"  ${tablesVO.tbl_size ==3 ? "checked" : "" }> 6
							</label>
							<label class="btn btn-secondary form-control ${tablesVO.tbl_size ==4 ? 'active' : '' }">
								<input type="radio" name="tbl_size" value="4" id="tblSize4" autocomplete="off"  ${tablesVO.tbl_size ==4 ? "checked" : "" }> 8
							</label>
							<label class="btn btn-secondary form-control" ${tablesVO.tbl_size ==5 ? 'active' : '' }>
								<input type="radio" name="tbl_size" value="5" id="tblSize5" autocomplete="off"  ${tablesVO.tbl_size ==5 ? "checked" : "" }> 10
							</label>
						</div>
					</div>

					<br>
					<!-- Update Tables -->
					<div class="form-group">
					<button type="submit" class="btn btn-secondary w-100" id="btnUpdTbl">修改</button>
					</div>
					
					<!-- Delete Tables -->
					<div class="form-group">
					<button type="submit" class="btn btn-secondary w-100" id="btnDelTbl" >刪除</button>
					</div>
					<input type="hidden" name="tbl_no"	value="${tablesVO.tbl_no }">
					<input type="hidden" name="vendor_no"	value="${tablesVO.vendor_no }">

					<input type="hidden" name="tbl_type"	value="${tablesVO.tbl_type }">
					<input type="hidden" name="tbl_x"	value="${tablesVO.tbl_x }">
					<input type="hidden" name="tbl_y"	value="${tablesVO.tbl_y }">		
					
					<input type="hidden" name="action"	value="">
					

				</form>

			</div>
		</div>
	</div>
	

	<script>		
		$(document).ready(function(){
			$("#fgiTblNum").inputSpinner($("#html2"));
		});	    
	</script>
	
    <!-- Side Nav -->
    <script type="text/javascript">
    
        $(document).ready(function () {
        	<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				alert(
					<c:forEach var="message" items="${errorMsgs}">
						"${message.trim()}" + "\n"
					</c:forEach>
				);

			</c:if>
        	
        	
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
            
            // 修改資料
            $(".tblObj").on('click', function() {
            	
            	var tbl_name = $(this).children('input[name="tbl_name"]').val();
            	$("#editTableForm").find('input[name="tbl_name"]').val(tbl_name);
            	
            	var tbl_size = $(this).children('input[name="tbl_size"]').val();
            	$("#editTableForm input:checked").parent().removeClass("active");
            	$("#editTableForm").find('input[name="tbl_size"][value="' + tbl_size + '"]').prop("checked", true);            	
            	$("#editTableForm").find('input[name="tbl_size"][value="' + tbl_size + '"]').parent().addClass("active");
            	
            	var tbl_no = $(this).children('input[name="tbl_no"]').val();
            	$("#editTableForm").find('input[name="tbl_no"]').val(tbl_no);
            	var vendor_no = $(this).children('input[name="vendor_no"]').val();
            	$("#editTableForm").find('input[name="vendor_no"]').val(vendor_no);
            	var tbl_type = $(this).children('input[name="tbl_type"]').val();
            	$("#editTableForm").find('input[name="tbl_type"]').val(tbl_type);
            	var tbl_x = $(this).children('input[name="tbl_x"]').val();
            	$("#editTableForm").find('input[name="tbl_x"]').val(tbl_x);
            	var tbl_y = $(this).children('input[name="tbl_y"]').val();
            	$("#editTableForm").find('input[name="tbl_y"]').val(tbl_y);
            	
            	
            });
            
            $("#btnUpdTbl").on("click", function(){
            	$("#editTableForm").find('input[name="action"]').val("updateBasic");
            });
            
            $("#btnDelTbl").on("click", function(){
            	$("#editTableForm").find('input[name="action"]').val("delete");
            });
            
        });
    </script>
	
  </body>
</html>