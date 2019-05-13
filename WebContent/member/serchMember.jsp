<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- <!-- Bootstrap CSS -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" -->
<!-- 	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" -->
<!-- 	crossorigin="anonymous"> -->

<title>查詢會員</title>

<style type="text/css">
.all-group {
	height: 125px;
	border-bottom: 1px solid;
	border-color: #cef1f6;
}

.container {
	margin-top: 15px;
}




.img-group {
	width: 100% ;
	height: 90px;
	width: 90px;
	border-radius: 999em;
}

.detail-inner{
	text-align: left;
	padding-top: 10px;
	
}

#mem_nickname{
	margin-top: 10px;
}
.memberResult{
	height:800px;
}


</style>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center ">
			<div class="col-6 row justify-content-center memberResult ">
				<c:forEach var="memberVO" items="${memberVOList}">
					<div
						class="col-3 all-group img-container d-flex align-items-center justify-content-center">
<!-- 						<div class="img-inner"> -->
							<a href="<%=request.getContextPath()%>/search/search.do?action=meminfo&seletcted_mem=${memberVO.mem_no}">
								<img class="img-group"
								src="<%= request.getContextPath() %>/tools/OutImg.do?mem_no='${memberVO.mem_no}'">
							</a>
<!-- 						</div> -->
					</div>
					<div
						class="col-7 all-group deatil-container justify-content-center">
						<div class="detail-inner">
					
							${memberVO.mem_name}
							<p class="h6" id="mem_nickname" ><a href="<%=request.getContextPath()%>/search/search.do?action=meminfo&seletcted_mem=${memberVO.mem_no}">${memberVO.mem_nickname}</a></p>
							<p>${memberVO.mem_account}</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
<!-- 	<script -->
<!-- 		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" -->
<!-- 		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" -->
<!-- 		crossorigin="anonymous"></script> -->

</body>
</html>