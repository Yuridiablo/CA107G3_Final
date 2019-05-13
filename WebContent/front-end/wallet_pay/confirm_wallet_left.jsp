<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ page import="com.ord.model.*"%>
<%@ page import="com.restaurant_menu.model.*"%>
<%@ page import="com.vendor.model.*,java.util.* "%>
<!DOCTYPE html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v3.8.5">
    <title>會員錢包付款頁面1</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.3/examples/checkout/">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!-- Bootstrap core CSS -->
<link href="/docs/4.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


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
    <link href="form-validation.css" rel="stylesheet">
    
    <jsp:useBean id="MemSvc" scope="page" class="com.member.model.MemberService" />
    <jsp:useBean id="mem_walletSvc" scope="page" class="com.member_wallet_list.model.Member_Wallet_ListService" />
    
    
  </head>
  <body class="bg-light">
    <div class="container">
  
  <div class="row">
    <div class="col-md-4 order-md-2 mb-4">
      <h4 class="d-flex justify-content-between align-items-center mb-3">
        <span class="text-muted">點餐車</span>

      </h4>
      <ul class="list-group mb-3">
      <c:forEach var="rmVO" items="${shoppingcart}">
        <li class="list-group-item d-flex justify-content-between lh-condensed">
          <div>
            <h6 class="my-0">${rmVO.menu_name }</h6>
            <small class="text-muted">Brief description</small>
          </div>
           <span class="text-muted">${rmVO.quantity }份</span>
          <span class="text-muted">$${rmVO.menu_price }</span>
        </li>
      </c:forEach>
       
      
        <li class="list-group-item d-flex justify-content-between">
          <span>Total (USD)</span>
          <strong>$${total}</strong>
        </li>
      </ul>

     
    </div>
    
    <div class="col-md-8 order-md-1">
      <h4 class="mb-3"></h4>
     <form name="insert_by_wallet" action="<%=request.getContextPath()%>/ord/ord.do" method="get">>
       

        <h4 class="mb-3">我的錢包</h4>

        
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="cc-name">錢包餘額:</label>
            <input type="hidden" class="form-control" id="cc-name" placeholder="" required>
            <c:set var="mVO" value="${MemSvc.getOneMember('M000001') }"/>
           <br> <big class="text-muted">$${mVO.mem_balance }</big>
            <div class="invalid-feedback">
              Name on card is required
            </div>
          </div>
          <div class="col-md-6 mb-3">
            <label for="cc-number">扣款金額:</label>
            <input type="hidden" class="form-control" id="cc-number" placeholder="" required>
            <br> <big class="text-muted">$${total }</big>
            <div class="invalid-feedback">
                Name on card is required
            </div>
          </div>
        </div>
        
        <hr class="mb-5">
      
        <button class="btn btn-info btn-lg btn-block" type="submit">付款</button>
        <div><a href="http://www.stackoverflow.com/">
		    <button class="btn btn-warning btn-lg btn-block">去儲值</button>
		    <input type="hidden" name="mem_no" value="M000004">
			<input type="hidden" name="action" value="insert_by_wallet">
		</a> 
		</div>
      </form>
    </div>
  </div>

 
</div>
<script>

</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
      <script>window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"><\/script>')</script><script src="/docs/4.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
        <script src="form-validation.js"></script></body>
</html>