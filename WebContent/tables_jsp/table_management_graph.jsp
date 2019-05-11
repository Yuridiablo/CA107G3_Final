<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ page import="com.tables.model.*" %>
<%@ page import="java.util.*" %>

<%
// 	TablesService tablesService = new TablesService();
// 	List<TablesVO> mglist = tablesService.getAllByVendor_no("V000001");
// 	pageContext.setAttribute("mglist", mglist);
%>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- jQuery UI CSS -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <title>桌位管理_平面圖</title>
	
	<!-- Side Nav -->
	<style type="text/css">
		#sidenavOverlay {
		    display: none;

		    position: fixed;
		    bottom: 0;
		    left: 0;
		    right: 0;
    		top: 0;

    		z-index: 998;

		    background: rgba(0, 0, 0, 0.5);
		}
		#sidenavOverlay.active {
		    display: block;
		}


		#sidenav {
			position: fixed;
		    top: 0;
		    bottom: 0;

		    width: 280px;

		    left: -280px;

		    z-index: 999;
		    background: #fff;
		    color: #000;
		}
		#sidenav.active {
		    left: 0;
		}

		#floorplan1{
			width:100%;
			height:600px;
			background-color: lightgray;
			position: relative;
			
			/* grid background*/
			background-size: 40px 40px;
		    background-image: linear-gradient(to right, #b4bd9e 1px, transparent 1px), linear-gradient(#b4bd9e 1px, transparent 1px);
		
		}
		.tblList .tbl {
			z-index: 3;
		}

		.roundTable{
			width:50px;
			height:50px;
			background-color: lightpink;
			border-radius: 50%;

			text-align: center;
			line-height: 50px;
		}
		
		.squareTable{
			width:50px;
			height:50px;
			background-color: lightpink;

			text-align: center;
			line-height: 50px;
		}

		/*tbl Checkbox*/
		.cbLbl input {
		    display: none;
		}
		.cbDiv {
			background-color: #b4bb9e;
			border: 2px solid #808080;
			border-radius: 50%;
			width: 20px;
			height: 20px;
		}	

		input:checked + .cbDiv {
		  border-radius: 0;
		}
	</style>

  </head>

  <!-- ============================================================================= -->
  <body>

	<!-- Content -->
	<div class="container-fluid">
		<div class="row justify-content-around p-3">

			<!-- Table List -->
			<div class="col-3 bg-light">
			
				<form method="get" action="<%=request.getContextPath()%>/tables/tables.do" id="formTblAxis">
					<button type="submit" class="btn btn-secondary btn-block" id="btnSaveAxis">儲存</button>
					<input type="hidden" name="action" value="updateAxis">
	
					
				<div id="accordion" class="tblList">

				  <!-- 2人桌 -->
				  <div class="card">

				  	<!-- card header -->
				    <div class="card-header p-0" id="headingTblSize1">
				        

				        <div class="btn-group w-100" role="group" aria-label="Basic example">
						  <button type="button" class="btn btn-secondary" data-toggle="collapse" data-target="#collapseTblSize1" aria-expanded="true" aria-controls="collapseTblSize1">
				          2人桌				        
				          </button>
				          <div class="btn-group" role="group">
					          <label class="cbLbl btn btn-secondary mb-0">
							     <input type="checkbox" class="tblType">
							     <div class="cbDiv"></div>
							  </label>
						  </div>
						</div>
				        
				    </div>

					<!-- card body -->
				    <div id="collapseTblSize1" class="collapse p-0" aria-labelledby="headingTblSize1" data-parent="#accordion">
				      <div class="card-body p-0">
				      
				        
<c:forEach var="tablesVO" items="${mglist}">
	<c:if test="${tablesVO.tbl_size == 1}">		
					   <div class="tbl w-100 rounded-0 btn btn-light" id="${tablesVO.tbl_no}" ${tablesVO.tbl_x == null && tablesVO.tbl_y == null ? '' : 'style="display: none;"'} >
					     ${tablesVO.tbl_name}	
						<input type="hidden" name="tbl_no"	value="${tablesVO.tbl_no}">
						<input type="hidden" name="vendor_no"	value="${tablesVO.vendor_no}">
						<input type="hidden" name="tbl_name"	value="${tablesVO.tbl_name}">
						<input type="hidden" name="tbl_size"	value="${tablesVO.tbl_size}">
						<input type="hidden" name="tbl_type"	value="${tablesVO.tbl_type}">
						<input type="hidden" name="tbl_x"	value="${tablesVO.tbl_x}">
						<input type="hidden" name="tbl_y"	value="${tablesVO.tbl_y}">				
					   </div>
	</c:if>
