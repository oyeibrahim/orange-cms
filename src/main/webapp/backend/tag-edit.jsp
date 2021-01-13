<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="dataBaseModel.Users"
	import="userInterfaces.SiteAlerts" import="utilities.UtilityMethods"
	import="dataBaseDAO.TagsDAO" import="dataBaseModel.Tags"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Tag Edit</title>

</head>
<body>

	<%--Import Header--%>
	<%--IMPORTANT, Handles unauthorised access rejection--%>
	<%@ include file="header.jsp"%>

	<%-- // Check user existence--%>
	<%
		//boolean for controlling getting the req parameter if it doesn't exist
	boolean check = false;
	TagsDAO tgDAO = new TagsDAO();
	if (request.getParameter("m") == null) {
		long reqCategory = Long.parseLong(request.getParameter("tagid"));
		check = true;
		Tags tg = tgDAO.getTag(reqCategory);

		//if user can't be found, print message
		if (tg.getName() == null) {
			//set session message
			session.setAttribute("UserNotFound", "The requested tag doesn't exist");
			//redirect
			response.sendRedirect("backend/tag-edit?m=message404");
			//to prevent moving forward after this
			return;
		}
	}
	%>
	<%-- // end--%>

	<%--Access wallet from DB--%>
	<%
		long reqTag = Long.parseLong(request.getParameter("tagid"));
	//get the category we want
	Tags tg = tgDAO.getTag(reqTag);
	%>

	<%--set session--%>
	<%
		session.setAttribute("TagAction", "update");
	session.setAttribute("TagID", request.getParameter("tagid"));
	%>




	<%-- End Print page title --%>


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
						Edit Tag :
						<%=tg.getName()%></h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<h4 class="text-right">
						<a href="<%=webAddress%>/TagDelete">Delete Tag</a>
					</h4>

					<hr>

					<div class="row">

						<div class="col-sm-12">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail bg-grey">

									<hr>
									<h5 style="padding-left: 10px">Tag info</h5>

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
														<p class="text-center"><%=tg.getName()%></p>

													</div>
												</div>
											</div>

											<div class="col-sm-4">
												<div class="img-thumbnail shadow"
													style="margin-bottom: 10px;">
													<div class="img-thumbnail">
														<h6 style="margin-bottom: -10px;">Owner</h6>
														<hr>
														<p class="text-center"><%=tg.getUsername()%></p>

													</div>
												</div>
											</div>

											<div class="col-sm-4">
												<div class="img-thumbnail shadow"
													style="margin-bottom: 10px;">
													<div class="img-thumbnail">
														<h6 style="margin-bottom: -10px;">Date Created</h6>
														<hr>
														<p class="text-center"><%=um.formatDbDate(tg.getUpdated().substring(0, tg.getUpdated().indexOf(" ")), "dd/M/yyyy")%></p>

													</div>
												</div>
											</div>




										</div>

									</div>
									<%-- END INFO --%>

									<form class="needs-validation" style="padding: 10px;"
										action="<%=webAddress%>/TagCreateEdit" method="post"
										id="auth-form" novalidate>


										<hr>

										<div class="form-label-group">
											<input type="text" id="inputNewTag" class="form-control"
												placeholder="Tag name" name="tagName"
												value="<%=tg.getName()%>" required> <label
												for="inputNewTag">Tag name</label>
										</div>


										<button class="btn btn-lg btn-primary" type="submit"
											id="submit-btn">Update Tag</button>
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