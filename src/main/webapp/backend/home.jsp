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

<title>Backend Dashboard Home</title>

</head>
<body>

	<%--Import Header--%>
	<%--IMPORTANT, Handles unauthorised access rejection--%>
	<%@ include file="header.jsp"%>


	<%-- Profile navbar --%>

	<div style="margin-top: 50px;">
		<div class="row">

			<%--Import Profile Menu Bar--%>
			<%@ include file="profile-menu.jsp"%>


			<div class="col-md-10" style="padding: 20px;" id="main">


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





				<%-- Title --%>
				&emsp;
				<div class="text-left img-thumbnail">
					<h4>Admin Dashboard</h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<div class="row"></div>

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