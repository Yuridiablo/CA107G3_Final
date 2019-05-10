<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ page import="java.util.*"%>
<%@ page import="com.ord_detail.model.*"%>

    
<!DOCTYPE html>
<html>


<%
	Order_DetailService O_detailSvc = new Order_DetailService();
	List<Order_DetailVO> list = O_detailSvc.findbyOrd_no("20190416-000005");
// 	List<Order_DetailVO> list = O_detailSvc.findbyOrd_no("20190416-000005");
	pageContext.setAttribute("list",list);
%>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<jsp:useBean id="vendorSvc" scope="page" class="com.vendor.model.VendorService" />
<jsp:useBean id="Order_DetailSvc" scope="page" class="com.ord_detail.model.Order_DetailService" />
<jsp:useBean id="OrdSvc" scope="page" class="com.ord.model.OrdService" />
<jsp:useBean id="MemSvc" scope="page" class="com.member.model.MemberService" />
<jsp:useBean id="MenuSvc" scope="page" class="com.restaurant_menu.model.Restaurant_MenuService" />


<style>

#xxx{
    vertical-align: ;
    }
</style>

<body>



<div class="container">
    <div class="row">
        <div class="col-md-12">
        
            <div class="alert alert-info">
               訂單明細列表</div>
            <div class="alert alert-success" style="display:none;">
                <span class="glyphicon glyphicon-ok"></span> Drag table row and change Order</div>
            <table class="table" id="xxx">
                <thead>
                    <tr>
                        <th>
                          訂單編號
                        </th>
                         <th>
                           餐廳名稱
                        </th>
                        <th>
                           餐點名稱
                        </th>
                        <th>
                          數量
                        </th>
                         <th>
                          價格
                        </th>
                         <th>
                          
                        </th>
                    </tr>
                </thead>
                <tbody>
                 
			<%@ include file="pages/page1.file" %>
			
                <c:forEach var="O_detailVO" items="${Order_DetailSvc.findbyOrd_no(param.ord_no)}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
              		
              		<c:set var="memuVO" value="${MenuSvc.findByPK(O_detailVO.menu_no) }"/>
              		<c:set var="ordVO" value="${OrdSvc.getOneOrd(O_detailVO.ord_no)}"/>
              		<c:set var="ordlist" value="${ordVO.vendor_no}"/>
              		<c:set var="vVO" value="${vendorSvc.findByPK(ordlist)}"/>
                     <tr class="warning">
                        <td>
                            ${O_detailVO.getOrd_no()}
                        </td>
                         <td>
                            ${vVO.v_name}
                        </td>
                        <td>
                             ${memuVO.menu_name}
                        </td>
                        <td>
                            ${O_detailVO.qty}
                        </td>
                        <td>
                            ${(O_detailVO.price)*(O_detailVO.qty)}
                        </td>
                        <td>
	                	<a href="<%=request.getContextPath()%>/ord/ord/listAllOrd.jsp" >
							<button class="btn btn-success " >查看其他訂單<span class="glyphicon glyphicon-shopping-cart"></span></button>
						</a>
					</td>
                    
<!-- 			  <td> -->
<%-- 			  <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/o_detail/o_detail.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="修改">  -->
<%-- 			     <input type="hidden" name="ord_no"      value="${O_detailVO.getOrd_no()}"> --%>
<%-- 			     <input type="hidden" name="menu_no"      value="${O_detailVO.menu_no}"> --%>
<%-- 			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller--> --%>
<!-- 			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM> -->
<!-- 			</td> -->
			
			</tr>
                    </c:forEach>
                    </table>
                  <%@ include file="pages/page2.file" %>
                </tbody>
           
        </div>
    </div>
</div>


</body>


<script>
(function ($) {
    $.fn.extend({
        tableAddCounter: function (options) {

            // set up default options 
            var defaults = {
                title: '#',
                start: 1,
                id: false,
                cssClass: false
            };

            // Overwrite default options with user provided
            var options = $.extend({}, defaults, options);

            return $(this).each(function () {
                // Make sure this is a table tag
                if ($(this).is('table')) {

                    // Add column title unless set to 'false'
                    if (!options.title) options.title = '';
                    $('th:first-child, thead td:first-child', this).each(function () {
                        var tagName = $(this).prop('tagName');
                        $(this).before('<' + tagName + ' rowspan="' + $('thead tr').length + '" class="' + options.cssClass + '" id="' + options.id + '">' + options.title + '</' + tagName + '>');
                    });

                    // Add counter starting counter from 'start'
                    $('tbody td:first-child', this).each(function (i) {
                        $(this).before('<td>' + (options.start + i) + '</td>');
                    });

                }
            });
        }
    });
})(jQuery);

$(document).ready(function () {
    $('.table').tableAddCounter();
    $.getScript("http://code.jquery.com/ui/1.9.2/jquery-ui.js").done(function (script, textStatus) { $('tbody').sortable();$(".alert-info").alert('close');$(".alert-success").show(); });
});
</script>
</html>