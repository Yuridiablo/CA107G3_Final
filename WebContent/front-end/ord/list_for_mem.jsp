<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ord.model.*"%>
<%@ page import="com.member.model.*"%>



<%
// 	 String mem_no=(String)request.getAttribute("mem_no"); 
	 OrdService ordSvc = new OrdService();
//   List<OrdVO> list = ordSvc.findBymem_no(mem_no); 
//   List<OrdVO> list = ordSvc.findBymem_no("M000004");
//   OrdVO ordVO = new OrdVO();
   	 List<OrdVO> olist = (List<OrdVO>)request.getAttribute("olist");
%>



<html>
<meta name="viewport" content="width=device-width, initial-scale=1">




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
<jsp:useBean id="MemSvc" scope="page" class="com.member.model.MemberService" />
<jsp:useBean id="VendorSvc" scope="page" class="com.vendor.model.VendorService" />
<jsp:useBean id="ord_detailSvc" scope="page" class="com.ord_detail.model.Order_DetailService" />
<jsp:useBean id="commentSvc" scope="page" class="com.comments.model.CommentsService" />
<meta charset="UTF-8">
<title>會員全部訂單＋訂單明細</title>

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
                        
						<th>會員姓名<br><hr style="width: 90%; height: 1px; border: none; background-color: #282828"><font color="blue">分攤會員</font></th>
						<th>廠商名稱</th>
						<th>預定人數</th>
<!-- 						<th>分攤會員編號</th> -->
<!-- 						<th>分攤會員編號</th> -->
						<th>分攤金額</th>
						<th>訂單成立時間</th>
						<th>訂位日期</th>
						<th>訂位時間</th>
						<th>備註</th>
						<th>總金額</th>
<!-- 						<th>開始用餐時間</th> -->
<!-- 						<th>結束用餐時間</th> -->
						
						<th>訂單狀態</th>
                    </tr>
                
           
             
              
                 <c:set var="mem_no1" value="${ ordVO.share_mem_no1}"/>
                <c:set var="mem_no2" value="${ ordVO.share_mem_no2}"/>
  
                <% MemberService memsvc =new MemberService();
                String mem_no1 = (String)request.getAttribute("mem_no1");
                MemberVO memVO1=memsvc.getOneMember(mem_no1);
            	pageContext.setAttribute("memVO1",memVO1);
            	
                String mem_no2 = (String)request.getAttribute("mem_no2");
                MemberVO memVO2=memsvc.getOneMember(mem_no2);
            	pageContext.setAttribute("memVO2",memVO2);
                %>
                
			<%@ include file="pageForOrder.file" %>
			<c:forEach var="ordVO" items="${olist}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
                <c:set var="memVO" value="${MemSvc.getOneMember(memberVO.mem_no)}"></c:set>
                
                
                
                 <c:set var="vendorVO" value="${VendorSvc.findByPK(ordVO.vendor_no)}"></c:set>
				
						
                     <tr class="warning">
                        
						<td>${memberVO.mem_name}<br>
						<hr><font color="blue">${memVO1.mem_name}<br></font>
						<hr><font color="blue">${memVO2.mem_name}</font></td>
						<td>${vendorVO.v_name}</td>
<%-- 						<td>${ordVO.tbl_no}</td> --%>
						<td>${ordVO.party_size}</td>
						
						<td>$${ordVO.share_amount}</td>
						<td> <fmt:formatDate value="${ordVO.ord_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>${ordVO.booking_date}</td> 
						<td>${ordVO.booking_time}</td> 
						<td>${ordVO.notes}</td> 
						<td>$${ordVO.total}</td> 
<%-- 						<td>${ordVO.arrival_time}</td>  --%>
<%-- 						<td>${ordVO.finish_time}</td>  --%>
						
						<c:if test ="${ordVO.status==1}" var="xxx">
						<td>已付款</td> 
						</c:if>
						<c:if test ="${ordVO.status==2}" var="xxx">
						<td>已取消</td> 
						</c:if>
						<c:if test ="${ordVO.status==3}" var="xxx">
						<td>待付款</td> 
						</c:if>
						<c:if test ="${ordVO.status==4}" var="xxx">
						<td>已核銷</td> 
						</c:if>
						<c:if test ="${ordVO.status==5}" var="xxx">
						<td>已失效</td> 
						</c:if>
						
                    
			
			<td>
				 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/o_detail/o_detail.do" style="margin-bottom: 0px;">
			     <input type="submit" value="查看訂單明細">
			     <input type="hidden" name="ord_no"  value="${ordVO.ord_no}">
			     <c:set var="o_detailVOlist" value="${ord_detailSvc.findbyOrd_no(ordVO.ord_no)}" ></c:set>
							
			     <input type="hidden" name="action"	value="getOne_ord_detail_display"></FORM>
			     
			     <c:set var="cVO" value="${commentSvc.findByord_no(ordVO.ord_no)}"></c:set>
			     
			      <c:if test ="${ordVO.status==4}" var="xxx">
			      <c:if test ="${cVO==null}" var="yyy">
			     <A href="<%=request.getContextPath()%>/comment/comment.do?ord_no=${ordVO.ord_no}&action=insert_comments">發表評論</a>
<%-- 			      <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/o_detail/o_detail.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="評論"> -->
<%-- 			     <input type="hidden" name="ord_no"  value="${ordVO.ord_no}"> --%>
<%-- 			      <input type="hidden" name="vendor_no" value="${ordVO.vendor_no}"> --%>
<!-- 			     <input type="hidden" name="action"	value="insert_comments"></FORM> -->
				</c:if>
				</c:if>
			</td>
			</tr>
                    </c:forEach> 
                     </tbody>
                    </table>
                    
                  <%@ include file="page2.file" %>
               
           
        </div>
    </div>
</div>
<c:if test="${not empty openModal}">

<div class="modal fade" id="basic1" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
				
			<div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title" id="myModalLabel"></h3>
            </div>
			
			<div class="modal-body">
<!-- =========================================以下為原listOneEmp.jsp的內容========================================== -->
               <jsp:include page="/front-end/comments/insert_comments.jsp" />
<!-- =========================================以上為原listOneEmp.jsp的內容========================================== -->
			</div>
			
			<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
		
		</div>
	</div>
</div>

 <script>
         	
    $(window).on('load',function(){
    	$('#basic1').modal('show')
    });
    
</script>       

 </c:if>




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