</c:forEach>	
		        
				      </div>
				    </div>

				  </div>

				  <!-- 4人桌 -->
				  <div class="card">

				  	<!-- card header -->
				  	
				    <div class="card-header p-0" id="headingTblSize2">
				    	<div class="btn-group w-100" role="group" aria-label="Basic example">
					        <button type="button" class="btn btn-secondary" data-toggle="collapse" data-target="#collapseTblSize2" aria-expanded="true" aria-controls="collapseTblSize2">
					          4人桌
					        </button>
					          <div class="btn-group" role="group">
						          <label class="cbLbl btn btn-secondary mb-0">
								     <input type="checkbox" class="tblType">
								     <div class="cbDiv"></div>
								  </label>
							  </div>
						  </div>				        
				    </div>

					<!-- card body -->
				    <div id="collapseTblSize2" class="collapse p-0" aria-labelledby="headingTblSize2" data-parent="#accordion">
				      <div class="card-body p-0">
<c:forEach var="tablesVO" items="${mglist}">
	<c:if test="${tablesVO.tbl_size == 2}">		
					   <div class="tbl w-100 rounded-0 btn btn-light" id="${tablesVO.tbl_no}"  ${tablesVO.tbl_x == null && tablesVO.tbl_y == null ? '' : 'style="display: none;"'}>
					     ${tablesVO.tbl_name}	

						<input type="hidden" name="tbl_no"	value="${tablesVO.tbl_no}">
						<input type="hidden" name="vendor_no"	value="${tablesVO.vendor_no}">
						<input type="hidden" name="tbl_name"	value="${tablesVO.tbl_name}">
						<input type="hidden" name="tbl_size"	value="${tablesVO.tbl_size}">
						<input type="hidden" name="tbl_type"	value="${tablesVO.tbl_type}">
						<input type="hidden" name="tbl_x"	value="${tablesVO.tbl_x}">
						<input type="hidden" name="tbl_y"	value="${tablesVO.tbl_y}">
					  </div>				
	</c:if>
</c:forEach>
				      </div>
				    </div>

				  </div>
					
				  <!-- 6人桌 -->
				  <div class="card">

				  	<!-- card header -->
				    <div class="card-header p-0" id="headingTblSize3">
				    	<div class="btn-group w-100" role="group" aria-label="Basic example">
					        <button type="button" class="btn btn-secondary" data-toggle="collapse" data-target="#collapseTblSize3" aria-expanded="true" aria-controls="collapseTblSize3">
					          6人桌
					        </button>
					          <div class="btn-group" role="group">
						          <label class="cbLbl btn btn-secondary mb-0">
								     <input type="checkbox" class="tblType">
								     <div class="cbDiv"></div>
								  </label>
							  </div>
						</div>				        
				    </div>

					<!-- card body -->
				    <div id="collapseTblSize3" class="collapse p-0" aria-labelledby="headingTblSize3" data-parent="#accordion">
				      <div class="card-body p-0">
<c:forEach var="tablesVO" items="${mglist}">
	<c:if test="${tablesVO.tbl_size == 3}">		
					   <div class="tbl w-100 rounded-0 btn btn-light" id="${tablesVO.tbl_no}"  ${tablesVO.tbl_x == null && tablesVO.tbl_y == null ? '' : 'style="display: none;"'}>
					     ${tablesVO.tbl_name}

						<input type="hidden" name="tbl_no"	value="${tablesVO.tbl_no}">
						<input type="hidden" name="vendor_no"	value="${tablesVO.vendor_no}">
						<input type="hidden" name="tbl_name"	value="${tablesVO.tbl_name}">
						<input type="hidden" name="tbl_size"	value="${tablesVO.tbl_size}">
						<input type="hidden" name="tbl_type"	value="${tablesVO.tbl_type}">
						<input type="hidden" name="tbl_x"	value="${tablesVO.tbl_x}">
						<input type="hidden" name="tbl_y"	value="${tablesVO.tbl_y}">
					  </div>					
	</c:if>
