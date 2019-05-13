<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>所有菜單清單</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!-- 以下是 自訂的東西 -->
    <!-- 線條樣式 -->
    <link rel="stylesheet" type="text/css" href="../front-end/css/simple-line-icons.css">
    <!-- Icon資源池 -->
    <link rel="stylesheet" type="text/css" href="../front-end/css/themify-icons.css">
    <!-- 動態效果 -->
    <link rel="stylesheet" type="text/css" href="../front-end/css/set1.css">
    <!-- 自訂 CSS主檔 -->
    <link rel="stylesheet" type="text/css" href="../front-end/css/style.css">
    
    <!-- Script 注意載入順序 -->
    <script src="../front-end/js/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="../front-end/js/popper.min.js"></script>
    <!-- 貓頭鷹 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <style type="text/css">
    	body{
    		margin-top: 100px;
    		margin-bottom: 100px;
    		font-family:"微軟正黑體";
    	}
    	#service{
			width: 60px;
			height: 60px;
			border-radius: 30px;
			border: 2px #fff solid;
			background-color: #f36;
			line-height: 60px;
			font-size: 14px;
			color: #fff;
			text-align: center;
			position: fixed;
			top:85%;/*top用負的,因為每個div都被加上了margin,為求在所有裝置都能順利顯示不會被吃掉*/
			left: 88%;/*也可以把margin調成0,就可以正常的用top調整*/
			z-index: 999;/*設定顯示層級*/
			margin: 0;
			cursor: pointer;
		}
		 #chatSpace{
			width: 300px;
			height: 350px;
			border-radius:10px;
			border: 2px #fff solid;
			background-color: #fff;
			line-height: 60px;
			font-size: 14px;
			color: #fff;
			text-align: center;
			position: fixed;
			top:45%;/*top用負的,因為每個div都被加上了margin,為求在所有裝置都能順利顯示不會被吃掉*/
			left: 80%;/*也可以把margin調成0,就可以正常的用top調整*/
			z-index: 999;/*設定顯示層級*/
			margin: 0;
		}
		#service:hover{
			background-color: orange;
		}
		#chatTopic{
			border-bottom: 2px #DCDCDC solid;
			height:60px;
			margin-bottom:10px;
		}
		#chatBody{
			height:220px;
			resize: none;
    		box-sizing: border-box;
   			overflow: auto;
		}
		#chatInput{
 			height:50px; 
			overflow:auto;
			resize:none;
			line-height: 1.5;
		}
		#chatPannel{
 			height:0px; 
		}
		#message{
			color: #000;
			background-color: orange;
			border-bottom: 2px orange solid;
			border-radius: 15px;
			padding:5px;
			line-height:25px;
			width: 120px;
			word-break: break-all;
		}
		.img-group {
			width: 100% ;
			height: 45px;
			width: 45px;
			border-radius: 999em;
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
                                    <li class="nav-item active">
                                        <a class="nav-link" href="#">文章列表</a>
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
                                            <a class="dropdown-item" href="#"><span class="icon-user"></span>編輯個人資訊</a>
                                            <a class="dropdown-item" href="#"><span class="icon-people"></span>好友列表</a>
                                            <a class="dropdown-item" href="#"><span class="icon-people"></span>我的追蹤會員</a>
                                            <a class="dropdown-item" href="#"><span class="icon-like"></span>我的收藏店家</a>
                                   			<a class="dropdown-item" href="<%=request.getContextPath()%>/member/member.do?action=myOrder"><span class="icon-docs"></span>我的訂單</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/member/member.do?action=myWallet"><span class="icon-wallet"></span>我的錢包</a>
                                        </div>
                                    </li>
                                    <li><a href="#" class="btn btn-outline-light top-btn"><span class="icon-login"></span>登入</a></li>
                                    <li><a href="#" class="btn btn-outline-light top-btn"><span class="icon-logout"></span>登出</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--//END HEADER -->


  <!-- ==============================自己的div start====================== -->
	<div id="body">
	<%
		if (request.getAttribute("myWallet")!= null||request.getParameter("myWallet")!= null) {
	%>
		<jsp:include page="/member/memberWallet.jsp" />
	<%
		}
	%>
	
<c:if test="${not empty olist}">
<jsp:include page="/front-end/ord/list_for_mem.jsp" />
</c:if>

<c:if test="${not empty select_mVO}">
<jsp:include page="/member/mem_infoView.jsp" />
</c:if>
	
	
	<div id="service" onclick="connect();">線上客服</div>

	
	<div class="container" id="chatSpace" style="display:none">
		<div class="row">
			<div id="chatTopic" class="col-2">
				<img class="img-group" src="<%= request.getContextPath() %>/tools/OutImg.do?mem_no='${memberVO.mem_no}'">
			</div>
			<div id="chatTopic" class="col-8 text-left">
				<p style="color:black;font-weight:bold">${memberVO.mem_name}</p>
			</div>
			<div id="chatTopic" class="col-2">
				<button type="button" class="close" id="closeBut" aria-label="Close">
  					<span aria-hidden="true">&times;</span>
				</button>
			</div>
		</div>
			<div id="chatBody" class="col-12">
			</div>
		<div class="row">
			<textarea id="chatInput" class="col" placeholder="訊息"></textarea>
		</div>
		<div class="row">
			<div id="chatPannel" class="col"></div>
		</div>
	</div>










</div>











    

    <!-- ==============================自己的div end====================== -->

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
    </footer>
    <!--//END FOOTER -->

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->


    <!-- //標題橘色 所有頁面適用 載入樣式 -->
      
      <script>
        $(window).ready(function() {
            // 100 = The point you would like to fade the nav in.
                $('.fixed').addClass('is-sticky');
        });
    </script>
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		$("#service").on('click',function(){
    			$("#service").css('display','none');
    			$("#chatSpace").css('display','');
    		})
    		$('#chatInput').keydown(function(){
    			var input = $('#chatInput').val().trim();
    			if(event.keyCode == 13&&input!=""){
        			sendMessage();
    			}
    		})
    	    $("#closeBut").on('click',function(){
    	    	$("#chatSpace").css('display','none');
    	    	$("#service").css('display','');
    	    });
    	});
    </script>

    <!-- 以下Script只有首頁要用 捲動時標題橘色-->
    <!-- <script>
        $(window).scroll(function() {
            // 100 = The point you would like to fade the nav in.

            if ($(window).scrollTop() > 10) {

                $('.fixed').addClass('is-sticky');

            } else {

                $('.fixed').removeClass('is-sticky');

            };
        });
    </script> -->
    <!-- 貓頭鷹的自動捲動腳本 -->
    <script>
     var owl = $('.owl-carousel');
        owl.owlCarousel({
            items:1,
            loop:true,
            margin:10,
            autoplay:true,
            autoplayTimeout:5000,
            autoplayHoverPause:true
        });
    </script>
