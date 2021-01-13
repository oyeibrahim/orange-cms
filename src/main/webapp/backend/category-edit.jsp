<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="dataBaseModel.Users"
	import="userInterfaces.SiteAlerts" import="utilities.UtilityMethods"
	import="dataBaseDAO.CategoriesDAO" import="dataBaseModel.Categories"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Edit Category</title>

</head>
<body>

	<%--Import Header--%>
	<%--IMPORTANT, Handles unauthorised access rejection--%>
	<%@ include file="header.jsp"%>

	<%-- // Check category existence--%>
	<%
		//boolean for controlling getting the req parameter if it doesn't exist
	boolean check = false;
	CategoriesDAO ctDAO = new CategoriesDAO();
	if (request.getParameter("m") == null) {
		long reqCategory = Long.parseLong(request.getParameter("categoryid"));
		check = true;
		Categories ct = ctDAO.getCategory(reqCategory);

		//if user can't be found, print message
		if (ct.getName() == null) {
			//set session message
			session.setAttribute("UserNotFound", "The requested category doesn't exist");
			//redirect
			response.sendRedirect(um.baseUrl(request, "/backend/category-edit?m=message404"));
			//to prevent moving forward after this
			return;
		}
	}
	%>
	<%-- // end--%>

	<%--Get category--%>
	<%
		long reqCategory = Long.parseLong(request.getParameter("categoryid"));
	//get the category we want
	Categories ct = ctDAO.getCategory(reqCategory);

	//"Uncategorised" can't be edited or deleted
	if (ct.getName().equals("Uncategorised")) {
		//set session
		session.setAttribute("ProfileUpdateErrorMessage", "This category can't be edited or deleted");
		response.sendRedirect(um.baseUrl(request, "/backend/categories/1/"));
		return;
	}
	%>

	<%--set session--%>
	<%
		session.setAttribute("CategoryAction", "update");
	session.setAttribute("CategoryID", request.getParameter("categoryid"));
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
						Edit Category :
						<%=ct.getName()%></h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<h4 class="text-right">
						<a href="<%=webAddress%>/CategoryDelete">Delete Category</a>
					</h4>

					<hr>

					<div class="row">

						<div class="col-sm-12">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail bg-grey">

									<hr>
									<h5 style="padding-left: 10px">Category info</h5>

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
														<p class="text-center"><%=ct.getName()%></p>

													</div>
												</div>
											</div>

											<div class="col-sm-4">
												<div class="img-thumbnail shadow"
													style="margin-bottom: 10px;">
													<div class="img-thumbnail">
														<h6 style="margin-bottom: -10px;">Owner</h6>
														<hr>
														<p class="text-center"><%=ct.getUsername()%></p>

													</div>
												</div>
											</div>

											<div class="col-sm-4">
												<div class="img-thumbnail shadow"
													style="margin-bottom: 10px;">
													<div class="img-thumbnail">
														<h6 style="margin-bottom: -10px;">Date Created</h6>
														<hr>
														<p class="text-center"><%=um.formatDbDate(ct.getUpdated().substring(0, ct.getUpdated().indexOf(" ")), "dd/M/yyyy")%></p>

													</div>
												</div>
											</div>




										</div>

									</div>
									<%-- END INFO --%>

									<form class="needs-validation" style="padding: 10px;"
										action="<%=webAddress%>/CategoryCreateEdit" method="post"
										id="auth-form" novalidate>


										<hr>

										<div class="form-label-group">
											<input type="text" id="inputNewCategory" class="form-control"
												placeholder="Category name" name="categoryName"
												value="<%=ct.getName()%>" required> <label
												for="inputNewCategory">Category name</label>
										</div>


										<button class="btn btn-lg btn-primary" type="submit"
											id="submit-btn">Update Category</button>
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