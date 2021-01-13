<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="java.util.List"
	import="dataBaseModel.Users" import="userInterfaces.SiteAlerts"
	import="utilities.UtilityMethods"
	import="dataBaseDAO.ContactMessagesDAO"
	import="dataBaseModel.ContactMessages"
	import="dataBaseDAO.SiteStructureDAO"
	import="dataBaseModel.SiteStructure"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Database Setting</title>

</head>
<body>

	<%--Import Header--%>
	<%--IMPORTANT, Handles unauthorised access rejection--%>
	<%@ include file="header.jsp"%>

	<%-- // Check structure existence--%>
	<%
		//check if parameter exist
	if (request.getParameter("id") == null) {
		//set session
		session.setAttribute("ProfileUpdateErrorMessage", "No parameter povided");
		response.sendRedirect("backend/db-settings/1/");
		return;
	}

	//access DAO
	SiteStructureDAO ssDAO = new SiteStructureDAO();

	//check if structure exist
	if (!ssDAO.checkStructureWithId(request.getParameter("id"))) {
		//set session
		session.setAttribute("ProfileUpdateErrorMessage", "The requested setting doesn't exist");
		response.sendRedirect("backend/db-settings/1/");
		return;
	}

	//get the message
	SiteStructure ss = ssDAO.getStructureWithId(request.getParameter("id"));
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
					<h4>
						Setting :
						<%=ss.getName()%></h4>
				</div>

				<%-- Information --%>

				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<div>

						<h6>ID :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=ss.getId()%></p>

						<h6>Name :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=ss.getName()%></p>

						<%-- Display NaN for null and zero --%>

						<h6>Text Value 1 :</h6>
						<p class="img-thumbnail" style="padding: 5px;">
							<%
								if (ss.getText_value1() == null || ss.getText_value1().equals("")) {
								out.println("NaN");
							} else {
								out.println(ss.getText_value1());
							}
							%>
						</p>

						<h6>Text Value 2 :</h6>
						<p class="img-thumbnail" style="padding: 5px;">
							<%
								if (ss.getText_value2() == null || ss.getText_value2().equals("")) {
								out.println("NaN");
							} else {
								out.println(ss.getText_value2());
							}
							%>
						</p>

						<h6>Text Value 3 :</h6>
						<p class="img-thumbnail" style="padding: 5px;">
							<%
								if (ss.getText_value3() == null || ss.getText_value3().equals("")) {
								out.println("NaN");
							} else {
								out.println(ss.getText_value3());
							}
							%>
						</p>

						<h6>Num Value 1 :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=ss.getNum_value1()%></p>

						<h6>Num Value 2 :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=ss.getNum_value2()%></p>

						<h6>Num Value 3 :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=ss.getNum_value3()%></p>

						<h6>Date Created :</h6>
						<p class="img-thumbnail" style="padding: 5px;">
							<%=um.formatDbDate(ss.getCreated().substring(0, ss.getCreated().indexOf(" ")), "E, MMM dd yyyy")%>
						</p>

						<h6>Last Update :</h6>
						<p class="img-thumbnail" style="padding: 5px;">
							<%=um.formatDbDate(ss.getUpdated().substring(0, ss.getUpdated().indexOf(" ")), "E, MMM dd yyyy")%>
						</p>



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