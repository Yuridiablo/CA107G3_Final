<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.friend_list.model.*"%>
<%@ page import="com.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
Friend_ListVO friend_listVO = (Friend_ListVO) request.getAttribute("friend_listVO");
%>

<%
	MemberService memberSvc = new MemberService();
	MemberVO memberVo = memberSvc.getOneMember(friend_listVO.getMem_no());
	MemberVO memberVo2 = memberSvc.getOneMember(friend_listVO.getFrie_no());
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
		<td><%=friend_listVO.getFrie_no()%></td>
		<td><%=memberVo2.getMem_name()%></td>
		<td>
				<c:if test="${friend_listVO.frie_code==1}">
					追蹤
				</c:if>
				<c:if test="${friend_listVO.frie_code==2}">
					被追蹤
				</c:if>
				<c:if test="${friend_listVO.frie_code==3}">
					寄出朋友邀請
				</c:if>
				<c:if test="${friend_listVO.frie_code==4}">
					收到朋友邀請
				</c:if>
				<c:if test="${friend_listVO.frie_code==5}">
					封鎖
				</c:if>
				<c:if test="${friend_listVO.frie_code==6}">
					被封鎖
				</c:if>
				<c:if test="${friend_listVO.frie_code==7}">
					朋友
				</c:if>
		</td>
		<td>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Friend_List/friend_list.do" style="margin-bottom: 0px;">
			  	<div>
			  		<c:if test="${friend_listVO.frie_code==1}">
			  			<input class="btn btn-primary" type="submit" value="寄出邀請">
			  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
			     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
			     		<input type="hidden" name="frie_code"  value="${friend_listVO.frie_code}">
			     		<input type="hidden" name="action"	value="update">
			    	</c:if>
			  	</div>
			    <div>
			    	<c:if test="${friend_listVO.frie_code==4}">
			  			<input class="btn btn-primary" type="submit" value="接受邀請">
			  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
			     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
			     		<input type="hidden" name="frie_code"  value="${friend_listVO.frie_code}">
			     		<input type="hidden" name="action"	value="update">
			    	</c:if>
			    </div>
			    <div>
			    	<c:if test="${friend_listVO.frie_code==5}">
			  			<input class="btn btn-primary" type="submit" value="解除封鎖">
			  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
			     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
			     		<input type="hidden" name="frie_code"  value="${friend_listVO.frie_code}">
			     		<input type="hidden" name="action"	value="update">
			    	</c:if>
			    </div>
			   <div>
			   		 <c:if test="${friend_listVO.frie_code==7}">
			  			<input class="btn btn-danger" type="submit" value="封鎖好友">
			  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
			     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
			     		<input type="hidden" name="frie_code"  value="${friend_listVO.frie_code}">
			     		<input type="hidden" name="action"	value="update">
			    	</c:if>
			   </div>
			 </FORM>
			 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Friend_List/friend_list.do" style="margin-bottom: 0px;">
			    <div>
			    	<c:if test="${friend_listVO.frie_code==1}">
			  			<input class="btn btn-danger" type="submit" value="解除追蹤">
			  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
			     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
			     		<input type="hidden" name="action"	value="delete">
			    	</c:if>
			    </div>
			    <div>
			    	<c:if test="${friend_listVO.frie_code==3}">
			  			<input class="btn btn-danger" type="submit" value="取消邀請">
			  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
			     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
			     		<input type="hidden" name="action"	value="delete">
			    	</c:if>
			    </div>
			   <div>
			    	<c:if test="${friend_listVO.frie_code==4}">
			  			<input class="btn btn-danger" type="submit" value="拒絕邀請">
			  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
			     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
			     		<input type="hidden" name="action"	value="delete">
			    	</c:if>
			   </div>
			    <div>
			    	<c:if test="${friend_listVO.frie_code==5}">
			  			<input class="btn btn-danger" type="submit" value="刪除好友">
			  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
			     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
			     		<input type="hidden" name="action"	value="delete">
			    	</c:if>
			    </div>
			    <div>
			    	<c:if test="${friend_listVO.frie_code==6}">
			  			<input class="btn btn-danger" type="submit" value="刪除好友">
			  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
			     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
			     		<input type="hidden" name="action"	value="delete">
			    	</c:if>
			    </div>
			    <div>
			    	<c:if test="${friend_listVO.frie_code==7}">
			  			<input class="btn btn-danger" type="submit" value="刪除好友">
			  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
			     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
			     		<input type="hidden" name="action"	value="delete">
			    	</c:if>
			    </div>
			   </FORM>
		</td>
        </tr>
      </tbody>
    </table>
</div>
</body>
</html>