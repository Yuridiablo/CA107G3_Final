<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.vendor.model.*"%>



<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="author" content="Colorlib">
    <meta name="description" content="#">
    <meta name="keywords" content="#">
    <!-- Favicons -->
    <link rel="shortcut icon" href="#">
    <!-- Page Title -->
    <title>SeekFoodTable &amp; 搜尋結果</title>
    <!-- Bootstrap CSS -->
    <!-- 貓頭鷹 -->
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
     <!-- 星星圖庫來源樣式 -->
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../front-end/css/starrr.css">
</head>
<style type="text/css">
body{
font-family:"微軟正黑體";
}

.featured-place-wrap img {
    width: 30%;

    object-fit: cover;
}

.featured-responsive .img-fluid {
    height: 240px;
    width: 300px;
    object-fit: cover;
    margin-top: 1%;
}

.featured-place-wrap .media {
    margin: 30px 0 10px 0
}

.memshow{
	height:64px!important;
	width:64px!important;
	object-fit: fill;
}

.featured-title-box{
	width:35%;
	height:30%;

}
.featured-place-wrap a{
	display: inline;
	cursor: default;
}

.starbox{
    padding: 20px;
    box-sizing: border-box;
}

.nickname{
	background-color: #FF5722;
	color: #fff;
    display:inline-block;
}

.yourpick:hover{
	cursor: pointer;
}

/* Style the links inside the sidenav */
#mySidenav a {
  text-align: center;
  position: absolute; /* Position them relative to the browser window */
  left: -160px; /* Position them outside of the screen */
  transition: 0.3s; /* Add transition on hover */
  padding: 15px; /* 15px padding */
  width: 230px; /* Set a specific width */
  text-decoration: none; /* Remove underline */
  font-size: 26px; /* Increase font size */
  color: white; /* White text color */
  border-radius: 0 5px 5px 0; /* Rounded corners on the top right and bottom right side */
}

#mySidenav a:hover {
  left: 0; /* On mouse-over, make the elements appear as they should */
}

/* The about link: 20px from the top with a green background */
#backHome {
  top: 80px;
  background-color: #FF9800;
}

</style>

<body>
    <!--============================= DETAIL =============================-->

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modaltitle">菜單預覽</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">

<c:forEach var="rmVO" items="${rmlist}">
    <div style="display:none" class="item showfood ${rmVO.vendor_no}"><h4>${rmVO.menu_name}</h4></div>
</c:forEach>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="closemodal">關閉</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal End-->  
    
    <section>
        <div class="container-fluid">
            <div class="row">
           
                <div class="col-md-7 responsive-wrap">
                    <div class="row detail-filter-wrap">
                        <div class="col-md-7 featured-responsive">
                            <div class="detail-filter-text">
                            <form  METHOD="post" ACTION="<%=request.getContextPath()%>/Vendor/Vendor.do" >
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control" placeholder="輸入條件.." aria-label="Recipient's username" aria-describedby="button-addon2" name="v_name" id="text_vendor" >
                                    <div class="input-group-append">
                                    <input type="hidden" name="action" value="search">
                                    <input type="hidden" name="scoreSelect" value="0">
                                        <button class="btn btn-warning" type="submit" id="button-addon2"><span class="icon-magnifier search-icon"></span>再次搜尋</button>
                                        <p>${fn:length(searchMap)}個符合條件的結果 <span>於${fn:length(alllist)}間餐廳</span></p>
                                    </div>
                                </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-5 featured-responsive">
                            <div class="detail-filter">
                                <p>變更條件</p>
                                <form class="filter-dropdown"  METHOD="post" ACTION="<%=request.getContextPath()%>/Vendor/Vendor.do">
                                    <select class="custom-select mb-2 mr-sm-2 mb-sm-0" name="scoreSelect" id="scoreSelect">
                                        <option selected>評分高於</option>
                                        <option value="4">4</option>
                                        <option value="3">3</option>
                                        <option value="2">2</option>
                                        <option value="2">1</option>
                                    </select>
                                    <input type="hidden" name="action" value="search">
                                    <input type="hidden" name="v_name" id="outerTxt" value="${param.v_name}">
                                </form>
                                <form class="filter-dropdown">
                                    <select class="custom-select mb-2 mr-sm-2 mb-sm-0" id="rangeSelect">
                                        <option selected>距離我</option>
                                        <option value="1">5公里</option>
                                        <option value="2">10公里</option>
                                        <option value="6">30公里</option>
                                        <option value="12">30公里以上</option>
                                    </select>
                                </form>
                                <div class="map-responsive-wrap">
                                    <a class="map-icon" href="#"><span class="icon-location-pin"></span></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row detail-checkbox-wrap">
                 
                        <div class="col-12">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="#" tabindex="-1" aria-disabled="true">上頁</a>
                                    </li>
                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item"><a class="page-link" href="#">4</a></li>
                                    <li class="page-item"><a class="page-link" href="#">5</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">下頁</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>

