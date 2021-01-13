<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>

<%@ page import="userInterfaces.SiteAlerts"
	import="dataBaseDAO.ReferralDAO" import="dataBaseModel.Referral"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Orange | Registration Page</title>

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


	<%--Handle referral if code provided--%>
	<%
		//if ref parameter is available
	if (request.getParameter("ref") != null) {

		String code = request.getParameter("ref");

		//access referral DAO
		ReferralDAO refDAO = new ReferralDAO();

		//check if the code exist
		int exist = refDAO.checkCode(code);

		if (exist == 1) {
			//if code exist, then get set session
			session.setAttribute("RefCode", code);
		}
	}
	%>




	<form class="form-signin needs-validation shadow"
		action="RegistrationController" method="post"
		oninput='password2.setCustomValidity(password2.value != password.value ? "Passwords do not match." : "")'
		style="margin-top: 100px; margin-bottom: 100px; border-radius: 20px;"
		id="auth-form" novalidate>

		<div class="text-center mb-4">
			<img class="mb-4 img-thumbnail shadow"
				src="<%=um.baseUrl(request, "")%>/lib/assets/settings/swk-square-medium.png"
				alt="" width="72" height="72">
			<h1 class="h3 mb-3 font-weight-normal">Registration form</h1>
			<p>Enter your details below to register</p>
		</div>


		<%-- //print error message --%>

		<%
			//check if there are messages to print
		if (session.getAttribute("EmailExistErrorMessage") != null || session.getAttribute("UsernameExistErrorMessage") != null
				|| session.getAttribute("RegistrationDatabaseErrorMessage") != null
				|| session.getAttribute("NoPasswordResetPermissionMessage") != null
				|| session.getAttribute("RegistrationErrorMessage") != null) {
			//use the class for printing messages
			SiteAlerts sa = new SiteAlerts();
			//call the method ang get its result
			String message = sa.showAlert(request, response);
			out.println(message);
		}
		%>
		<%-- End error message printing --%>



		<div class="form-label-group">
			<input type="text" id="inputUsername" class="form-control"
				placeholder="Username" name="username" required autofocus> <label
				for="inputUsername">Username</label>
		</div>



		<div class="form-label-group">
			<input type="email" id="inputEmail" class="form-control"
				placeholder="Email" name="email" required> <label
				for="inputEmail">Email</label>
		</div>

		<div class="form-label-group">
			<input type="text" id="inputFirstname" class="form-control"
				placeholder="First name" name="firstname" required> <label
				for="inputFirstname">First name</label>
		</div>


		<div class="form-label-group">
			<input type="text" id="inputLastname" class="form-control"
				placeholder="Last name" name="lastname" required> <label
				for="inputLastname">Last name</label>
		</div>


		<div class="form-label-group">
			<input type="password" id="regPassword"
				class="form-control regPassword" placeholder="Password"
				name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
				title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
				required> <label for="regPassword">Password</label>

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
		<hr>
		<div class="form-label-group">
			<%-- <label for="genderSelect">Gender</label>--%>
			<select class="form-control" id="genderSelect" name="gender" required>
				<option value="" selected disabled hidden=true>Gender</option>
				<option>Male</option>
				<option>Female</option>
			</select>

		</div>

		<div class="form-label-group">
			<%-- <label for="countrySelect">Country</label>--%>
			<select class="form-control" id="countrySelect" name="country"
				required>
				<option value="" selected disabled hidden=true>Country</option>
				<%-- print countries --%>
				<%
					//UtilityMethods um = new UtilityMethods();
				String[] countries = um.getCountries();
				for (String country : countries) {
					out.println("<option>" + country + "</option>");
				}
				%>
			</select>

		</div>

		<hr>

		<div class="custom-control custom-checkbox mb-3">
			<input type="checkbox" class="custom-control-input"
				id="customControlValidation1" required> <label
				class="custom-control-label" for="customControlValidation1">Agree
				to terms and conditions</label>
			<div class="invalid-feedback">You must agree to our terms</div>
		</div>

		<button class="btn btn-lg btn-primary btn-block" type="submit"
			id="submit-btn">Register</button>
		<button class="btn btn-lg btn-primary btn-block" id="submit-ani"
			disabled>
			<span class="spinner-grow spinner-grow-sm"></span> Registering your
			account...
		</button>

		<p class="mt-5 mb-3 text-muted d-flex justify-content-center"
			style="margin-top: -100px; margin-bottom: 500px;">
			Already Registered?&nbsp;&nbsp;<a
				href="<%=um.baseUrl(request, "/login")%>"
				style="text-decoration: none;"> Sign in </a>
		</p>
		<hr>
	</form>

	<%--Import Footer --%>
	<%@ include file="footer.jsp"%>

</body>
</html>