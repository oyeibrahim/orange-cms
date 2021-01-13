<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ page import="userInterfaces.SiteAlerts"
	import="utilities.UtilityMethods"%>

<!DOCTYPE html>
<html>
<head>


<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Orange | Login Page</title>

</head>


<body>

	<%--Import Header--%>
	<%@ include file="header.jsp"%>

	<%--Can't access if logged in--%>
	<%
		if (session.getAttribute("Username") != null && session.getAttribute("Firstname") != null
			&& session.getAttribute("Email") != null) {

		response.sendRedirect(um.baseUrl(request, ""));

		//to prevent moving forward after this
		return;

	}
	%>


	<form class="form-signin needs-validation shadow"
		action="LoginController" method="post" id="auth-form"
		style="margin-top: 100px; margin-bottom: 100px; border-radius: 20px;">

		<div class="text-center mb-4">
			<img class="mb-4 img-thumbnail shadow"
				src="<%=um.baseUrl(request, "")%>/lib/assets/settings/swk-square-medium.png"
				alt="" width="72" height="72">
			<h1 class="h3 mb-3 font-weight-normal">Sign in</h1>
			<p>Enter your login details below</p>
		</div>


		<%-- //print error message if failed login --%>

		<%
			//check if there are messages to print
		if (session.getAttribute("LoginErrorMessage") != null || session.getAttribute("LoginDatabaseErrorMessage") != null
				|| session.getAttribute("UserNotFound") != null || session.getAttribute("RegistrationSuccessMessage") != null
				|| session.getAttribute("ActivationSuccessMessage") != null
				|| session.getAttribute("ActivationErrorMessage") != null
				|| session.getAttribute("ActivationDatabaseErrorMessage") != null
				|| session.getAttribute("AccountUnconfirmed") != null || session.getAttribute("MessageSent") != null
				|| session.getAttribute("NoPasswordResetPermissionMessage") != null) {
			//use the class for printing messages
			SiteAlerts sa = new SiteAlerts();
			//call the method and get its result
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

		<div class="form-label-group">
			<input type="password" id="inputPassword" class="form-control"
				placeholder="Password" name="password" required> <label
				for="inputPassword">Password</label>
		</div>

		<div class="checkbox mb-3">
			<label> <input type="checkbox" value="remember-me">
				Remember me
			</label>
		</div>
		<button class="btn btn-lg btn-primary btn-block" type="submit"
			id="submit-btn">Sign in</button>
		<button class="btn btn-lg btn-primary btn-block" id="submit-ani"
			disabled>
			<span class="spinner-grow spinner-grow-sm"></span> Working...
		</button>

		<p class="mt-5 mb-3 text-muted d-flex justify-content-between"
			style="margin-top: -100px; margin-bottom: 500px;">
			<a href="<%=um.baseUrl(request, "/register")%>"
				style="text-decoration: none;">Register </a> <a
				href="<%=um.baseUrl(request, "/password-reset-request")%>"
				style="text-decoration: none;">Forgot Password</a>
		</p>
		<hr>
	</form>

	<%--Import Footer --%>
	<%@ include file="footer.jsp"%>

</body>
</html>