<c:if test="${fn:length(searchMap) == 0}"><h2>查無結果，請重新操作！</h2></c:if>
<c:forEach var="sMap" items="${searchMap}">

<div id="mySidenav" class="sidenav">

  <a href="<%=request.getContextPath()%>/front-end/FrontPage.jsp" id="backHome">回首頁<span class="icon-home" style="float: right; text-align: right;"></span></a>
 
</div>
                    
                    <div class="container-fluid onerest">
                        <div class="col-12 featured-responsive" >
                            <div class="featured-place-wrap">
                                <div class="d-flex" id="big${sMap.key.vendor_no}">
                                <img  class="img-fluid resultpic" onerror="this.src='../front-end/images/SeeKFoodA.png'" alt="#" src="<%= request.getContextPath()%>/ShowImg.do?vendor_no='${sMap.key.vendor_no}'&pic=1">
                                                                        <span class="featured-rating-green">${sMap.value[0]}</span>
                                    <div class="featured-title-box">
                                        <h5><a class="yourpick" href="<%=request.getContextPath()%>/ord/ord.do?action=selected&vendor_no=${sMap.key.vendor_no}">${sMap.key.v_name}</a></h5>
                                        <p>${sMap.key.v_type} </p> <span>• </span>
                                        <p>${sMap.value[1]} 評論</p> <span> • </span>
                                        <p><span>$$$</span>$$</p>
                                        <ul>
                                            <li><span class="icon-location-pin"></span>
                                                <span>${sMap.key.v_ad_code}${sMap.key.v_address1}${sMap.key.v_address2}${sMap.key.v_address3}</span>
                                            </li>
                                            <li><span class="icon-screen-smartphone"></span>
                                                <p>${sMap.key.v_n_code}-${sMap.key.v_tel}</p>
                                            </li>
                                            <li><span class="icon-info"></span>
                                                <p>座位數：${sMap.key.v_tables}</p>
                                            </li>
                                        </ul>
                                        <div class="bottom-icons">
                                            <div class="open-now">營業中</div>
                                            <span class="ti-heart"></span>
                                            <span class="ti-share"></span>
                                        </div>
                                    </div>
                                    <div class="col-5">
                                        <div class="media">
                                        	
                                           <a class="yourpick" href="<%=request.getContextPath()%>/search/search.do?action=meminfo&seletcted_mem=${sMap.value[4]}">
                                           <img src="<%= request.getContextPath()%>/ShowImg.do?mem_no='${sMap.value[4]}'" class="mr-3 memshow" onerror="this.src='../front-end/images/dog.png'" alt="...">
                                           </a>
                                          
                                            <div class="media-body">
                                                <div class="nickname">${sMap.value[7]}</div>
                                                <h5 class="mt-0">
                                                <a class="yourpick" href="<%=request.getContextPath()%>/search/search.do?action=meminfo&seletcted_mem=${sMap.value[4]}">${sMap.value[6]}</a>
                                                </h5>
                                                ${sMap.value[2]}
                                            </div>
                                        </div>
                                        <c:if test="${ not empty sMap.value[3] }">
                                        <div class="starbox"><span style="font-size:20px">評分：</span><div class='starrr showstar' id="s${sMap.value[5]}"></div></div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
  
