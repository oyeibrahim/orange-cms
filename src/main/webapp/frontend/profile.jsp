<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>

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

<title>Orange | User Profile Page</title>


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

	<%-- // access the db to get public user profile--%>
	<%
		UsersDAO Users = new UsersDAO();
	//get the username requested //info passed in from /* in web.xml
	String userReq = request.getPathInfo().substring(1);

	//deal with case where there are more than one / at end
	//get the full link which will include the /s
	String userReq2 = request.getRequestURI();

	//from that, get the username with the /s... check for one / below
	userReq2 = userReq2.substring(userReq2.indexOf("/profile") + 9);

	//deal with the case where there is a / after the request
	//and make sure nothing is after that /, if anything after it then redirect
	if (userReq.contains("/") && userReq.endsWith("/")) {
		//remove the / and make sure its just one / after
		//this uses the above userReq2
		if (userReq.substring(0, userReq.indexOf("/")).length() + 1 == userReq2.length()) {
			userReq = userReq.substring(0, userReq.indexOf("/"));
		}
	}

	Users user = Users.getUserProfile(userReq);

	//if user can't be found, redirect to login
	if (user.getUsername() == null) {
		//set session message
		session.setAttribute("UserNotFound", "There is no user with username " + userReq2);
		//redirect to login
		response.sendRedirect(um.baseUrl(request, "/login"));
		//response.sendError(404, "No such user found!!! Please check the username!");
		//to prevent moving forward after this
		return;
	}

	//get the requested profile and set in session for use later
	String requestEmail = user.getEmail();
	String requestUsername = user.getUsername();
	session.setAttribute("requestEmail", requestEmail);
	session.setAttribute("requestUsername", requestUsername);
	%>

	<%-- // end--%>



	<%-- HTML CODE --%>

	<%-- Print page title --%>

	<%-- Include design if viewing private profile --%>
	<c:if
		test="${sessionScope['Username'] != null && sessionScope['Email'] != null && sessionScope['Email'] == sessionScope['requestEmail']  && sessionScope['Username'] == sessionScope['requestUsername']}">
		<div
			class="d-flex justify-content-left flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom shadow tog-fix"
			id="tog-fix">

			<%-- Small screen side navbar button --%>
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
			<h1 class="h2">Dashboard</h1>
		</div>
	</c:if>

	<%-- remove design if viewing public profile --%>
	<c:if
		test="${sessionScope['Username'] == null || sessionScope['Email'] == null || sessionScope['Email'] != sessionScope['requestEmail']  || sessionScope['Username'] != sessionScope['requestUsername']}">

		<div
			class="d-flex justify-content-left flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom shadow">

			<%-- Small screen side navebar button --%>
			<%-- Use any element to open the sidenav hidden on medium screen up with bootstrap class(d-md-none d-lg-none d-xl-none) --%>
			<%-- <button class="navbar-toggler navbar-toggler-left d-md-none d-lg-none d-xl-none" type="button" style= "margin-left: 20px;">
				<div class="row" style="margin-top:-8px;"><span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776;</span></div>
			</button> --%>

			&emsp;
			<%-- page title --%>
			<h2 class="h2">
				Profile of
				<%=userReq%></h2>
		</div>

	</c:if>

	<%-- End Print page title --%>


	<%-- Profile navbar --%>

	<div style="margin-top: 50px;">
		<div class="row">


			<%-- Show sidebar only when user logged in--%>

			<c:if
				test="${sessionScope['Username'] != null && sessionScope['Email'] != null && sessionScope['Email'] == sessionScope['requestEmail']  && sessionScope['Username'] == sessionScope['requestUsername']}">

				<%--Import Profile Menu Bar--%>
				<%@ include file="profile-menu.jsp"%>

			</c:if>
			<%-- End if statement--%>

			<%-- ////////////////// Content ///////////////// --%>
			<%-- print a container class for this content if user is not loged in and viewing public
		        profile so the content will occupy the whole page.. else print a col-md-10 class --%>

			<c:choose>
				<c:when
					test="${sessionScope['Username'] != null && sessionScope['Email'] != null && sessionScope['Email'] == sessionScope['requestEmail']  && sessionScope['Username'] == sessionScope['requestUsername']}">
					<c:set var="contentClass" scope="page" value="col-md-10" />
				</c:when>
				<c:otherwise>
					<c:set var="contentClass" scope="page" value="container" />
				</c:otherwise>
			</c:choose>


			<div class="<c:out value='${contentClass}' />" style="padding: 20px;"
				id="main">


				<%-- //print error message --%>

				<%
					//check if there are messages to print
				if (session.getAttribute("ProfileUpdatedMessage") != null) {
					//use the class for printing messages
					SiteAlerts sa = new SiteAlerts();
					//call the method ang get its result
					String message = sa.showAlert(request, response);
					out.println(message);
				}
				%>
				<%-- End error message printing --%>

				<%-- Image --%>
				<div class="text-center img-thumbnail profile-background-img"
					style="border-radius: 50px;">
					<img src="<%=um.baseUrl(request, "") + user.getProfilePicture()%>"
						class="text-center img-fluid img-thumbnail rounded-circle shadow"
						style="width: 150px; height: 150px;"
						alt="Profile Picture of <%=user.getUsername()%>">

				</div>

				<%-- Title --%>
				&emsp;
				<div class="text-left img-thumbnail">
					<h4>User Details</h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<div class="row">

						<div class="col-sm-4">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Username</h6>
									<hr>
									<p class="text-center"><%=user.getUsername()%></p>
								</div>
							</div>
						</div>


						<div class="col-sm-4">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Name</h6>
									<hr>
									<p class="text-center"><%=user.getLastname() + " " + user.getFirstname()%></p>
								</div>
							</div>
						</div>

						<div class="col-sm-4">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Country</h6>
									<hr>
									<p class="text-center"><%=user.getCountry()%></p>
								</div>
							</div>
						</div>

						<%-- 
				    <c:if test="${sessionScope['Username'] != null && sessionScope['Email'] != null && sessionScope['Email'] == sessionScope['requestEmail']  && sessionScope['Username'] == sessionScope['requestUsername']}">
				    <div class="col-sm-4">
				      <div class="img-thumbnail shadow" style="margin-bottom: 10px;">
				        <div class="img-thumbnail">
				        <h6 style="margin-bottom: -10px;">Birthday (only visible to you)</h6>
				        <hr>
				        <p class="text-center"><%  if (user.getBirth() == null){
					        	
				        		out.println("*Not Available*");
					        }else{
					        	out.println(user.getBirth());
					        } 	
				        	%></p>
				        </div>
				      </div>
				    </div>
				    </c:if>
				    --%>

						<div class="col-sm-4">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Joined</h6>
									<hr>
									<p class="text-center">
										<%
											String joinedDB = user.getJoined();
										int startDate = joinedDB.indexOf("Date: ") + 6;
										int endDate = joinedDB.indexOf(" Time: ");

										String dateOnly = joinedDB.substring(startDate, endDate);
										//**********desgin**********//
										//call utility method to format date.. um has been imported and declared in Header.jsp
										String formatedDate = um.formatDate(dateOnly, "E, MMM dd yyyy");
										//**********end desgin**********//
										out.println(formatedDate);
										%>
									</p>
								</div>
							</div>
						</div>

						<div class="col-sm-4">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">About</h6>
									<hr>
									<p class="text-center">
										<%
											if (user.getAbout() == null) {

											out.println("*Not Available*");
										} else {
											out.println(user.getAbout());
										}
										%>
									</p>
								</div>
							</div>
						</div>

					</div>

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