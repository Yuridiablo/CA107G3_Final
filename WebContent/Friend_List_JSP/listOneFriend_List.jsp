<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.friend_list.model.*"%>
<%@ page import="com.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
Friend_ListVO friend_listVO = (Friend_ListVO) request.getAttribute("friend_listVO");
%>

<%
	String mem_no = (String)request.getAttribute("mem_no");
	String frie_no = (String)request.getAttribute("frie_no");
	String mem_nickname = (String)request.getAttribute("mem_nickname");
	
	MemberService memberSvc = new MemberService();
	MemberVO memberVo = memberSvc.getOneMember(mem_no);
	MemberVO memberVo2 = memberSvc.getOneMember(frie_no);
	
	double d = Math.random();
	String flag = Double.toString(d);
	session.setAttribute("flag", flag);
%>

<!-- 參考資料
1.https://bootsnipp.com/snippets/DrG -->
<html>
<head>
<title>關係搜尋結果</title>



<%@ include file="/front-end/header_footer/header_css.txt" %>
</head>
<body>
<%@ include file="/front-end/header_footer/header.txt" %>
<c:if test="${friend_listVO==null}">
<div class="well">
<table class="table">
      <thead>
        <tr>
          <th>會員暱稱</th>
          <th>狀態</th>
          <th></th>
          <th style="width: 36px;"></th>
        </tr>
      </thead>
      <tbody>
        <tr>
		<td><%=mem_nickname%></td>
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
</c:if>
<c:if test="${friend_listVO!=null}">
<div class="well">
    <table class="table">
      <thead>
        <tr>
          <th>會員暱稱</th>
          <th>狀態</th>
          <th></th>
          <th style="width: 36px;"></th>
        </tr>
      </thead>
      <tbody>
        <tr>
		<td><%=memberVo2.getMem_nickname()%></td>
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
						  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
						     		<input type="hidden" name="frie_no"  value="<%=frie_no%>">
						     		<input type="hidden" name="frie_code"  value="1">
						     		<input type="hidden" name="action"	value="update">
						    	</c:if>
						  	</div>
						    <div>
						    	<c:if test="${friend_listVO.frie_code==4}">
						  			<input type="submit" class="btn btn-primary" value="接受邀請">
						  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
						     		<input type="hidden" name="frie_no"  value="<%=frie_no%>">
						     		<input type="hidden" name="frie_code"  value="4">
						     		<input type="hidden" name="action"	value="update">
						    	</c:if>
						    </div>
						    <div>
						    	<c:if test="${friend_listVO.frie_code==5}">
						  			<input type="submit" class="btn btn-primary" value="解除封鎖">
						  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
						     		<input type="hidden" name="frie_no"  value="<%=frie_no%>">
						     		<input type="hidden" name="frie_code"  value="5">
						     		<input type="hidden" name="action"	value="update">
						    	</c:if>
						    </div>
						   <div>
						   		 <c:if test="${friend_listVO.frie_code==7}">
						  			<input type="submit" class="btn btn-danger" value="封鎖好友">
						  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
						     		<input type="hidden" name="frie_no"  value="<%=frie_no%>">
						     		<input type="hidden" name="frie_code"  value="7">
						     		<input type="hidden" name="action"	value="update">
						    	</c:if>
						   </div>
			 		</FORM>
					 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Friend_List/friend_list.do" style="margin-bottom: 0px;">
					    <div>
					    	<c:if test="${friend_listVO.frie_code==1}">
					  			<input type="submit" class="btn btn-danger" value="解除追蹤">
					  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
						     	<input type="hidden" name="frie_no"  value="<%=frie_no%>">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					    </div>
					    <div>
					    	<c:if test="${friend_listVO.frie_code==3}">
					  			<input type="submit" class="btn btn-danger" value="取消邀請">
					  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
						     	<input type="hidden" name="frie_no"  value="<%=frie_no%>">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					    </div>
					   <div>
					    	<c:if test="${friend_listVO.frie_code==4}">
					  			<input type="submit" class="btn btn-danger" value="拒絕邀請">
					  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
						     	<input type="hidden" name="frie_no"  value="<%=frie_no%>">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					   </div>
					    <div>
					    	<c:if test="${friend_listVO.frie_code==5}">
					  			<input type="submit" class="btn btn-danger" value="刪除好友">
					  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
						     		<input type="hidden" name="frie_no"  value="<%=frie_no%>">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					    </div>
					    <div>
					    	<c:if test="${friend_listVO.frie_code==6}">
					  			<input type="submit" class="btn btn-danger" value="刪除好友">
					  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
						     	<input type="hidden" name="frie_no"  value="<%=frie_no%>">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					    </div>
					    <div>
					    	<c:if test="${friend_listVO.frie_code==7}">
					  			<input type="submit" class="btn btn-danger" value="刪除好友">
					  			<input type="hidden" name="mem_no"  value="<%=mem_no%>">
						     	<input type="hidden" name="frie_no"  value="<%=frie_no%>">
					     		<input type="hidden" name="action"	value="delete">
					    	</c:if>
					    </div>
					   </FORM>
		</td>
        </tr>
      </tbody>
    </table>
</div>
</c:if>
<%@ include file="/front-end/header_footer/footer.txt" %>
<%@ include file="/front-end/header_footer/footer_js.txt" %>
</body>
</html>