<!--   ======================================webSocket===========================================   -->
    <script>
    
    var MyPoint = "/FriendWS/${memberVO.mem_no}";
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
    
	var statusOutput = document.getElementById("statusOutput");
	var webSocket;
	
	function connect() {
		
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			alert("open");
			var history = true;
			sendMessage(history);
		};

		webSocket.onmessage = function(event) {
	        var jsonObj = JSON.parse(event.data);
	        if(jsonObj.sender==='${memberVO.mem_no}'){
		        $("#chatBody").append(
		        		$('<div/>').addClass('row justify-content-end message_container').append($('<div/>').append($('<p/>').attr('id','message').html(jsonObj.message)))
		        		);
	        }else{
	        	 $("#chatBody").append(
	 	        		$('<div/>').addClass('row justify-content-start message_container').append($('<div/>').append($('<p/>').attr('id','message').html(jsonObj.message)))
	 	        		);
	        	 
	        }
	        $("#chatBody").scrollTop($("#chatBody")[0].scrollHeight);
		};

		webSocket.onclose = function(event) {
			updateStatus("WebSocket 已離線");
		};
	}
	
	
	
	function sendMessage(hisreceiver) {
		if(hisreceiver!=null){
			alert("send1");
			var jsonObj = {"type" : "history","sender" : "${memberVO.mem_no}","receiver" : "employee", "message" : "","name" : "${memberVO.mem_name}"};
			webSocket.send(JSON.stringify(jsonObj));
		}else{
		    var inputMessage = document.getElementById("chatInput");
		    var message = inputMessage.value.trim();
		    var jsonObj = {"type" : "send","sender" : "${memberVO.mem_no}","receiver" : "employee", "message" : message,"name" : "${memberVO.mem_name}"};
		    webSocket.send(JSON.stringify(jsonObj));
		    inputMessage.value = "";
		    inputMessage.focus();
		}
	    
	}

	
	function disconnect () {
		webSocket.close();
	}


</script>
<!--   ======================================webSocket===========================================   -->
    
 
</body>
</html>