<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<meta charset="UTF-8">
<title>修改訂單</title>
</head>
<body>
<jsp:useBean id="now" scope="page" class="java.util.Date"/>


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
<div class="col-md-12">
    <div class="form-area">  
       <FORM METHOD="get" ACTION="<%= request.getContextPath() %>/ord/ord.do" name="form1">
        <br style="clear:both">
                    <h3 style="margin-bottom: 20px; text-align: center;">訂單資訊修改</h3>
                    <div class="form-group">
						<font color=red><b>訂單編號:*</b></font>${ordVO.ord_no}
						<input type="hidden" name="ord_no" value="${ordVO.ord_no}"/>
					</div>
    				<div class="form-group">
						會員編號：<input type="text" class="form-control" readonly="readonly" id="mem_no" name="mem_no" value="${ordVO.mem_no}" required>
					</div>
					<div class="form-group">
						廠商編號：<input type="text" class="form-control"readonly="readonly" id="vendor_no" name="vendor_no" value="${ordVO.vendor_no }"required>
					</div>
					<div class="form-group">
						卓號：<input type="text" class="form-control" id="tbl_no" name="tbl_no" value="${ordVO.tbl_no}">
					</div>
					<div class="form-group">
						用餐日期:<input type="TEXT" class="form-control" name="booking_date"  id="f_date1" size="45"	value="${ordVO.booking_date}" required>
					</div>
					
					<div class="form-group">
						人數選擇 :
									<td><select  style="width: 500px" name="party_size">
																			
										<option  name="2" value="2">二人</option>
										<option  name="3" value="3">三人</option>
										<option  name="4" value="4">四人</option>
										<option  name="5" value="5">五人</option>
										<option  name="6" value="6">六人</option>
										<option  name="7" value="7">七人</option>
										<option  name="8" value="8">八人</option>
										<option  name="9" value="10">十人</option>
																			
									</select></td>
					</div>
					<div class="form-group">
						狀態:
						<td><select  style="width: 500px" name="status"required>
										<option  name="status" value="">-----請選擇-----</option>									
										<option  name="status" value="0">已付款</option>
										<option  name="status" value="1">已用餐</option>
										<option  name="status" value="2">已取消</option>
										
										
																			
									</select></td>
					</div>
					
					
					<div class="form-group">
						付款好友1:<input type="TEXT" class="form-control" name="share_mem_no1"  readonly="readonly" id="share_mem_no1" size="45"	value="${ordVO.share_mem_no1}" >
					</div>
					<div class="form-group">
						付款好友2:<input type="TEXT" class="form-control" name="share_mem_no2"  readonly="readonly" id="share_mem_no2" size="45"	value="${ordVO.share_mem_no2}" >
					</div>
					<div class="form-group">
						分攤總金額:<input type="number" class="form-control" name="share_amount"  id="share_amount" size="10"	value="${ordVO.share_amount}" >
					</div>
					
					<div class="form-group">
						訂位時段<input type="number" class="form-control" name="booking_time"  id="booking_time" maxlength="5" value="${ordVO.booking_time}" required>
					</div>
					
					<div class="form-group">
						訂單時間:<input type="TEXT" class="form-control" name="ord_time" size="20"	readonly="readonly" value= "<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/>" required>
					</div>
					<div class="form-group">
						總金額:<input type="TEXT" class="form-control" name="total" size="10"	value="${ordVO.total}" />
					</div>
					<div class="form-group">
						到達時間:<input type="text" class="form-control" name="arrival_time"  readonly="readonly" value="${ordVO.arrival_time}" />
					</div>
					<div class="form-group">
						結束時間:<input type="number" class="form-control" name="fnish_time"  readonly="readonly" value="${ordVO.finish_time}" />
					</div>
					<div class="form-group">
						驗證碼:<input type="TEXT" class="form-control" name="verif_code" maxlength="10"readonly="readonly"	value="${ordVO.verif_code}" required/>
					</div>
					
                    <div class="form-group">
                    備註：<textarea class="form-control" type="textarea" id="notes" maxlength="70" rows="3"></textarea>
                        <span class="help-block"><p id="characterLeft" class="help-block "></p></span>                    
                    </div>
            	<input type="hidden" name="action" value="update">
        <button type="submit" id="submit" name="submit" class="btn btn-primary pull-right">送出修改</button>
        </form>
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