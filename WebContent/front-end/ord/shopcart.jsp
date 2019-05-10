<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.restaurant_menu.model.*,java.util.* "%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ page import="com.ord.model.*"%>
<%@ page import="com.restaurant_menu.model.*"%>
<!DOCTYPE html>
<html>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>購物車內容檢視</title>
<jsp:useBean id="res_memuSvc" scope="page" class="com.restaurant_menu.model.Restaurant_MenuService" />
<style>
body {
	margin-top: 20px;
}
.input-sm {
    height: 35px;
    font-size: 16px;
    }

.btn-xs {
    font-size: 20px;
    padding: 6px 5px;
}

</style>
</head>
<body>


<div class="container">
	<div class="row">
		<div class="col-xs-8">
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">
						<div class="row">
							<div class="col-xs-6">
							 <% @SuppressWarnings("unchecked")
							   Vector<Restaurant_MenuVO> cart = (Vector<Restaurant_MenuVO>) session.getAttribute("shoppingcart");
							   String total =  (String) session.getAttribute("total");%>
							<%if (cart != null && (cart.size() > 0)) {%>
								<h5><span class="glyphicon glyphicon-shopping-cart"></span> ${param.vendor}</h5>
							</div>
							
						</div>
					</div>
				</div>
				<div class="panel-body">
				 <%
					 for (int index = 0; index < cart.size(); index++) {
						 Restaurant_MenuVO order = cart.get(index);
				%>
					<div class="row">
						<div class="col-xs-2">
						
						</div>
						<div class="col-xs-4">
							<h4 class="product-name"><strong><%=order.getMenu_name()%></strong></h4><h4><small>Product description</small></h4>
						</div>
						<div class="col-xs-6">
							<div class="col-xs-6 text-right">
								<h4><strong>$<%=order.getMenu_price()%><span class="text-muted">x</span></strong></h4>
							</div>
							<div class="col-xs-3">
<%-- 							<h4><strong><%=order.getQuantity()%> <span class="text-muted"></span></strong></h4> --%>
								<input type="text" class="form-control input-sm" value="<%=order.getQuantity()%>" disabled>
							</div>
							<div class="col-xs-2">
							 <form name="deleteForm" action="<%=request.getContextPath()%>/ord/ord.do" method="get">
				              <input type="hidden" name="action"  value="DELETE_menu">
				              <input type="hidden" name="del" value="<%=index %>">
								<button type="submit"class="btn btn-link btn-xs">
									<span class="glyphicon glyphicon-trash"> </span>
								</button>	
								
								
							</form>
								
							</div>
						</div>
					</div>
					<hr>
					<%}%>
					
					
				</div>
				<div class="panel-footer">
					<div class="row text-center">
						<div class="col-xs-9">
							<h4 class="text-right">Total <strong>$${total}</strong></h4>
						</div>
						<div class="col-xs-3">
						 <form name="checkoutForm" action="<%=request.getContextPath()%>/ord/ord.do" method="get">
              				<input type="hidden" name="action"  value="checkout"> 
							<input type="submit" value="付款結帳" class="btn btn-success btn-block">
							
							 </form>
							
						</div>
					</div>
				</div>
				<%}%>
			</div>
		</div>
	</div>
</div>

</body>
</html>