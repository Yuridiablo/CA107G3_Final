<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ page import="com.ord.model.*"%>
<%@ page import="com.restaurant_menu.model.*"%>
<%@ page import="com.vendor.model.*,java.util.* "%>

 <jsp:useBean id="MemSvc" scope="page" class="com.member.model.MemberService" />
 <jsp:useBean id="mem_walletSvc" scope="page" class="com.member_wallet_list.model.Member_Wallet_ListService" />
 
<!DOCTYPE html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v3.8.5">
    <title>會員錢包付款頁面1</title>

   
    <!-- Bootstrap core CSS -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>

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
   
    
   
    
   <%@ include file="/front-end/header_footer/header_css.txt" %> 
  </head>
  <body class="bg-light">
  <%@ include file="/front-end/header_footer/header.txt" %>
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
     <form name="insert_by_wallet" action="<%=request.getContextPath()%>/ord/ord.do" method="post">
       
 
        <h4 class="mb-3">我的錢包</h4>

        
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="cc-name">錢包餘額:</label>
            <input type="hidden" class="form-control" id="cc-name" placeholder="" required>
            <c:set var="mVO" value="${MemSvc.getOneMember(mem_no) }"/>
           <br> <big class="text-muted">$${mVO.mem_balance }</big>
           <input type="hidden" name="mem_balance" id="mem_balance" value="${mVO.mem_balance }">
            <div class="invalid-feedback">
              Name on card is required
            </div>
          </div>
          <div class="col-md-6 mb-3">
            <label for="cc-number">扣款金額:</label>
            <input type="hidden" class="form-control" id="cc-number" placeholder="" required>
            <br> <big class="text-muted">$${total }</big>
            <input type="hidden" name="total" id="total" value="${total }">
            <div class="invalid-feedback">
                Name on card is required
            </div>
          </div>
        </div>
        
        <hr class="mb-5">
      
        <button class="btn btn-info btn-lg btn-block" type="submit" id="topay">付款</button>
        <div>
		    <input type="hidden" name="mem_no" value="${mem_no}">
			<input type="hidden" name="action" value="insert_by_wallet">
			
		
		</div>
      </form>
      		<form>
		    <button class="btn btn-warning btn-lg btn-block" type="submit" id="to_store">去儲值</button>
		    <div>
		    <input type="hidden" name="mem_no" value="${mem_no}">
			<input type="hidden" name="action" value="store_value">
			</div> 
			</form>
    </div>
  </div>

 
</div>
<script>

</script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
      
       </body>
 <script>

var tt= $("#total").val();
var mb=$("#mem_balance").val();
var mem_balance=parseInt(mb);
var total=parseInt(tt);
 $(document).ready(function(){
	if(total>mem_balance||typeof mem_balance=="null"){
		$("#topay").css('display','none'); 
		$("#store_value").css('display','none'); 
		 Swal.fire({
			  type: 'warning',
			  title: '非常抱歉.',
			  text: '您的錢包餘額不足,請前往儲值!', 
			
			})
		
	}
	
	if(${mem_no==null}){
		$("#topay").css('display','none'); 
		$("#to_store").css('display','none'); 
		 Swal.fire({
			  type: 'warning',
			  title: '非常抱歉.',
			  text: '您尚未登入,請回去登入!', 
			
			})
	}
 })
 </script>
 <%@ include file="/front-end/header_footer/footer.txt" %>
<%@ include file="/front-end/header_footer/footer_js.txt" %>
</html>
