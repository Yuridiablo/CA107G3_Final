<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:useBean id="nSvc" scope="page" class="com.news.model.NewsService" />
<jsp:useBean id="commentSvc" scope="page" class="com.comments.model.CommentsService" />
<jsp:useBean id="vSvc" scope="page" class="com.vendor.model.VendorService" />
<jsp:useBean id="ordSvc" scope="page" class="com.ord.model.OrdService" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content=""> 
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->
 
    <!-- Title -->
    <title>SeekFoodTable - 首頁</title>
 
    <!-- Favicon --> 
    <link rel="icon" href="<%= request.getContextPath() %>/front-end/images/seekfood_AIy_icon.ico">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/front-end/herostyle.css">
    <!-- Bootstrap CSS -->
    <!-- 以下是 自訂的東西 -->
    <!-- 線條樣式 -->
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/front-end/css/simple-line-icons.css">
    <!-- Icon資源池 -->
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/front-end/css/themify-icons.css">
    <!-- 動態效果 -->
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/front-end/css/set1.css">
    <!-- 自訂 CSS主檔 -->
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/front-end/css/style.css">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/front-end/css/simple-line-icons.css">
    <!-- 自訂 CSS主檔 -->
    
 
    
    <style>
    .book-now-form form .form-group1{
    height:90px;
    background-color: rgba(255, 82, 82, 0.6);
    border: 2px solid #cb8670;
    border-right: 0px;
    }
    
     .book-now-form form .form-group2{
    height:90px;
    background-color: rgba(245, 124, 0, 0.6);
    border: 2px solid #cb8670;
    width:65%;
    }
    
    .book-now-form form button{
    background-color: rgba(245, 124, 0, 0.6);
    border: 2px solid #cb8670;
    border-left: 0px;
    height:90px;
    }
    
    .book-now-form form button:hover{
    background-color: rgba(245, 124, 0, 1);
    border: 2px solid #cb8670;
    border-left: 0px;
    height:90px;
    font-size:32px;
    }
    
    .searchbar{
    margin: 0 auto;
    float: none;
    display: block;
    width: 80%;
    }
    
    .memPicInner{
    	width: 35px;
    	height: 50px;
    }
    
    .quickPic h5, .quickPic p{
    	color:#FFF;
    }
    </style>
</head>

<body>
    <!-- Preloader -->
    <div class="preloader d-flex align-items-center justify-content-center">
        <div class="cssload-container">
            <div class="cssload-loading"><i></i><i></i><i></i><i></i></div>
        </div>
    </div>

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
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/Vendor/Vendor.do?action=search&v_position=north">北部</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/Vendor/Vendor.do?action=search&v_position=center">中部</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/Vendor/Vendor.do?action=search&v_position=south">南部</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/Vendor/Vendor.do?action=search&v_position=east">東部</a>
                                        </div>
                                    </li>
                                    <li class="nav-item dropdown">
                                        <a class="nav-link" href="#" id="navbarDropdownMenuLink1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            風格料理
                                            <span class="icon-arrow-down"></span>
                                        </a>
                                       <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/Vendor/Vendor.do?action=search&v_type=中式料理">中式料理</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/Vendor/Vendor.do?action=search&v_type=美式餐廳">美式餐廳</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/Vendor/Vendor.do?action=search&v_type=日式料理">日式料理</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/Vendor/Vendor.do?action=search&v_type=義式料理">義式料理</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/Vendor/Vendor.do?action=search&v_type=東南亞風味">東南亞風味</a>
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
                                       		<a class="dropdown-item" href="${pageContext.request.contextPath}/search/search.do?action=meminfo&seletcted_mem=${memberVO.mem_no}"><span class="icon-heart"></span>個人頁面</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/member/member.do?action=updateInFront"><span class="icon-user"></span>編輯個人資訊</a>
                                            <a class="dropdown-item" href="<%=request.getContextPath()%>/Friend_List/friend_list.do?action=myFriend"><span class="icon-people"></span>社交清單管理</a>
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

    <!--//END HEADER -->

    <!-- ##### Hero Area Start ##### -->
    <section class="hero-area">
        <div class="hero-slides owl-carousel">
        
        <c:set var="newsList" value="${nSvc.getAll()}" />
		   <c:set var="newsLength" value="${fn:length(newsList)}" />
		   <c:forEach var="news" items="${newsList}" begin="${newsLength-5}" end="${newsLength}">
			   <div class="single-hero-slide d-flex align-items-center justify-content-center">
	                <!-- Slide Img -->
	                <div class="slide-img bg-img" style="background-image: url(<%= request.getScheme() + "://" + request.getServerName() + ":" +request.getServerPort() +  request.getContextPath()%>/tools/OutImg.do?news_no=%27${news.news_no}%27),url('../front-end/images/otoro.jpg');"></div>
	                <div class="container">
	                
	          
	                    <div class="row justify-content-center">
	                        <div class="col-12 col-lg-9">
	                            <!-- Slide Content -->
	                            <div class="hero-slides-content" data-animation="fadeInUp" data-delay="100ms">
	                                <div class="line" data-animation="fadeInUp" data-delay="300ms"></div>
	                                <h2 data-animation="fadeInUp" data-delay="500ms">${news.news_cont}</h2>
	                                <p data-animation="fadeInUp" data-delay="700ms">${news.news_text}</p>
	                                <a href="#" class="btn palatin-btn mt-50" data-animation="fadeInUp" data-delay="900ms">前往主題</a>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
		   </c:forEach>

            <!-- Single Hero Slide -->
