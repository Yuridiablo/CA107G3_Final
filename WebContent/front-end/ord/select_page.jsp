<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.vendor.model.*" %>
<html>
<head>


<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

</head>
<body bgcolor='white'>

<h3>挑選一家廠商開始操作</h3>

<%--   <jsp:useBean id="ordSvc" scope="page" class="com.OrdService" /> --%>
  <jsp:useBean id="vSvc" scope="page" class="com.vendor.model.VendorService" />
     <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/ord/ord.do" >
       <b>廠商編號:</b>
       <select size="1" name="vendor_no">
         <c:forEach var="vVO" items="${vSvc.all}" > 
<%--           <option value="${vVO.vendor_no}">${vVO.vendor_no} --%>
<!-- EL傳參數取值  -->
          <option value="${vVO.vendor_no}">${vSvc.findByPK(vVO.vendor_no).v_name}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="selected">
<%--        <input type="hidden" name="vendor_no" value="${vVO.vendor_no}"> --%>
       <input type="submit" value="送出">
    </FORM>
<br><br><br><br><br>






<table id="table-1">
   
</table>



<h3>資料查詢:</h3>
	
<ul>
  <li><a href='addOrd.jsp'>返回新增頁</a> </li>
</ul>	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllOrd.jsp'>List</a> all Ords.  <br><br></li>
  
  
  <li>
    <FORM METHOD="get" ACTION="<%= request.getContextPath() %>/ord/ord.do">
        <b>輸入訂單編號 </b>
        <input type="text" name="ord_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="ordSvc" scope="page" class="com.ord.model.OrdService" />
   
  <li>
     <FORM METHOD="get" ACTION="<%= request.getContextPath() %>/ord/ord.do" >
       <b>選擇訂單編號:</b>
       <select size="1" name="ord_no">
         <c:forEach var="ordVO" items="${ordSvc.all}" > 
          <option value="${ordVO.ord_no}">${ordVO.ord_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <%-- <li>
     <FORM METHOD="post" ACTION="emp.do" >
       <b>選擇員工姓名:</b>
       <select size="1" name="empno">
         <c:forEach var="empVO" items="${empSvc.all}" > 
          <option value="${empVO.empno}">${empVO.ename}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li> --%>
</ul>


<h3>訂單管理</h3>

<ul>
  <li><a href='<%= request.getContextPath() %>/ord/ord/addOrd2.jsp'>Add</a> a new Ord.</li>
</ul>

</body>
</html>