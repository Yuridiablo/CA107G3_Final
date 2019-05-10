<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ord.model.*"%>


<%
	OrdService ordSvc = new OrdService();
    List<OrdVO> list = ordSvc.getAll();
    OrdVO ordVO = new OrdVO();
    pageContext.setAttribute("list",list);
%>

<style>
.hrr {
border:0;
background-color:#ff999;
height:1px
}

</style>

<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<html>
<head>



<meta charset="UTF-8">
<title>所有訂單查詢</title>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-12">
        <table class="table" id="xxx">
        <div class="alert alert-info">
               訂單列表</div>
            <div class="alert alert-success" style="display:none;">
                <span class="glyphicon glyphicon-ok"></span> Drag table row and change Order</div>
            
                
                    <tr>
                        <th><h4>訂單編號</h4></th>
						<th>會員編號<br><hr style="width: 90%; height: 1px; border: none; background-color: #282828"><font color="blue">分攤會員</font></th>
						<th>廠商編號</th>
						<th>卓位編號</th>
						<th>人數</th>
<!-- 						<th>分攤會員編號</th> -->
<!-- 						<th>分攤會員編號</th> -->
						<th>分攤金額</th>
						<th>訂單成立時間</th>
						<th>訂位日期</th>
						<th>訂位時間</th>
						<th>備註</th>
						<th>總金額</th>
						<th>開始用餐時間</th>
						<th>結束用餐時間</th>
						
						<th>訂單狀態</th>
                    </tr>
                
           
              
                 
			<%@ include file="page1.file" %>
			<c:forEach var="ordVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
               

                     <tr class="warning">
                        <td>${ordVO.ord_no}</td>
						<td>${ordVO.mem_no}<br>
						<hr><font color="blue">${ordVO.share_mem_no1}<br></font>
						<hr><font color="blue">${ordVO.share_mem_no2}</font></td>
						<td>${ordVO.vendor_no}</td>
						<td>${ordVO.tbl_no}</td>
						<td>${ordVO.party_size}</td>
						
						<td>${ordVO.share_amount}</td>
						<td>${ordVO.ord_time}</td> 
						<td>${ordVO.booking_date}</td> 
						<td>${ordVO.booking_time}</td> 
						<td>${ordVO.notes}</td> 
						<td>${ordVO.total}</td> 
						<td>${ordVO.arrival_time}</td> 
						<td>${ordVO.finish_time}</td> 
						
						<c:if test ="${ordVO.status==0}" var="xxx">
						<td>已付款</td> 
						</c:if>
						<c:if test ="${ordVO.status==1}" var="xxx">
						<td>已用餐</td> 
						</c:if>
						<c:if test ="${ordVO.status==2}" var="xxx">
						<td>已取消</td> 
						</c:if>
						
                    
			  <td> 
			  <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/ord/ord.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="ord_no"  value="${ordVO.ord_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			 <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/o_detail/o_detail.do" style="margin-bottom: 0px;">
			     <input type="submit" value="查看訂單明細">
			     <input type="hidden" name="ord_no"  value="${ordVO.ord_no}">
			      <input type="hidden" name="menu_no" value="${O_detailVO.menu_no}">
			     <input type="hidden" name="action"	value="getOne_ord_detail_display"></FORM>
			</td>
			</tr>
                    </c:forEach>
                     </tbody>
                    </table>
                    
                  <%@ include file="page2.file" %>
               
           
        </div>
    </div>
</div>






<%--  <li><a href="<%= request.getContextPath() %>/ord/ord/addOrd.jsp">新增訂單</a> a new Emp.</li> --%>
<%-- <%-- 錯誤表列 --%>
<%-- <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<font style="color:red">請修正以下錯誤:</font> -->
<!-- 	<ul> -->
<%-- 		<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 			<li style="color:red">${message}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if> --%>

<!-- <table> -->
<!-- 	<tr> -->
<!-- 		<th>訂單編號</th> -->
<!-- 		<th>會員編號</th> -->
<!-- 		<th>廠商編號</th> -->
<!-- 		<th>卓位編號</th> -->
<!-- 		<th>人數</th> -->
<!-- 		<th>共同支付會員編號</th> -->
<!-- 		<th>共同支付會員編號</th> -->
<!-- 		<th>分攤金額</th> -->
<!-- 		<th>訂單成立時間</th> -->
<!-- 		<th>訂位日期</th> -->
<!-- 		<th>訂位時間</th> -->
<!-- 		<th>備註</th> -->
<!-- 		<th>總金額</th> -->
<!-- 		<th>開始用餐時間</th> -->
<!-- 		<th>結束用餐時間</th> -->
<!-- 		<th>驗證序號</th> -->
<!-- 		<th>訂單狀態</th> -->
		
<!-- 	</tr> -->
<%-- 	<%@ include file="page1.file" %>  --%>
<%-- 	<c:forEach var="ordVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"> --%>
		
<!-- 		<tr> -->
<%-- 			<td>${ordVO.ord_no}</td> --%>
<%-- 			<td>${ordVO.mem_no}</td> --%>
<%-- 			<td>${ordVO.vendor_no}</td> --%>
<%-- 			<td>${ordVO.tbl_no}</td> --%>
<%-- 			<td>${ordVO.party_size}</td> --%>
<%-- 			<td>${ordVO.share_mem_no1}</td>  --%>
<%-- 			<td>${ordVO.share_mem_no2}</td>  --%>
<%-- 			<td>${ordVO.share_amount}</td> --%>
<%-- 			<td>${ordVO.ord_time}</td>  --%>
<%-- 			<td>${ordVO.booking_date}</td>  --%>
<%-- 			<td>${ordVO.booking_time}</td>  --%>
<%-- 			<td>${ordVO.notes}</td>  --%>
<%-- 			<td>${ordVO.total}</td>  --%>
<%-- 			<td>${ordVO.arrival_time}</td>  --%>
<%-- 			<td>${ordVO.finish_time}</td>  --%>
<%-- 			<td>${ordVO.verif_code}</td>  --%>
<%-- 			<td>${ordVO.status}</td>  --%>
<!-- 			<td> -->
<%-- 			  <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/ord/ord.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="修改"> -->
<%-- 			     <input type="hidden" name="ord_no"  value="${ordVO.ord_no}"> --%>
<!-- 			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord/ord.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="刪除"> -->
<%-- 			     <input type="hidden" name="ord_no"  value="${ordVO.ord_no}"> --%>
<!-- 			     <input type="hidden" name="action" value="delete"></FORM> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<%-- 	</c:forEach> --%>
<!-- </table> -->
<%-- <%@ include file="page2.file" %> --%>

</body>
</html>