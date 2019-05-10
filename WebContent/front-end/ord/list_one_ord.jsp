<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ord.model.*"%>


${OrdVO}



<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



<!-- <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"> -->
<!-- <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script> -->

<head>
<style>
.hrr {
border:0;
background-color:#ff999;
height:1px

@media screen and (min-width:1025px){   
  .modal-dialog {
    
    left: auto;
    width: auto;
    padding-top: 30px;
    padding-bottom: 30px;
}
}

</style>


<meta charset="UTF-8">
<title>會員檢視即時訂單</title>
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
                
           
              
                 
			
			
               

                     <tr class="warning">
                        <td>${OrdVO.ord_no}</td>
						<td>${OrdVO.mem_no}<br>
						<hr><font color="blue">${OrdVO.share_mem_no1}<br></font>
						<hr><font color="blue">${OrdVO.share_mem_no2}</font></td>
						<td>${OrdVO.vendor_no}</td>
						<td>${OrdVO.tbl_no}</td>
						<td>${OrdVO.party_size}</td>
						
						<td>${OrdVO.share_amount}</td>
						<td>${OrdVO.ord_time}</td> 
						<td>${OrdVO.booking_date}</td> 
						<td>${OrdVO.booking_time}</td> 
						<td>${OrdVO.notes}</td> 
						<td>${OrdVO.total}</td> 
						<td>${OrdVO.arrival_time}</td> 
						<td>${OrdVO.finish_time}</td> 
						
						<c:if test ="${OrdVO.status==0}" var="xxx">
						<td>已付款</td> 
						</c:if>
						<c:if test ="${OrdVO.status==1}" var="xxx">
						<td>已用餐</td> 
						</c:if>
						<c:if test ="${OrdVO.status==2}" var="xxx">
						<td>已取消</td> 
						</c:if>
						
                    
			 
			<td>
			 <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/o_detail/o_detail.do" style="margin-bottom: 0px;">
			     <input type="submit" value="查看訂單明細">
			     <input type="hidden" name="ord_no"  value="${OrdVO.ord_no}">
			      <input type="hidden" name="menu_no" value="${O_detailVO.menu_no}">
			     <input type="hidden" name="action"	value="getOne_ord_detail_display"></FORM>
			     
			     <A href="<%=request.getContextPath()%>/comment/comment.do?ord_no=${OrdVO.ord_no}&action=insert_comments">發表評論</a>
<%-- 			      <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/o_detail/o_detail.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="評論"> -->
<%-- 			     <input type="hidden" name="ord_no"  value="${ordVO.ord_no}"> --%>
<%-- 			      <input type="hidden" name="vendor_no" value="${ordVO.vendor_no}"> --%>
<!-- 			     <input type="hidden" name="action"	value="insert_comments"></FORM> -->
			</td>
			</tr>
                   
                     </tbody>
                    </table>
                    
                
               
           
        </div>
    </div>
</div>



</body>
</html>