<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="dataBaseModel.Users"
	import="userInterfaces.SiteAlerts" import="dataBaseDAO.WalletsDAO"
	import="dataBaseModel.Wallets" import="dataBaseDAO.ReferralDAO"
	import="dataBaseModel.Referral" import="java.util.List"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Orange | Referral</title>

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

	<%--Access wallet from DB--%>
	<%
		ReferralDAO refDAO = new ReferralDAO();
	Referral ref = refDAO.getReferralWithUsername(session.getAttribute("Username").toString());
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
		<h1 class="h2">Wallet</h1>
	</div>


	<%-- Profile navbar --%>

	<div style="margin-top: 50px;">
		<div class="row">

			<%--Import Profile Menu Bar--%>
			<%@ include file="profile-menu.jsp"%>


			<%-- ////////////////// Content ///////////////// --%>


			<div class="col-md-10" style="padding: 20px;" id="main">


				<%-- Title --%>
				&emsp;
				<div class="text-left img-thumbnail">
					<h4>Referred Users</h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<div class="row">

						<div class="col-sm-6">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h5 style="margin-bottom: -10px;">Active</h5>
									<hr>
									<h4 class="text-center"><%=ref.getReferrals()%></h4>

								</div>
							</div>
						</div>


						<div class="col-sm-6">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h5 style="margin-bottom: -10px;">Pending</h5>
									<hr>
									<h4 class="text-center"><%=ref.getPending()%></h4>

								</div>
							</div>
						</div>

					</div>

				</div>
				<%-- End Information --%>

				&emsp;

				<%-- Link --%>
				<div class="text-left img-thumbnail">
					<h4>Your Referral Links</h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<div class="row">

						<div class="col-sm-6">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h5 style="margin-bottom: -10px;">Registration</h5>
									<hr>
									<a
										href="<%=um.baseUrl(request, "/register?ref=")%><%=ref.getCode()%>"
										class="text-center"><%=um.baseUrl(request, "/register?ref=")%><%=ref.getCode()%></a>

								</div>
							</div>
						</div>


						<div class="col-sm-6">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h5 style="margin-bottom: -10px;">Homepage</h5>
									<hr>
									<a href="<%=um.baseUrl(request, "?ref=")%><%=ref.getCode()%>"
										class="text-center"><%=um.baseUrl(request, "?ref=")%><%=ref.getCode()%></a>

								</div>
							</div>
						</div>

					</div>

				</div>
				<%-- End Link --%>





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