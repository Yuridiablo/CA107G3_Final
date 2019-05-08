
<%@page import="com.employee.model.EmployeeVO"%>
<%@page import="java.util.List"%>
<%@page import="com.employee.model.EmployeeService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	if (request.getAttribute("list") == null) {
		EmployeeService employeeSvc = new EmployeeService();
		List<EmployeeVO> list = employeeSvc.getAll();
		pageContext.setAttribute("list", list);
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
</style>
</head>

<body>
	<div class="container ">
		<div class="row justify-content-center">
			<div class="col-12">
				<div class="col-12 row" id="buttonBar">
					<form method="post"
						action="${pageContext.request.contextPath}/employee/Employee.do">
						<input type="hidden" name="action" value="listAllEmp">
						<button type="submit" class="btn btn-outline-success buttonInTop"
							id="allEmp">所有員工</button>
					</form>
					<form method="post">
						<button type="button" class="btn btn-outline-success buttonInTop"
							id="">新增員工</button>
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