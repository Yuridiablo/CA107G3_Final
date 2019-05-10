<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ page import="com.ord.model.*"%>
<%@ page import="com.restaurant_menu.model.*"%>
<%@ page import="com.vendor.model.*"%>


<!DOCTYPE html>
<html>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<jsp:useBean id="res_menuSvc" scope="page" class="com.restaurant_menu.model.Restaurant_MenuService" />
<jsp:useBean id="res_tboSvc" scope="page" class="com.reservation_table_ordered.model.Reservation_Table_OrderedService" />
<jsp:useBean id="rev_tSvc" scope="page" class="com.reservation_time.model.Reservation_TimeService" />
<jsp:useBean id="now" scope="page" class="java.util.Date" />
<jsp:useBean id="ordSvc" scope="page" class="com.ord.model.OrdService" />
<jsp:useBean id="exc_dateSvc" scope="page" class="com.exception_date.model.Exception_DateService" />
<jsp:useBean id="vendorSvc" scope="page" class="com.vendor.model.VendorService" />

<style type="text/css">
  
  .btn-product{
  width: 100%;
  }
  .label-info {
    background-color: #de5bb6;
}
.label{
	font-size: 100%;
}    
  </style>


<head>
<meta charset="UTF-8">
<title>訂餐</title>
</head>
<body>



<!------ Include the above in your HEAD tag ---------->

<div class="container">
    <div class="row ">
      <div class="col-md-12">
      <c:forEach var="menu_n" items="${res_menuSvc.getVendor('V000001')}">
      <form name="shopping" action="<%=request.getContextPath()%>/ord/ord.do" method="get">
            <div class="col-sm-6 col-md-6">
		        <div class="thumbnail" >
		          	<h4 class="text-center">
		          		<span class="label label-info">
		        			 <c:set var ="vendor" value="${vendorSvc.findByPK('V000001')}" />
		         					${vendor.v_name}
		         		 </span>
		         		 </h4>
		         		<img id="p${menu_n.menu_no}" src="<%= request.getContextPath()%>/ShowImg.do?menu_no='${menu_n.menu_no}'"/>
		         				 <div class="caption">
		           					<div class="row">
		              					<div class="col-md-6 col-xs-6">   
		               						<h3> ${menu_n.menu_name}</h3>
		              					</div>
		              					<div class="col-md-6 col-xs-6 price">
		               						<h3>$<label>${menu_n.menu_price}</label></h3>
		              					</div>
		            				</div>
		            			<p>${menu_n.menu_text}</p>
		           				 <div class="row">
		              				<div class="col-md-6">
<!-- 		                				<a class="btn btn-primary btn-product"><span class="glyphicon glyphicon-thumbs-up"></span> Like</a>  -->
		                				<input type="text" name="quantity" size="3"  class="btn btn-primary btn-product" placeholder="輸入數量"value=1>
		              				</div>
		              			<div class="col-md-6">
					                 <button type="submit" class="btn btn-success btn-product" value="Buy"><span class="glyphicon glyphicon-shopping-cart">Buy</span></button>
					               </div>
					            </div>
					            <p> </p>
					          </div>
					        </div>
					      </div>
					      
					    <input type="hidden" name="vendor_no" value="${vendor_no}">
						 <input type="hidden" name="vendor" value="${vendor.v_name}">
						<input type="hidden" name="menu_name" value="${menu_n.menu_name}">
						<input type="hidden" name="menu_price" value="${menu_n.menu_price}">
						<input type="hidden" name="menu_no" value="${menu_n.menu_no}">
						
<%-- 						<input type="hidden" name="quantity" value="${menu_n.quantity}"> --%>
					       <input type="hidden" name="action" value="ADD_menu">
					       
					      </form>
			      </c:forEach>
     
<!--             <div class="col-sm-6 col-md-4"> -->
<!--         <div class="thumbnail" > -->
<!--           <h4 class="text-center"><span class="label label-info">Nokia</span></h4> -->
<!--           <img src="http://placehold.it/650x450&text=Lumia 1520" class="img-responsive"> -->
<!--           <div class="caption"> -->
<!--             <div class="row"> -->
<!--               <div class="col-md-6 col-xs-6"> -->
<!--                 <h3>Lumia 1520</h3> -->
<!--               </div> -->
<!--               <div class="col-md-6 col-xs-6 price"> -->
<!--                 <h3> -->
<!--                 <label>$749.00</label></h3> -->
<!--               </div> -->
<!--             </div> -->
<!--             <p>32GB, 4GB Ram, 1080HD, 6.3 inches, WP 8</p> -->
<!--             <div class="row"> -->
<!--               <div class="col-md-6"> -->
<!--                 <a class="btn btn-primary btn-product"><span class="glyphicon glyphicon-thumbs-up"></span> Like</a>  -->
<!--               </div> -->
<!--               <div class="col-md-6"> -->
<!--                 <a href="#" class="btn btn-success btn-product"><span class="glyphicon glyphicon-shopping-cart"></span> Buy</a></div> -->
<!--             </div> -->

<!--             <p> </p> -->
<!--           </div> -->
<!--         </div> -->
<!--       </div> -->
            
        </div> 
   <%--      <jsp:include page="/ord/ord/shopcart.jsp" flush="true" /> --%>
 <div class="col-12">
   <%@ include file="/front-end/ord/shopcart.jsp"%>
</div>
  </div>
  
 
</div>




</body>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
</html>