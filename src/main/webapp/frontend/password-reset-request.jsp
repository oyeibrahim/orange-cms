<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>

<%@ page import="userInterfaces.SiteAlerts"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Orange | Password Reset Request</title>

</head>


<body>

	<%--Import Header--%>
	<%@ include file="header.jsp"%>


	<form class="form-signin needs-validation shadow"
		action="PasswordResetRequestController" method="post" id="auth-form"
		style="margin-top: 100px; margin-bottom: 100px; border-radius: 20px;">

		<div class="text-center mb-4">
			<img class="mb-4 img-thumbnail shadow"
				src="<%=um.baseUrl(request, "")%>/lib/assets/settings/swk-square-medium.png"
				alt="" width="72" height="72">
			<h1 class="h3 mb-3 font-weight-normal">Password Reset</h1>
			<p>Input your registered email address below, you will get a
				password reset link</p>
		</div>

		<%-- //print error message if failed login --%>

		<%
			//check if there are messages to print
		if (session.getAttribute("NoPasswordResetPermissionMessage") != null) {
			//use the class for printing messages
			SiteAlerts sa = new SiteAlerts();
			//call the method ang get its result
			String message = sa.showAlert(request, response);
			out.println(message);
		}
		%>
		<%-- End error message printing --%>


		<div class="form-label-group">
			<input type="email" id="inputEmail" class="form-control"
				placeholder="Email address" name="email" required autofocus>
			<label for="inputEmail">Email address</label>
		</div>

		<button class="btn btn-lg btn-primary btn-block" type="submit"
			id="submit-btn">Request Password reset link</button>
		<button class="btn btn-lg btn-primary btn-block" id="submit-ani"
			disabled>
			<span class="spinner-grow spinner-grow-sm"></span> Working...
		</button>

		<%-- show only if not logged in --%>
		<c:if
			test="${sessionScope['Username'] == null && sessionScope['Firstname'] == null && sessionScope['Email'] == null}">
			<p class="mt-5 mb-3 text-muted d-flex justify-content-center"
				style="margin-top: -100px; margin-bottom: 500px;">
				Don't have an account yet?&nbsp;&nbsp;<a
					href="<%=um.baseUrl(request, "/register")%>"
					style="text-decoration: none;">Register </a>
			</p>
			<hr>
		</c:if>
	</form>

	<%--Import Footer --%>
	<%@ include file="footer.jsp"%>

</body>
</html>