<!--             <div class="single-hero-slide d-flex align-items-center justify-content-center"> -->
<!--                 Slide Img -->
<%--                 <div class="slide-img bg-img" style="background-image: url(<%= request.getContextPath() %>/front-end/images/big1.jpg);"></div> --%>
<!--                 <div class="container"> -->
<!--                     <div class="row justify-content-center"> -->
<!--                         <div class="col-12 col-lg-9"> -->
<!--                             Slide Content -->
<!--                             <div class="hero-slides-content" data-animation="fadeInUp" data-delay="100ms"> -->
<!--                                 <div class="line" data-animation="fadeInUp" data-delay="300ms"></div> -->
<%--                                 <h2 data-animation="fadeInUp" data-delay="500ms">${nSvc.getOneNews("N001").news_cont}</h2> --%>
<%--                                 <p data-animation="fadeInUp" data-delay="700ms">${nSvc.getOneNews("N001").news_text}</p> --%>
<!--                                 <a href="#" class="btn palatin-btn mt-50" data-animation="fadeInUp" data-delay="900ms">前往主題</a> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->

<!--             Single Hero Slide -->
<!--             <div class="single-hero-slide d-flex align-items-center justify-content-center"> -->
<!--                 Slide Img -->
<%--                 <div class="slide-img bg-img" style="background-image: url(<%= request.getContextPath() %>/front-end/images/big2.jpg);"></div> --%>
<!--                 <div class="container"> -->
<!--                     <div class="row justify-content-center"> -->
<!--                         <div class="col-12 col-lg-9"> -->
<!--                             Slide Content -->
<!--                             <div class="hero-slides-content" data-animation="fadeInUp" data-delay="100ms"> -->
<!--                                 <div class="line" data-animation="fadeInUp" data-delay="300ms"></div> -->
<%--                                 <h2 data-animation="fadeInUp" data-delay="500ms">${nSvc.getOneNews("N002").news_cont}</h2> --%>
<%--                                 <p data-animation="fadeInUp" data-delay="700ms">${nSvc.getOneNews("N002").news_text}</p> --%>
<!--                                 <a href="#" class="btn palatin-btn mt-50" data-animation="fadeInUp" data-delay="900ms">前往主題</a> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->

<!--             Single Hero Slide -->
<!--             <div class="single-hero-slide d-flex align-items-center justify-content-center"> -->
<!--                 Slide Img -->
<%--                 <div class="slide-img bg-img" style="background-image: url(<%= request.getContextPath() %>/front-end/images/big3.jpg);"></div> --%>
<!--                 <div class="container"> -->
<!--                     <div class="row justify-content-center"> -->
<!--                         <div class="col-12 col-lg-9"> -->
<!--                             Slide Content -->
<!--                             <div class="hero-slides-content" data-animation="fadeInUp" data-delay="100ms"> -->
<!--                                 <div class="line" data-animation="fadeInUp" data-delay="300ms"></div> -->
<%--                                 <h2 data-animation="fadeInUp" data-delay="500ms">${nSvc.getOneNews("N003").news_cont}</h2> --%>
<%--                                 <p data-animation="fadeInUp" data-delay="700ms">${nSvc.getOneNews("N003").news_text}</p> --%>
<!--                                 <a href="#" class="btn palatin-btn mt-50" data-animation="fadeInUp" data-delay="900ms">前往主題</a> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->

        </div>
    </section>
    <!-- ##### Hero Area End ##### -->
    
