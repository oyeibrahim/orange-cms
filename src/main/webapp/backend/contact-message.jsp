<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="java.util.List"
	import="dataBaseModel.Users" import="userInterfaces.SiteAlerts"
	import="utilities.UtilityMethods"
	import="dataBaseDAO.ContactMessagesDAO"
	import="dataBaseModel.ContactMessages"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Contact Message - <%=request.getParameter("id")%></title>

</head>
<body>

	<%--Import Header--%>
	<%--IMPORTANT, Handles unauthorised access rejection--%>
	<%@ include file="header.jsp"%>

	<%-- // Check message existence--%>
	<%
		//check if parameter exist
	if (request.getParameter("id") == null) {
		//set session
		session.setAttribute("ProfileUpdateErrorMessage", "No parameter povided");
		response.sendRedirect("backend/contact-messages/1/");
		return;
	}

	//access DAO
	ContactMessagesDAO cmDAO = new ContactMessagesDAO();

	//check if message exist
	if (!cmDAO.checkMessageWithId(request.getParameter("id"))) {
		//set session
		session.setAttribute("ProfileUpdateErrorMessage", "The requested message doesn't exist");
		response.sendRedirect("backend/contact-messages/1/");
		return;
	}

	//get the message
	ContactMessages cm = cmDAO.getMessage(request.getParameter("id"));
	%>
	<%-- // end--%>


	<%-- //Auto set to read--%>
	<%
		//only do that if the status was previously Unseen
	if (cm.getSeen_status().equals("Unseen")) {
		ContactMessages cm2 = new ContactMessages();
		cm2.setId(Long.parseLong(request.getParameter("id")));
		cm2.setSeen_status("Seen");
		cmDAO.updateMessageSeenStatus(cm2);
	}
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
						Message :
						<%=cm.getTitle()%></h4>
				</div>

				<%-- Information --%>

				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<h4 class="text-right">
						<a
							href="<%=webAddress%>/MessageStatusToggle?id=<%=cm.getId()%>&task=MarkUnread">Mark
							Unread</a>
					</h4>
					<hr>

					<div>

						<h6>ID :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=cm.getId()%></p>

						<h6>Name :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=cm.getName()%></p>

						<h6>Email :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=cm.getEmail()%></p>

						<h6>Purpose :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=cm.getPurpose()%></p>

						<h6>Title :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=cm.getTitle()%></p>

						<h6>Message :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=cm.getMessage()%></p>

						<h6>Date :</h6>
						<p class="img-thumbnail" style="padding: 5px;">
							<%
								String unformattedDate = cm.getDate_time();
							int startDate = unformattedDate.indexOf("Date: ") + 6;
							int endDate = unformattedDate.indexOf(" Time: ");

							String dateOnly = unformattedDate.substring(startDate, endDate);
							//**********desgin**********//
							//call utility method to format date.. um has been imported and declared in Header.jsp
							String formatedDate = um.formatDate(dateOnly, "E, MMM dd yyyy");
							//**********end desgin**********//
							out.println(formatedDate);
							%>
						</p>

						<h6>Time :</h6>
						<p class="img-thumbnail" style="padding: 5px;"><%=cm.getDate_time().substring(cm.getDate_time().indexOf("Time: ") + 7)%></p>



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