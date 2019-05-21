<%@page import="com.ord.controller.OrdVOn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<%@ page import="com.ord.model.*" %>
<%@ page import="com.vendor.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.*" %>
<%@ page import="com.tables.model.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.vendor.model.*" %>

<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<title>訂單管理_桌位安排</title>
	
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="bootstrap/bootstrap.min.css">



	<%@ include file="/ord_jsp/navbar/nav_css.txt" %>


  </head>

  <!-- ============================================================================= -->
  <body>

  	<%@ include file="navbar/navbar.txt" %>

	
	
	<%@ include file="/ord_jsp/navbar/side_navbar.txt" %>
	
	請先設定開始營業時間即結束營業時間
	
	
	
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="bootstrap/jquery-3.3.1.min.js"></script>
	<script src="bootstrap/popper.min.js"></script>
	<script src="bootstrap/bootstrap.min.js"></script> 

<%@ include file="/ord_jsp/navbar/side_navbar_js.txt" %>
   
  </body>
</html>