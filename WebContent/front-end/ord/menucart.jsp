<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="com.restaurant_menu.model.*,java.util.* "%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ page import="com.ord.model.*"%>
<%@ page import="com.restaurant_menu.model.*"%>

<jsp:useBean id="res_memuSvc" scope="page" class="com.restaurant_menu.model.Restaurant_MenuService" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>點餐車內容</title>


<!-- 		icon來源 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
    <!-- Custom styles for this template -->
   
    
   
    
<%--    <%@ include file="/front-end/header_footer/header_css.txt" %>  --%>

   
</head>
<body>
<%--  <%@ include file="/front-end/header_footer/header.txt" %> --%>

 <% @SuppressWarnings("unchecked")
	Vector<Restaurant_MenuVO> cart = (Vector<Restaurant_MenuVO>) session.getAttribute("shoppingcart");
%>
<c:set var="total" value="${total}"/>

<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-6 order-md-2 mb-4">
      <h4 class="d-flex justify-content-between align-items-center mb-3">
     
        <span class="text-muted">點餐車</span>
       
	<%if (cart != null && (cart.size() > 0)) {%>
	<%	 for (int index = 0; index < cart.size(); index++) {
						 Restaurant_MenuVO order = cart.get(index);
	%>
      </h4>
      <ul class="list-group mb-3">
        <li class="list-group-item d-flex justify-content-between lh-condensed">
          <div>
          <div class="col-xs-4">
            <h6 class="my-0"><%=order.getMenu_name()%></h6>
            <small class="text-muted">Brief description</small>
            </div>
          </div>
          <div class="col-2">
           <span class="text-muted"><%=order.getQuantity()%>份</span>
           </div>
          <span class="text-muted">$<%=order.getMenu_price()%></span>
          <form name="" action="<%=request.getContextPath()%>/ord/ord.do" method="get">
				  <input type="hidden" name="action"  value="DELETE_menu">
				  <input type="hidden" name="del" value="<%=index %>">
				<button type="submit"class="btn btn-link btn-xs">
				<i class="far fa-trash-alt fa-lg"></i>
				
				</button>	
			
		</form>
        </li>
        			<%}%><%}%>
       
      
        <li class="list-group-item d-flex justify-content-between">
          <span>Total (USD)</span>
          <h4><strong>$${total}</strong></h4>
        </li>
      </ul>
      <div class="row justify-content-center">
      <form name="checkoutForm" action="<%=request.getContextPath()%>/ord/ord.do" method="post">
              <input type="hidden" name="action"  value="checkout"> 			
		<button type="submit" class="btn btn-warning " style='font-size:24px'>付款結帳 <i class='fab fa-amazon-pay'></i></button>	
		</form>
		</div>
</div>

</div>
		
							
						
    </div>

</body>
<%--  <%@ include file="/front-end/header_footer/footer.txt" %> --%>
<%-- <%@ include file="/front-end/header_footer/footer_js.txt" %> --%>
</html>