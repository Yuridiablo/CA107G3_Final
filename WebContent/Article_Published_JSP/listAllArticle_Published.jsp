<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.article_published.model.*"%>

<%
	Article_PublishedService article_publishedSvc = new Article_PublishedService();
	List<Article_PublishedVO> list = article_publishedSvc.getAll();
	pageContext.setAttribute("list", list);
%>
<!--
 參考資料：
 1.https://bootsnipp.com/snippets/O6eZ -->
<html>
<head>
<title>搜尋文章結果</title>

<style>
@import url(http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,700,400italic);

font-family: 'Open Sans', sans-serif;

html {
  font-family: 'Open Sans', sans-serif;
}

body {
  min-height: 3000px;
  padding-top: 70px;
  font-family: 'Open Sans', sans-serif;
}

.thumbnail {
    position: relative;
    padding: 0px;
    margin-bottom: 20px;
}

.thumbnail img {
    width: 100%;
}
</style>


</head>
<%@ include file="/front-end/header_footer/header_css.txt" %>
<body>
<%@ include file="/front-end/header_footer/header.txt" %>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
 <div class="container">
      <div class="row">
        <c:forEach var="article_publishedVO" items="${list}">
        <div class="col-xs-18 col-sm-6 col-md-3">
          <div class="thumbnail">
            <img src="<%=request.getContextPath()%>/Article_Published/DBGifReader1?art_no=${article_publishedVO.art_no}" alt="">
              <div class="caption">
                <h4>${article_publishedVO.art_title}</h4>
                <p>${article_publishedVO.art_time}</p>
                <p><FORM METHOD="POST" ACTION="<%=request.getContextPath()%>/Article_Published/article_published.do">
                    				<input class="btn btn-primary" type="submit" value="瀏覽文章">
                    				<input type="hidden" name="action" value="getOne_For_Display">
                    				<input type="hidden" name="art_no" value="${article_publishedVO.art_no}" >
                   </FORM></p>
            </div>
          </div>
        </div>
        </c:forEach>
      </div>
 </div>
 <%@ include file="/front-end/header_footer/footer.txt" %>
<%@ include file="/front-end/header_footer/footer_js.txt" %>
</body>
</html>