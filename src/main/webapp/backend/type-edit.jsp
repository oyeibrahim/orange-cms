<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="dataBaseModel.Users"
	import="userInterfaces.SiteAlerts" import="utilities.UtilityMethods"
	import="dataBaseDAO.TypesDAO" import="dataBaseModel.Types"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Type Edit</title>

</head>
<body>

	<%--Import Header--%>
	<%--IMPORTANT, Handles unauthorised access rejection--%>
	<%@ include file="header.jsp"%>

	<%-- // Check user existence--%>
	<%
		//boolean for controlling getting the req parameter if it doesn't exist
	boolean check = false;
	TypesDAO tpDAO = new TypesDAO();
	if (request.getParameter("m") == null) {
		long reqCategory = Long.parseLong(request.getParameter("typeid"));
		check = true;
		Types tp = tpDAO.getType(reqCategory);

		//if user can't be found, print message
		if (tp.getName() == null) {
			//set session message
			session.setAttribute("UserNotFound", "The requested type doesn't exist");
			//redirect
			response.sendRedirect("backend/type-edit?m=message404");
			//to prevent moving forward after this
			return;
		}
	}
	%>
	<%-- // end--%>

	<%--Access wallet from DB--%>
	<%
		long reqType = Long.parseLong(request.getParameter("typeid"));
	//get the category we want
	Types tp = tpDAO.getType(reqType);
	%>

	<%--set session--%>
	<%
		session.setAttribute("TypeAction", "update");
	session.setAttribute("TypeID", request.getParameter("typeid"));
	%>


	<%-- Profile navbar --%>

	<div style="margin-top: 50px;">
		<div class="row">

			<%--Import Profile Menu Bar--%>
			<%@ include file="profile-menu.jsp"%>


			<%-- Edit User Details --%>
			<div class="col-md-10" style="padding: 20px;" id="main">


				<%-- //print error message --%>

				<%
					//check if there are messages to print
				if (session.getAttribute("ProfileUpdatedMessage") != null || session.getAttribute("ProfileUpdateErrorMessage") != null
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
				<div class="img-thumbnail">
					<h4>
						Edit Type :
						<%=tp.getName()%></h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<h4 class="text-right">
						<a href="<%=webAddress%>/TypeDelete">Delete Type</a>
					</h4>

					<hr>

					<div class="row">

						<div class="col-sm-12">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail bg-grey">

									<hr>
									<h5 style="padding-left: 10px">Type info</h5>

									<%-- INFO --%>
									<div class="img-thumbnail bg-grey container"
										style="padding-top: 10px;">

										<div class="row">

											<div class="col-sm-4">
												<div class="img-thumbnail shadow"
													style="margin-bottom: 10px;">
													<div class="img-thumbnail">
														<h6 style="margin-bottom: -10px;">Name</h6>
														<hr>
														<p class="text-center"><%=tp.getName()%></p>

													</div>
												</div>
											</div>

											<div class="col-sm-4">
												<div class="img-thumbnail shadow"
													style="margin-bottom: 10px;">
													<div class="img-thumbnail">
														<h6 style="margin-bottom: -10px;">Owner</h6>
														<hr>
														<p class="text-center"><%=tp.getUsername()%></p>

													</div>
												</div>
											</div>

											<div class="col-sm-4">
												<div class="img-thumbnail shadow"
													style="margin-bottom: 10px;">
													<div class="img-thumbnail">
														<h6 style="margin-bottom: -10px;">Date Created</h6>
														<hr>
														<p class="text-center"><%=um.formatDbDate(tp.getUpdated().substring(0, tp.getUpdated().indexOf(" ")), "dd/M/yyyy")%></p>

													</div>
												</div>
											</div>




										</div>

									</div>
									<%-- END INFO --%>

									<form class="needs-validation" style="padding: 10px;"
										action="<%=webAddress%>/TypeCreateEdit" method="post"
										id="auth-form" novalidate>


										<hr>

										<div class="form-label-group">
											<input type="text" id="inputNewType" class="form-control"
												placeholder="Type name" name="typeName"
												value="<%=tp.getName()%>" required> <label
												for="inputNewType">Type name</label>
										</div>


										<button class="btn btn-lg btn-primary" type="submit"
											id="submit-btn">Update Type</button>
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