<!-- ##### Book Now Area Start ##### -->
    <div class="book-now-area">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-10">
                    <div class="book-now-form">
                        <form id="searchbar" action="<%=request.getContextPath()%>/Vendor/Vendor.do">
                            <!-- Form Group -->
                            <div class="form-group1">
                                <label for="select1">類別選項</label>
                                <select class="form-control" id="selectFrom">
                                
                                  <option value="<%=request.getContextPath()%>/Vendor/Vendor.do">找餐廳</option>
                                  <option value="<%= request.getContextPath() %>/member/member.do">找會員</option>
                                  <option value="<%=request.getContextPath()%>/Article_Published/article_published.do">找文章</option>
                                  
                                </select>
                            </div>


                            <!-- Form Group -->
                            <div class="form-group2 input-group-lg">
							<!-- ↓↓↓	佔位置 不可移除 -->
                                <label for="select4"></label>
                               <input type="text" class="form-control searchbar" placeholder="輸入條件.." aria-label="Username" aria-describedby="basic-addon1" name="v_name" id="vv2">
                               <input type="text" class="form-control searchbar" placeholder="輸入條件.." aria-label="Username" aria-describedby="basic-addon1" name="mem_account_nickname" id="mm2">
                               <input type="text" class="form-control searchbar" placeholder="輸入條件.." aria-label="Username" aria-describedby="basic-addon1" name="art_content" id="aa2">
                            </div>
                            <input type="hidden" name="action" value="search" id="vv1">
                            <input type="hidden" name="flag" class="flag" value="">
                            <input type="hidden" name="scoreSelect" value="0" id="vv3">
						
                            <!-- Button -->
                            <button type="submit">立即查詢</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ##### Book Now Area End ##### -->
    
	<section class="main-block quickPic">
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
                                <img src="<%= request.getContextPath() %>/webWorking/images/zachariah-hagy-484664-unsplash.jpg" class="img-fluid img-center" alt="img13" id="hotp1" />
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
                                        <img src="<%= request.getContextPath() %>/webWorking/images/melissa-walker-horn-637092-unsplash.jpg" class="img-fluid img-center" id="hotp2" alt="img13" />
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
                                        <img src="<%= request.getContextPath() %>/webWorking/images/jason-leung-537357-unsplash.jpg" class="img-fluid img-center" id="hotp3" alt="img13" />
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
                                        <img src="<%= request.getContextPath() %>/webWorking/images/sabri-tuzcu-182962-unsplash.jpg" class="img-fluid img-center" id="hotp4" alt="img13" />
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
                                        <img src="<%= request.getContextPath() %>/webWorking/images/photo2.jpg" class="img-fluid img-center" id="hotp5" alt="img13" />
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
<!--                 <div class="col-md-4 featured-responsive"> -->
<!--                     <div class="featured-place-wrap"> -->
<!--                         <a href="detail.html"> -->
<%--                             <img src="<%= request.getContextPath() %>/webWorking/images/000J7RD0AACDCC23D13991j.jpg" class="img-fluid" alt="#"> --%>
<!--                             <span class="featured-rating-green">4.7</span> -->
<!--                             <div class="featured-title-box"> -->
<!--                                 <h6>大衛早午餐</h6> -->
<!--                                 <p>美式餐廳</p> <span>• </span> -->
<!--                                 <p>26 Reviews</p> <span> • </span> -->
<!--                                 <p><span>$$$</span>$$</p> -->
<!--                                 <div class="media"> -->
<%--                                     <img src="<%= request.getContextPath() %>/webWorking/images/4809.jpg" class="align-self-start mr-3" alt="..."> --%>
<!--                                     <div class="media-body"> -->
<!--                                         <h5 class="mt-0">我沒鼻子都覺得香</h5> -->
<!--                                         <p>555555555</p> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="bottom-icons"> -->
<!--                                     <div class="open-now">營業中</div> -->
<!--                                     <span class="ti-heart"></span> -->
<!--                                     <span class="ti-bookmark"></span> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!--                 </div> -->
                
