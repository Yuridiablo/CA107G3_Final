<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>


<html>
<head>
<!-- <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" id="bootstrap-css"> -->
<!-- <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script> -->
<!-- <script src="//code.jquery.com/jquery-1.11.1.min.js"></script> -->
<meta charset="UTF-8">
<title>選擇分攤付款好友</title>

<style>
.table-sortable tbody tr {
    cursor: move;
}
</style>
<jsp:useBean id="res_tboSvc" scope="page" class="com.reservation_table_ordered.model.Reservation_Table_OrderedService" />
<jsp:useBean id="rev_tSvc" scope="page" class="com.reservation_time.model.Reservation_TimeService" />
<jsp:useBean id="now" scope="page" class="java.util.Date" />
<jsp:useBean id="ordSvc" scope="page" class="com.ord.model.OrdService" />
<jsp:useBean id="exc_dateSvc" scope="page" class="com.exception_date.model.Exception_DateService" />
<jsp:useBean id="commentSvc" scope="page" class="com.comments.model.CommentsService" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemberService" />
<jsp:useBean id="fSvc" scope="page" class="com.friend_list.model.Friend_ListService" />

</head>
<body>

<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-12">	
					<table class="table table-condensed table-hover">
					
					  <thead>
					    <tr>
					      <th class="span1"></th>
					      <th class="span2"></th>
					      <th class="span2"></th>
					      <th class="span9"></th>
					      <th class="span2"></th>
					    </tr>
					  </thead>
					
					  
					  <tbody><form action="<%=request.getContextPath()%>/ord/ord.do" method="get">
					  <c:forEach var="fVO" items="${fSvc.getfriendlist(mem_no)}">	
					  
					    <tr>
					      <td><h4><input type="checkbox" name="share_mem_no" value="${fVO.frie_no}"> <a href="#"><i class="icon-star-empty"></i></a></h3></td>
					      <c:set var ="m_name" value="${memSvc.getOneMember(fVO.frie_no)}" />
		         											 
					      <td><strong>${m_name.mem_name}</strong></td>
					     
											
					      <td><span class="label pull-right">分攤金額</span></td>
					      <td><input type="number" name="share_amount" ></td>
					     
					      <td><strong><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/></strong></td>
					    </tr>
					      </c:forEach>
					      
					  </tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-5">	
		<input type="hidden" name="action" value="share_pick"> 
		<button class="btn btn-success btn-lg btn2-block" type="submit" >送出</button>   
			</form>
			</div>
			</div>
			</div>
			
	</body>
					
</html>