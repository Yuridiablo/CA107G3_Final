<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.article_reported.model.*"%>

<!-- 參考資料
1.http://www.runoob.com/bootstrap/bootstrap-collapse-plugin.html
2.https://bootsnipp.com/snippets/DrG
-->

<%
Article_ReportedService article_reportedSvc = new Article_ReportedService();
List<Article_ReportedVO> list = article_reportedSvc.getAll();
pageContext.setAttribute("list",list);
%>

<jsp:useBean id="article_publishedSvc" scope="page" class="com.article_published.model.Article_PublishedService" />

<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService" />

<!DOCTYPE html>
<html>
<head>
<title>Manage Article_Reported</title>

<style>
img{
max-width:50px;
max-height:50px;
}
.card-header{
width:200px;
background-color:#00ffb2;
}
</style>

</head>
<body>
<div class="container">
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<div class="card-group" id="accordion">
    <div class="card card-default">
        <div class="card-header">
            <h4 class="card-title">
                <a data-toggle="collapse" data-parent="#accordion" 
                href="#collapseOne">
                	查閱文章檢舉
                </a>
            </h4>
        </div>
        <div id="collapseOne" class="card-collapse collapse in">
            <div class="card-body">
            	<div class="well">
                <table class="table">
			      <thead>
			        <tr>
			          <th>舉報人姓名</th>
			          <th>文章內容</th>
			          <th>檢舉時間</th>
			          <th>檢舉理由</th>
			          <th>狀態</th>
			          <th style="width: 36px;"></th>
			        </tr>
			      </thead>
			      <tbody>
			      	<c:forEach var="article_reportedVO" items="${list}">
			      	<tr>
			          <td>
			          	<c:forEach var="memberVO" items="${memberSvc.all}">
						<c:if test="${article_reportedVO.mem_no==memberVO.mem_no}">
							${memberVO.mem_name}
						</c:if>
						</c:forEach>
					</td>
			          <td>
			          <c:forEach var="article_publishedVO" items="${article_publishedSvc.all}">
						<c:if test="${article_publishedVO.art_no==article_reportedVO.art_no}">
							${article_publishedVO.art_content}
						</c:if>
					  </c:forEach>
					  </td>
			          <td>${article_reportedVO.artre_time}</td>
			          <td>${article_reportedVO.artre_content}</td>
			          <td>
			          <c:if test="${article_reportedVO.artre_code==1}">
			          		未處理
			          </c:if>
			          <c:if test="${article_reportedVO.artre_code==2}">
			          		已處理通過
			          </c:if>
			          <c:if test="${article_reportedVO.artre_code==3}">
			          		已處理不通過
			          </c:if>
			          </td>
			          <td>
			             <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Article_Reported/article_reported.do" style="margin-bottom: 0px;">
					  		<c:if test="${article_reportedVO.artre_code==1}">
					  			<input type="submit"  class="btn btn-danger" value="通過">
					  			<input type="hidden" name ="artre_no" value="${article_reportedVO.artre_no}">
					  			<input type="hidden" name ="art_no" value="${article_reportedVO.art_no}">
					  			<input type="hidden" name ="artre_content" value="${article_reportedVO.artre_content}">
					  			<input type="hidden" name ="artre_time" value="${article_reportedVO.artre_time}">
					  			<input type="hidden" name="artre_code" value="2">
					     		<input type="hidden" name="action"	value="update">
					    	</c:if>
			   			</FORM>
					   <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Article_Reported/article_reported.do" style="margin-bottom: 0px;">
					    	<c:if test="${article_reportedVO.artre_code==1}">
					  			<input type="submit" class="btn btn-secondary" value="不通過">
					  			<input type="hidden" name ="artre_no" value="${article_reportedVO.artre_no}">
					  			<input type="hidden" name ="artre_content" value="${article_reportedVO.artre_content}">
					  			<input type="hidden" name ="artre_time" value="${article_reportedVO.artre_time}">
					  			<input type="hidden" name="artre_code" value="3">
					     		<input type="hidden" name="action"	value="update">
					    	</c:if>
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
</div>
</div>




</body>
</html>