</c:forEach>				        
				      </div>
				    </div>

				  </div>
				  	
				  <!-- 8人桌 -->
				  <div class="card">

				  	<!-- card header -->
				    <div class="card-header p-0" id="headingTblSize4">
				    	<div class="btn-group w-100" role="group" aria-label="Basic example">
					        <button type="button" class="btn btn-secondary" data-toggle="collapse" data-target="#collapseTblSize4" aria-expanded="true" aria-controls="collapseTblSize4">
					          8人桌
					        </button>
					          <div class="btn-group" role="group">
						          <label class="cbLbl btn btn-secondary mb-0">
								     <input type="checkbox" class="tblType">
								     <div class="cbDiv"></div>
								  </label>
							  </div>
						</div>				        
				    </div>

					<!-- card body -->
				    <div id="collapseTblSize4" class="collapse p-0" aria-labelledby="headingTblSize4" data-parent="#accordion">
				      <div class="card-body p-0">
<c:forEach var="tablesVO" items="${mglist}">
	<c:if test="${tablesVO.tbl_size == 4}">		
					   <div class="tbl w-100 rounded-0 btn btn-light" id="${tablesVO.tbl_no}"  ${tablesVO.tbl_x == null && tablesVO.tbl_y == null ? '' : 'style="display: none;"'}>
					   		${tablesVO.tbl_name}	

							<input type="hidden" name="tbl_no"	value="${tablesVO.tbl_no}">
							<input type="hidden" name="vendor_no"	value="${tablesVO.vendor_no}">
							<input type="hidden" name="tbl_name"	value="${tablesVO.tbl_name}">
							<input type="hidden" name="tbl_size"	value="${tablesVO.tbl_size}">
							<input type="hidden" name="tbl_type"	value="${tablesVO.tbl_type}">
							<input type="hidden" name="tbl_x"	value="${tablesVO.tbl_x}">
							<input type="hidden" name="tbl_y"	value="${tablesVO.tbl_y}">
					  </div>					
	</c:if>
</c:forEach>				        
				      </div>
				    </div>
						
				  </div>
				  
				  <!-- 10人桌 -->
				  <div class="card">

				  	<!-- card header -->
				    <div class="card-header p-0" id="headingTblSize5">
				    	<div class="btn-group w-100" role="group" aria-label="Basic example">
					        <button type="button" class="btn btn-secondary" data-toggle="collapse" data-target="#collapseTblSize5" aria-expanded="true" aria-controls="collapseTblSize5">
					          10人桌
					        </button>
					          <div class="btn-group" role="group">
						          <label class="cbLbl btn btn-secondary mb-0">
								     <input type="checkbox" class="tblType">
								     <div class="cbDiv"></div>
								  </label>
							  </div>
						</div>				        
				    </div>

					<!-- card body -->
				    <div id="collapseTblSize5" class="collapse p-0" aria-labelledby="headingTblSize5" data-parent="#accordion">
				      <div class="card-body p-0">
<c:forEach var="tablesVO" items="${mglist}">
	<c:if test="${tablesVO.tbl_size == 5}">		
					   <div class="tbl w-100 rounded-0 btn btn-light" id="${tablesVO.tbl_no}"  ${tablesVO.tbl_x == null && tablesVO.tbl_y == null ? '' : 'style="display: none;"'}>
					     ${tablesVO.tbl_name}

						<input type="hidden" name="tbl_no"	value="${tablesVO.tbl_no}">
						<input type="hidden" name="vendor_no"	value="${tablesVO.vendor_no}">
						<input type="hidden" name="tbl_name"	value="${tablesVO.tbl_name}">
						<input type="hidden" name="tbl_size"	value="${tablesVO.tbl_size}">
						<input type="hidden" name="tbl_type"	value="${tablesVO.tbl_type}">
						<input type="hidden" name="tbl_x"	value="${tablesVO.tbl_x}">
						<input type="hidden" name="tbl_y"	value="${tablesVO.tbl_y}">	
					  </div>				
	</c:if>
</c:forEach>				        
				      </div>
				    </div>

				  </div>
				  
				  			  				  				  				  
  
				</div>
				</form>
			</div>

			<!-- Table Floorplan -->
			<div class="col-9">
				
					<div id="floorplan1">
<c:forEach var="tablesVO" items="${mglist}">
	<c:if test="${tablesVO.tbl_x != null && tablesVO.tbl_y != null}">						
						<div class="${tablesVO.tbl_type == 1 ? 'square' : 'round'}Table" id="${tablesVO.tbl_no}c" title="${tablesVO.tbl_no}" style="position: absolute; opacity: 1; z-index: 800; left: ${tablesVO.tbl_x}px; top: ${tablesVO.tbl_y}px;">
							${tablesVO.tbl_name}
						</div>
	</c:if>
