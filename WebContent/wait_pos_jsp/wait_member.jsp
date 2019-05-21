<%@page import="com.vendor.model.VendorVO"%>
<%@page import="com.vendor.model.VendorService"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.member.model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ page import="java.util.*" %>
    
 <% 
 MemberService ms = new MemberService();
 List<MemberVO> mList = ms.getAll();

//  VendorService vs = new VendorService();
//  List<VendorVO> vList = vs.getAll();

%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>wait_member</title>
<style>
td {
padding: 2px;
}
</style>
</head>
<body>
<table border="1">
<tr><th>廠商編號</th><th>會員編號</th><th>會員姓名</th><th>人數</th><th>候位取號</th></tr>
<% for(int i = 0; i < mList.size(); i++) { 
	MemberVO mVO = mList.get(i);
%>
<form action="<%=request.getContextPath()%>/wait_pos/wait_pos.do">
<tr>
	<td><input type="text" name="vendor_no" value="V000001" ></td>
	<td><input type="text" name="mem_no" value="<%= mVO.getMem_no() %>"></td>
	<td><input type="text" name="mem_name" value="<%= mVO.getMem_name() %>"></td>
	<td><input type="number"  name="party_size" min="1" max="10" value="1"></td>
	<td><button type="submit" class="getPosNum">候位取號</button></td>
</tr>
<input type="hidden" name="action" value="insert">
</form>

<% } %>
</table>

<form action="<%=request.getContextPath()%>/wait_pos/wait_pos.do">

廠商編號<input type="text" name="vendor_no"> <br>

會員編號<input type="text" name="mem_no"> <br>
會員姓名<input type="text" name="mem_name"> <br>
人數<input type="number"  name="party_size" min="1" max="10" value="1"> <br>

<button type="submit" class="getPosNum">候位取號</button>
<input type="hidden" name="action" value="insert">
</form>


<br><br>

<!-- Cancel Wait -->
<form action="<%=request.getContextPath()%>/wait_pos/wait_pos.do">

廠商編號<input type="text" name="vendor_no"> <br>

會員編號<input type="text" name="mem_no"> <br>

桌位<input type="number"  name="tbl_size" min="1" max="5" value="1"> <br>

<button type="submit" class="cancel">取消候位</button>
<input type="hidden" name="action" value="cancel">
</form>

</body>
</html>