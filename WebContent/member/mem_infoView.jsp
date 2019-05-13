<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:useBean id="odSvc" class="com.ord_detail.model.Order_DetailService" />

<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../front-end/css/starrr.css">

<style>
.memshow{
	width:250px;
	height:250px;
	object-fit:cover;
}

.resultpic{
	width:100px;
	height:100px;
	object-fit:cover;
	border-radius: 0px !important;
}

.menushow{
	width:100px;
	height:100px;
	object-fit:cover;
	border-radius: 0px !important;
}

.showstar{
	margin-left:15%;
}

#totalcom{
    display: block;
}

</style>

</head>

<body>
    <!--============================= HEADER =============================-->
   
    <!--//END HEADER -->

    <!--============================= BOOKING DETAILS =============================-->
    <section class="light-bg booking-details_wrap">
        <div class="container">
            <div class="row">
                <div class="col-md-4 responsive-wrap">
                    <div class="follow">
                        <div class="follow-img">
                            <img src="<%= request.getContextPath()%>/ShowImg.do?mem_no='${select_mVO.mem_no}'" class="mr-3 memshow" onerror="this.src='../front-end/images/SeeKFoodA.png'" alt="...">
                            <h3>${select_mVO.mem_nickname}</h3>
                            <span>New York</span>
                        </div>
                        <ul class="social-counts">
                            <li>
                                <h6>${fn:length(selectmemOrd)}</h6>
                                <span>用餐經驗</span>
                            </li>
                            <li>
                                <h6>326</h6>
                                <span>追隨者</span>
                            </li>
                            <li>
                                <h6>12</h6>
                                <span>好友</span>
                            </li>
                        </ul>
                        <a href="#">FOLLOW</a>
                    </div>
                </div>
                <div class="col-md-8 responsive-wrap">
                    <div class="booking-checkbox_wrap mt-4">
                        <h5>${fn:length(vcMap)} 篇評論發表</h5>
                        <hr>
                        
<c:forEach var="vcVO" items="${vcMap}">      
<c:set var="txt" value="${vcVO.value.cmnt}"/>
<c:set var="vfotsub" value="${vcVO.key.v_name}"/>
                <div class='starrr showstar' id="s${vcVO.value.cmnt_no}"></div>
                        <div class="customer-review_wrap">
                            <div class="customer-img">
                                <img  class="img-fluid resultpic" onerror="this.src='../front-end/images/SeeKFoodA.png'" alt="#" src="<%= request.getContextPath()%>/ShowImg.do?vendor_no='${vcVO.key.vendor_no}'&pic=1">
                                <p><a class="yourpick" href="<%=request.getContextPath()%>/ord/ord.do?action=selected&vendor_no=${vcVO.key.vendor_no}">${fn:substring(vfotsub, 0, 6)}</a></p>
                                <span id="totalcom">${vcVO.key.v_address2}篇用餐回應</span>
                            </div>
                            <div class="customer-content-wrap">
                                <div class="customer-content">
                                    <div class="customer-review">
                                        
                                        
                                      
                                      
                                        <fmt:formatDate value="${vcVO.value.time}" pattern="yyyy-MM-dd hh:mm:ss"/>
                                        <h5>${fn:substringBefore(txt, "，")}</h5>
                                    </div>
                                    <div class="customer-rating">${vcVO.key.v_address3}</div>
                                </div>
                                <p class="customer-text">
                                ${vcVO.value.cmnt}
                                </p>
                              
                                <ul>
	 <c:forEach var="odVO" items="${odSvc.findbyOrd_no(vcVO.value.ord_no)}">     
                                    <li><img src="<%= request.getContextPath()%>/ShowImg.do?menu_no='${odVO.menu_no}'" class="mr-3 menushow" onerror="this.src='../front-end/images/SeeKFoodA.png'" alt="..."></li>
	 </c:forEach>    
                                </ul>
                            
<!--                                 <span>28 people marked this review as helpful</span> -->
<!--                                 <A HREF="#"><SPAN CLASS="ICON-LIKE"></SPAN>HELPFUL</A> -->
                            </div>
                           <hr>
                        </div>
                        
</c:forEach>                        
                        
                        
              	  </div>
      
            </div>
        </div>
        
        </div>
    </section>
    <!--//END BOOKING DETAILS -->
    <!--============================= FOOTER =============================-->

    <!--//END FOOTER -->
	<script src="../front-end/js/starrr.js"></script>
	<c:forEach var="vcVO" items="${vcMap}">    
    <script type="text/javascript">
    $('#s${vcVO.value.cmnt_no}').starrr({
    	
    	max: 5,
    	rating:${vcVO.value.score},
    	readOnly: true,
    	emptyClass: 'fa fa-star-o',
        fullClass: 'fa fa-star'
        
      });
    

    
    </script>
</c:forEach>

     
</body>

</html>
