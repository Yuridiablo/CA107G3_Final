
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="java.util.*"%>
<%@page import="com.restaurant_menu.model.*"%>

<jsp:useBean id="vVO" scope="session" class="com.vendor.model.VendorVO" />

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<meta charset="UTF-8">
<title>廠商後台-菜單管理</title>

<style>
img{
max-width:300px;
}
.resTitle {
	font-size: 30px;
	margin-left: 5%;
}

body {
	background-color: #eee;
	font-family: "微軟正黑體";
}

.col-4, .col-6{
 margin-top:1%;
}

#modal_submit{
margin-top:10px;
  display: block;
  margin-right: auto;
  margin-left: auto;
}

#upimg{
margin-top:10px;
  display: block;
  margin-right: auto;
  margin-left: auto;
}

</style>



</head>
<body>



<div class="container">
  <div class="row">
    <div class="col-12">
<%-- <button type="button" class="btn btn-warning justify-content-end" onclick="location.href='<%=request.getContextPath()%>/Restaurant_Menu/addMenu.jsp'">新增菜色</button> --%>
<button type="button" class="btn btn-warning justify-content-end btn-lg" data-toggle="modal" data-target="#menuCenter" style="margin:2%">新增菜色</button>
</div>
</div>
</div>

<!-- Modal**************************************************************************** -->
<div class="modal fade" id="menuCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
     <div class="modal-header">
              
                <label id="topicBar" class="col-12">菜單新增畫面</label>
            </div>
			
			<div class="modal-body">
<!-- ========================================BODY開始========================================== -->
              

<table id="table-1" data-toggle="table"
  data-url="data1.json"
  data-pagination="true"
  data-search="true">

</table>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Restaurant_Menu/Restaurant_Menu.do" name="form1" enctype="multipart/form-data" >
<table>

	<tr>
		<td>品名:</td>
		<td><input type="TEXT" name="menu_name" size="45"	value="${rmVO.menu_name}" /></td>
	</tr>
	<tr>
		<td>圖片:</td>
		<td><input type="file" name="menu_pic" id="menu_pic" onchange="changePic(event)" ></td>
	</tr>
	<tr>
		<td>價格:</td>
		<td><input type="TEXT" name="menu_price" size="45"	value="${rmVO.menu_price}" /></td>
	</tr>
	<tr>
		<td>狀態:</td>
<%-- 		<td><input type="TEXT" name="menu_stat" size="45"	value="${rmVO.menu_stat}" /></td> --%>
		<td>
		<select name="menu_stat">
		　<option value="1">上架</option>
		　<option value="2" selected>下架</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>說明:</td>
		<td><input type="TEXT" name="menu_text" size="45"	value="${rmVO.menu_text}" /></td>
	</tr>
	
</table>
<input type="hidden" name="action" value="insertOneFood">
<input type="hidden" name="vendor_no" value="${vendor_no}">
<%-- <input type="hidden" name="menu_no" value="${rmVO.menu_no}"> --%>
<input type="submit" value="送出" id="modal_submit">
</FORM>

<img src="" alt="" id="upimg">
              <c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
	<script>
    $(window).on('load',function(){
        $('#menuCenter').modal('show');
    });
</script>
	
</c:if>
              
              
<!-- =========================================BODY結束========================================== -->
			</div>
			
			<div class="modal-footer">
           
            </div>
      </div>
    </div>
  </div>
</div>

<!-- Modal結束*******************************************************  -->

<div class="container">
<div class="row">


<c:forEach var="rmVO" items="${rmlist}">


<div class="col-4">

 <div class="profile-img"><img id="p${rmVO.menu_no}" src="<%= request.getContextPath()%>/ShowImg.do?menu_no='${rmVO.menu_no}'" onerror="this.src='../front-end/images/SeeKFoodA.png'"/></div>
 
 </div>     

<fieldset  class="col-8" disabled id="dis${rmVO.menu_no}">
 

<div class="input-group mb-3">
  <div class="input-group-prepend">
 
      <input type="text" class="form-control input-group-text" aria-label="Username" aria-describedby="basic-addon1" value="${rmVO.menu_name}" id="name${rmVO.menu_no}">
  </div>
  <input type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon2" value="${rmVO.menu_price}" id="price${rmVO.menu_no}">
</div>

   
   <textarea class="form-control" id="txt${rmVO.menu_no}" rows="6">${rmVO.menu_text}</textarea>
  



</fieldset>

<div class="col-12 d-flex d-flex justify-content-end">
       <div class="btn-group" role="group" aria-label="Basic example"style="margin-bottom:2%" >
      <button type="button" class="btn btn-secondary pic" id="xx${rmVO.menu_no}">換圖</button>
      <button type="button" class="btn btn-secondary edit" id="yy${rmVO.menu_no}">編輯</button>
      <c:if test="${rmVO.menu_stat == 1}">
      <button type="button" class="btn btn-secondary updown" id="zz${rmVO.menu_no}">下架</button>
      </c:if>
       <c:if test="${rmVO.menu_stat == 2}">
      <button type="button" class="btn btn-secondary updown" id="zz${rmVO.menu_no}">上架</button>
      </c:if>
      
    </div>
