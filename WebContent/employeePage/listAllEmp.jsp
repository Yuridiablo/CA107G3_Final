
<%@page import="com.employee.model.EmployeeVO"%>
<%@ page import="java.util.*"%>
<%@page import="com.employee.model.EmployeeService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	List<EmployeeVO> list = null;
	if (request.getAttribute("list") == null) {
		EmployeeService employeeSvc = new EmployeeService();
		list = employeeSvc.getAll();
		pageContext.setAttribute("list", list);
	} else {
		EmployeeService employeeSvc = new EmployeeService();
		list = (List<EmployeeVO>) request.getAttribute("list");
	}
%>

<jsp:useBean id="feaSvc" scope="page" class="com.feature_detail.model.Feature_detailService"></jsp:useBean>

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
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12">
				<div class="col-12 row" id="buttonBar">
					<form method="post"
						action="${pageContext.request.contextPath}/employee/Employee.do">
						<input type="hidden" name="action" value="listAllEmp">
						<button type="submit" class="btn btn-outline-success buttonInTop"
							id="allEmp">所有員工</button>
					</form>
					<form method="post"
						action="${pageContext.request.contextPath}/employee/Employee.do">
						<button type="submit" class="btn btn-outline-success buttonInTop"
							name="action" value="addEmp">新增員工</button>
					</form>
					<form method="post">
						<button type="button" class="btn btn-outline-success buttonInTop"
							id="serchEmp">員工查詢</button>
					</form>
					<form method="post"
						action="${pageContext.request.contextPath}/employee/Employee.do">
						<div class="input-group mb-3 buttonInTop serchBar" id="serchBar">

							<input type="text" class="form-control" name="emp_name"
								placeholder="請輸入員工姓名" aria-label="Recipient's username"
								aria-describedby="button-addon2">
							<div class="input-group-append">
								<input type="hidden" name="action" value="listEmpByName">
								<button class="btn btn-outline-secondary" type="submit"
									id="button-addon2">送出</button>
							</div>
						</div>
					</form>
				</div>
				<table class="table table-striped table-dark">
					<thead>
						<tr>
							<th scope="col">員工編號</th>
							<th scope="col">員工姓名</th>
							<th scope="col">員工性別</th>
							<th scope="col">員工帳號</th>
							<th scope="col">員工密碼</th>
							<th scope="col">員工權限</th>
							<th scope="col">到職日</th>
							<th scope="col">離職日</th>
							<th scope="col">在職狀態</th>
							<th scope="col">去職</th>
							<th scope="col">修改資料</th>
						</tr>
					</thead>
					<tbody>
						<%@ include file="pagesForaEmp/page1.file"%>
						<c:forEach var="employeeVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
							<tr>
								<th scope="row">${employeeVO.emp_no}</th>
								<td>${employeeVO.emp_name}</td>
								<td>
									<c:choose>
										<c:when test="${employeeVO.emp_sex=='M'}"> 
											男
										</c:when>
										<c:otherwise>
											女
										</c:otherwise>
									</c:choose>
								</td>
								<td>${employeeVO.emp_acc}</td>
								<td>${employeeVO.emp_pwd}</td>
								<td>
									<c:set var="top" value="false"/>
									<c:set var="mid" value="false"/>
											<c:if test="${feaSvc.getOneFeature_detail(employeeVO.emp_no,'F002')!=null}">
												<c:set var="top" value="true"/>
													高
											</c:if>
									<c:if test="${top==false}">
												<c:if test="${feaSvc.getOneFeature_detail(employeeVO.emp_no,'F001')!=null}">
													<c:set var="mid" value="true"/>
														中
												</c:if>
									</c:if>
									<c:if test="${top==false&&mid==false}">
										低
									</c:if>
								</td>
								<td>${employeeVO.emp_hire}</td>
								<td>${employeeVO.emp_resign}</td>
								<td><c:choose>
										<c:when test="${employeeVO.emp_stat==1}"> 
											在職
										</c:when>
										<c:otherwise>
											離職
										</c:otherwise>
									</c:choose></td>
								<td>
									<form method="post"
										action="${pageContext.request.contextPath}/employee/Employee.do">
										<input type="hidden" name="action" value="resignEmp">
										<input type="hidden" name="emp_no"
											value="${employeeVO.emp_no}">
										<button type="submit" class="btn btn-outline-danger">確定</button>
									</form>
								</td>
								<td>
									<form method="post"
										action="${pageContext.request.contextPath}/employee/Employee.do">
										<input type="hidden" name="action" value="updateEmp">
										<input type="hidden" name="emp_no"
											value="${employeeVO.emp_no}">
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
				<%@ include file="pagesForaEmp/page2.file"%>

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