</c:forEach>

 


                    <div class="col-md-5 responsive-wrap map-wrap">
                        <div class="map-fix">
                            <!-- data-toggle="affix" -->
                            <!-- Google map will appear here! Edit the Latitude, Longitude and Zoom Level below using data-attr-*  -->
                            <div id="map" data-lat="24.969" data-lon="121.191" data-zoom="14"></div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
           
    </section>
    <!--//END DETAIL -->
    <!-- jQuery, Bootstrap JS. -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="../front-end/js/jquery-3.3.1.min.js"></script>
    <script src="../front-end/js/popper.min.js"></script>
	<!-- 星星 -->
    <script src="../front-end/js/starrr.js"></script>
    <!-- 貓頭鷹 -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script>
    $(".map-icon").click(function() {
        $(".map-fix").toggle();
    });
    </script>
    
    
   <script>

      var map;
      var service;
      var infowindow;

      function initMap() {
        var tibami = new google.maps.LatLng(24.9678012, 151.195);

        infowindow = new google.maps.InfoWindow();

        map = new google.maps.Map(
            document.getElementById('map'), {center: tibami, zoom: 10});

        searched();
  
      }
      
    
    </script>
    
     
		    <script>
		    

		    function searched(){
<c:forEach var="sMap" items="${searchMap}">  
		  	  var request${sMap.key.vendor_no} = {
		  	          query: '${sMap.key.v_address1}${sMap.key.v_address2}${sMap.key.v_address3}',
		  	          fields: ['name', 'geometry'],
		  	        };
		
		  	        service = new google.maps.places.PlacesService(map);
		
		  	        service.findPlaceFromQuery(request${sMap.key.vendor_no}, function(results, status) {
		  	          if (status === google.maps.places.PlacesServiceStatus.OK) {
		  	            for (var i = 0; i < results.length; i++) {
		  	              createMarker${sMap.key.vendor_no}(results[i]);
		  	            }
		
		  	            map.setCenter(results[0].geometry.location);
		  	          }
		  	        });
		  	        
		  	
		    }
		    
		
		    function createMarker${sMap.key.vendor_no}(place) {
		      var marker${sMap.key.vendor_no} = new google.maps.Marker({
		    	
		    	title: '${sMap.key.v_name}',
		        position: place.geometry.location,
		        draggable: false,
		        animation: google.maps.Animation.DROP
		        
		        
		      });
		
		   
		      
// 		      google.maps.event.addListener(marker${sMap.key.vendor_no}, 'click', function() {
// 		    	infowindow.setContent('${sMap.key.v_name}');
// 		        infowindow.open(map, this);	      
// 		      });
		      
		     
		      
		    
		      marker${sMap.key.vendor_no}.setMap(map);
		      
		      marker${sMap.key.vendor_no}.addListener('click', function() {
		          map.setZoom(13);
		          map.setCenter(marker${sMap.key.vendor_no}.getPosition());
		        });
		      

		      
		      $('#big${sMap.key.vendor_no}').mouseover(function(){
		      	console.log(marker${sMap.key.vendor_no});
 		      	map.setZoom(10);
		        map.setCenter(marker${sMap.key.vendor_no}.getPosition());
		        marker${sMap.key.vendor_no}.setAnimation(google.maps.Animation.BOUNCE);
		    	
		        $('#big${sMap.key.vendor_no}').mousedown(function(e){ 
		     	    if( e.button == 2 ) { 
		    			$('.${sMap.key.vendor_no}').show();
		    			$('#modaltitle').text('菜單預覽-' + '${sMap.key.v_name}')
		     	    }
		         })
		        

		      });
		      
		      $('#big${sMap.key.vendor_no}').mouseleave(function(){
			      	console.log(marker${sMap.key.vendor_no});
			   
			      	 marker${sMap.key.vendor_no}.setAnimation(null);
			      });
</c:forEach> 
 
 yourplace();
 
		    }

		    </script>

			<script type="text/javascript">
			
			function yourplace(){
				
				infoWindow = new google.maps.InfoWindow;
			    var test = null;
		        // Try HTML5 geolocation.
		        if (navigator.geolocation) {
		          navigator.geolocation.getCurrentPosition(function(position) {
		            var pos = {
		              lat: position.coords.latitude,
		              lng: position.coords.longitude
		            };

		            var marker = new google.maps.Marker({
		            	draggable: true,
	                    position: pos,
	                    icon: {
	                        path: google.maps.SymbolPath.CIRCLE,
	                        fillColor: '#0000b3',
	                        fillOpacity: 1,
	                        strokeColor: '#FFFFFF',
	                        strokeWeight: 2,
	                        scale: 10
	                     },
	                    map: map
	                });
		            
		            setInterval(function() {
			        	   if (marker.getOpacity() == 1) {
			        	      marker.setOpacity(0);
			        	   } else {
			        	      marker.setOpacity(1);
			        	   }
			        	}, 700);
		            
		            infoWindow.open(map);
		            map.setCenter(pos);
		            
		           
		            
		            function circlesize(radius) {   
		            		
		            var sunCircle = {

		                    strokeColor: "#4CAF50",
		                    strokeOpacity: 0.8,
		                    strokeWeight: 2,
		                    fillColor: "#4CAF50",
		                    fillOpacity: 0.25,
		                    map: map,
		                    center: pos,
		                    radius: radius // in meters
		          
		                };
		            if (test != null){
		            	test.setMap(null);
		            }
		            
		            cityCircle = new google.maps.Circle(sunCircle);
		            test =cityCircle;
		        
	                cityCircle.bindTo('center', marker, 'position');
	                
	                google.maps.event.addListener(marker, 'dragend', function() {
	                	
                	    //	抓取新的中心點
	                	var position = marker.getPosition()
	                	var lat = position.lat()
	                	var lng = position.lng()
	                	
	                	console.log(position);
	                	console.log(lat);
	                	console.log(lng);
	                	
	                	
	                	$.ajax({
	        	    		url: "<%=request.getContextPath()%>/MySearch",
	        	            type : 'post',
	        				data: { action: 'ajaxStatu', 
	        				menu_no:'${rmVO.menu_no}',
	        				menu_stat: 1},
	        				dataType: 'json',
	        				async : false,//同步請求
	        				cache : false,//不快取頁面
	        				
	        	    	})
	                });
	              }
		      
		        	$('#rangeSelect').change(function(){
		        	
		        		 
						  var rrr = $('#rangeSelect').val();
						  circlesize(rrr*5000);
						  circle.setMap(null);
					}); 
					      
		            
		            
		          }, function() {
		            handleLocationError(true, infoWindow, map.getCenter());
		          });
		        } else {
		          // Browser doesn't support Geolocation
		          handleLocationError(false, infoWindow, map.getCenter());
		        }
				
		        
			}
			
			
			
			</script>
			
			<script>
			$(function() {
			    $('#scoreSelect').change(function() {
			    	
			    	
			    	this.form.submit();
			    });
			});
			
			</script>
			

<c:forEach var="sMap" items="${searchMap}">    
    <script type="text/javascript">
    $('#s${sMap.value[5]}').starrr({
    	
    	max: 5,
    	rating:${sMap.value[3]},
    	readOnly: true,
    	emptyClass: 'fa fa-star-o',
        fullClass: 'fa fa-star'
        
      });
    

    
    </script>
</c:forEach>



    <script>
    $(document).ready(function(){ 
    	  document.oncontextmenu = function() {return false;};

    	  $(document).mousedown(function(e){ 
    	    if( e.button == 2 ) { 
    	    	$('#exampleModalCenter').modal('toggle');
    	      return false; 
    	    } 
    	    return true; 
    	  }); 
    	});
   	
    $('#exampleModalCenter').on('hidden.bs.modal', function () {
    	 $('.showfood').hide();
    	})
    
    </script>
    <!-- Map JS (Please change the API key below. Read documentation for more info) -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBYZhprf58VI160spKuA98fVS9AcSeVuVg&libraries=places&callback=initMap" async defer></script>
</body>

</html>