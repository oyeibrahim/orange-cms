<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="dataBaseModel.Users"
	import="userInterfaces.SiteAlerts" import="dataBaseModel.SiteStructure"
	import="dataBaseDAO.SiteStructureDAO"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Database Setting Create</title>

</head>
<body>

	<%--Import Header--%>
	<%--IMPORTANT, Handles unauthorised access rejection--%>
	<%@ include file="header.jsp"%>

	<%-- // Set session--%>
	<%
		//set up

	//set redirect link
	session.setAttribute("structureRedirectLink", webAddress + "/backend/db-settings/1/");

	//set task
	session.setAttribute("structureTask", "Create");

	//set id
	session.setAttribute("structureId", request.getParameter("id"));
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
				<div class="text-left img-thumbnail">
					<h4>Create new setting</h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">





					<%-- FORM START --%>
					<form class="needs-validation" autocomplete="off"
						action="../SettingUpdateController" method="post" id="auth-form"
						novalidate>



						<%-- --------------------------------------------------------------------------- --%>


						<hr>
						<h5>Name</h5>


						<div class="form-label-group">
							<input type="text" id="inputName" class="form-control"
								placeholder="Name" name="name" required> <label
								for="inputName">Name</label>
						</div>

						<%-- --------------------------------------------------------------------------- --%>

						<hr>
						<h5>Text Value 1</h5>
						<div class="form-label-group">
							<textarea class="form-control" id="inputText1" rows="3"
								name="text1"></textarea>
						</div>


						<%-- --------------------------------------------------------------------------- --%>

						<hr>
						<h5>Text Value 2</h5>
						<div class="form-label-group">
							<textarea class="form-control" id="inputText2" rows="3"
								name="text2"></textarea>
						</div>

						<%-- --------------------------------------------------------------------------- --%>

						<hr>
						<h5>Text Value 3</h5>
						<div class="form-label-group">
							<textarea class="form-control" id="inputText3" rows="3"
								name="text3"></textarea>
						</div>

						<%-- --------------------------------------------------------------------------- --%>

						<hr>
						<h5>Num Value 1</h5>
						<div class="form-label-group">
							<textarea class="form-control" id="inputNum1" rows="3"
								name="num1"></textarea>
						</div>

						<%-- --------------------------------------------------------------------------- --%>

						<hr>
						<h5>Num Value 2</h5>
						<div class="form-label-group">
							<textarea class="form-control" id="inputNum2" rows="3"
								name="num2"></textarea>
						</div>

						<%-- --------------------------------------------------------------------------- --%>

						<hr>
						<h5>Num Value 3</h5>
						<div class="form-label-group">
							<textarea class="form-control" id="inputNum3" rows="3"
								name="num3"></textarea>
						</div>

						<%-- --------------------------------------------------------------------------- --%>

						<hr>

						<button type="submit" class="btn btn-primary shadow"
							id="submit-btn">Create Setting</button>
						<button class="btn btn-primary" id="submit-ani" disabled>
							<span class="spinner-grow spinner-grow-sm"></span> Creating...
						</button>

						<%-- --------------------------------------------------------------------------- --%>
					</form>
					<%-- FORM END --%>


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