<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="dataBaseModel.Users"
	import="userInterfaces.SiteAlerts" import="dataBaseModel.Users"
	import="dataBaseDAO.UsersDAO" import="dataBaseModel.Comments"
	import="dataBaseDAO.CommentsDAO" import="dataBaseModel.ContactMessages"
	import="dataBaseDAO.ContactMessagesDAO" import="java.util.List"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Email List</title>

</head>
<body>

	<%--Import Header--%>
	<%--IMPORTANT, Handles unauthorised access rejection--%>
	<%@ include file="header.jsp"%>

	<%-- // Initialise DAO --%>
	<%
		UsersDAO usDAO = new UsersDAO();
	CommentsDAO comDAO = new CommentsDAO();
	ContactMessagesDAO cmDAO = new ContactMessagesDAO();
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
					<h4>Email Lists (CSV)</h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">




					<%-- --------------------------------------------------------------------------- --%>


					<hr>
					<h5>Users Email</h5>
					<div class="form-label-group">
						<textarea class="form-control" id="user" rows="12" name="user">
							<%
								List<String> userList = usDAO.getAllUsersEmail();
							for (String email : userList) {
								out.print(email + ",");
							}
							%>
						</textarea>
					</div>


					<%-- --------------------------------------------------------------------------- --%>

					<hr>
					<h5>Anonymous Comments Email</h5>
					<div class="form-label-group">
						<textarea class="form-control" id="comment" rows="12"
							name="comment">
							<%
								List<String> commentList = comDAO.getAllAnonymousCommentsEmail();
							for (String uname : commentList) {
								String email = uname.substring(uname.indexOf("Email:") + 7);
								out.print(email + ",");
							}
							%>
						</textarea>
					</div>

					<script type="text/javascript">
						console.log(document.getElementById("comment").value);
					</script>

					<%-- --------------------------------------------------------------------------- --%>

					<hr>
					<h5>Contact Messages Email</h5>
					<div class="form-label-group">
						<textarea class="form-control" id="contact" rows="12"
							name="contact">
							<%
								List<String> contactList = cmDAO.getAllContactsEmail();
							for (String email : contactList) {
								out.print(email + ",");
							}
							%>
						</textarea>
					</div>

					<%-- --------------------------------------------------------------------------- --%>




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