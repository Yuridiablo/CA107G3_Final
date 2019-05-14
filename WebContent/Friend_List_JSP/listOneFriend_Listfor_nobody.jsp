<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5" %>
<%@ page import="com.friend_list.model.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="java.lang.String"%>
<%
	String mem_no = (String)request.getAttribute("mem_no");
	String frie_no = (String)request.getAttribute("frie_no");
%>
<%
	MemberService memberSvc = new MemberService();
	MemberVO memberVo = memberSvc.getOneMember(mem_no);
	MemberVO memberVo2 = memberSvc.getOneMember(frie_no);
%>
<%
	double d = Math.random();
	String flag = Double.toString(d);
	session.setAttribute("flag", flag);
%>
<!-- 參考資料
1.https://bootsnipp.com/snippets/DrG -->
<html>
<head>
<title>關係搜尋結果</title>
<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>


</head>
<body>
<div class="well">
<table class="table">
      <thead>
        <tr>
          <th>會員編號</th>
          <th>會員姓名</th>
          <th>狀態</th>
          <th></th>
          <th style="width: 36px;"></th>
        </tr>
      </thead>
      <tbody>
        <tr>
		<td><%=frie_no%></td>
		<td><%=memberVo2.getMem_name()%></td>
		<td>尚未加入追蹤或未寄出邀請</td>
		<td>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Friend_List/friend_list.do" style="margin-bottom: 0px;">
			  			<input class="btn btn-primary" type="submit" value="加入追蹤">
			  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
			     		<input type="hidden" name="frie_no"  value="<%=frie_no%>">
			     		<input type="hidden" name="frie_code"  value="1">
			     		<input type="hidden" name="flag" value="<%=flag%>">
			     		<input type="hidden" name="action"	value="insert">
			</FORM>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Friend_List/friend_list.do" style="margin-bottom: 0px;">
			  			<input class="btn btn-primary" type="submit" value="寄出邀請">
			  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
			     		<input type="hidden" name="frie_no"  value="<%=frie_no%>">
			     		<input type="hidden" name="frie_code"  value="3">
			     		<input type="hidden" name="flag" value="<%=flag%>">
			     		<input type="hidden" name="action"	value="insert">
			 </FORM>
		</td>
        </tr>
      </tbody>
    </table>
</div>
</body>
</html>