<!--    ------------------------------------------------test-------------------------------------------------------- -->
				<c:set var="commList" value="${commentSvc.getAll()}" />
				<c:set var="commLength" value="${fn:length(commList)}" />
                <c:forEach var="comm" items="${commentSvc.getAll()}" begin="${commLength-3}" end="${commLength}">
                		<c:set var="vendor_no" value="${comm.vendor_no}" />
                         <c:set var="vendor" value="${vSvc.findByPK(vendor_no)}" />
                		<div class="col-md-4 featured-responsive">
                    <div class="featured-place-wrap">
                        <a href="${pageContext.request.contextPath}/Vendor/Vendor.do?action=search&v_name=${vendor.v_name}&commSearch=commSearch">
                        	<c:set var="ord_no" value="${comm.ord_no}" />
                        	<c:set var="mem_no" value="${ordSvc.getOneOrd(ord_no).mem_no}" />
                            <img src="<%= request.getContextPath()%>/ShowImg.do?vendor_no='${comm.vendor_no}'&pic=1" onerror="this.src='../front-end/images/SeeKFoodA.png'" class="img-fluid" alt="#">
                            <span class="featured-rating-green">${comm.score}</span>
                            <div class="featured-title-box">
                            	
                                <h6>${vendor.v_name}</h6>
                                <p>${vendor.v_type}</p> <span>• </span>
                                <p>26 Reviews</p> <span> • </span>
                                <p><span>$$$</span>$$</p>
                                <div class="media">
                                    <img src="<%= request.getContextPath() %>/tools/OutImg.do?mem_no='${mem_no}'" onerror="this.src='../front-end/images/dog.png'" class="align-self-start mr-3 memPicInner" alt="...">
                                    <div class="media-body">
                                    	<c:set var="commInner" value="${comm.cmnt}"></c:set>
                                    	<c:set var="commTopicIndex" value="${fn:indexOf(commInner,',')}"></c:set>
                                    	<c:set var="commTopic" value="${fn:substring(commInner, 0,commTopicIndex)}" />
                                        <h5 class="mt-0">${commTopic}</h5>
                                        <p>${commInner}</p>
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
                
                </c:forEach>
<!--    -------------------------------------------------test-------------------------------------------------------- -->                
                
