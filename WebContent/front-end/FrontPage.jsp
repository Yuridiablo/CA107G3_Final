<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>


<html lang="en">

<head>
    <!-- jQuery, Bootstrap JS. -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 貓頭鷹 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!-- 以下是 自訂的東西 --> 
    <!-- 線條樣式 -->
       <!-- 線條樣式 -->
    <link rel="stylesheet" type="text/css" href="../front-end/css/simple-line-icons.css">
    <!-- Icon資源池 -->
    <link rel="stylesheet" type="text/css" href="../front-end/css/themify-icons.css">
    <!-- 動態效果 -->
    <link rel="stylesheet" type="text/css" href="../front-end/css/set1.css">
    <!-- 自訂 CSS主檔 -->
    <link rel="stylesheet" type="text/css" href="../front-end/css/style.css">
    
    
    
    <title>SeekFoodTable - 首頁</title>

    <style type="text/css">
        .slider {
          background: url(<%= request.getContextPath() %>/webWorking/images/ali-inay-9858-unsplash.jpg) no-repeat;
          background-size: cover;
            min-height: 1000px;
            opacity: 0.8;
        }
    </style>

</head>

<body>

    <!--============================= HEADER =============================-->
    <div class="nav-menu">
        <div class="bg transition">
            <div class="container-fluid fixed">
                <div class="row">
                    <div class="col-md-12">
                        <div class="navbar navbar-expand-lg navbar-light">
                            <a  href="<%=request.getContextPath()%>/front-end/FrontPage.jsp"><img src="../front-end/images/SeeKFoodA.png" id="logo" ></a>
                            <a class="navbar-brand" href="<%=request.getContextPath()%>/front-end/FrontPage.jsp">SeekFoodTable</a>
                            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="icon-menu"></span>
                            </button>
                            <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
                                <ul class="navbar-nav">
                                    <li class="nav-item dropdown">
                                        <a class="nav-link" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            城市美食
                                            <span class="icon-arrow-down"></span>
                                        </a>
                                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                            <a class="dropdown-item" href="#">北部</a>
                                            <a class="dropdown-item" href="#">中部</a>
                                            <a class="dropdown-item" href="#">南部</a>
                                        </div>
                                    </li>
                                    <li class="nav-item dropdown">
                                        <a class="nav-link" href="#" id="navbarDropdownMenuLink1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            風格料理
                                            <span class="icon-arrow-down"></span>
                                        </a>
                                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                            <a class="dropdown-item" href="#">中式料理</a>
                                            <a class="dropdown-item" href="#">美式餐廳</a>
                                            <a class="dropdown-item" href="#">日本料理</a>
                                            <a class="dropdown-item" href="#">義式料理</a>
                                            <a class="dropdown-item" href="#">東南亞風味</a>
                                        </div>
                                    </li>
                                                                       <li class="nav-item">
                                        <a class="nav-link" href="#">關於我們</a>
                                    </li>
                                    <li class="nav-item dropdown">
                                        <a class="nav-link" href="#" id="navbarDropdownMenuLink2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            會員管理
                                            <span class="icon-arrow-down"></span>
                                        </a>
                                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/member/member.do?action=updateInFront"><span class="icon-user"></span>編輯個人資訊</a>
                                            <a class="dropdown-item" href="#"><span class="icon-people"></span>社交清單管理</a>
                                            <a class="dropdown-item" href="<%=request.getContextPath()%>/Article_Published_JSP/manage_article_published.jsp"><span class="icon-like"></span>我的文章管理</a>
                                            <a class="dropdown-item" href="<%=request.getContextPath()%>/member/member.do?action=myOrder"><span class="icon-docs"></span>我的訂單</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/member/member.do?action=myWallet"><span class="icon-wallet"></span>我的錢包</a>
                                        </div>
                                    </li>
                                    <li><a href="#" class="btn btn-outline-light top-btn" id="loginButton"
											data-toggle="modal" data-target="#loginBar"><span id="icon-login" class="icon-login"></span>登入</a></li>
                                    <li><a href="${pageContext.request.contextPath}/member/member.do?action=logout" class="btn btn-outline-light top-btn" id="logoutButton"><span id="icon-logout" class="icon-logout"></span>登出</a></li>
                                	<li><a href="${pageContext.request.contextPath}/member/member.do?action=addMember" class="btn btn-outline-light top-btn" id="addButton"><span id="icon-logout" class="icon-logout"></span>註冊</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- SLIDER -->
    <section class="slider d-flex align-items-center">
        <!-- <img src="<%= request.getContextPath() %>/webWorking/images/slider.jpg" class="img-fluid" alt="#"> -->
        <div class="container">
            <div class="row d-flex justify-content-center">
                <div class="col-md-12">
                    <div class="slider-title_box">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="slider-content_wrap">
                                    <h1 id="bigtitle">SeekFoodTable</h1>
                                    <h5>發現你的美味時光</h5>
                                </div>
                            </div>
                        </div>
                        <div class="row d-flex justify-content-center">
                            <div class="col-md-5 mysearch">
                              
                                    <!-- 搜尋bar nav是上方換頁 按鈕有append的z-index是2 注意 -->
                                    <nav>
                                        <div class="nav nav-tabs nav-search" id="nav-tab" role="tablist">
                                            <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">搜餐廳</a>
                                            <a class="nav-item nav-link" id="nav-date-tab" data-toggle="tab" href="#nav-date" role="tab" aria-controls="nav-date" aria-selected="true">搜會員</a>
                                            <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">搜文章</a>
                                        </div>
                                    </nav>
                                    <div class="tab-content" id="nav-tabContent">
                                        <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                                        
                                        
                  	   <form  METHOD="post" ACTION="<%=request.getContextPath()%>/Vendor/Vendor.do" >                    
                                            <div class="input-group">
                                                <input type="text" class="form-control" placeholder="輸入餐廳名稱.." aria-label="Recipient's username" aria-describedby="button-addon2" name="v_name" id="text_vendor">
                                                <div class="input-group-append">
                                                <input type="hidden" name="scoreSelect" value="0">
                                              		 <input type="hidden" name="action" value="search">
                                                    <button class="btn btn-warning" type="submit" id="button-addon2"><span class="icon-magnifier search-icon"></span>搜餐廳GO</button>
                                                </div>
                                            </div>
                                            
                      </form>                 
                                            
                                        </div>
                                        <div class="tab-pane fade show" id="nav-date" role="tabpanel" aria-labelledby="nav-date-tab">
                                        
                                        
                         <form class="form-wrap mt-4" action="<%= request.getContextPath() %>/member/member.do">
                                        
                                            <div class="input-group">
                                                <input type="text" class="form-control" placeholder="輸入會員暱稱或帳號.." aria-label="Recipient's username" aria-describedby="button-addon2" name="mem_account_nickname">
                                                <div class="input-group-append">
                                                <input type="hidden" name="action" value="selectOneMember" >
                                                <input type="hidden" name="flag" id="flag" value="">
                                                    <button class="btn btn-success" type="submit" id="button-addon4"><span class="icon-magnifier search-icon"></span>找會員GO</button>
                                                </div>
                                            </div>
                                       
                                        
                                        
                                        </form>
                                         </div>
                                        <div class="tab-pane fade show" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                                          <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Article_Published/article_published.do">
                                            <div class="input-group">
                                                <input type="text"  class="form-control" placeholder="輸入文章標題或內文.." aria-label="Recipient's username" aria-describedby="button-addon2" name="art_content">
                                                <input type="hidden" name="action" value="listArticle_PublishedByCompositeQuery">
                                                <div class="input-group-append">
                                                    <button class="btn btn-primary" type="submit" id="button-addon3"><span class="icon-magnifier search-icon"></span>找文章GO</button>
                                                </div>
                                            </div>
                                            </FORM>
                                            
                                        </div>
                                    </div>
                             
                            </div>
                            <!-- 中間的廢物間隔 -->
                            <div class="col-md-1"></div>
                            <!-- 輪播廣告 -->
                            <div class="col-md-6 myad">
                                <div class="owl-carousel owl-theme">
                                    <div class="item">
                                        <h4>現在註冊新會員，就送優惠券!!</h4>
                                        <img src="<%= request.getContextPath() %>/webWorking/images/photo2.jpg">
                                    </div>
                                    <div class="item">
                                        <h4>謝師宴主題餐廳特惠中</h4>
                                        <img src="<%= request.getContextPath() %>/webWorking/images/photo3.jpg">
                                    </div>
                                    <div class="item">
                                        <h4>多久沒和姊妹淘一起聚餐？</h4>
                                        <img src="<%= request.getContextPath() %>/webWorking/images/melissa-walker-horn-637092-unsplash.jpg">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--// SLIDER -->
    <!--//END HEADER -->
    <!--============================= 主題快搜 =============================-->
    <section class="main-block">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class="styled-heading">
                        <h3>熱門推薦</h3>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="find-place-img_wrap">
                        <div class="grid">
                            <figure class="effect-ruby">
                                <img src="<%= request.getContextPath() %>/webWorking/images/zachariah-hagy-484664-unsplash.jpg" class="img-fluid" alt="img13" id="hotp1" />
                                <figcaption>
                                    <h5>謝師宴。精選</h5>
                                    <p>6451席</p>
                                </figcaption>
                            </figure>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="row find-img-align">
                        <div class="col-md-12">
                            <div class="find-place-img_wrap">
                                <div class="grid">
                                    <figure class="effect-ruby">
                                        <img src="<%= request.getContextPath() %>/webWorking/images/melissa-walker-horn-637092-unsplash.jpg" class="img-fluid" id="hotp2" alt="img13" />
                                        <figcaption>
                                            <h5>本月話題</h5>
                                            <p>612席</p>
                                        </figcaption>
                                    </figure>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="find-place-img_wrap">
                                <div class="grid">
                                    <figure class="effect-ruby">
                                        <img src="<%= request.getContextPath() %>/webWorking/images/jason-leung-537357-unsplash.jpg" class="img-fluid" id="hotp3" alt="img13" />
                                        <figcaption>
                                            <h5>日本料理</h5>
                                            <p>1249席</p>
                                        </figcaption>
                                    </figure>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="row find-img-align">
                        <div class="col-md-12">
                            <div class="find-place-img_wrap">
                                <div class="grid">
                                    <figure class="effect-ruby">
                                        <img src="<%= request.getContextPath() %>/webWorking/images/sabri-tuzcu-182962-unsplash.jpg" class="img-fluid" id="hotp4" alt="img13" />
                                        <figcaption>
                                            <h5>女孩最愛</h5>
                                            <p>917席</p>
                                        </figcaption>
                                    </figure>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="find-place-img_wrap">
                                <div class="grid">
                                    <figure class="effect-ruby">
                                        <img src="<%= request.getContextPath() %>/webWorking/images/photo2.jpg" class="img-fluid" id="hotp5" alt="img13" />
                                        <figcaption>
                                            <h5>健康樂活</h5>
                                            <p>242席</p>
                                        </figcaption>
                                    </figure>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--//END 主題快搜 -->
    <!--============================= 評價卡片 =============================-->
    <section class="main-block light-bg">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class="styled-heading">
                        <h3>最新評價</h3>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 featured-responsive">
                    <div class="featured-place-wrap">
                        <a href="detail.html">
                            <img src="<%= request.getContextPath() %>/webWorking/images/000J7RD0AACDCC23D13991j.jpg" class="img-fluid" alt="#">
                            <span class="featured-rating-green">4.7</span>
                            <div class="featured-title-box">
                                <h6>大衛早午餐</h6>
                                <p>美式餐廳</p> <span>• </span>
                                <p>26 Reviews</p> <span> • </span>
                                <p><span>$$$</span>$$</p>
                                <div class="media">
                                    <img src="<%= request.getContextPath() %>/webWorking/images/4809.jpg" class="align-self-start mr-3" alt="...">
                                    <div class="media-body">
                                        <h5 class="mt-0">我沒鼻子都覺得香</h5>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magni veritatis, repellendus earum assumenda error hic ratione beatae dolorem alias expedita.</p>
                                    </div>
                                </div>
                                <div class="bottom-icons">
                                    <div class="open-now">營業中</div>
                                    <span class="ti-heart"></span>
                                    <span class="ti-bookmark"></span>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-4 featured-responsive">
                    <div class="featured-place-wrap">
                        <a href="detail.html">
                            <img src="<%= request.getContextPath() %>/webWorking/images/1200_20180831131707.png" class="img-fluid" alt="#">
                            <span class="featured-rating">2.3</span>
                            <div class="featured-title-box">
                                <h6>小木屋鬆餅</h6>
                                <p>甜點店</p> <span>• </span>
                                <p>17 Reviews</p> <span> • </span>
                                <p><span>$</span>$$$$</p>
                                <div class="media">
                                    <img src="<%= request.getContextPath() %>/webWorking/images/4809.jpg" class="align-self-start mr-3" alt="...">
                                    <div class="media-body">
                                        <h5 class="mt-0">甜的東西很難吃</h5>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sunt impedit reiciendis saepe tempora sequi similique blanditiis quia ipsum accusamus perspiciatis!</p>
                                    </div>
                                </div>
                                <div class="bottom-icons">
                                    <div class="closed-now">休息中</div>
                                    <span class="ti-heart"></span>
                                    <span class="ti-bookmark"></span>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-4 featured-responsive">
                    <div class="featured-place-wrap">
                        <a href="detail.html">
                            <img src="<%= request.getContextPath() %>/webWorking/images/20180102-051047_U10834_M365289_a0da.jpg" class="img-fluid" alt="#">
                            <span class="featured-rating-green">5.0</span>
                            <div class="featured-title-box">
                                <h6>吳師傅石頭火鍋</h6>
                                <p>中式餐廳</p> <span>• </span>
                                <p>1107 Reviews</p> <span> • </span>
                                <p><span>$$$$$</span></p>
                                <div class="media">
                                    <img src="<%= request.getContextPath() %>/webWorking/images/4809.jpg" class="align-self-start mr-3" alt="...">
                                    <div class="media-body">
                                        <h5 class="mt-0">吃完學會了Java</h5>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi sunt porro, laboriosam dignissimos fugiat magnam obcaecati, quis quibusdam fuga odio.</p>
                                    </div>
                                </div>
                                <div class="bottom-icons">
                                    <div class="open-now">營業中</div>
                                    <span class="ti-heart"></span>
                                    <span class="ti-bookmark"></span>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-4">
                    <div class="featured-btn-wrap">
                        <a href="#" class="btn btn-warning">看更多評價</a>
                    </div>
                </div>
            </div>
                   <div class="modal fade" id="loginBar" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
			<input type="hidden" name="action" value="login">

				<div class="modal-body">
					<jsp:include page="/member/loginMember.jsp"></jsp:include>
				</div>

		</div>
			
			
			
		</div>
		</div>
        </div>
    </section>
    <!--//END 評價卡片 -->
    <!-- <h1>Hello, world!</h1> -->
    <!--============================= FOOTER =============================-->
    <footer class="main-block dark-bg">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="copyright">
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        <p>Copyright &copy; 2019 CA107G3. All rights reserved
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            <ul>
                                <li><a href="#"><span class="ti-email"></span></a></li>
                                <li><a href="#"><span class="ti-github"></span></a></li>
                                <li><a href="#"><span class="ti-android"></span></a></li>
                            </ul>
                    </div>
                </div>
            </div>
        </div>
