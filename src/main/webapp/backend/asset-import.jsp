<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ page import="utilities.UtilityMethods"%>



<meta charset="utf-8">

<%-- 
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
		
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		--%>

<%-- Use this to get the base path to prevent using (.) or (..) which may not work accross all paths
		as some will need one dot and others will need two according to their path --%>
<%
	String webAddress = request.getContextPath();

//Load utility methods
UtilityMethods um = new UtilityMethods();
%>

<link rel="stylesheet"
	href="<%out.println(webAddress);%>/lib/css/bootstrap.min.css"
	type="text/css" />

<link rel="stylesheet"
	href="<%out.println(webAddress);%>/lib/css/jquery-ui.min.css"
	type="text/css" />

<link rel="stylesheet"
	href="<%out.println(webAddress);%>/lib/fontawesome/css/fontawesome-all.min.css"
	type="text/css" />

<%-- Private css --%>
<link rel="stylesheet"
	href="<%out.println(webAddress);%>/lib/css/style.css" type="text/css" />

<script src="<%out.println(webAddress);%>/lib/js/jquery-3.5.1.min.js"
	type="text/javascript" /></script>

<script src="<%out.println(webAddress);%>/lib/js/bootstrap.min.js"
	type="text/javascript" /></script>

<script
	src="<%out.println(webAddress);%>/lib/js/jquery.twbsPagination.min.js"
	type="text/javascript" /></script>

<script src="<%out.println(webAddress);%>/lib/js/jquery-ui.min.js"
	type="text/javascript" /></script>

<%-- Private js --%>
<script src="<%out.println(webAddress);%>/lib/js/style.js"
	type="text/javascript" /></script>

<%-- TinyMCE local --%>
<%--<script src="<%out.println(webAddress); %>/lib/js/tinymce.min.js" type="text/javascript"/></script> --%>

<%-- TinyMCE CDN --%>
<!-- <script -->
<!-- 	src="https://cdn.tiny.cloud/1/cngq18m28rzub1klwipwdpwxa10l8txyd2yrvffuqm5vvszw/tinymce/5/tinymce.min.js" -->
<!-- 	referrerpolicy="origin"></script> -->
<script
	src="https://cdn.tiny.cloud/1/cngq18m28rzub1klwipwdpwxa10l8txyd2yrvffuqm5vvszw/tinymce/5/tinymce.min.js"></script>

<%--Favicon icon bar in browser tab --%>
<link rel="icon"
	href="<%out.println(webAddress);%>/lib/assets/settings/swk-small.png"
	type="image/icon type">
