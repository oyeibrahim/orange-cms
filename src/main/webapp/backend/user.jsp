<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="java.util.List"
	import="dataBaseModel.Users" import="userInterfaces.SiteAlerts"
	import="dataBaseDAO.ReferralDAO" import="dataBaseModel.Referral"
	import="dataBaseDAO.WalletsDAO" import="dataBaseModel.Wallets"
	import="dataBaseDAO.WalletsHistoryDAO"
	import="dataBaseModel.WalletsHistory" import="java.util.List"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>User - <%=request.getParameter("u")%></title>

</head>
<body>

	<%--Import Header--%>
	<%--IMPORTANT, Handles unauthorised access rejection--%>
	<%@ include file="header.jsp"%>


	<%-- // Check user existence--%>
	<%
		//boolean for controlling getting the req parameter if it doesn't exist
	boolean check = false;
	if (request.getParameter("m") == null) {
		String reqUser = request.getParameter("u");
		check = true;
		Users us = Users.getUserProfile(reqUser);

		//if user can't be found, print message
		if (us.getUsername() == null) {
			//set session message
			session.setAttribute("UserNotFound", "There is no user with username " + reqUser);
			//redirect
			response.sendRedirect("/BAYK-Platform/backend/user?m=message404");
			//to prevent moving forward after this
			return;
		}
	}

	//get the profile we want
	Users us = Users.getUserProfileAdmin(request.getParameter("u"));

	//set session

	//get referral info
	ReferralDAO refDao = new ReferralDAO();
	Referral ref = refDao.getReferralWithUsername(request.getParameter("u"));

	//get wallet info
	WalletsDAO walletDAO = new WalletsDAO();
	Wallets wallet = walletDAO.getWallet(us);
	%>
	<%-- // end--%>


	<%-- Profile navbar --%>

	<div style="margin-top: 50px;">
		<div class="row">

			<%--Import Profile Menu Bar--%>
			<%@ include file="profile-menu.jsp"%>


			<div class="col-md-10" style="padding: 20px;" id="main">


				<%-- //print error message --%>

				<%
					//check if there are messages to print
				if (session.getAttribute("ProfileUpdatedMessage") != null || session.getAttribute("UserNotFound") != null) {
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
					<h4>
						User :
						<%
						if (check) {
						out.println(request.getParameter("u"));
					} //print only if exist
					%>
					</h4>
				</div>

				<%-- Information --%>

				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<h4 class="text-right">
						<a
							href="<%=webAddress%>/backend/user-edit?u=<%=request.getParameter("u")%>">Edit
							User</a>
					</h4>

					<hr>

					<div class="row">

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">ID</h6>
									<hr>
									<p class="text-center"><%=us.getId()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Username</h6>
									<hr>
									<p class="text-center"><%=us.getUsername()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Email</h6>
									<hr>
									<p class="text-center"><%=us.getEmail()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Activated</h6>
									<hr>
									<p class="text-center">
										<%
											if (us.getActive() == 1) {
											out.println("YES");
										} else {
											out.println("NO");
										}
										%>
									</p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Firstname</h6>
									<hr>
									<p class="text-center"><%=us.getFirstname()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Lastname</h6>
									<hr>
									<p class="text-center"><%=us.getLastname()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Gender</h6>
									<hr>
									<p class="text-center"><%=us.getGender()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Country</h6>
									<hr>
									<p class="text-center"><%=us.getCountry()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Joined</h6>
									<hr>
									<%
										String joined = us.getJoined();
									%>
									<p class="text-center"><%=joined.substring(0, joined.indexOf(" T"))%>
										(d/m/y)
									</p>
									<p class="text-center"><%=joined.substring(joined.indexOf("Time"), joined.length())%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Date of Birth</h6>
									<hr>
									<p class="text-center"><%=us.getBirth()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Genesis Platform</h6>
									<hr>
									<p class="text-center"><%=us.getPlatformTag()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Platform level</h6>
									<hr>
									<p class="text-center"><%=us.getTag()%></p>

								</div>
							</div>
						</div>


						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Profile Picture Location</h6>
									<hr>
									<p class="text-center"><%=us.getProfilePicture()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Activation Code</h6>
									<hr>
									<p class="text-center"><%=us.getActivationCode().substring(0, 20)%>
										<%=us.getActivationCode().substring(20, 40)%>
										<%=us.getActivationCode().substring(40, us.getActivationCode().length())%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail text-center">
									<h6 style="margin-bottom: -10px;">Picture</h6>
									<hr>
									<img src="<%=webAddress + us.getProfilePicture()%>"
										class="text-center img-fluid img-thumbnail rounded-circle shadow"
										style="width: 150px; height: 150px;"
										alt="Profile Picture of <%=us.getUsername()%>">

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">About</h6>
									<hr>
									<p class="text-center"><%=us.getAbout()%></p>

								</div>
							</div>
						</div>







					</div>

				</div>
				<%-- End Information --%>



				<%-- Referral --%>
				&emsp;
				<div class="text-left img-thumbnail">
					<h4>Referral</h4>
				</div>

				<%-- Information --%>



				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<div class="row">

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Referral Code</h6>
									<hr>
									<p class="text-center"><%=ref.getCode()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Total Active Referrals</h6>
									<hr>
									<p class="text-center"><%=ref.getReferrals()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Total Pending Referrals</h6>
									<hr>
									<p class="text-center"><%=ref.getPending()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Referred By</h6>
									<hr>
									<p class="text-center"><%=ref.getReferred_by()%></p>

								</div>
							</div>
						</div>

						<div class="col-sm-6">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Registration Link</h6>
									<hr>
									<a
										href="http://localhost:8080/BAYK-Platform/RegistrationPage.jsp?ref=<%=ref.getCode()%>"
										class="text-center">http://localhost:8080/BAYK-Platform/RegistrationPage.jsp?ref=<%=ref.getCode()%></a>

								</div>
							</div>
						</div>

						<div class="col-sm-6">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">Homepage Link</h6>
									<hr>
									<a
										href="http://localhost:8080/BAYK-Platform/index.jsp?ref=<%=ref.getCode()%>"
										class="text-center">http://localhost:8080/BAYK-Platform/index.jsp?ref=<%=ref.getCode()%></a>

								</div>
							</div>
						</div>

					</div>

				</div>
				<%-- End Information --%>



				<%-- Wallet --%>
				&emsp;
				<div class="text-left img-thumbnail">
					<h4>Wallet</h4>
				</div>

				<%-- Information --%>

				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<div class="row">

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">BAYK</h6>
									<hr>
									<h6 class="text-center"><%=wallet.getBayk()%>
										BAYK
									</h6>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">BAYK (HOLD)</h6>
									<hr>
									<h6 class="text-center"><%=wallet.getBayk_hold()%>
										BAYK
									</h6>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">CoinTick</h6>
									<hr>
									<h6 class="text-center"><%=wallet.getCtk()%>
										CTK
									</h6>

								</div>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<h6 style="margin-bottom: -10px;">CoinTick (HOLD)</h6>
									<hr>
									<h6 class="text-center"><%=wallet.getCtk_hold()%>
										CTK
									</h6>

								</div>
							</div>
						</div>




					</div>

				</div>
				<%-- End Information --%>



				<%-- Wallet History --%>
				&emsp;
				<div class="text-left img-thumbnail">
					<h4>Wallet History</h4>
				</div>

				<%-- Information --%>

				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<div class="row">

						<div class="col-sm-12">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">
									<table
										class="table table-hover table-sm table-responsive-md text-nowrap">

										<%-- Table Head --%>

										<thead class="thead-light">
											<tr>
												<th scope="col">&nbsp; &nbsp; Amount</th>
												<th scope="col">&nbsp; &nbsp; Action</th>
												<th scope="col">&nbsp; &nbsp; Status</th>
												<th scope="col">&nbsp; &nbsp; details</th>
												<th scope="col">&nbsp; &nbsp; Date (d/m/y)</th>
											</tr>
										</thead>

										<%-- End Table Head --%>

										<%-- Table Body --%>
										<tbody>

											<%
												//display the data

											//initialise the DAO
											WalletsHistoryDAO whd = new WalletsHistoryDAO();

											List<WalletsHistory> list = whd.getHistory(us.getUsername(), 0, 10);

											for (WalletsHistory wh : list) {
												String dateTime = wh.getDate_time();
												dateTime = dateTime.substring(0, dateTime.indexOf(".") - 3);
												String color;

												if (wh.getStatus().equals("completed")) {
													color = "#15e62a";
												} else if (wh.getStatus().equals("failed")) {
													color = "#eb3d34";
												} else {
													color = "#e6be0e";
												}
												out.println("<tr>" + "<td>&nbsp; &nbsp; " + wh.getAmount() + " " + wh.getCoin() + "</td>" + "<td>&nbsp; &nbsp; "
												+ wh.getAction() + "</td>" + "<td style='color:" + color + "'>&nbsp; &nbsp; " + wh.getStatus() + "</td>"
												+ "<td>&nbsp; &nbsp; " + wh.getDetails() + "</td>" + "<td>&nbsp; &nbsp; " + dateTime + "</td>" + "</tr>");
											}
											%>


										</tbody>

										<%-- End Table Body --%>

									</table>

									<%-- End Table --%>

									<%
										if (list.size() > 0) {
										out.println("<div class='text-center'><a href='" + webAddress + "/backend/wallet-history/1/?u=" + us.getUsername()
										+ "'>Show Full History</a></div>");
									}
									%>


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