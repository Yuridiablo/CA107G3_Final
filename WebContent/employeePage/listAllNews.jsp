

<%@page import="com.employee.model.EmployeeService"%>
<%@page import="com.news.model.NewsService"%>
<%@page import="com.news.model.NewsVO"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	List<NewsVO> list = null;
	if (request.getAttribute("list") == null) {
		NewsService newsSvc = new NewsService();
		list = newsSvc.getAll();
		pageContext.setAttribute("list", list);
	} else {
		NewsService newsSvc = new NewsService();
		list = (List<NewsVO>) request.getAttribute("list");
	}
%>
<jsp:useBean id="employeeSvc" scope="page" class="com.employee.model.EmployeeService"/>

<!doctype html>
<html lang="en">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<title></title>
<style type="text/css">
.container {
	margin-top: 5px;
}

.buttonInTop {
	margin: 5px;
}

.serchBar {
	display: none;
}

.btn-default{
	background-color: #212121;
	color: white;
}

.submitbut{
	margin-top: 10px;
}

#addNews{
	height: 38px;
}

#output{
	width: 300px;
	height: 300px;
}

.newsInnerText{
	overflow:auto;
	resize:none;
	line-height: 1;
}			


</style>
</head>

<body>

	<div class="container ">
		<div class="row justify-content-center">
			<div class="col-12">
				<div class="col-12 row" id="buttonBar">
					<form method="post"
						action="${pageContext.request.contextPath}/employee/Employee.do">
						<input type="hidden" name="action" value="listAllNews">
						<button type="submit" class="btn btn-outline-success buttonInTop"
							id="allEmp">所有消息</button>
					</form>


						<button type="submit" class="btn btn-outline-success buttonInTop"
							data-toggle="modal" data-target="#modalForAddNews" id="addNews">新增消息</button>

					<form method="post">
						<button type="button" class="btn btn-outline-success buttonInTop"
							id="serchEmp">消息查詢</button>
					</form>
					<form method="post"
						action="${pageContext.request.contextPath}/employee/Employee.do">
						<div class="input-group mb-3 buttonInTop serchBar" id="serchBar">

							<input type="text" class="form-control" name="newsSerchValue"
								placeholder="輸入消息標號或員工姓名" aria-label="Recipient's username"
								aria-describedby="button-addon2">
							<div class="input-group-append">
								<input type="hidden" name="action" value="listNewsBySerch">
								<button class="btn btn-outline-secondary" type="submit"
									id="button-addon2">送出</button>
							</div>
						</div>
					</form>
				</div>
				<table class="table table-striped table-dark">
					<thead>
						<tr>
							<th scope="col">消息編號</th>
							<th scope="col">經手員工</th>
							<th scope="col">消息標題</th>
							<th scope="col">發布時間</th>
							<th scope="col">刪除</th>
						</tr>
					</thead>
					<tbody>
						<%@ include file="pagesForNews/page1.file"%>
						<c:forEach var="newsVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
							<tr>
								<th scope="row"><A href="${pageContext.request.contextPath}/employee/Employee.do?news_no=${newsVO.news_no}&action=getNewsPic&whichPage=${param.whichPage}">${newsVO.news_no}</A></th>
								<td>
									<c:forEach var="employeeVO" items="${employeeSvc.all}">
										<c:if test="${newsVO.emp_no==employeeVO.emp_no}">
											${employeeVO.emp_name}
										</c:if>	
									</c:forEach>
								</td>
								<td>${newsVO.news_cont}</td>
								<td>${newsVO.news_rea}</td>
								<td>
								<form method="post"
										action="${pageContext.request.contextPath}/employee/Employee.do">
										<input type="hidden" name="action" value="deleteNews">
										<input type="hidden" name="news_no" value="${newsVO.news_no}">
										<button type="submit" class="btn btn-outline-danger">確定</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
