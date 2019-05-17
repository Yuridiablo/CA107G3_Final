
<%@page import="com.member_wallet_list.model.Member_Wallet_ListService"%>
<%@page import="com.member_wallet_list.model.Member_Wallet_ListVO"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	List<Member_Wallet_ListVO> list = (List<Member_Wallet_ListVO>) session.getAttribute("list");
// 	if (request.getAttribute("list") == null) {
// 		Member_Wallet_ListService walletSvc = new Member_Wallet_ListService();
// 		list = walletSvc.getAll();
// 		pageContext.setAttribute("list", list);
// 	} else {
// 		list = (List<Member_Wallet_ListVO>) request.getAttribute("list");
// 	}
%>

<jsp:useBean id="feaSvc" scope="page" class="com.feature_detail.model.Feature_detailService"></jsp:useBean>

<!doctype html>
<html lang="en">

<head>
<!-- <!-- Required meta tags -->
<!-- <meta charset="utf-8"> -->
<!-- <meta name="viewport" -->
<!-- 	content="width=device-width, initial-scale=1, shrink-to-fit=no"> -->
<!-- <!-- Bootstrap CSS -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" -->
<!-- 	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" -->
<!-- 	crossorigin="anonymous"> -->
<title></title>
<style type="text/css">
.container {
	margin-top: 5px;
}

.buttonInTop {
	margin: 5px;
}

.serchBar {
	display: none;
}

.btn-default{
	background-color: #212121;
	color: white;
}

.rest{
	font-size: 18px;
	background-color: green;
	height:38px;
	padding:5px;
	border-radius: 5px;	
	color:white;
}
#deposit{
	height:38px;
}
.creditnum{
	background-color: white;
	border: none;
}
</style>
</head>

<body>

	<div class="container ">
		<div class="row justify-content-center">
			<div class="col-12">
				<div class="col-12 row" id="buttonBar">
					<div class="col-form-label justify-content-end">
						<label class="rest" id="rest">目前餘額:<fmt:formatNumber value="${memberVO.mem_balance}" maxFractionDigits = "0"/>元</label>
					</div>
						<button type="button" class="btn btn-outline-success buttonInTop"
							id="deposit" data-toggle="modal" data-target="#modalForDeposit">儲值</button>
					<form method="post"
						action="${pageContext.request.contextPath}/member/member.do">
						<input type="hidden" name="action" value="myWallet">
						<button type="submit" class="btn btn-outline-success buttonInTop"
							id="allEmp">所有錢包異動</button>
					</form>
					
				</div>
				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col">日期</th>
							<th scope="col">支出</th>
							<th scope="col">儲值</th>
							<th scope="col">說明</th>
						</tr>
					</thead>
					<tbody>
						<%@ include file="pagesForDeposit/page1.file"%>
						<c:forEach var="walletVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
							<tr>
								<th scope="row">${walletVO.list_time}</th>
								<td>${walletVO.list_wit}</td>
								<td>${walletVO.list_dep}</td>
								<td>
									<c:if test="${walletVO.list_stat==1}">
										自付訂單
									</c:if>
									<c:if test="${walletVO.list_stat==2}">
										代付訂單
									</c:if>
									<c:if test="${walletVO.list_stat==3}">
										提領
									</c:if>
									<c:if test="${walletVO.list_stat==4}">
										儲值
									</c:if>
								</td>
<!-- 								<td> -->
<!-- 									<form method="post" -->
<%-- 										action="${pageContext.request.contextPath}/employee/Employee.do"> --%>
<!-- 										<input type="hidden" name="action" value="updateEmp"> -->
<!-- 										<input type="hidden" name="emp_no" -->
<%-- 											value="${employeeVO.emp_no}"> --%>
<!-- 										<button type="submit" class="btn btn-outline-danger">確定</button> -->
<!-- 									</form> -->
<!-- 								</td> -->
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<%@ include file="pagesForDeposit/page2.file"%>

			</div>
		</div>
	</div>
	
	
	<div class="modal fade " id="modalForDeposit" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
				
			<div class="modal-body">
			<form action="${pageContext.request.contextPath}/member/member.do" method="post" id="my-form" enctype="multipart/form-data" >
			<input type="hidden" name="action" value="deposit">
			<input id="flag" type="hidden" name="flag" value="">
<!-- =================================================================================== -->
        
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">選擇儲值金額:</label>
            <select name="list_dep" class="custom-select mr-sm-2" id="inlineFormCustomSelect">
        		<option value="500" selected>500元</option>
       			<option value="1000">1000元</option>
       			<option value="5000">5000元</option>
      		</select>
          </div>
          <label for="recipient-name" class="col-form-label">請輸入信用卡卡號:</label>
          <div class="input-group">
          
            <div class="input-group-text creditnum">
      			 <input type="text" maxlength="4" id="credit1">
      			 <label for="recipient-name" class="col-form-label">-</label>
      			 <input type="text" maxlength="4" id="credit2">
      			 <label for="recipient-name" class="col-form-label">-</label>
      			 <input type="text" maxlength="4" id="credit3">
      			 <label for="recipient-name" class="col-form-label">-</label>
      			 <input type="text" maxlength="4" id="credit4">
    		</div>
          </div>
          <label for="recipient-name" class="col-form-label">請輸入信用卡安全碼:</label>
          <div class="input-group-text creditnum">
          	<input type="text" maxlength="3" id="credit5">
          </div>
          <div>
          	<button type="button" id="fillCreditMsg"></button>
          </div>
           <div class="container">
               <div class="row">
               		<img src="" class="col" id="output">
               </div>
				<button type="submit" class="btn btn-warning col submitbut">確定送出</button>
           </div>
       
<!-- =================================================================================== -->
			</form>
			</div>


			 	
		</div>
	</div>
</div>
	
	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
<!-- 	<script -->
<!-- 		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" -->
<!-- 		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" -->
<!-- 		crossorigin="anonymous"></script> -->
<!-- 	<script -->
<!-- 		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" -->
<!-- 		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" -->
<!-- 		crossorigin="anonymous"></script> -->

	<script type="text/javascript">
		$(document).ready(function() {
			$("#serchEmp").on('click', function() {
				$("#serchBar").removeClass('serchBar');
			});
			$("#allEmp").on('click', function() {
				$("#serchBar").addClass('serchBar');
			});
			$("#fillCreditMsg").on('click', function() {
				$("#credit1").val("4783");
				$("#credit2").val("3800");
				$("#credit3").val("1602");
				$("#credit4").val("7799");
				$("#credit5").val("466");
			});

			var randomFlag = Math.floor(Math.random()*10000+1);
	 		$("#flag").val(randomFlag);
			
		});
	</script>
</body>
</html>