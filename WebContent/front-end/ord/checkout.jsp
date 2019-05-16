<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ page import="com.ord.model.*"%>
<%@ page import="com.restaurant_menu.model.*"%>
<%@ page import="com.vendor.model.*,java.util.* "%>

<jsp:useBean id="vendorSvc" scope="page" class="com.vendor.model.VendorService" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>分攤或付款選擇</title>
<style>
.p2{
margin-right:60px;
}
</style>
<!-- icon -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">

<%@ include file="/front-end/header_footer/header_css.txt" %>
</head>
<body>
<%@ include file="/front-end/header_footer/header.txt" %>
<c:set var ="vendor" value="${vendorSvc.findByPK(vendor_no)}" />
<div class="container">
<div class="row justify-content-center">
<div class="card text-center" style="width: 50rem;">
  <div class="card-header">
		<div class="d-flex justify-content-between">
					<div class=" ">
		   					<address>
		 
		                        <strong>	${vendor.v_name}</strong>
		                        <br>
		                     <I>${vendor.v_address1}${vendor.v_address2}</I>
		                        <br>
		                       <I> ${vendor.v_address3}</I>
		                        <br>
		                        <P >P:${vendor.v_n_code}-${vendor.v_tel}</P> 
		                    </address>
		            </div>
		            <div class="p2">
		            		<h3 class="card-title">點餐明細</h3>
		            </div>
		            <div class="">
		                    <p>
		                        <em>Date: ${date}</em>
		                    </p>
		           </div>
		  </div>
  </div>
  
   
  <div class="card-header">
  <div class="d-flex justify-content-between">
  
    	<div><h4>餐點</h4></div>
       <div><h4>數量</h4></div>
       <div><h4>單價</h4></div>
  </div>
  </div>
  <div class="card-header">
  <table class="table-hover">
   <div class="d-flex justify-content-between">
    <%  @SuppressWarnings("unchecked")
		Vector<Restaurant_MenuVO> buylist = (Vector<Restaurant_MenuVO>) session.getAttribute("shoppingcart");
	%>	
	
	<c:set var="total" value="${total}"/>
	<%	for (int i = 0; i < buylist.size(); i++) {
		Restaurant_MenuVO menu = buylist.get(i);
		
			String vendor=menu.getMenu_no();
			
			String name = menu.getVendor_no();
			String menu_name = menu.getMenu_name();
			String menu_price = menu.getMenu_price();
			Integer quantity = menu.getQuantity();
	%>
  
  
  
  
  <tr>
  <td class="col-md-4" ><%= menu_name %></td>
  
  <td class="col-md-4" ><%=quantity %></td>
  
  <td class="col-md-4"><%= menu_price %></td>
  </tr>

  
   <%	}%>
  
   
</div>
  </table>
  </div>
 <div class="card-header ">
<div class="text-right"><h4><strong>Total: </strong> <strong class="text-center text-danger">${total}</strong></h4></div>

</div>                       

  <div class="card-footer text-muted">
 
<%-- 	                	<a href="<%=request.getContextPath()%>/front-end/ord/orderfood.jsp" > --%>
<!-- 							<button class="btn btn-success btn-lg btn-block" >繼續點餐<span class="fas fa-shopping-cart"></span></button> -->
<!-- 						</a> -->
					
					
					<form name="share" action="<%=request.getContextPath()%>/ord/ord.do" method="post">
					<input type="hidden" name="action" value="show_share">
					<button type="submit" class="btn btn-success btn-lg btn-block"> 分攤<span class="fas fa-users"></span> </button>
					</form>
					
					<form name="check" action="<%=request.getContextPath()%>/ord/ord.do" method="post">
					<button type="submit" class="btn btn-success btn-lg btn-block" id="pay"> 信用卡付款<span class="far fa-credit-card"></span></button>
						<input type="hidden" name="mem_no" value="${mem_no}">
<%-- 						<input type="hidden" name="mem_no" value="${mem_no}"> --%>
					<input type="hidden" name="action" value="tocredit">
					</form>
					
					<form name="check2" action="<%=request.getContextPath()%>/ord/ord.do" method="post">
					<button type="submit" class="btn btn-success btn-lg btn-block" id="pay"> 會員錢包付款<span class="far fa-money-bill-alt"></span></button>
						<input type="hidden" name="mem_no" value="${mem_no }">
<%-- 						<input type="hidden" name="mem_no" value="${mem_no}"> --%>
					<input type="hidden" name="action" value="to_wallet_pay">
					</form>
		          
  </div>
</div>
					<c:if test="${not empty errorMsgs}">
							<font style="color: red">請修正以下錯誤:</font>
							<ul>
								<c:forEach var="message" items="${errorMsgs}">
									<li style="color: red">${message}</li>
								</c:forEach>
							</ul>
						</c:if>	
	
</div>
<div >
      	
	<c:if test="${(share1234 )==3}">
     <jsp:include page="/front-end/ord/share_sel.jsp" flush="true" />
  	</c:if>
   </div>
</div>

   
     


<%@ include file="/front-end/header_footer/footer.txt" %>
<%@ include file="/front-end/header_footer/footer_js.txt" %>
</body>
</html>