<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ord.model.*"%>
<%@ page import="com.comments.model.*"%>

<!DOCTYPE html>
<html>
<style>
.hrr {
border:0;
background-color:#ff999;
height:1px
}
</style>

<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>會員瀏覽評論</title>
</head>

<jsp:useBean id="c_Svc" scope="page" class="com.comments.model.CommentsService" />
<jsp:useBean id="v_Svc" scope="page" class="com.vendor.model.VendorService" />


<c:set var="c_list" value="${c_VOlist}"></c:set>
<body>


<div class="container">
    <div class="row">
        <div class="col-md-12">
        <table class="table" id="xxx">
        <div class="alert alert-info">
               評論列表</div>
            <div class="alert alert-success" style="display:none;">
                <span class="glyphicon glyphicon-ok"></span> Drag table row and change Order</div>
            
                
                    <tr class="alert-info">
                        
						
						<th>廠商名稱</th>
						<th>評分</th>
						<th>評論內容</th>
						<th>評論時間</th>
						
						
						
                    </tr>
                
           
              
<%--                  begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%> --%>
<%-- 			<%@ include file="page1.file" %> --%>
			<c:forEach var="c_VO" items="${c_VOlist}" >
               <c:set var="vendor" value="${v_Svc.findByPK(c_VO.vendor_no)}"></c:set>
							
                     <tr class="warning">
                       
					
						<td>${vendor.v_name }</td>
						<td>${c_VO.score}</td>
						<td>${c_VO.cmnt}</td>
						<td>${c_VO.time}</td>
						
						
<%-- 						<c:if test ="${c_VO.cmnt_status==1}" var="xxx"> --%>
<!-- 						<td>正常</td> -->
<%-- 						</c:if> --%>
<%-- 						<c:if test ="${c_VO.cmnt_status==2}" var="xxx"> --%>
<!-- 						<td>被檢舉中</td>  -->
<%-- 						</c:if> --%>
<%-- 						<c:if test ="${c_VO.cmnt_status==3}" var="xxx"> --%>
<!-- 						<td>黑名單</td>  -->
<%-- 						</c:if> --%>
						
						
                    
<!-- 			  <td>  -->
<%-- 			  <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/comment/comment.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="評論管理"> -->
<%-- 			     <input type="hidden" name="cmnt_no"  value="${c_VO.cmnt_no}"> --%>
<!-- 			     <input type="hidden" name="action"	value="get_comments_Update"></FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 			 <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/comment/comment.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="查看訂單明細"> -->
<%-- 			     <input type="hidden" name="ord_no"  value="${ordVO.ord_no}"> --%>
<%-- 			      <input type="hidden" name="menu_no" value="${O_detailVO.menu_no}"> --%>
<!-- 			     <input type="hidden" name="action"	value="getOne_ord_detail_display"></FORM> -->
<!-- 			</td> -->
			</tr>
                    </c:forEach>
                     </tbody>
                    </table>
                    
<%--                   <%@ include file="page2.file" %> --%>
               
           
        </div>
    </div>
</div>



</body>
</html>