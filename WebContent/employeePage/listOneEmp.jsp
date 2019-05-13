<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title></title>
</head>
<body>

<%@page import="com.employee.model.EmployeeVO"%>
<%@page import="java.util.List"%>
<%@page import="com.employee.model.EmployeeService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	EmployeeService employeeSvc = new EmployeeService();
	List<EmployeeVO> list = employeeSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <title></title>
</head>

<body>
<%-- 	<%-- 錯誤表列 --%> --%>
<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<font style="color: red">請修正以下錯誤:</font> -->
<!-- 		<ul> -->
<%-- 			<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 				<li style="color: red">${message}</li> --%>
<%-- 			</c:forEach> --%>
<!-- 		</ul> -->
<%-- 	</c:if> --%>
    <div class="container ">
        <div class="row justify-content-center">
            <div class="col-12 table-responsive">
                <table class="table table-striped table-dark ">
                    <thead>
                        <tr>
                            <th scope="col">員工編號</th>
                            <th scope="col">員工姓名</th>
                            <th scope="col">員工性別</th>
                            <th scope="col">員工帳號</th>
                            <th scope="col">員工密碼</th>
                            <th scope="col">到職日</th>
                            <th scope="col">離職日</th>
                            <th scope="col">到職狀態</th>
                            <th scope="col">去職</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="employeeVO" items="${list}">
                        <tr>
                            <th scope="row">${employeeVO.emp_no}</th>
                            <td>${employeeVO.emp_name}</td>
                            <td>${employeeVO.emp_sex}</td>
                            <td>${employeeVO.emp_acc}</td>
                            <td>${employeeVO.emp_pwd}</td>
                            <td>${employeeVO.emp_hire}</td>
                            <td>${employeeVO.emp_resign}</td>
                            <td>${employeeVO.emp_stat}</td>
                            <td>
                            	<form method="post" action="">
                            		<button type="button" class="btn btn-outline-danger">確定</button>
                            	</form>
                            </td>
                        </tr>
                       </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>

</html>
</body>
</html>