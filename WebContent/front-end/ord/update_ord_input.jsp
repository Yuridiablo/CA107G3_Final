<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page import="com.ord.model.*"%>

<%
  OrdVO ordVO = (OrdVO) request.getAttribute("ordVO");
//EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)

%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>訂單更改 </title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
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

<style>
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>



<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<div class="row justify-content-center" style="margin-top: 100px">

<FORM METHOD="get" ACTION="<%= request.getContextPath() %>/ord/ord.do" name="form1">
<table>
	<tr>
		<td><font color=red><b>訂單編號:*</b></font>${ordVO.ord_no}</td>
<%-- 		<td>${ordVO.ord_no}</td> --%>
		<input type="hidden" name="ord_no" value="${ordVO.ord_no}"/>
	</tr>
	<tr>
<!-- 		<td>會員編號:</td> -->
		<td>會員編號:<input type="TEXT"  readonly="readonly" name="mem_no" size="45" value="<%=ordVO.getMem_no()%>" /></td>
	</tr>
	<tr>
<!-- 		<td>廠商編號:</td> -->
		<td>廠商編號:<input type="TEXT" readonly="readonly" name="vendor_no" size="45"	value="<%=ordVO.getVendor_no()%>" /></td>
	</tr>
	<tr>
<!-- 		<td>卓號:</td> -->
		<td>卓號:<input type="TEXT" name="tbl_no" size="45" value="<%=ordVO.getTbl_no()%>" /></td>
	</tr>
	<tr>
<!-- 		<td>付款好友1:</td> -->
		<td>付款好友1:<input type="TEXT" name="share_mem_no1" size="45" readonly="readonly"	value="${ordVO.share_mem_no1}" /></td>
	</tr>
	<tr>
<!-- 		<td>付款好友2:</td> -->
		<td>付款好友2:<input type="TEXT" name="share_mem_no1" size="45" readonly="readonly"	value="${ordVO.share_mem_no2}" /></td>
	</tr>
	<tr>
<!-- 		<td>付款金額:</td> -->
		<td>付款金額:<input type="text" name="share_amount" size="45"	value="<%=ordVO.getShare_amount()%>" /></td>
	</tr>
	<tr>
<!-- 		<td>訂位時段:</td> -->
		<td>訂位時段:<input name="booking_time"  type="text"  value="<%=ordVO.getBooking_time()%>"></td>
	</tr>
	<tr>
<!-- 		<td>訂單時間:</td> -->
<jsp:useBean id="now" scope="page" class="java.util.Date"/>
		
		<td>訂單時間:<input type="TEXT" name="ord_time" size="100"	readonly="readonly" value="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/>	" />
		</td>
	</tr>
	<tr>
<!-- 		<td>總金額:</td> -->
		<td>總金額:<input type="TEXT" name="total" size="45"	value="<%=ordVO.getTotal()%>" /></td>
	</tr>
	<tr>
<!-- 		<td>到達時間:</td> -->
		<td>到達時間:<input type="TEXT" name="arrival_time" size="45"	value="${ordVO.arrival_time}"/></td>
	</tr>
	<tr>
<!-- 		<td>結束時間:</td> -->
		<td>結束時間:<input type="TEXT" name="fnish_time" size="45"	value="${ordVO.finish_time}" /></td>
	</tr>
	<tr>
<!-- 		<td>驗證碼:</td> -->
		<td>驗證碼:<input type="TEXT" name="verif_code" size="45" readonly="readonly"	value="<%=ordVO.getVerif_code()%>" /></td>
	</tr>
	<tr>
<!-- 		<td>狀態碼:</td> -->
		<td>狀態碼:<input type="TEXT" name="status" size="45"	value="<%=ordVO.getStatus()%>" /></td>
	</tr>
	<tr>
<!-- 		<td>用餐日期:</td> -->
		<td>用餐日期:<input type="TEXT" name="booking_date"  id="f_date1" size="45"	value="${ordVO.booking_date}" /></td>
	</tr>
	
	
			
					
								
	<jsp:useBean id="ordSvc" scope="page" class="com.ord.model.OrdService"/>
							
									
	人數選擇 :
	<select  style="width: 500px" name="party_size">
											
		<option  name="2" value="2">二人</option>
		<option  name="3" value="3">三人</option>
		<option  name="4" value="4">四人</option>
		<option  name="5" value="5">五人</option>
		<option  name="6" value="6">六人</option>
		<option  name="7" value="7">七人</option>
		<option  name="8" value="8">八人</option>
		<option  name="9" value="10">十人</option>
											
	</select>
									
							
	</div>
						<tr>
								<td>備註:<input type="TEXT" name="notes" size="70"  
										 value="" />
								</td>
						</tr>

	
	


<br>
<input type="hidden" name="action" value="update">

</table>
<input type="submit" value="送出修改"></FORM>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:false,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 		   value: '${ordVO.booking_date}', // value:   new Date(),
           disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
  </script>
</html>