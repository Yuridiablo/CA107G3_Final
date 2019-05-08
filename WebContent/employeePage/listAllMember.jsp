
<%@page import="com.member.model.MemberService"%>
<%@page import="com.member.model.MemberVO"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	List<MemberVO> list = null;
	if (request.getAttribute("list") == null) {
		MemberService memberSvc = new MemberService();
		list = memberSvc.getAll();
		pageContext.setAttribute("list", list);
	} else {
		MemberService memberSvc = new MemberService();
		list = (List<MemberVO>) request.getAttribute("list");
	}
%>

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
</style>
</head>

<body>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<div class="container ">
		<div class="row justify-content-center">
			<div class="col-12">
				<div class="col-12 row" id="buttonBar">
					<form method="post"
						action="${pageContext.request.contextPath}/employee/Employee.do">
						<input type="hidden" name="action" value="listAllMem">
						<button type="submit" class="btn btn-outline-success buttonInTop"
							id="allEmp">所有會員</button>
					</form>
					<form method="post">
						<button type="button" class="btn btn-outline-success buttonInTop"
							id="serchEmp">會員查詢</button>
					</form>
					<form method="post"
						action="${pageContext.request.contextPath}/employee/Employee.do">
						<div class="input-group mb-3 buttonInTop serchBar" id="serchBar">

							<input type="text" class="form-control" name="mem_account_name"
								placeholder="請輸入會員帳號或姓名" aria-label="Recipient's username"
								aria-describedby="button-addon2">
							<div class="input-group-append">
								<input type="hidden" name="action" value="listMemByName">
								<button class="btn btn-outline-secondary" type="submit"
									id="button-addon2">送出</button>
							</div>
						</div>
					</form>
				</div>
				<table class="table table-striped table-dark">
					<thead>
						<tr>
							<th scope="col">會員編號</th>
							<th scope="col">會員姓名</th>
							<th scope="col">會員暱稱</th>
							<th scope="col">會員帳號</th>
							<th scope="col">會員密碼</th>
							<th scope="col">會員電話</th>
							<th scope="col">會員帳戶餘額</th>
							<th scope="col">會員狀態</th>
							<th scope="col">修改會員</th>
						</tr>
					</thead>
					<tbody>
						<%@ include file="pagesForMem/page1.file"%>
						<c:forEach var="memberVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
							<tr>
								<th scope="row">${memberVO.mem_no}</th>
								<td>${memberVO.mem_name}</td>
								<td>${memberVO.mem_nickname}</td>
								<td>${memberVO.mem_account}</td>
								<td>${memberVO.mem_pwd}</td>
								<td>${memberVO.mem_tel}</td>
								<td>${memberVO.mem_balance}</td>
								<td>
									<c:choose>
										<c:when test="${memberVO.mem_status==1}"> 
											未認證
										</c:when>
										<c:when test="${memberVO.mem_status==2}"> 
											已認證
										</c:when>
										<c:otherwise>
											停權
										</c:otherwise>
									</c:choose>
								</td>
								<td>
								<form method="post"
										action="${pageContext.request.contextPath}/employee/Employee.do">
										<input type="hidden" name="action" value="updateMem">
										<input type="hidden" name="mem_no" value="${memberVO.mem_no}">
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
				<%@ include file="pagesForMem/page2.file"%>

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
		});
	</script>
</body>

</html>