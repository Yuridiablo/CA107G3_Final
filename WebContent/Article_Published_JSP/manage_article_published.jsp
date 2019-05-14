<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.article_published.model.*"%>
<%@ page import="com.member.model.*"%>

<%
	MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
	Article_PublishedService article_publishedSvc = new Article_PublishedService();
	List<Article_PublishedVO> list = article_publishedSvc.getAll(memberVO.getMem_no());
	pageContext.setAttribute("list", list);
	 java.sql.Date newart_time = null;
	 newart_time = new java.sql.Date(System.currentTimeMillis());
	 java.sql.Date art_time = null;
	 art_time = new java.sql.Date(System.currentTimeMillis());
	 
	 double d = Math.random();
	 String flag = Double.toString(d);
	 session.setAttribute("flag", flag);
%>

<%

response.setHeader("Pragma", "no-cache");

response.setHeader("Cache-Control", "no-cache");

response.setDateHeader("Expires", 0);

response.flushBuffer();

%>
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

<style>
.contact-form{ margin-top:15px;}
.contact-form .textarea{ min-height:220px; resize:none;}
.form-control{ box-shadow:none; border-color:#eee; height:49px;}
.form-control:focus{ box-shadow:none; border-color:#00b09c;}
.form-control-feedback{ line-height:50px;}
.main-btn{ background:#00b09c; border-color:#00b09c; color:#fff;}
.main-btn:hover{ background:#00a491;color:#fff;}
.form-control-feedback {
line-height: 50px;
top: 0px;
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
					瀏覽自己的文章
				</a>
			</h4>
		</div>
		<div id="collapseOne" class="panel-collapse collapse in">
			<div class="panel-body">
				<div class="well">
				<table class="table">
			      <thead>
			        <tr>
			          <th>文章標題</th>
			          <th>文章內容</th>
			          <th>發表時間</th>
			          <th>圖片1</th>
			          <th>圖片2</th>
			          <th>圖片3</th>
			          <th>圖片4</th>
			          <th>圖片5</th>
			          <th>狀態</th>
			          <th style="width: 36px;"></th>
			        </tr>
			      </thead>
			      <tbody>
			      	<c:forEach var="article_publishedVO" items="${list}">
			        <tr>
			          <td>${article_publishedVO.art_title}</td>
			          <td><div class="form-group">
							  <textarea class="form-control rounded-0" id="exampleFormControlTextarea1" rows="8">${article_publishedVO.art_content}</textarea>
						  </div>
			          </td>
			          <td>${article_publishedVO.art_time}</td>
			          <td><img src="<%=request.getContextPath()%>/Article_Published/DBGifReader1?art_no=${article_publishedVO.art_no}" alt=""></td>
			          <td><img src="<%=request.getContextPath()%>/Article_Published/DBGifReader2?art_no=${article_publishedVO.art_no}" alt=""></td>
			          <td><img src="<%=request.getContextPath()%>/Article_Published/DBGifReader3?art_no=${article_publishedVO.art_no}" alt=""></td>
			          <td><img src="<%=request.getContextPath()%>/Article_Published/DBGifReader4?art_no=${article_publishedVO.art_no}" alt=""></td>
			          <td><img src="<%=request.getContextPath()%>/Article_Published/DBGifReader5?art_no=${article_publishedVO.art_no}" alt=""></td>
			          <td>
			          	<c:if test="${article_publishedVO.art_code==1}">
			          		<p class="text-success">上架</p>
			          	</c:if>
			          	<c:if test="${article_publishedVO.art_code==2}">
			          		<p class="text-danger">下架</p>
			          	</c:if>
			          </td>
			          <td>
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
															<input type="hidden" name="action" value="updateformyself">
															<input type="hidden" name="art_no" value="${article_publishedVO.art_no}">
															<input type="hidden" name="art_time" value="<%=newart_time%>">
														</div>
													  </FORM>
													</div>
										</div>
									</div>
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
					新增文章
				</a>
			</h4>
		</div>
		<div id="collapseTwo" class="panel-collapse collapse">
			<div class="panel-body">
				
				<div class="container">
					<div class="row">
						<form role="form" id="contact-form" class="contact-form" METHOD="POST" ACTION="<%=request.getContextPath()%>/Article_Published/article_published.do" enctype="multipart/form-data">
				                    <div class="row">
				                		<div class="col-md-6">
					                  		<div class="form-group">
					                            <input type="text" class="form-control" name="art_title" autocomplete="off" id="Name" placeholder="文章標題">
					                  		</div>
				                  		</div>
				                  	</div>
				                  	<div class="row">
				                		<div class="col-md-6">
					                  		<div class="form-group">
					                            <p><%=art_time%></p>
					                  		</div>
				                  		</div>
				                  	</div>
				                  	<div class="row">
				                		<div class="col-md-6">
					                  		<div class="form-group">
					                            <input type="file" name="art_pic1" size="40" accept="image/*">
					                  		</div>
				                  		</div>
				                  	</div>
				                  	<div class="row">
				                		<div class="col-md-6">
					                  		<div class="form-group">
					                            <input type="file" name="art_pic2" size="40" accept="image/*">
					                  		</div>
				                  		</div>
				                  	</div>
				                  	<div class="row">
				                		<div class="col-md-6">
					                  		<div class="form-group">
					                            <input type="file" name="art_pic3" size="40" accept="image/*">
					                  		</div>
				                  		</div>
				                  	</div>
				                  	<div class="row">
				                		<div class="col-md-6">
					                  		<div class="form-group">
					                            <input type="file" name="art_pic4" size="40" accept="image/*">
					                  		</div>
				                  		</div>
				                  	</div>
				                  	<div class="row">
				                		<div class="col-md-6">
					                  		<div class="form-group">
					                            <input type="file" name="art_pic5" size="40" accept="image/*">
					                  		</div>
				                  		</div>
				                  	</div>
				                  	<div class="row">
				                  	   <div class="col-md-12">
				                  		<div class="form-group">
				                            <textarea class="form-control textarea" rows="3" name="art_content" id="Message" placeholder="文章內容"></textarea>
				                  		</div>
				                  	   </div>
				                    </div>
				                    <div class="row">
				                    	<div class="col-md-12">
				                  			<input type="submit" class="btn main-btn pull-right" value="新增文章">
				                  			<input type="hidden" name="art_time" value="<%=art_time%>">
				                  			<input type="hidden" name="mem_no" value="${memberVO.mem_no}">
				                  			<input type="hidden" name="art_code" value="1">
				                  			<input type="hidden" name="action" value="insert">
				                  			<input type="hidden" name="flag" value="<%=flag%>">
				                  		</div>
				                  	</div>
				           </form>
					</div>
				</div>			
			</div>
		</div>
	</div>
</div>
<script>
$('#contact-form').bootstrapValidator({
//  live: 'disabled',
  message: 'This value is not valid',
  feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
  },
  fields: {
      art_title: {
          validators: {
              notEmpty: {
                  message: '需填寫標題'
              }
          }
      },
      art_content: {
          validators: {
              notEmpty: {
                  message: '需填寫內容'
              }
          }
      }
  }
});

var submitcount=0;

function submitOnce (form){

if (submitcount == 0){

submitcount++;

return true;

} else{

alert("正在操作,請不要重複提交,謝謝!");

return false;

}

}
</script>
</body>
</html>