<!-- 				<div class="row justify-content-center"> -->
<!-- 					<div class="col-10"> -->
<!-- 						<div class="btn-toolbar d-flex justify-content-center" -->
<!-- 							role="toolbar" aria-label="Toolbar with button groups"> -->
<!-- 							<div class="btn-group mr-2 pagebut" role="group" -->
<!-- 								aria-label="First group"> -->
<!-- 								<a href="#link" class="btn btn-default" role="button">1</a> <a -->
<!-- 									href="#link" class="btn btn-default" role="button">2</a> <a -->
<!-- 									href="#link" class="btn btn-default" role="button">3</a> <a -->
<!-- 									href="#link" class="btn btn-default" role="button">4</a> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<%@ include file="pagesForNews/page2.file"%>

			</div>
		</div>
	</div>
<!-- 	============================modalForPic================================================= -->
<c:if test="${openModal!=null}">

<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
				
			<div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
			
			<div class="modal-body">
<!-- =================================================================================== -->
               <div class="container">
               	 	<div class="row">
               			<img src="${pageContext.request.contextPath}/tools/OutImg.do?news_no='${news_no}'" class="col">
               		</div>
               </div>
<!-- =================================================================================== -->
			</div>
			
		
		</div>
	</div>
</div>

 </c:if>
 <!-- 	============================modalForPic================================================= -->
<!-- 	=================================modalForAddNews============================================== -->
	
	<div class="modal fade" id="modalForAddNews" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
				
			<div class="modal-body">
			<form action="${pageContext.request.contextPath}/employee/Employee.do" method="post" id="my-form" enctype="multipart/form-data" >
			<input type="hidden" name="action" value="addNews">
<!-- =================================================================================== -->
        
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">消息標題 :</label>
            <input type="text" class="form-control" placeholder="輸入消息標題" id="recipient-name"
            name="news_cont">
            <input type="button" id="newsMsg">
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">消息內文 :</label>
            <textarea class="form-control newsInnerText" placeholder="輸入消息內文" id="recipient-name" name="news_text"></textarea>
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">消息圖片:</label>
           <input type="file" onchange="loadFile(event)" name="news_pic">
          </div>
           <div class="container">
               <div class="row">
               		<img src="" style="display:none" class="col" id="output">
               </div>
				<button type="submit" class="btn btn-warning col submitbut">確定送出</button>
           </div>
       
<!-- =================================================================================== -->
			</form>
			</div>


			 	
		</div>
	</div>
</div>

<!--        =============================test================================= -->
		
<!--        =============================test================================= -->

<!-- 	=================================modalForAddNews============================================== -->
	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#serchEmp").on('click', function() {
				$("#serchBar").removeClass('serchBar');
			});
			
			$("#allEmp").on('click', function() {
				$("#serchBar").addClass('serchBar');
			});
			
			$(".submitbut").css('display','none');
			
			$("#basicModal").modal({show: true});
			$('.modal').on('shown.bs.modal', function(){
			    var margin_vertical = parseInt( $(this).find('.modal-dialog').css('margin-top') ) + parseInt( $(this).find('.modal-dialog').css('margin-bottom') ) || 0;
			    var height_header   = parseInt( $(this).find('.modal-header').css('height') ) || 0;
			    var height_footer   = parseInt( $(this).find('.modal-footer').css('height') ) || 0;
			    var height_body     = ( window.innerHeight - height_header - height_footer - margin_vertical - 10 ) + 'px';
			    $(this).find('.modal-body').css('max-height', height_body).css('overflow', 'auto');
			});
			
			$("#newsMsg").on('click', function() {
				$("#recipient-name").val("好吃大咖哩");
				$(".newsInnerText").val("好吃大咖哩,天然食材加上精選醬料,吃過的都說讚,只要吃過一次保證你天天都會懷念這個好滋味,現在限時特價兩人同行還有優惠,優惠名額有限要來要快喔,好吃大咖哩等待您的光臨");
			});
		});
		var loadFile = function(e) {
			var output = document.getElementById('output');
			output.src = URL.createObjectURL(event.target.files[0]);
			$("#output").css('display','');
			$(".submitbut").css('display','');
		};
	</script>
</body>

</html>