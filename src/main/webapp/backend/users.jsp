<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="dataBaseDAO.UsersDAO" import="java.util.List"
	import="dataBaseModel.Users" import="userInterfaces.SiteAlerts"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>User List</title>

</head>
<body>

	<%--Import Header--%>
	<%--IMPORTANT, Handles unauthorised access rejection--%>
	<%@ include file="header.jsp"%>

	<%
		//pagination
	//deals with more than one / after the link issue

	//get the link requested
	String userReq = request.getPathInfo().substring(1);

	if (userReq.contains("/")) {

		//deal with case where there are more than one / at end
		//get the full link which will include the /s
		String userReq2 = request.getRequestURI();

		//from that, get the username with the /s... check for one / below
		userReq2 = userReq2.substring(userReq2.indexOf("/users") + 7);

		//make sure nothing is after that /, if anything after it then throw error
		if (userReq.endsWith("/")) {
			//if just one /, remove the /
			//this uses the above userReq2
			if (userReq.substring(0, userReq.indexOf("/")).length() + 1 == userReq2.length()) {

		userReq = userReq.substring(0, userReq.length() - 1);

			} else {//if many /s
		response.sendError(404, "An error occured due to the link requested!");
		return;
			}
		} else {//if something after / then throw error
			response.sendError(404, "An error occured due to the link requested!");
			return;
		}
	}

	//initialise the DAO
	UsersDAO users = new UsersDAO();

	//get the total post number
	//placeholder
	double count = 0;
	//------------------------------------------------------------
	//handle count if there is or isn't a search parameter as the total number will be different with both
	if (request.getParameter("search") == null && request.getParameter("status") == null) {
		count = users.countUsers("non");
	}

	if (request.getParameter("search") != null) {
		count = users.countSearchUsers(request.getParameter("search"), "non");
	}

	if (request.getParameter("status") != null && request.getParameter("status").equals("unconfirmed")) {
		count = users.countUnconfirmedUsers();
	}
	//------------------------------------------------------------

	//total number of posts per page
	double total = 25;

	//Do total page to list calculation

	//do the page number calculation
	//divide the number of history by the total to display on each page
	//make both double so if their is a decimal place we can get it
	double pageNumTemp = count / total;

	//round up to higher value in case it is double(has decimal places)
	int pageNum = (int) Math.ceil(pageNumTemp);
	//int pageNum = 30;

	if (pageNum > 0) {
		//check if the user hasn't requested a wrong or non existense page number
		//if too much, set to the last page
		if (Integer.parseInt(userReq) > pageNum) {
			//userReq = String.valueOf(pageNum);
			//get requested url and replace the wrong request number with the maximum page available
			response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)));
			return;
		} //if too small, set to the first page
		else if (Integer.parseInt(userReq) < 1) {
			//userReq = String.valueOf(1);
			response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(1)));
			return;
		}
	}
	%>


	<%-- Profile navbar --%>

	<div style="margin-top: 50px;">
		<div class="row">

			<%--Import Profile Menu Bar--%>
			<%@ include file="profile-menu.jsp"%>


			<%-- ////////////////// Content ///////////////// --%>


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



				<%-- Search --%>
				<form action="<%=webAddress%>/backend/users/1/"
					class="navbar-form navbar-right form-row">
					<div class="form-group col">
						<input type="text" class="form-control" placeholder="Search"
							name="search">
					</div>
					<div class="form-group col">
						<button class="btn btn-primary">Search</button>
					</div>
				</form>
				<%-- End Search --%>



				<%-- Title --%>
				&emsp;
				<div class="text-left img-thumbnail">
					<h4>
						All users &emsp; <span class="h6">Total (<%=(int) count%>)
						</span> &emsp;
						<%
							//show only if no parameter
						int unconfirmedCount = (int) users.countUnconfirmedUsers();
						if (request.getParameter("search") == null && request.getParameter("status") == null) {
							out.println("<a class='h6' href='" + webAddress + "/backend/users/1/?status=unconfirmed'>Only unactivated ("
							+ unconfirmedCount + ")</a>");
						}
						%>
					</h4>
					<h4 class="text-right"></h4>
				</div>

				<%-- Information --%>

				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">

					<div class="row">

						<div class="col-sm-12">
							<div class="img-thumbnail shadow" style="margin-bottom: 10px;">
								<div class="img-thumbnail">


									<%-- ////////////////////////// history code /////////////////////////////////// --%>
									<%-- Table --%>

									<table
										class="table table-hover table-sm table-responsive-md text-nowrap">

										<%-- Table Head --%>

										<thead class="thead-light">
											<tr>
												<th scope="col">&nbsp; &nbsp; No</th>
												<th scope="col">&nbsp; &nbsp; ID</th>
												<th scope="col">&nbsp; &nbsp; Firstname</th>
												<th scope="col">&nbsp; &nbsp; Lastname</th>
												<th scope="col">&nbsp; &nbsp; Username</th>
												<th scope="col">&nbsp; &nbsp; Email</th>
												<th scope="col">&nbsp; &nbsp; Joined</th>
												<th scope="col">&nbsp; &nbsp; Activated</th>
												<th scope="col">&nbsp; &nbsp; Tag</th>
												<th scope="col">&nbsp; &nbsp; Info</th>
												<th scope="col">&nbsp; &nbsp; Edit</th>
											</tr>
										</thead>

										<%-- End Table Head --%>

										<%-- Table Body --%>
										<tbody>

											<%
												//display the data
											//if no search query
											if (request.getParameter("search") == null && request.getParameter("status") == null) {
												//multiply request by number of post per page then subtract answer by number of post per page
												int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

												//get data from db
												List<Users> list = users.getAllUsers("non", start, (int) total);
												//for counting item number, use the above tactive but add 1 so as not to start from 0
												int No = 1 + (Integer.parseInt(userReq) * (int) total) - (int) total;

												//list users in table
												for (Users us : list) {
													//process activated and unactivated
													String activated = "";
													//bold unactivated
													String unactivatedFormat = "";
													if (us.getActive() == 1) {
												activated = "YES";
													} else {
												activated = "NO";
												unactivatedFormat = "style='font-weight:bold;'";
													}

													out.println("<tr>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; " + No++ + "</td>" + "<td "
													+ unactivatedFormat + ">&nbsp; &nbsp; " + us.getId() + "</td>" + "<td " + unactivatedFormat
													+ ">&nbsp; &nbsp; " + us.getFirstname() + "</td>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; "
													+ us.getLastname() + "</td>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; " + us.getUsername()
													+ "</td>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; " + us.getEmail() + "</td>" + "<td "
													+ unactivatedFormat + ">&nbsp; &nbsp; "
													+ us.getJoined().substring(us.getJoined().indexOf(" "), us.getJoined().indexOf(" T")) + "</td>" + "<td "
													+ unactivatedFormat + ">&nbsp; &nbsp; " + activated + "</td>" + "<td " + unactivatedFormat
													+ ">&nbsp; &nbsp; " + us.getTag() + "</td>" + "<td>&nbsp; &nbsp; <a href='" + webAddress
													+ "/backend/user?u=" + us.getUsername() + "'>Click</a></td>" + "<td>&nbsp; &nbsp; <a href='"
													+ webAddress + "/backend/user-edit?u=" + us.getUsername() + "'>Click</a></td>" + "</tr>");
												}
											}

											//if search query exist
											if (request.getParameter("search") != null) {
												//multiply request by number of post per page then subtract answer by number of post per page
												int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

												//get data from db
												List<Users> list = users.searchUsers(request.getParameter("search"), "non", start, (int) total);
												//for counting item number, use the above tactive but add 1 so as not to start from 0
												int No = 1 + (Integer.parseInt(userReq) * (int) total) - (int) total;

												//list users in table
												for (Users us : list) {
													//process activated and unactivated
													String activated = "";
													//bold unactivated
													String unactivatedFormat = "";
													if (us.getActive() == 1) {
												activated = "YES";
													} else {
												activated = "NO";
												unactivatedFormat = "style='font-weight:bold;'";
													}

													out.println("<tr>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; " + No++ + "</td>" + "<td "
													+ unactivatedFormat + ">&nbsp; &nbsp; " + us.getId() + "</td>" + "<td " + unactivatedFormat
													+ ">&nbsp; &nbsp; " + us.getFirstname() + "</td>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; "
													+ us.getLastname() + "</td>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; " + us.getUsername()
													+ "</td>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; " + us.getEmail() + "</td>" + "<td "
													+ unactivatedFormat + ">&nbsp; &nbsp; "
													+ us.getJoined().substring(us.getJoined().indexOf(" "), us.getJoined().indexOf(" T")) + "</td>" + "<td "
													+ unactivatedFormat + ">&nbsp; &nbsp; " + activated + "</td>" + "<td " + unactivatedFormat
													+ ">&nbsp; &nbsp; " + us.getTag() + "</td>" + "<td>&nbsp; &nbsp; <a href='" + webAddress
													+ "/backend/user?u=" + us.getUsername() + "'>Click</a></td>" + "<td>&nbsp; &nbsp; <a href='"
													+ webAddress + "/backend/user-edit?u=" + us.getUsername() + "'>Click</a></td>" + "</tr>");
												}
											}

											//if only unconfirmed requested
											if (request.getParameter("status") != null && request.getParameter("status").equals("unconfirmed")) {
												//multiply request by number of post per page then subtract answer by number of post per page
												int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

												//get data from db
												List<Users> list = users.getAllUnconfirmedUsers(start, (int) total);

												//for counting item number, use the above tactive but add 1 so as not to start from 0
												int No = 1 + (Integer.parseInt(userReq) * (int) total) - (int) total;

												//list users in table
												for (Users us : list) {
													//process activated and unactivated
													String activated = "";
													//bold unactivated
													String unactivatedFormat = "";
													if (us.getActive() == 1) {
												activated = "YES";
													} else {
												activated = "NO";
												unactivatedFormat = "style='font-weight:bold;'";
													}

													out.println("<tr>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; " + No++ + "</td>" + "<td "
													+ unactivatedFormat + ">&nbsp; &nbsp; " + us.getId() + "</td>" + "<td " + unactivatedFormat
													+ ">&nbsp; &nbsp; " + us.getFirstname() + "</td>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; "
													+ us.getLastname() + "</td>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; " + us.getUsername()
													+ "</td>" + "<td " + unactivatedFormat + ">&nbsp; &nbsp; " + us.getEmail() + "</td>" + "<td "
													+ unactivatedFormat + ">&nbsp; &nbsp; "
													+ us.getJoined().substring(us.getJoined().indexOf(" "), us.getJoined().indexOf(" T")) + "</td>" + "<td "
													+ unactivatedFormat + ">&nbsp; &nbsp; " + activated + "</td>" + "<td " + unactivatedFormat
													+ ">&nbsp; &nbsp; " + us.getTag() + "</td>" + "<td>&nbsp; &nbsp; <a href='" + webAddress
													+ "/backend/user?u=" + us.getUsername() + "'>Click</a></td>" + "<td>&nbsp; &nbsp; <a href='"
													+ webAddress + "/backend/user-edit?u=" + us.getUsername() + "'>Click</a></td>" + "</tr>");
												}
											}
											%>


										</tbody>

										<%-- End Table Body --%>

									</table>
									<hr>
									<%-- End Table --%>





									<%-- Pagination --%>
									<nav>
										<ul class="pagination pagination-sm justify-content-center"
											id="pagination-demo">

											<%
												//Pagination

											//pagination for no parameter
											if (request.getParameter("search") == null && request.getParameter("status") == null) {
												//show pagination only if there is more than one page
												if (pageNum > 1) {
													//back button
													if (Integer.parseInt(userReq) > 1) {
												//minus one from the value when greater than one
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) - 1))
														+ ">&laquo;</a>");
													}

													//gets three section of the total pages -BEGINNING, MIDDLE and END sections
													//for putting direct link to the farthest page
													int pageSec = pageNum / 3;

													//if page in the END section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													//using pageNum and not pageSec*3 in the test below as some devision may end up providing less than
													//the total number when multiplied by 3 since its integer division
													if (Integer.parseInt(userReq) <= pageNum && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(1)) + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//if page in the MIDDLE section, put link to the first page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(1)) + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//print all pages (constraint inside to prevent printing all)
													for (int i = 1; i <= pageNum; i++) {
												//put active class on the active link tab
												if (i == Integer.parseInt(userReq)) {
													out.println("<li class='page-item active'><a class='page-link' href="
															+ request.getRequestURI().replaceAll(userReq, String.valueOf(i)) + ">" + i + "</a>");
												}
												//print the number of pages we want, specified by the number added below
												//to constraint this, make sure its not a small number of pages for good UI, so, i define a small number as below 9
												//as i have used 9 to set the test for pageSec (page sections) above
												else if (i <= Integer.parseInt(userReq) + 2 && i >= Integer.parseInt(userReq) - 2 && pageNum > 8) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ request.getRequestURI().replaceAll(userReq, String.valueOf(i)) + ">" + i + "</a>");

												}
												//if small number of pages, just print everything
												else if (pageNum < 9) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ request.getRequestURI().replaceAll(userReq, String.valueOf(i)) + ">" + i + "</a>");
												}
													}

													//if page in the MIDDLE section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + ">" + pageNum + "</a>");
													}

													//if page in the BEGINNING section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + ">" + pageNum + "</a>");
													}

													//if page in the END section, put link to the last page, so if the last section is big, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageNum - 4 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + ">" + pageNum + "</a>");
													}
													//an extension of the above to show last page without dots when the page number gets to second to last
													if (Integer.parseInt(userReq) == pageNum - 3 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + ">" + pageNum + "</a>");
													}

													//forward button
													if (Integer.parseInt(userReq) < pageNum) {
												//add one to the value when less than the highest number
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) + 1))
														+ ">&raquo;</a>");
													}
												}
											}

											//pagination for search parameter
											if (request.getParameter("search") != null) {
												//show pagination only if there is more than one page
												if (pageNum > 1) {
													//back button
													if (Integer.parseInt(userReq) > 1) {
												//minus one from the value when greater than one
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) - 1))
														+ "?search=" + request.getParameter("search") + ">&laquo;</a>");
													}

													//gets three section of the total pages -BEGINNING, MIDDLE and END sections
													//for putting direct link to the farthest page
													int pageSec = pageNum / 3;

													//if page in the END section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													//using pageNum and not pageSec*3 in the test below as some devision may end up providing less than
													//the total number when multiplied by 3 since its integer division
													if (Integer.parseInt(userReq) <= pageNum && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(1)) + "?search="
														+ request.getParameter("search") + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//if page in the MIDDLE section, put link to the first page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(1)) + "?search="
														+ request.getParameter("search") + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//print all pages (constraint inside to prevent printing all)
													for (int i = 1; i <= pageNum; i++) {
												//put active class on the active link tab
												if (i == Integer.parseInt(userReq)) {
													out.println("<li class='page-item active'><a class='page-link' href="
															+ request.getRequestURI().replaceAll(userReq, String.valueOf(i)) + "?search="
															+ request.getParameter("search") + ">" + i + "</a>");
												}
												//print the number of pages we want, specified by the number added below
												//to constraint this, make sure its not a small number of pages for good UI, so, i define a small number as below 9
												//as i have used 9 to set the test for pageSec (page sections) above
												else if (i <= Integer.parseInt(userReq) + 2 && i >= Integer.parseInt(userReq) - 2 && pageNum > 8) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ request.getRequestURI().replaceAll(userReq, String.valueOf(i)) + "?search="
															+ request.getParameter("search") + ">" + i + "</a>");

												}
												//if small number of pages, just print everything
												else if (pageNum < 9) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ request.getRequestURI().replaceAll(userReq, String.valueOf(i)) + "?search="
															+ request.getParameter("search") + ">" + i + "</a>");
												}
													}

													//if page in the MIDDLE section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?search="
														+ request.getParameter("search") + ">" + pageNum + "</a>");
													}

													//if page in the BEGINNING section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?search="
														+ request.getParameter("search") + ">" + pageNum + "</a>");
													}

													//if page in the END section, put link to the last page, so if the last section is big, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageNum - 4 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?search="
														+ request.getParameter("search") + ">" + pageNum + "</a>");
													}
													//an extension of the above to show last page without dots when the page number gets to second to last
													if (Integer.parseInt(userReq) == pageNum - 3 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?search="
														+ request.getParameter("search") + ">" + pageNum + "</a>");
													}

													//forward button
													if (Integer.parseInt(userReq) < pageNum) {
												//add one to the value when less than the highest number
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) + 1))
														+ "?search=" + request.getParameter("search") + ">&raquo;</a>");
													}
												}
											}

											//pagination for status parameter
											if (request.getParameter("status") != null && request.getParameter("status").equals("unconfirmed")) {
												//show pagination only if there is more than one page
												if (pageNum > 1) {
													//back button
													if (Integer.parseInt(userReq) > 1) {
												//minus one from the value when greater than one
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) - 1))
														+ "?status=" + request.getParameter("status") + ">&laquo;</a>");
													}

													//gets three section of the total pages -BEGINNING, MIDDLE and END sections
													//for putting direct link to the farthest page
													int pageSec = pageNum / 3;

													//if page in the END section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													//using pageNum and not pageSec*3 in the test below as some devision may end up providing less than
													//the total number when multiplied by 3 since its integer division
													if (Integer.parseInt(userReq) <= pageNum && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(1)) + "?status="
														+ request.getParameter("status") + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//if page in the MIDDLE section, put link to the first page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(1)) + "?status="
														+ request.getParameter("status") + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//print all pages (constraint inside to prevent printing all)
													for (int i = 1; i <= pageNum; i++) {
												//put active class on the active link tab
												if (i == Integer.parseInt(userReq)) {
													out.println("<li class='page-item active'><a class='page-link' href="
															+ request.getRequestURI().replaceAll(userReq, String.valueOf(i)) + "?status="
															+ request.getParameter("status") + ">" + i + "</a>");
												}
												//print the number of pages we want, specified by the number added below
												//to constraint this, make sure its not a small number of pages for good UI, so, i define a small number as below 9
												//as i have used 9 to set the test for pageSec (page sections) above
												else if (i <= Integer.parseInt(userReq) + 2 && i >= Integer.parseInt(userReq) - 2 && pageNum > 8) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ request.getRequestURI().replaceAll(userReq, String.valueOf(i)) + "?status="
															+ request.getParameter("status") + ">" + i + "</a>");

												}
												//if small number of pages, just print everything
												else if (pageNum < 9) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ request.getRequestURI().replaceAll(userReq, String.valueOf(i)) + "?status="
															+ request.getParameter("status") + ">" + i + "</a>");
												}
													}

													//if page in the MIDDLE section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?status="
														+ request.getParameter("status") + ">" + pageNum + "</a>");
													}

													//if page in the BEGINNING section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?status="
														+ request.getParameter("status") + ">" + pageNum + "</a>");
													}

													//if page in the END section, put link to the last page, so if the last section is big, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageNum - 4 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?status="
														+ request.getParameter("status") + ">" + pageNum + "</a>");
													}
													//an extension of the above to show last page without dots when the page number gets to second to last
													if (Integer.parseInt(userReq) == pageNum - 3 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?status="
														+ request.getParameter("status") + ">" + pageNum + "</a>");
													}

													//forward button
													if (Integer.parseInt(userReq) < pageNum) {
												//add one to the value when less than the highest number
												out.println("<li class='page-item'><a class='page-link' href="
														+ request.getRequestURI().replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) + 1))
														+ "?status=" + request.getParameter("status") + ">&raquo;</a>");
													}
												}
											}
											%>
										</ul>
									</nav>
									<%-- End Pagination --%>
									<%-- ////////////////////////// end history code /////////////////////////////////// --%>

								</div>
							</div>
						</div>

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