</div>
</c:forEach>


</div>
 </div>






<c:forEach var="rmVO" items="${rmlist}">

<script type="text/javascript">
$("#xx${rmVO.menu_no}").click(async function(event) {
    
	const {value: file} = await Swal.fire({
	  title: '請選擇圖片',
	  input: 'file',
	  inputAttributes: {
	    'accept': 'image/*',
	    'aria-label': 'Upload your profile picture'
	  }
	})
	if (file) {
	  const reader = new FileReader
	  reader.onload = (e) => {
	    Swal.fire({
	      title: '圖片已變更為',
	      imageUrl: e.target.result,
	      imageAlt: 'The uploaded picture'
	      
	   
	    }).then(function(file){
	    	$.ajax({
	    		url: "<%=request.getContextPath()%>/Restaurant_Menu/Restaurant_Menu.do",
	            type : 'post',
				data: { action: 'upMenu', file: e.target.result , menu_no:'${rmVO.menu_no}'},
				dataType: 'json',
				async : false,//同步請求
				cache : false,//不快取頁面
				
	    	})
	    })
	    $('#p${rmVO.menu_no}').attr('src', e.target.result);
	  }
	  
	  reader.readAsDataURL(file)
	}
	})


</script>

<script type="text/javascript">
  
$("#yy${rmVO.menu_no}").click(function() {
	
	if($("#yy${rmVO.menu_no}").text() == '編輯'){		
		$("#yy${rmVO.menu_no}").text('完成')
		$("#yy${rmVO.menu_no}").css("background-color","green");
		$("#dis${rmVO.menu_no}").removeAttr('disabled');
		$("#name${rmVO.menu_no}").focus();

	


	} else {
		$("#yy${rmVO.menu_no}").text('編輯')
		$("#yy${rmVO.menu_no}").css("background-color","#6c757d");
		$("#dis${rmVO.menu_no}").attr('disabled', 'disabled');
			$.ajax({
	    		url: "<%=request.getContextPath()%>/Restaurant_Menu/Restaurant_Menu.do",
	            type : 'post',
				data: { action: 'ajaxUp', menu_no:'${rmVO.menu_no}',
					 menu_name: $("#name${rmVO.menu_no}").val(), 
					 menu_price: $("#price${rmVO.menu_no}").val(),
					 menu_text: $("#txt${rmVO.menu_no}").val()},
				dataType: 'json',
				async : false,//同步請求
				cache : false,//不快取頁面
				
	    	})

	}
  
})


</script>


<script type="text/javascript">
  
$("#zz${rmVO.menu_no}").click(function() {
  
  if($("#zz${rmVO.menu_no}").text() == '下架'){   
    $("#zz${rmVO.menu_no}").text('上架')
    $("#zz${rmVO.menu_no}").css("background-color","#FF5722");
    $("#p${rmVO.menu_no}").css("opacity",0.2);
      		$.ajax({
	    		url: "<%=request.getContextPath()%>/Restaurant_Menu/Restaurant_Menu.do",
	            type : 'post',
				data: { action: 'ajaxStatu', 
				menu_no:'${rmVO.menu_no}',
				menu_stat: 2},
				dataType: 'json',
				async : false,//同步請求
				cache : false,//不快取頁面
				
	    	})
//   alert( $("#zz${rmVO.menu_no}").text() );
  } else {
    $("#zz${rmVO.menu_no}").text('下架')
    $("#zz${rmVO.menu_no}").css("background-color","#6c757d");
    $("#p${rmVO.menu_no}").css("opacity",1);  
     		$.ajax({
	    		url: "<%=request.getContextPath()%>/Restaurant_Menu/Restaurant_Menu.do",
	            type : 'post',
				data: { action: 'ajaxStatu', 
				menu_no:'${rmVO.menu_no}',
				menu_stat: 1},
				dataType: 'json',
				async : false,//同步請求
				cache : false,//不快取頁面
				
	    	})
  }
  
})


</script>

<script type="text/javascript">

	$( document ).ready(function() {

		if($('#zz${rmVO.menu_no}').text() == '上架'){

			$('#zz${rmVO.menu_no}').css("background-color","#FF5722");
			$("#p${rmVO.menu_no}").css("opacity",0.2);
		}
       
    })

</script>



</c:forEach>




<!-- 秀圖的JS裝置 -->
<script type="text/javascript">
	function changePic(e) {		
		
		document.getElementsByTagName("img")[0].src = URL.createObjectURL(event.target.files[0]); 		
	}
</script>
</body>
</html>