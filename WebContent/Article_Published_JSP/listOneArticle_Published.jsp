<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.article_published.model.*"%>
<%@ page import="com.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
 java.sql.Date artre_time = null;
 artre_time = new java.sql.Date(System.currentTimeMillis());
 java.sql.Date newart_time = null;
 newart_time = new java.sql.Date(System.currentTimeMillis());
%>

<%
	double d = Math.random();
	String flag = Double.toString(d);
	session.setAttribute("flag", flag);
%>


<!--
 參考資料：
 1.https://bootsnipp.com/snippets/56bAW
 2.http://www.runoob.com/bootstrap/bootstrap-carousel-plugin.html -->
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>文章個人頁面</title>

<style>
body {
  font-family: 'open sans';
  overflow-x: hidden; }

.yourcar img {
  width: 100%; 
  height:100%;}

.preview {
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
  -webkit-flex-direction: column;
      -ms-flex-direction: column;
          flex-direction: column; }
  @media screen and (max-width: 996px) {
    .preview {
      margin-bottom: 20px; } }

.card {
  margin-top: 50px;
  background:#00ffb2;
  padding: 3em;
  line-height: 1.5em; }

@media screen and (min-width: 997px) {
  .wrapper {
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex; } }
    
.carousel-indicators li{
	background-color:#00ffb2;
}

.btn{
 width:100px;
 height:50px;
}
</style>
<%@ include file="/front-end/header_footer/header_css.txt" %>
</head>
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
		<div class="card">
			<div class="container-fliud">
				<div class="wrapper row">
					<div class="preview col-md-6">
						<div id="myCarousel" class="carousel slide">
						    <ol class="carousel-indicators">
						        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						        <li data-target="#myCarousel" data-slide-to="1"></li>
						        <li data-target="#myCarousel" data-slide-to="2"></li>
						        <li data-target="#myCarousel" data-slide-to="3"></li>
						        <li data-target="#myCarousel" data-slide-to="4"></li>
						    </ol>   
				    <div class="carousel-inner yourcar">
				        <div class="carousel-item active">
				            <img src="<%=request.getContextPath()%>/Article_Published/DBGifReader1?art_no=${article_publishedVO.art_no}" alt="First slide">
				        </div>
				        <div class="carousel-item">
				            <img src="<%=request.getContextPath()%>/Article_Published/DBGifReader2?art_no=${article_publishedVO.art_no}" alt="Second slide">
				        </div>
				        <div class="carousel-item">
				            <img src="<%=request.getContextPath()%>/Article_Published/DBGifReader3?art_no=${article_publishedVO.art_no}" alt="Third slide">
				        </div>
				        <div class="carousel-item">
				            <img src="<%=request.getContextPath()%>/Article_Published/DBGifReader4?art_no=${article_publishedVO.art_no}" alt="Third slide">
				        </div>
				        <div class="carousel-item">
				            <img src="<%=request.getContextPath()%>/Article_Published/DBGifReader5?art_no=${article_publishedVO.art_no}" alt="Third slide">
				        </div>
				    </div>
				    <a class="carousel-control left" href="#myCarousel" 
				       data-slide="prev"> <span _ngcontent-c3="" aria-hidden="true" class="glyphicon glyphicon-chevron-right"></span></a>
				    <a class="carousel-control right" href="#myCarousel" 
				       data-slide="next">&rsaquo;</a>
				</div>
						
					</div>
					<div class="details col-md-6">
						<h3 >${article_publishedVO.art_title}</h3>
						<h4>${article_publishedVO.art_time}</h4>
						<p>${article_publishedVO.art_content}</p>
						<div>
								<c:if test="${memberVO.mem_no!=null&&memberVO.mem_no==article_publishedVO.mem_no}">
									<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">編輯</button>
									<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
											<div class="modal-dialog">
													<div class="modal-content">
													  <FORM METHOD="POST" ACTION="<%=request.getContextPath()%>/Article_Published/article_published.do" enctype="multipart/form-data">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
																&times;
															</button>
															
															<h4 class="modal-title" id="myModalLabel">
															<input name="art_title" value="${article_publishedVO.art_title}">
															</h4>
															
															
														</div>
														<div class="modal-body">
														<textarea name="art_content" cols="20" rows="20">${article_publishedVO.art_content}</textarea> 
														<p><%=newart_time%></p>
														<input type="file" name="art_pic1" size="40" accept="image/*">
														<input type="file" name="art_pic2" size="40" accept="image/*">
														<input type="file" name="art_pic3" size="40" accept="image/*">
														<input type="file" name="art_pic4" size="40" accept="image/*">
														<input type="file" name="art_pic5" size="40" accept="image/*">
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-default" data-dismiss="modal">
																關閉
															</button>
															<input type="submit" class="btn btn-primary" value="編輯完成">
															<input type="hidden" name="action" value="update">
															<input type="hidden" name="art_no" value="${article_publishedVO.art_no}">
															<input type="hidden" name="art_time" value="<%=newart_time%>">
														</div>
													  </FORM>
													</div>
										</div>
									</div>
								</c:if>
								<c:if test="${memberVO.mem_no!=null&&memberVO.mem_no!=article_publishedVO.mem_no}">
									<button class="btn btn-danger btn-lg" data-toggle="modal" data-target="#myModal">檢舉</button>
									<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
											<div class="modal-dialog">
													<div class="modal-content">
													  <FORM METHOD="POST" ACTION="<%=request.getContextPath()%>/Article_Reported/article_reported.do">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
																&times;
															</button>
															
															<h4 class="modal-title" id="myModalLabel">
															${article_publishedVO.art_title}"
															</h4>
															
															
														</div>
														<div class="modal-body">
														<textarea name="artre_content" cols="20" rows="20"></textarea> 
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-default" data-dismiss="modal">
																關閉
															</button>
															<input type="submit" class="btn btn-danger" value="提出檢舉">
															<input type="hidden" name="action" value="insert">
															<input type="hidden" name="art_no" value="${article_publishedVO.art_no}">
															<input type="hidden" name="mem_no" value="${memberVO.mem_no}">
															<input type="hidden" name="artre_time" value="<%=artre_time%>">
															<input type="hidden" name="flag" value="<%=flag%>">
															<input type="hidden" name="artre_code" value="1">
														</div>
													  </FORM>
													</div>
										</div>
									</div>
								</c:if>
								<c:if test="${memberVO.mem_no==null}">
								</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/front-end/header_footer/footer.txt" %>
<%@ include file="/front-end/header_footer/footer_js.txt" %>
</body>
</html>