<!--                 <div class="col-md-4 featured-responsive"> -->
<!--                     <div class="featured-place-wrap"> -->
<!--                         <a href="detail.html"> -->
<%--                             <img src="<%= request.getContextPath() %>/webWorking/images/1200_20180831131707.png" class="img-fluid" alt="#"> --%>
<!--                             <span class="featured-rating">2.3</span> -->
<!--                             <div class="featured-title-box"> -->
<!--                                 <h6>小木屋鬆餅</h6> -->
<!--                                 <p>甜點店</p> <span>• </span> -->
<!--                                 <p>17 Reviews</p> <span> • </span> -->
<!--                                 <p><span>$</span>$$$$</p> -->
<!--                                 <div class="media"> -->
<%--                                     <img src="<%= request.getContextPath() %>/webWorking/images/4809.jpg" class="align-self-start mr-3" alt="..."> --%>
<!--                                     <div class="media-body"> -->
<!--                                         <h5 class="mt-0">甜的東西很難吃</h5> -->
<!--                                         <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sunt impedit reiciendis saepe tempora sequi similique blanditiis quia ipsum accusamus perspiciatis!</p> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="bottom-icons"> -->
<!--                                     <div class="closed-now">休息中</div> -->
<!--                                     <span class="ti-heart"></span> -->
<!--                                     <span class="ti-bookmark"></span> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!--                 </div> -->
<!--                 <div class="col-md-4 featured-responsive"> -->
<!--                     <div class="featured-place-wrap"> -->
<!--                         <a href="detail.html"> -->
<%--                             <img src="<%= request.getContextPath() %>/webWorking/images/20180102-051047_U10834_M365289_a0da.jpg" class="img-fluid" alt="#"> --%>
<!--                             <span class="featured-rating-green">5.0</span> -->
<!--                             <div class="featured-title-box"> -->
<!--                                 <h6>吳師傅石頭火鍋</h6> -->
<!--                                 <p>中式餐廳</p> <span>• </span> -->
<!--                                 <p>1107 Reviews</p> <span> • </span> -->
<!--                                 <p><span>$$$$$</span></p> -->
<!--                                 <div class="media"> -->
<%--                                     <img src="<%= request.getContextPath() %>/webWorking/images/4809.jpg" class="align-self-start mr-3" alt="..."> --%>
<!--                                     <div class="media-body"> -->
<!--                                         <h5 class="mt-0">吃完學會了Java</h5> -->
<!--                                         <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi sunt porro, laboriosam dignissimos fugiat magnam obcaecati, quis quibusdam fuga odio.</p> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="bottom-icons"> -->
<!--                                     <div class="open-now">營業中</div> -->
<!--                                     <span class="ti-heart"></span> -->
<!--                                     <span class="ti-bookmark"></span> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!--                 </div> -->
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

   
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
    <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="<%= request.getContextPath() %>/front-end/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="<%= request.getContextPath() %>/front-end/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="<%= request.getContextPath() %>/front-end/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="<%= request.getContextPath() %>/front-end/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="<%= request.getContextPath() %>/front-end/js/active.js"></script>
	<!--sweet alert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<!--jquery cookie -->
    <script src="<%= request.getContextPath() %>/front-end/js/jquery/jquery.cookie.js"></script>
    
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
    
    <script>
    $(window).ready(function() {
    	
        // 100 = The point you would like to fade the nav in.
        $(".navbar").css("box-shadow", "none");
        $('#mm2').hide();
		$('#aa2').hide();
        
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
    	
    	$(".img-center").on('click',function(){
    		$(location).attr('href','${pageContext.request.contextPath}/Vendor/Vendor.do?action=search&randSearch=randSearch');
    	});
    	
    	
  
 //以下隨機產生flag亂數,塞進hidden的值,供controller辨識是否為重複提交   	
    	
  			var randomFlag = Math.floor(Math.random()*10000+1);
	  		$(".flag").val(randomFlag);
    });

    </script>
    <script>
	    document.getElementById('searchbar').selectFrom.onchange = function() {
	        var newaction = this.value;
	        document.getElementById('searchbar').action = newaction;
	    	if($('#selectFrom option:selected').text()=='找餐廳' ){
	    		$('#vv1').val('search');
	    		$('#mm2').hide();
	    		$('#aa2').hide();
	    		$('#vv2').show();
	    	} 
	    	if($('#selectFrom option:selected').text()=='找會員' ){
	    		$('#vv1').val('selectOneMember');
	    		$('#vv2').hide();
	    		$('#aa2').hide();
	    		$('#mm2').show();
	    	}
	    	if($('#selectFrom option:selected').text()=='找文章' ){
	    		$('#vv1').val('listArticle_PublishedByCompositeQuery');
	    		$('#vv2').hide();
	    		$('#mm2').hide();
	    		$('#aa2').show();
	    		$('#vv3').val('');
	    		$('.flag').val('');
	    	}
	    };
    	
	    
    </script>

		<c:if test="${account!=null}">
			<script>
				if($.cookie("helloMsg")!="seen"||${updatePwdRedirect!=null}){
					
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
			<% session.removeAttribute("updatePwdRedirect"); %>> 
		</c:if>
		
		<c:if test="${account==null}">
			<script>
	    		$.cookie("helloMsg", null);
			</script>
		</c:if>
 		
 	<c:if test="${not empty errorMsgs}">
		<c:forEach var="message" items="${errorMsgs}">
			<script type="text/javascript">
				if($.cookie("error")!="${flag}"){
					Swal.fire({
					 	 type: 'error',
					 	 title: 'Oops...',
					 	 text: '${message}',
					})
				}
			</script>
		</c:forEach>
			<script type="text/javascript">
				$.cookie("error", "${flag}");
			</script>
	</c:if>
</body>
</html>