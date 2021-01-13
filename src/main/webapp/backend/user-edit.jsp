<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.WalletsHistoryDAO"
	import="dataBaseModel.WalletsHistory" import="java.util.List"
	import="dataBaseDAO.UsersDAO" import="dataBaseModel.Users"
	import="userInterfaces.SiteAlerts" import="dataBaseDAO.WalletsDAO"
	import="dataBaseModel.Wallets" import="utilities.UtilityMethods"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Edit User Details</title>

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
			response.sendRedirect("backend/user?m=message404");
			//to prevent moving forward after this
			return;
		}
	}
	%>
	<%-- // end--%>

	<%--Access wallet from DB--%>
	<%
		//get the profile we want
	Users us = Users.getUserProfileAdmin(request.getParameter("u"));

	//get wallet info
	WalletsDAO walletDAO = new WalletsDAO();
	Wallets wallet = walletDAO.getWallet(us);
	%>

	<%--set session--%>
	<%
		session.setAttribute("editingUserID", us.getId());
	%>


	<%-- Profile navbar --%>

	<div style="margin-top: 50px;">
		<div class="row">

			<%--Import Profile Menu Bar--%>
			<%@ include file="profile-menu.jsp"%>


			<%-- ////////////////// Content ///////////////// --%>

			<%-- Edit User Details --%>
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
				<div class="img-thumbnail">
					<h4>
						Edit User :
						<%=request.getParameter("u")%></h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<div class="row">

						<div class="col-sm-12">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail bg-grey">
									<hr>
									<h5 style="padding-left: 10px">Basic</h5>

									<form class="needs-validation" style="padding: 10px;"
										action="../UserInfoEditAdmin" method="post" id="auth-form"
										novalidate>


										<div class="form-label-group">
											<input type="text" id="inputUsername" class="form-control"
												placeholder="Username" name="username"
												value="<%=us.getUsername()%>" required autofocus> <label
												for="inputUsername">Username</label>
										</div>

										<div class="form-row">

											<div class="form-label-group col">
												<input type="text" id="inputFirstname" class="form-control"
													placeholder="First name" name="firstname"
													value="<%=us.getFirstname()%>" required> <label
													for="inputFirstname">First name</label>
											</div>


											<div class="form-label-group col">
												<input type="text" id="inputLastname" class="form-control"
													placeholder="Last name" name="lastname"
													value="<%=us.getLastname()%>" required> <label
													for="inputLastname">Last name</label>
											</div>

										</div>


										<div class="form-label-group">
											<%-- <label for="genderSelect">Gender</label>--%>
											<select class="form-control" id="genderSelect" name="gender"
												required>
												<option
													<%if (us.getGender().equals("Male")) {
	out.println("selected");
}%>>Male</option>
												<option
													<%if (us.getGender().equals("Female")) {
	out.println("selected");
}%>>Female</option>
											</select>

										</div>

										<div class="form-label-group">
											<%-- <label for="countrySelect">Country</label>--%>
											<select class="form-control" id="countrySelect"
												name="country" required>
												<%-- print countries --%>
												<%
													String[] countries = um.getCountries();
												for (String country : countries) {
													if (us.getCountry().equals(country)) {
														out.println("<option selected>" + country + "</option>");
													} else {
														out.println("<option>" + country + "</option>");
													}
												}
												%>
											</select>

										</div>


										<div class="form-row">

											<div class="form-label-group col">
												<input type="text" id="inputGenesisPlatform"
													class="form-control" placeholder="Genesis Platform"
													name="genesis" value="<%=us.getPlatformTag()%>" required>
												<label for="inputGenesisPlatform">Genesis Platform</label>
											</div>


											<div class="form-label-group col">
												<input type="text" id="inputProfilePic" class="form-control"
													placeholder="Profile Picture Location"
													name="picturelocation" value="<%=us.getProfilePicture()%>"
													required> <label for="inputProfilePic">Profile
													Picture Location</label>
											</div>

										</div>


										<hr>
										<h5>Activation code</h5>

										<div class="form-label-group">
											<input type="text" id="inputActivationCode"
												class="form-control" placeholder="Activation code"
												name="activationcode" value="<%=us.getActivationCode()%>"
												required> <label for="inputActivationCode">Activation
												code</label>
										</div>


										<hr>
										<h5>Activated</h5>

										<div class="form-label-group">
											<select class="form-control" id="activated" name="activated"
												required>
												<option
													<%if (us.getActive() == 1) {
	out.println("selected");
}%>>YES</option>
												<option
													<%if (us.getActive() == 0) {
	out.println("selected");
}%>>NO</option>
											</select>

										</div>

										<hr>
										<h5>Platform Level</h5>

										<div class="form-label-group">
											<select class="form-control" id="activated" name="level"
												required>
												<option value="" selected disabled hidden=true>Platform
													Level</option>
												<option
													<%if (us.getTag().equals("admin")) {
	out.println("selected");
}%>>admin</option>
												<option
													<%if (us.getTag().equals("user")) {
	out.println("selected");
}%>>user</option>
											</select>

										</div>



										<button class="btn btn-lg btn-primary" type="submit"
											id="submit-btn">Update User</button>
										<button class="btn btn-lg btn-primary" id="submit-ani"
											disabled>
											<span class="spinner-grow spinner-grow-sm"></span>
											Updating...
										</button>


									</form>





								</div>
							</div>
						</div>

					</div>

				</div>
				<%-- End Information --%>



				<%-- Title --%>
				&emsp;
				<div class="img-thumbnail">
					<h4>
						Edit Wallet for :
						<%=request.getParameter("u")%></h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<div class="row">

						<div class="col-sm-12">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail bg-grey">

									<hr>
									<h5 style="padding-left: 10px">Current Balance</h5>

									<%-- BALANCE INFO --%>
									<div class="img-thumbnail bg-grey container"
										style="padding-top: 10px;">

										<div class="row">

											<div class="col-sm-3">
												<div class="img-thumbnail shadow"
													style="margin-bottom: 10px;">
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
												<div class="img-thumbnail shadow"
													style="margin-bottom: 10px;">
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
												<div class="img-thumbnail shadow"
													style="margin-bottom: 10px;">
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
												<div class="img-thumbnail shadow"
													style="margin-bottom: 10px;">
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
									<%-- END BALANCE INFO --%>

									<form class="needs-validation" style="padding: 10px;"
										action="../UserWalletEditAdmin" method="post" id="auth-form"
										novalidate>


										<hr>
										<h5>Add or Subtract Coin</h5>

										<div class="form-row">

											<div class="form-label-group col">
												<select class="form-control" id="activated" name="operation"
													required>
													<option value="" selected disabled hidden=true>Operation</option>
													<option>ADD</option>
													<option>SUBTRACT</option>
												</select>

											</div>

											<div class="form-label-group col">
												<input type="text" id="amount" class="form-control"
													placeholder="Amount" name="amount" required> <label
													for="amount">Amount</label>
											</div>

											<div class="form-label-group col">
												<select class="form-control" id="activated" name="coin"
													required>
													<option value="" selected disabled hidden=true>Coin</option>
													<option>BAYK (BAYK)</option>
													<option>CoinTick (CTK)</option>
													<option>BAYK_HOLD (BAYK_HOLD)</option>
													<option>CoinTick_HOLD (CTK_HOLD)</option>
												</select>

											</div>

										</div>

										<div class="form-row">

											<div class="form-label-group col-md-4">
												<select class="form-control" id="activated" name="status"
													required>
													<option value="" selected disabled hidden=true>Status</option>
													<option>completed</option>
													<option>pending...</option>
													<option>failed</option>
												</select>

											</div>

											<div class="form-label-group col-md-4">
												<input type="text" id="action" class="form-control"
													placeholder="Action" name="action" required> <label
													for="action">Action</label>
											</div>

											<div class="form-label-group col-md-4">
												<input type="text" id="details" class="form-control"
													placeholder="Details" name="details" required> <label
													for="details">Details</label>
											</div>

										</div>


										<button class="btn btn-lg btn-primary" type="submit"
											id="submit-btn">Update Wallet</button>
										<button class="btn btn-lg btn-primary" id="submit-ani"
											disabled>
											<span class="spinner-grow spinner-grow-sm"></span>
											Updating...
										</button>


									</form>





								</div>
							</div>
						</div>

					</div>

				</div>
				<%-- End Information --%>





			</div>
			<%-- End Edit User Details --%>




			<%-- ////////////////// End Content ///////////////// --%>

		</div>
	</div>

	<%-- End Profile navbar --%>






	<%--Import Footer --%>
	<%@ include file="footer.jsp"%>
</body>
</html>