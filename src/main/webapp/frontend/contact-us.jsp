<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.SiteStructureDAO"
	import="dataBaseModel.SiteStructure" import="userInterfaces.SiteAlerts"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Orange | Contact Us</title>


</head>
<body>

	<%--Import Header--%>
	<%@ include file="header.jsp"%>


	<div
		class="d-flex justify-content-left flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">

		<%-- page title will be unique to each parameter  --%>
		&emsp;

		<h1 class='h2'>Contact Us</h1>


	</div>


	<div class="col-sm-6" style="padding: 50px;">

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

		<form class='needs-validation'
			action='<%=webAddress%>/ContactController' method='post'
			id='auth-form' novalidate>

			<h5>Name:</h5>
			<input type="text" id="inputName" class="form-control" name="name"
				style="margin-bottom: 20px;" required>


			<h5>Email:</h5>
			<input type="text" id="inputEmail" class="form-control" name="email"
				style="margin-bottom: 20px;" required>


			<h5>Purpose:</h5>
			<%
				//get purposes from db
			SiteStructureDAO ssDAO = new SiteStructureDAO();
			SiteStructure ss = ssDAO.getStructure("contact_purpose");
			String[] options = ss.getText_value1().split(" ");
			%>

			<select class="form-control" id="purpose"
				style="margin-bottom: 20px;" name="purpose" required>
				<option value="" selected disabled hidden=true></option>
				<%
					for (int i = 0; i < options.length; i++) {
					out.println("<option>" + options[i] + "</option>");
				}
				%>
			</select>


			<h5>Title:</h5>
			<input type="text" id="inputTitle" class="form-control" name="title"
				style="margin-bottom: 20px;" required>


			<h5>Message:</h5>
			<textarea class="form-control" id="inputMessage" rows="6"
				name="message" style="margin-bottom: 20px;" required></textarea>



			<button class="btn btn-lg btn-primary btn-block" type="submit"
				id="submit-btn">Submit</button>
			<button class="btn btn-lg btn-primary btn-block" id="submit-ani"
				disabled>
				<span class="spinner-grow spinner-grow-sm"></span> Submitting...
			</button>

		</form>
	</div>


	<%--Import Footer --%>
	<%@ include file="footer.jsp"%>
</body>
</html>