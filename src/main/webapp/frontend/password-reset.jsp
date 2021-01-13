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

<title>Orange | Password Reset</title>

</head>

<body>

	<%--Import Header--%>
	<%@ include file="header.jsp"%>


	<form class="form-signin needs-validation shadow"
		action="PasswordReset" method="post"
		oninput='password2.setCustomValidity(password2.value != password.value ? "Passwords do not match." : "")'
		style="margin-top: 100px; margin-bottom: 100px; border-radius: 20px;"
		id="auth-form" novalidate>

		<div class="text-center mb-4">
			<img class="mb-4 img-thumbnail shadow"
				src="<%=um.baseUrl(request, "")%>/lib/assets/settings/swk-square-medium.png"
				alt="" width="72" height="72">
			<h1 class="h3 mb-3 font-weight-normal">Password Reset</h1>
			<p>Input your new password below</p>
		</div>


		<%-- //print error message if failed login --%>

		<%
			//check if there are messages to print
		if (session.getAttribute("SetPasswordMessage") != null) {
			//use the class for printing messages
			SiteAlerts sa = new SiteAlerts();
			//call the method ang get its result
			String message = sa.showAlert(request, response);
			out.println(message);
		}
		%>
		<%-- End error message printing --%>

		<%-- //get email and activation code from session and re-set it to use in the recieving servlet--%>

		<%
			if (session.getAttribute("email") != null && session.getAttribute("activationCode") != null
				&& session.getAttribute("username") != null) {
			String email = session.getAttribute("email").toString();
			String activationcode = session.getAttribute("activationCode").toString();
			String username = session.getAttribute("username").toString();

			session.setAttribute("email", email);
			session.setAttribute("activationCode", activationcode);
			session.setAttribute("username", username);
		}
		%>
		<%-- End get email and activation code from session --%>


		<div class="form-label-group">
			<input type="password" id="regPassword"
				class="form-control regPassword" placeholder="Password"
				name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
				title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
				required autofocus> <label for="regPassword">New
				Password</label>

			<div class="invalid-feedback">
				<strong>Password must contain the following:</strong>
				<hr style="margin-top: 1px; margin-bottom: 1px;">
				<p style="margin-top: 1px; margin-bottom: 1px;" id="letter"
					class="invalid letter">
					A <b>lowercase</b> letter
				</p>
				<p style="margin-top: 1px; margin-bottom: 1px;" id="capital"
					class="invalid capital">
					A <b>capital (uppercase)</b> letter
				</p>
				<p style="margin-top: 1px; margin-bottom: 1px;" id="number"
					class="invalid number">
					A <b>number</b>
				</p>
				<p style="margin-top: 1px;" id="length" class="invalid length">
					Minimum <b>8 characters</b>
				</p>
			</div>
		</div>



		<div class="form-label-group">
			<input type="password" id="confirmPassword" class="form-control"
				placeholder="Confirm Password" name="password2" required> <label
				for="confirmPassword">Confirm Password</label>

			<div class="invalid-feedback">Password doesn't match!</div>
		</div>

		<button class="btn btn-lg btn-primary btn-block" type="submit"
			id="submit-btn">Change Password</button>
		<button class="btn btn-lg btn-primary btn-block" id="submit-ani"
			disabled>
			<span class="spinner-grow spinner-grow-sm"></span> Working...
		</button>

		<%-- show only if not logged in --%>
		<c:if
			test="${sessionScope['Username'] == null && sessionScope['Firstname'] == null && sessionScope['Email'] == null}">
			<p class="mt-5 mb-3 text-muted d-flex justify-content-center"
				style="margin-top: -100px; margin-bottom: 500px;">
				Already Registered?&nbsp;&nbsp;<a
					href="<%=um.baseUrl(request, "/login")%>"
					style="text-decoration: none;"> Sign in </a>
			</p>
			<hr>
		</c:if>
	</form>

	<%--Import Footer --%>
	<%@ include file="footer.jsp"%>

</body>
</html>