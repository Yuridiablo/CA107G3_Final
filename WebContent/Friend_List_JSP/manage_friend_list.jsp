<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.friend_list.model.*"%>
<%@ page import="com.member.model.*"%>

<%
	MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
	Friend_ListService friend_listSvc = new Friend_ListService();
	List<Friend_ListVO> list = friend_listSvc.getAll(memberVO.getMem_no());
	pageContext.setAttribute("list", list);
%>

<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService" />
<!-- 參考資料
1.http://www.runoob.com/bootstrap/bootstrap-collapse-plugin.html
2.https://bootsnipp.com/snippets/DrG
3.https://bootsnipp.com/snippets/QbnaX
-->

<!DOCTYPE html>
<html>
<head>
<title>Manage Article</title>
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.2/css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.2/js/bootstrapValidator.min.js"></script>

<style>
img{
max-width:50px;
max-height:50px;
}
.panel-heading{
width:200px;
background-color:#00ffb2;
}
</style>



</head>
<body>

<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<div class="panel-group" id="accordion">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a data-toggle="collapse" data-parent="#accordion" 
				   href="#collapseOne">
					瀏覽朋友清單
				</a>
			</h4>
		</div>
		<div id="collapseOne" class="panel-collapse collapse in">
			<div class="panel-body">
				<div class="well">
				<table class="table">
			      <thead>
			        <tr>
			          <th>朋友姓名</th>
					  <th>狀態</th>
			          <th style="width: 36px;"></th>
			        </tr>
			      </thead>
			      <tbody>
			      	<c:forEach var="friend_listVO" items="${list}">
			        <tr>
			         <td><c:forEach var="memberVo2" items="${memberSvc.all}">
						<c:if test="${friend_listVO.frie_no==memberVo2.mem_no}">
							${memberVo2.mem_name}
						</c:if>
						</c:forEach>
					</td>
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
						  			<input type="submit" class="btn btn-primary" value="寄出邀請">
						  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
						     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
						     		<input type="hidden" name="frie_code"  value="${friend_listVO.frie_code}">
						     		<input type="hidden" name="action"	value="update">
						    	</c:if>
						  	</div>
						    <div>
						    	<c:if test="${friend_listVO.frie_code==4}">
						  			<input type="submit" class="btn btn-primary" value="接受邀請">
						  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
						     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
						     		<input type="hidden" name="frie_code"  value="${friend_listVO.frie_code}">
						     		<input type="hidden" name="action"	value="update">
						    	</c:if>
						    </div>
						    <div>
						    	<c:if test="${friend_listVO.frie_code==5}">
						  			<input type="submit" class="btn btn-primary" value="解除封鎖">
						  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
						     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
						     		<input type="hidden" name="frie_code"  value="${friend_listVO.frie_code}">
						     		<input type="hidden" name="action"	value="update">
						    	</c:if>
						    </div>
						   <div>
						   		 <c:if test="${friend_listVO.frie_code==7}">
						  			<input type="submit" class="btn btn-danger" value="封鎖好友">
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
					  			<input type="submit" class="btn btn-danger" value="解除追蹤">
					  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
					     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					    </div>
					    <div>
					    	<c:if test="${friend_listVO.frie_code==3}">
					  			<input type="submit" class="btn btn-danger" value="取消邀請">
					  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
					     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					    </div>
					   <div>
					    	<c:if test="${friend_listVO.frie_code==4}">
					  			<input type="submit" class="btn btn-danger" value="拒絕邀請">
					  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
					     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					   </div>
					    <div>
					    	<c:if test="${friend_listVO.frie_code==5}">
					  			<input type="submit" class="btn btn-danger" value="刪除好友">
					  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
					     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					    </div>
					    <div>
					    	<c:if test="${friend_listVO.frie_code==6}">
					  			<input type="submit" class="btn btn-danger" value="刪除好友">
					  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
					     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					    </div>
					    <div>
					    	<c:if test="${friend_listVO.frie_code==7}">
					  			<input type="submit" class="btn btn-danger" value="刪除好友">
					  			<input type="hidden" name="mem_no"  value="${friend_listVO.mem_no}">
					     		<input type="hidden" name="frie_no"  value="${friend_listVO.frie_no}">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					    </div>
					   </FORM>
					</td>
					</tr>
			         </c:forEach>
			      </tbody>
			    </table>
			</div>
			</div>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a data-toggle="collapse" data-parent="#accordion" 
				   href="#collapseTwo">
					以ID搜尋
				</a>
			</h4>
		</div>
		<div id="collapseTwo" class="panel-collapse collapse">
			<div class="panel-body">
				<FORM METHOD="post"  ACTION="<%=request.getContextPath()%>/Friend_List/friend_list.do">
					<input type="text" name="frie_no">
					<input type="hidden" name="mem_no" value="${memberVO.mem_no}">
					<input type="hidden" name="action" value="getOne_For_Search">
					<input class="btn btn-info" type="submit" value="搜尋">
				</FORM>		
			</div>
		</div>
	</div>
</div>
</body>
</html>