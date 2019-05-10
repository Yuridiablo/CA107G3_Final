<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<!-- <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" id="bootstrap-css"> -->
<!-- <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script> -->
<!-- <script src="//code.jquery.com/jquery-1.11.1.min.js"></script> -->
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../front-end/css/starrr.css">
<head>

<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.rating input {
    -webkit-appearance:none;
}
	
</style>
<style>
.red{
    color:red;
    }
.form-control {
width:220%;
}

.starrr {
  display: inline-block; }
  .starrr a {
    font-size: 32px;
    padding: 0 1px;
    cursor: pointer;
    color: #FFD119;
    text-decoration: none; }

</style>

</head>
<body>

<div class="container">
    <div>        
        <br style="clear:both">
        
        
   					<FORM METHOD="get" ACTION="<%=request.getContextPath()%>/comment/comment.do" style="margin-bottom: 0px;">
            <div class="form-group col-md-4 ">  
            		  <label id="scoreLabel" for="score">SCORE </label>
  						<div class="rating">
						  <label>
						    <input type="radio" name="score" value="1">
						    	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
						    		<path d="M0 0h24v24H0z" fill="none"/>
						    		<path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
						    		<path d="M0 0h24v24H0z" fill="none"/>
						    	</svg>
						  </label>
						  <label>
						    <input type="radio" name="score" value="2">
						    	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
						    		<path d="M0 0h24v24H0z" fill="none"/>
						    		<path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
						    		<path d="M0 0h24v24H0z" fill="none"/>
						    	</svg>
						  </label>
						  <label>
						    <input type="radio" name="score" value="3">
						    	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
						    		<path d="M0 0h24v24H0z" fill="none"/>
						    		<path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
						    		<path d="M0 0h24v24H0z" fill="none"/>
						    	</svg>
						  </label>
						  <label>
						    <input type="radio" name="score" value="4"  >
						    	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
						    		<path d="M0 0h24v24H0z" fill="none"/>
						    		<path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
						    		<path d="M0 0h24v24H0z" fill="none"/>
						    	</svg>
						  </label>
						  <label>
						    <input type="radio" name="score" value="5" checked >
						    	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
						    		<path d="M0 0h24v24H0z" fill="none"/>
						    		<path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
						    		<path d="M0 0h24v24H0z" fill="none"/>
						    	</svg>
						  </label>
						</div>
                                  
               
                <textarea class="form-control input-sm " type="textarea" name="cmnt" id="message" placeholder="Message" maxlength="140" rows="7"></textarea>
                    <span class="help-block"><p id="characterLeft" class="help-block "></p></span>                    
            </div>  
             
            
        <br style="clear:both">
        <div class="form-group col-md-2">
        <button class="form-control input-sm btn btn-success disabled" id="btnSubmit" name="btnSubmit" type="submit" style="height:35px"> Send</button>    
    
    </div>
    <input type="hidden" name="vendor_no" value="${vendor_no}">
     <input type="hidden" name="ord_no" value="${ord_no}">
            <input type="hidden" name="action"	value="get_one_insert">
     
    </FORM>

</div>
</div>

</body>
<script>
$(document).ready(function(){ 
    $('#characterLeft').text('140 characters left');
    $('#message').keyup(function () {
        var max = 140;
        var len = $(this).val().length;
        if (len >= max) {
            $('#characterLeft').text('You have reached the limit');
            $('#characterLeft').addClass('red');
            $('#btnSubmit').addClass('disabled');            
        } 
        else {
            var ch = max - len;
            $('#characterLeft').text(ch + ' characters left');
            $('#btnSubmit').removeClass('disabled');
            $('#characterLeft').removeClass('red');            
        }
    });    
});
</script>
<script type="text/javascript">
	
	$("label").click(function(){
		var i=($(this).index());
		$("label:lt("+(i+2)+") path:nth-child(2)").css("fill","#fa0");
		$("label:gt("+(i+1)+") path:nth-child(2)").css("fill","#ccc");
	
	})
		
		$(document).ready(function() {
			var i=($("input:checked").parent().index());
			$("label:lt("+(i+2)+") path:nth-child(2)").css("fill","#fa0");
			$("label:gt("+(i+1)+") path:nth-child(2)").css("fill","#ccc");
		});	
</script>
</html>