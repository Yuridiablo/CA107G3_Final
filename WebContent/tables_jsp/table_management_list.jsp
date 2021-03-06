<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ page import="com.tables.model.*" %>
<%@ page import="com.vendor.model.*" %>
<%@ page import="java.util.*" %>

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

TablesService tablesService = new TablesService();
List<TablesVO> list = tablesService.getAllByVendor_no(vendor_no);
pageContext.setAttribute("list", list);
%>
 
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <title>桌位管理_列表</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/tables_jsp/bootstrap/bootstrap.min.css">

	 <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="<%=request.getContextPath()%>/tables_jsp/bootstrap/jquery-3.3.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/tables_jsp/bootstrap/popper.min.js"></script>
	<script src="<%=request.getContextPath()%>/tables_jsp/bootstrap/bootstrap.min.js"></script>  
	<!-- Input type=number -->
	<script src="<%=request.getContextPath()%>/tables_jsp/bootstrap-input-spinner.js"></script>
	
	<%@ include file="/ord_jsp/navbar/nav_css.txt" %>
	
	<style>
		#fgiTblNum {
			display: none;
		}
	</style>
</head>
<body>
	<%@ include file="/ord_jsp/navbar/navbar.txt" %>
	<%@ include file="/ord_jsp/navbar/side_navbar.txt" %>

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
					<input type="hidden" name="vendor_no"	value="<%= vendor_no %>">
				</form>
			</div>

			<!-- Table List -->			
			<div class="col-6">
<%@ include file="/tables_jsp/page1.file" %>
				<table class="table table-hover table-light">
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
				<div id="non-edit" style="font-size:25px;">
					請選擇桌位以編輯
				</div>
				<form style="display:none" id="editTableForm" method="post" action="<%=request.getContextPath()%>/tables/tables.do">
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
	

<!--  magic button -->
<div style="position: fixed;left:0;bottom:0">
<form method="post" action="<%=request.getContextPath()%>/tables/tables.do">		
<input type="hidden" name="tbl_size" value="2"> 
<input type="hidden" name="tbl_number" value="2"/>					
<input type="hidden" name="tbl_name" value="B"/>		
<button type="submit" style="width: 10px; height: 10px">4</button>				
<input type="hidden" name="action" value="insert">
<input type="hidden" name="vendor_no"	value="<%= vendor_no %>">
</form>

<form method="post" action="<%=request.getContextPath()%>/tables/tables.do">		
<input type="hidden" name="tbl_size" value="3"> 
<input type="hidden" name="tbl_number" value="2"/>					
<input type="hidden" name="tbl_name" value="C"/>		
<button type="submit" style="width: 10px; height: 10px">6</button>				
<input type="hidden" name="action" value="insert">
<input type="hidden" name="vendor_no"	value="<%= vendor_no %>">
</form>

<form method="post" action="<%=request.getContextPath()%>/tables/tables.do">		
<input type="hidden" name="tbl_size" value="4"> 
<input type="hidden" name="tbl_number" value="2"/>					
<input type="hidden" name="tbl_name" value="D"/>		
<button type="submit" style="width: 10px; height: 10px">8</button>				
<input type="hidden" name="action" value="insert">
<input type="hidden" name="vendor_no"	value="<%= vendor_no %>">
</form>

<form method="post" action="<%=request.getContextPath()%>/tables/tables.do">		
<input type="hidden" name="tbl_size" value="5"> 
<input type="hidden" name="tbl_number" value="2"/>					
<input type="hidden" name="tbl_name" value="E"/>		
<button type="submit" style="width: 10px; height: 10px">10</button>				
<input type="hidden" name="action" value="insert">
<input type="hidden" name="vendor_no"	value="<%= vendor_no %>">
</form>
</div>


	<script>		
		$(document).ready(function(){
			$("#fgiTblNum").inputSpinner($("#html2"));
		});	    
	</script>
	
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
        	

            // 修改資料
            $(".tblObj").on('click', function() {
            	$("#non-edit").hide();
            	$("#editTableForm").show();
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
	<%@ include file="/ord_jsp/navbar/side_navbar_js.txt" %>	
  </body>
</html>