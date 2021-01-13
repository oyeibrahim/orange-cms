<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="utilities.UtilityMethods"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


	<%
		//To print active in each active navbar
	UtilityMethods um = new UtilityMethods();
	%>

	<%="UtilityMethods.getRelativeUrl : " + um.getRelativeUrl(request)%><br>
	<br>
	<%="UtilityMethods.getRelativeUrlWithQueryString : " + um.getRelativeUrlWithQueryString(request) %><br>
	<br>
	<%="UtilityMethods.getBaseUrl : " + um.getBaseUrl(request)%><br>
	<br>
	<%="UtilityMethods.getBaseUrl(request, '/path/path/path') : " + um.baseUrl(request, "/path/path/path") %><br>
	<br>
	<%="UtilityMethods.fullPath : " + um.fullPath(request)%><br>
	<br>
	<%="UtilityMethods.fullPathWithQueryString : " + um.fullPathWithQueryString(request) %><br>
	<br>
	<%="UtilityMethods.getRealFile : " + um.getRealFile(request, request.getContextPath())%><br>
	<br>
	<br>


	<hr>

	<%="request.getRequestURL() : " + request.getRequestURL().toString()%><br>
	<%
		String whole = request.getRequestURL().toString();
	%><br>
	<%=whole.substring(0, whole.indexOf("/orange"))%><br>
	<br>
	<br>
	<%="getContentLength : " + request.getContentLength()%><br>
	<%="getContextPath : " + request.getContextPath()%><br>
	<%="getLocalAddr : " + request.getLocalAddr()%><br>
	<%="getLocalName : " + request.getLocalName()%><br>
	<%="getLocalPort : " + request.getLocalPort()%><br>
	<%="getMethod : " + request.getMethod()%><br>
	<%="getPathInfo : " + request.getPathInfo()%><br>
	<%="getPathTranslated : " + request.getPathTranslated()%><br>
	<%="getProtocol : " + request.getProtocol()%><br>
	<%="getQueryString : " + request.getQueryString()%><br>
	<%="getRemoteAddr : " + request.getRemoteAddr()%><br>
	<%="getRemoteHost : " + request.getRemoteHost()%><br>
	<%="getRemotePort : " + request.getRemotePort()%><br>
	<%="getRemoteUser : " + request.getRemoteUser()%><br>
	<%="getRequestURI : " + request.getRequestURI()%><br>
	<%="getScheme : " + request.getScheme()%><br>
	<%="getServerName : " + request.getServerName()%><br>
	<%="getServerPort : " + request.getServerPort()%><br>
	<%="getServletPath : " + request.getServletPath()%><br>
	<%="hashCode : " + request.hashCode()%><br>
	<%="toString : " + request.toString()%><br>
	<%="getAttributeNames : " + request.getAttributeNames().toString()%><br>
	<%="getClass : " + request.getClass()%><br>
	<%="getLocale : " + request.getLocale()%><br>
	<%="getLocales : " + request.getLocales().toString()%><br>
	<%="getParameterMap : " + request.getParameterMap().toString()%><br>
	<%="getParameterNames : " + request.getParameterNames().toString()%><br>
	<%="getReader : " + request.getReader().toString()%><br>
	<%="getRequestURL : " + request.getRequestURL()%><br>
	<%="getSession : " + request.getSession().toString()%><br>
	<%="getUserPrincipal : " + request.getUserPrincipal()%><br>
	<%="isSecure : " + request.isSecure()%><br>
	<br>
	<br>

</body>
</html>