</c:forEach>					
					</div>	
		
			</div>

		</div>
	</div>


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
    <script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<!-- jQuery UI -->
	<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!-- Side Nav -->
    <script type="text/javascript">
        $(document).ready(function () {                     
            $('#btnSidenav').on('click', function () {
                $('#sidenavOverlay').addClass('active');
                $('#sidenav').addClass('active');             
            });
            $('#sidenavOverlay').on('click', function () {
                $('#sidenavOverlay').removeClass('active'); 
                $('#sidenav').removeClass('active');              
            });
        });
    </script>
	
	<!-- floorplan -->    
	<script type="text/javascript">
		$( function() {
			$( "#floorplan1" ).resizable();

			// $( ".tblList .tbl" ).draggable();
			$( ".tbl" ).draggable();
			$( ".tbl" ).draggable( "option", "helper", dragHelper);
			$( ".tbl" ).draggable( "option", "opacity", 0.35 );
			$( ".tbl" ).draggable( "option", "zIndex", 800 );
			$( ".tbl" ).draggable( "option", "cursorAt", { left: 0, top: 0 } );
			$( ".tbl" ).draggable( "option", "cursor", "crosshair" );
			$( ".tbl" ).draggable( "option", "scope", "tasks" );
			$( ".tbl" ).draggable( "option", "appendTo", $( "#floorplan1" ) );

			$( "#floorplan1" ).droppable();
			$( "#floorplan1" ).droppable( "option", "scope", "tasks" );
			$( "#floorplan1" ).droppable({
				  drop: function( event, ui ) {
		        
				    $(this).append(

			            ui.helper.clone(false).css({
			            position: 'absolute',
			            left: ui.position.left,
			            top: ui.position.top,
			            opacity: 1
			        	}).attr({
			        		id: ui.helper.attr("id"),
			        		title: ui.helper.attr("title")
			        	}).draggable({
			        		scope: "tasks",
			        		containment: "parent"

			        	}).dblclick(function() {
			        		$("#" + this.title).css("display", "inline-block");
						    this.remove();
						})

			        );

				    ui.draggable.css({display: 'none'});
				 }
			});
			
			
			$("#btnSaveAxis").on("click", function(e){
				var tbl_x_all = document.querySelectorAll("#formTblAxis input[name=tbl_x]");
				for (var i = 0; i < tbl_x_all.length; i++) {
					if (document.getElementById(tbl_x_all[i].parentNode.id + 'c')) {
						tbl_x_all[i].value = document.getElementById(tbl_x_all[i].parentNode.id + 'c').offsetLeft;
					} else {
						tbl_x_all[i].value = "";
					}
				}
				
				var tbl_y_all = document.querySelectorAll("#formTblAxis input[name=tbl_y]");
				for (var i = 0; i < tbl_y_all.length; i++) {
					if (document.getElementById(tbl_y_all[i].parentNode.id + 'c')) {
						tbl_y_all[i].value = document.getElementById(tbl_y_all[i].parentNode.id + 'c').offsetTop;
					} else {
						tbl_y_all[i].value = "";
					}
				}
				
				var tbl_type_all = document.querySelectorAll("#formTblAxis input[name=tbl_type]");
				for (var i = 0; i < tbl_type_all.length; i++) {
					if (document.getElementById(tbl_type_all[i].parentNode.id + 'c')) {
						tbl_type_all[i].value = document.getElementById(tbl_y_all[i].parentNode.id + 'c').classList.contains("roundTable") ? "2" : "1";
					} else {
						tbl_type_all[i].value = "";
					}
				}
				//e.preventDefault();
			});
			
			$(".roundTable, .squareTable").draggable().dblclick(function() {
        		$("#" + this.title).css("display", "inline-block");
			    this.remove();
			});

		} );
		function dragHelper(){
			var table = document.createElement("div");
			console.log();
			var tblTypeClass;
			if ($(this).parents(".card").find("input:checkbox")[0].checked) {
				tblTypeClass = "squareTable";
			} else {
				tblTypeClass = "roundTable";
			}
			table.setAttribute("class", tblTypeClass);
			table.setAttribute("id", this.id + "c");
			table.innerHTML = this.innerHTML;
			table.title = this.id;
			return table;
		}


		

	</script>

  </body>
</html>