<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

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
                
                        <div class="customer-review_wrap">
                            <div class="customer-img">
                                <img  class="img-fluid resultpic" onerror="this.src='../front-end/images/SeeKFoodA.png'" alt="#" src="<%= request.getContextPath()%>/ShowImg.do?vendor_no='${vcVO.key.vendor_no}'&pic=1">
                                <p>${vcVO.key.v_name}</p>
                                <span>35 Reviews</span>
                            </div>
                            <div class="customer-content-wrap">
                                <div class="customer-content">
                                    <div class="customer-review">
                                        <h6>Best noodles in the Newyork city</h6>
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                        <span class="round-icon-blank"></span>
                                        <p>Reviewed 2 days ago</p>
                                    </div>
                                    <div class="customer-rating">8.0</div>
                                </div>
                                <p class="customer-text">
                                ${vcVO.value.cmnt}
                                </p>
                                
                                <ul>
                                    <li><img src="images/review-img1.jpg" class="img-fluid" alt="#"></li>
                                    <li><img src="images/review-img2.jpg" class="img-fluid" alt="#"></li>
                                    <li><img src="images/review-img3.jpg" class="img-fluid" alt="#"></li>
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



     
</body>

</html>
