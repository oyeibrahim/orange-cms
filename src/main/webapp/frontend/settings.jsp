<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="dataBaseModel.Users"
	import="userInterfaces.SiteAlerts"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Orange | User Settings</title>

</head>
<body>

	<%--Import Header--%>
	<%@ include file="header.jsp"%>

	<%--Cache control--%>
	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	%>

	<%--Can't access if not logged in--%>
	<%
		if (session.getAttribute("Username") == null || session.getAttribute("Firstname") == null
			|| session.getAttribute("Email") == null) {

		response.sendRedirect(um.baseUrl(request, "/login"));
		//to prevent moving forward after this
		return;
	}
	%>


	<%-- HTML CODE  --%>

	<%--<br>
		<h2 class="jumbotron text-center jumbo-inner" style="color: black;">Profile</h2>--%>

	<div
		class="d-flex justify-content-left flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom shadow tog-fix"
		id="tog-fix">

		<%-- Small screen side navebar button --%>
		<%-- Use any element to open the sidenav hidden on medium screen up with bootstrap class(d-md-none d-lg-none d-xl-none) --%>
		<button
			class="navbar-toggler navbar-toggler-left d-md-none d-lg-none d-xl-none"
			type="button" style="margin-left: 20px;">
			<div class="row" style="margin-top: -8px;">
				<span style="font-size: 30px; cursor: pointer" onclick="openNav()">&#9776;</span>
			</div>
		</button>

		&emsp;
		<%-- page title --%>
		<h1 class="h2">Profile Settings</h1>
	</div>


	<%-- Profile navbar --%>

	<div style="margin-top: 50px;">
		<div class="row">

			<%--Import Profile Menu Bar--%>
			<%@ include file="profile-menu.jsp"%>

			<%-- ////////////////// Content ///////////////// --%>

			<div class="col-md-10" style="padding: 20px;" id="main">

				<%-- //print error message --%>

				<%
					//check if there are messages to print
				if (session.getAttribute("ProfileUpdateErrorMessage") != null
						|| session.getAttribute("ProfileUpdateDatabaseErrorMessage") != null) {
					//use the class for printing messages
					SiteAlerts sa = new SiteAlerts();
					//call the method ang get its result
					String message = sa.showAlert(request, response);
					out.println(message);
				}
				%>
				<%-- End error message printing --%>

				<%-- Title --%>
				&emsp;
				<div class="text-left img-thumbnail">
					<h4>Update Info</h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<h4 class="text-right">
						<a href="PasswordResetRequest.jsp">Change Password?</a>
					</h4>

					<hr>

					<h5>Profile image update</h5>

					<label for="profilePicture" class="custom-file-upload"
						id="placeHolding"> <i class="fa fa-cloud-upload"></i>
						Click here to select a new profile picture
					</label>

					<form class="needs-validation" id="picForm"
						action="ProfileImageUpload" method="post"
						enctype="multipart/form-data">
						<input type="file" id="profilePicture" accept="image/*"
							name="file" required />
						<button class="btn btn-primary" type="submit" id="submit-picture">Change
							Profile Picture</button>
					</form>


					<%-- Image select script --%>
					<script type="text/javascript">
						//if no image selected, tell the user to do that
						$('#submit-picture')
								.bind(
										'click',
										function() {
											var test = document
													.getElementById("placeHolding").innerHTML
													.includes("Image Selected : "
															+ document
																	.getElementById("profilePicture").value);
											if (test) {
												document
														.getElementById("placeHolding").innerHTML = "<i class='fa fa-cloud-upload' style='color:green;'></i>  Updating your profile picture...";
											} else {
												document
														.getElementById("placeHolding").innerHTML = "<i class='fa fa-cloud-upload' style='color:red;'></i>  You must select an image first.. Click here!";
											}
										})

						//change the interface value so user know when image selected 
						$('#profilePicture')
								.bind(
										'change',
										function() {
											if (this.files[0].size > 1048576) {
												//alert("File is too big!");
												this.value = "";
												document
														.getElementById("placeHolding").innerHTML = "<i class='fa fa-cloud-upload' style='color:red;'></i>  Selected image bigger than 1MB!!! Please select another";
											} else {
												document
														.getElementById("placeHolding").innerHTML = "<i class='fa fa-cloud-upload' style='color:green;'></i>  Image Selected : "
														+ document
																.getElementById("profilePicture").value;
											}
										})
					</script>

					<hr>

					<h5>User about update</h5>

					<form class="needs-validation" action="UserDataUpdate"
						method="post" id="auth-form">


						<div class="form-group">
							<label for="about">About</label>
							<textarea class="form-control shadow" id="about" rows="3"
								name="about" required></textarea>
						</div>



						<button type="submit" class="btn btn-primary shadow"
							id="submit-btn">Update User Info</button>
						<button class="btn btn-primary" id="submit-ani" disabled>
							<span class="spinner-grow spinner-grow-sm"></span> Updating your
							profile...
						</button>
					</form>


				</div>

				<%-- End Information --%>

			</div>
			<%-- ////////////////// End Content ///////////////// --%>

		</div>
	</div>

	<%-- End Profile navbar --%>


	<%--Import Footer --%>
	<%@ include file="footer.jsp"%>
</body>
</html>