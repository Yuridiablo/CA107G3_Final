<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 參考資料
1.https://bootsnipp.com/snippets/DrG -->
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>搜索文章</title>
<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
</head>
<body>
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Article_Published/article_published.do">
  		<input type="text" name="art_title" placeholder="標題關鍵字"><br>
  		<input type="text" name="art_content" placeholder="內容關鍵字"><br>
  		<input class="btn btn-info" type="submit" value="搜尋">
  		<input type="hidden" name="action" value="listArticle_PublishedByCompositeQuery">
  	</FORM>
</body>
</html>