<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!-- ���եεn�J�e�� -->
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>login</title>
</head>
<body>
	<FORM METHOD="POST" ACTION="<%=request.getContextPath()%>/Friend_List/friend_list.do">
		<input type="text" name="mem_no">
		<input type="hidden" name="action" value="login">
		<input type="submit" value="�n�J">
	</FORM>
</body>
</html>