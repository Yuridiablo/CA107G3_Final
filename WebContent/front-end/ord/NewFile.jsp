<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ord.model.*"%>
<!DOCTYPE html>
<html>
<head>
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

<meta charset="UTF-8">
<title>修改訂單</title>
</head>
<body>

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
<div class="container">
    <div class="row">
        <div class="col-md-12">
        <table class="table" id="xxx">
        <div class="alert alert-info">
               訂單列表</div>
            <div class="alert alert-success" style="display:none;">
                <span class="glyphicon glyphicon-ok"></span> Drag table row and change Order</div>
            <FORM METHOD="get" ACTION="<%= request.getContextPath() %>/ord/ord.do" name="form1">
                
                    <tr>
                        <th><font color=red><h4>訂單編號:*</h4></font></th>
						<th>會員編號:<br><hr style="width: 90%; height: 1px; border: none; background-color: #282828"><font color="blue">分攤會員</font></th>
						<th>廠商編號</th>
						<th>卓位編號</th>
						<th>人數</th>
<!-- 						<th>分攤會員編號</th> -->
<!-- 						<th>分攤會員編號</th> -->
						<th>分攤金額</th>
						<th>訂單成立時間</th>
						<th>訂位日期</th>
						<th>訂位時間</th>
						<th>備註</th>
						<th>總金額</th>
						<th>開始用餐時間</th>
						<th>結束用餐時間</th>
						<th>驗證碼</th>
						<th>訂單狀態</th>
                    </tr>
                
           
              
                 
			
			
               

                     <tr class="warning">
                        <td>${ordVO.ord_no}</td>
                        <input type="hidden" name="ord_no" value="${ordVO.ord_no}"/>
						<td>${ordVO.mem_no}<br>
						<hr><font color="blue">${ordVO.share_mem_no1}<br></font>
						<hr><font color="blue">${ordVO.share_mem_no2}</font></td>
						<td>${ordVO.vendor_no}</td>
						<td>${ordVO.vendor_no}</td>
						<td>${ordVO.tbl_no}</td>
						<td>${ordVO.party_size}</td>
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
						<td>${ordVO.share_amount}</td>
						<td>${ordVO.ord_time}</td> 
						<td><input type="TEXT" name="booking_date"  id="f_date1" size="45"	value="${ordVO.booking_date}"></td> 
						<td>${ordVO.booking_time}</td> 
						<td><input type="TEXT" name="notes" size="45"	value="${ordVO.notes}" /></td> 
						<td><input type="TEXT" name="total" size="45"	value="${ordVO.total}" /></td> 
						<td><input type="TEXT" name="total" size="45"	value="${ordVO.arrival_time}" /></td> 
						<td><input type="TEXT" name="total" size="45"	value="${ordVO.finish_time}" /></td> 
						<td>${ordVO.verif_code}</td> 
						<td><input type="TEXT" name="total" size="45"	value="${ordVO.status}" /></td> 
						<c:if test ="${ordVO.status==0}" var="xxx">
						<td>已付款</td> 
						</c:if>
						<c:if test ="${ordVO.status==1}" var="xxx">
						<td>已用餐</td> 
						</c:if>
						<c:if test ="${ordVO.status==2}" var="xxx">
						<td>已取消</td> 
						</c:if>
					<input type="hidden" name="action" value="update">

					</table>
					<input type="submit" value="送出修改"></FORM>	
                    
			  
		
                    
                 
               
           
        </div>
    </div>
</div>


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

</body>
</html>