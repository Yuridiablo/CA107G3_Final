<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ page import="com.ord.model.*"%>
<%@ page import="com.restaurant_menu.model.*"%>
<%@ page import="com.vendor.model.*"%>    

<!DOCTYPE html>

<html lang="en">

<jsp:useBean id="res_menuSvc" scope="page" class="com.restaurant_menu.model.Restaurant_MenuService" />
<jsp:useBean id="res_tboSvc" scope="page" class="com.reservation_table_ordered.model.Reservation_Table_OrderedService" />
<jsp:useBean id="rev_tSvc" scope="page" class="com.reservation_time.model.Reservation_TimeService" />
<jsp:useBean id="now" scope="page" class="java.util.Date" />
<jsp:useBean id="ordSvc" scope="page" class="com.ord.model.OrdService" />
<jsp:useBean id="exc_dateSvc" scope="page" class="com.exception_date.model.Exception_DateService" />
<jsp:useBean id="vendorSvc" scope="page" class="com.vendor.model.VendorService" />
  <head>
    <meta charset="utf-8">
 
    <title>訂餐</title>


    <!-- Bootstrap core CSS -->


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
      .text-center{
      	flex:warp;
      }
      .yourmenu{
      	display:flex;
      	flex-warp:wrap;
      }
      
      .yourmenu .card-body li{
      	height:100px;
      }
    </style>
    <!-- Custom styles for this template -->
   
     <%@ include file="/front-end/header_footer/header_css.txt" %> 
  </head>
  <body>
  <%@ include file="/front-end/header_footer/header.txt" %>
    
<c:set var="Vvo" value="${vendorSvc.findByPK(vendor_no)}"/>
<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  <h1 class="display-4" >${ Vvo.v_name}</h1>
</div>

<div class="container ">
<div class="row">
<div class="col-md-12 ">
	
<!-- ============================================================================= -->
	 
		<div class="yourmenu d-flex flex-wrap">
		<c:forEach var="menu_n" items="${res_menuSvc.getVendor(vendor_no)}">
		<div class="col-md-4">
			<form name="shopping" action="<%=request.getContextPath()%>/ord/ord.do" method="get">			 
						 
						   
						  <div class="card-deck mb-12 text-center">
						
							    <div class="card mb-4 shadow-sm">
							      <div class="card-header">
							        <h4 class="my-0 font-weight-normal"> ${menu_n.menu_name}</h4>
							      </div>
							      <div class="card-body">
							      <img id="p${menu_n.menu_no}" src="<%= request.getContextPath()%>/ShowImg.do?menu_no='${menu_n.menu_no}'"/>
							        <h2 class="card-title pricing-card-title">$${menu_n.menu_price} <small class="text-muted"></small></h2>
							        <ul class="list-unstyled mt-3 mb-4">
							          <li>${menu_n.menu_text}</li>
							        </ul>
								        <div class="row">
									        <div class="col-md-6">
									        <input type="number" name="quantity" size="3"  class="btn btn-lg btn-outline-warning" placeholder="輸入數量"value="1">
									        </div>
									        <div class="col-md-6">
									        <button type="submit" class="btn btn-lg btn-block btn-warning" value="Buy"><span class="glyphicon glyphicon-shopping-cart">Buy</span></button>
									        </div>
								        </div>
							      </div> 
							    </div>
							 
						  </div>	
						  				
<input type="hidden" name="vendor_no" value="${vendor_no}">
<input type="hidden" name="vendor" value="${Vvo.v_name}">
<input type="hidden" name="menu_name" value="${menu_n.menu_name}">
<input type="hidden" name="menu_price" value="${menu_n.menu_price}">
<input type="hidden" name="menu_no" value="${menu_n.menu_no}">				
<input type="hidden" name="action" value="ADD_menu">
<%-- <input type="hidden" name="quantity" value="${menu_n.quantity}"> --%>

</form>
		 </div>
		  </c:forEach>  
	</div>	  
	
<!-- ========================================================================== -->
<%if (request.getAttribute("total")!=null){%>
       <jsp:include page="/front-end/ord/menucart.jsp" />
<%} %>
<%--   			<c:if test="${(total)>0}"> --%>
<%--      <jsp:include page="/front-end/ord/menucart.jsp" flush="true" /> --%>
<%-- <%--   	</c:if> --%> 
<%-- 			   <%@ include file="/front-end/ord/menucart.jsp"%> --%>
			
</div>
</div>
</div>
</body>
 <%@ include file="/front-end/header_footer/footer.txt" %>
<%@ include file="/front-end/header_footer/footer_js.txt" %> 
</html>
