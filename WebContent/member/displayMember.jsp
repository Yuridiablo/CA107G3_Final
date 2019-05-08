
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<html>
<head>
<title>員工資料 - listOneEmp.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>




<table>
	<tr>
		<th>會員編號</th>
		<th>會員姓名</th>
		<th>會員暱稱</th>
		<th>會員性別</th>
	</tr>
<c:forEach var="memberVO" items="${memberVO}">
	<tr>
		<td>${memberVO.mem_no}</td>
		<td>${memberVO.mem_name}</td>
		<td>${memberVO.mem_nickname}</td>
		<td>${memberVO.mem_gender}</td>
	</tr>
</c:forEach>
</table>

</body>
</html>