<!--         =======================modal======================================== -->

	<!--         =======================modal======================================== -->
    </footer>
    <!--//END FOOTER -->
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="../front-end/js/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
    <script src="../front-end/js/popper.min.js"></script>
    <!-- 貓頭鷹 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <!-- //標題橘色 所有頁面適用 載入樣式 -->
    <!-- sweet alert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <!--   <script>
          $(window).ready(function() {
              // 100 = The point you would like to fade the nav in.
                  $('.fixed').addClass('is-sticky');
          });
      </script> -->
    <!-- 以下Script只有首頁要用 捲動時標題橘色-->
    <script>
    $(window).scroll(function() {
        // 100 = The point you would like to fade the nav in.

        if ($(window).scrollTop() > 10) {

            $('.fixed').addClass('is-sticky');

        } else {

            $('.fixed').removeClass('is-sticky');

        };
    });
    </script>
    <!-- 貓頭鷹的自動捲動腳本 -->
    <script>
    var owl = $('.owl-carousel');
    owl.owlCarousel({
        items: 1,
        loop: true,
        margin: 10,
        autoplay: true,
        autoplayTimeout: 5000,
        autoplayHoverPause: true
    });
    </script>
    <script>
    $(window).ready(function() {
    	
        // 100 = The point you would like to fade the nav in.
        $(".navbar").css("box-shadow", "none");
        
    });
    
    </script>
    
    <script type="text/javascript">
    $(document).ready(function(){
    	
    	$("#logoutButton").hide();
    	$("#navbarDropdownMenuLink2").hide();
    	
    	if(${account!=null}){
			$("#addButton").hide();
        	$("#loginButton").hide();
        	$("#logoutButton").show();
        	$("#navbarDropdownMenuLink2").show();
    	}
    	
    	

  
 //以下隨機產生flag亂數,塞進hidden的值,供controller辨識是否為重複提交   	
    	
 		var randomFlag = Math.floor(Math.random()*10000+1);
 		$("#flag").val(randomFlag);
//  		$("button").on('click',function(){
//  			$.cookie("error", null);
//  		});
 			
 		
    });

    </script>
</body>
		<c:if test="${account!=null}">
			<script>
				if($.cookie("helloMsg")!="seen"){
		    		Swal.fire({
						  position: 'center',
						  type: 'success',
						  title: '${memberVO.mem_name}您好',
						  showConfirmButton: false,
						  timer: 2500
						});
			    		$.cookie("helloMsg", "seen");
				}
			</script>
		</c:if>
		
		<c:if test="${account==null}">
			<script>
	    		$.cookie("helloMsg", null);
			</script>
		</c:if>
 		
 	<c:if test="${not empty errorMsgs}">
		<c:forEach var="message" items="${errorMsgs}">
			<script type="text/javascript">
				if($.cookie("error")!="${sessionScope.flag}"){
					Swal.fire({
					 	 type: 'error',
					 	 title: 'Oops...',
					 	 text: '${message}',
					})
				}
			</script>
		</c:forEach>
			<script type="text/javascript">
				$.cookie("error", "${sessionScope.flag}");
			</script>
	</c:if>
</html>