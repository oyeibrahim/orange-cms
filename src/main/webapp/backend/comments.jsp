<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="java.util.List"
	import="dataBaseModel.Users" import="userInterfaces.SiteAlerts"
	import="dataBaseModel.Posts" import="dataBaseDAO.PostsDAO"
	import="dataBaseModel.Comments" import="dataBaseDAO.CommentsDAO"
	import="utilities.UtilityMethods"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Comments List</title>

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
		userReq2 = userReq2.substring(userReq2.indexOf("/comments") + 10);

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
	PostsDAO postDAO = new PostsDAO();

	CommentsDAO comDAO = new CommentsDAO();

	UsersDAO userDAO = new UsersDAO();


	//get the total post number
	//placeholder
	double count = 0;
	//------------------------------------------------------------
	//handle count if there is or isn't a parameter as the total number will be different with each

	if (request.getParameter("search") == null && request.getParameter("status") == null) {
		count = comDAO.countAllComments("All");
		//set session for redirecting
		session.setAttribute("redirect", request.getRequestURI());
	}

	if (request.getParameter("status") != null) {
		//All comment fetch is just used with status for status parameter
		count = comDAO.countAllComments(request.getParameter("status"));
		//set session for redirecting
		session.setAttribute("redirect", request.getRequestURI() + "?status=" + request.getParameter("status"));
	}

	if (request.getParameter("search") != null) {
		count = comDAO.countSearchComments(request.getParameter("search"), "All");
		//set session for redirecting
		session.setAttribute("redirect", request.getRequestURI() + "?search=" + request.getParameter("search"));
	}
	//------------------------------------------------------------

	//total number of comments per page
	double total = 10;

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



				<%-- Search --%>
				<form action="<%=um.baseUrl(request, "/backend/comments/1/")%>"
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
						All comments &emsp; <span class="h6">Total (<%=(int) count%>)
						</span> &emsp; <a class='h6'
							href='<%=um.baseUrl(request, "/backend/comments/1/?status=Pending")%>'>Only
							pending (<%=(int) comDAO.countAllComments("Pending")%>)
						</a>
						<%
							//show only if no parameter
						//if(request.getParameter("search") == null && request.getParameter("status") == null){
						//	out.println("<a class='h6' href='" + webAddress + "/swk-admin/posts/1/?status=Pending'>See pending posts</a>");
						//}
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
										class="table table-hover table-sm table-responsive-lg text-nowrap">

										<%-- Table Head --%>

										<thead class="thead-light">
											<tr>
												<th scope="col">&nbsp; &nbsp; No</th>
												<th scope="col">&nbsp; &nbsp; ID</th>
												<th scope="col">&nbsp; &nbsp; body</th>
												<th scope="col">&nbsp; &nbsp; View</th>
												<th scope="col">&nbsp; &nbsp; Approval</th>
											</tr>
										</thead>

										<%-- End Table Head --%>

										<%-- Table Body --%>
										<tbody>

											<%
												//display the data

											//if no query
											if (request.getParameter("search") == null && request.getParameter("status") == null) {
												//multiply request by number of post per page then subtract answer by number of post per page
												int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

												//get data from db
												List<Comments> list = comDAO.getAllComments("All", start, (int) total);

												//for counting item number, use the above tactive but add 1 so as not to start from 0
												int No = 1 + (Integer.parseInt(userReq) * (int) total) - (int) total;

												//list users in table
												for (Comments comment : list) {
													//body words must not be more than 10 to prevent disfigure table as it may be too long
													String editedBody = um.getWordCount(comment.getBody(), 15, "YES");
													//toggle approve button
													String toggleApprove = "";
													//bold unapproved
													String unapprovedFormat = "";
													//if already approved, button will be to unapprove
													if (comment.getStatus().equals("Published")) {
												toggleApprove = "<td>&nbsp; &nbsp; <a href='" + webAddress + "/CommentStatusToggle?id=" + comment.getId()
														+ "&task=Unapprove'>Unapprove</a></td>";
													} else {//else, button will be to approve
												toggleApprove = "<td>&nbsp; &nbsp; <a href='" + webAddress + "/CommentStatusToggle?id=" + comment.getId()
														+ "&task=Approve'>Approve</a></td>";
												unapprovedFormat = "style='font-weight:bold;'";
													}

													out.println("<tr>" + "<td " + unapprovedFormat + ">&nbsp; &nbsp; " + No++ + "</td>" + "<td " + unapprovedFormat
													+ ">&nbsp; &nbsp; " + comment.getId() + "</td>" + "<td " + unapprovedFormat + ">&nbsp; &nbsp; "
													+ editedBody + "</td>" + "<td>&nbsp; &nbsp; <a href='" + webAddress + "/post/"
													+ postDAO.getPostLinkWithId(comment.getComments_posts_id()) + "'>Click</a></td>" + toggleApprove
													+ "</tr>");
												}
											}

											//status query
											if (request.getParameter("status") != null) {
												//multiply request by number of post per page then subtract answer by number of post per page
												int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

												//get data from db
												List<Comments> list = comDAO.getAllComments(request.getParameter("status"), start, (int) total);

												//for counting item number, use the above tactive but add 1 so as not to start from 0
												int No = 1 + (Integer.parseInt(userReq) * (int) total) - (int) total;

												//list users in table
												for (Comments comment : list) {
													//body words must not be more than 10 to prevent disfigure table as it may be too long
													String editedBody = um.getWordCount(comment.getBody(), 15, "YES");
													//toggle approve button
													String toggleApprove = "";
													//bold unapproved
													String unapprovedFormat = "";
													//if already approved, button will be to unapprove
													if (comment.getStatus().equals("Published")) {
												toggleApprove = "<td>&nbsp; &nbsp; <a href='" + webAddress + "/CommentStatusToggle?id=" + comment.getId()
														+ "&task=Unapprove'>Unapprove</a></td>";
													} else {//else, button will be to approve
												toggleApprove = "<td>&nbsp; &nbsp; <a href='" + webAddress + "/CommentStatusToggle?id=" + comment.getId()
														+ "&task=Approve'>Approve</a></td>";
												unapprovedFormat = "style='font-weight:bold;'";
													}

													out.println("<tr>" + "<td " + unapprovedFormat + ">&nbsp; &nbsp; " + No++ + "</td>" + "<td " + unapprovedFormat
													+ ">&nbsp; &nbsp; " + comment.getId() + "</td>" + "<td " + unapprovedFormat + ">&nbsp; &nbsp; "
													+ editedBody + "</td>" + "<td>&nbsp; &nbsp; <a href='" + webAddress + "/post/"
													+ postDAO.getPostLinkWithId(comment.getComments_posts_id()) + "'>Click</a></td>" + toggleApprove
													+ "</tr>");
												}
											}

											//search query
											if (request.getParameter("search") != null) {
												//multiply request by number of post per page then subtract answer by number of post per page
												int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

												//get data from db
												List<Comments> list = comDAO.getSearchComments(request.getParameter("search"), "All", start, (int) total);

												//for counting item number, use the above tactive but add 1 so as not to start from 0
												int No = 1 + (Integer.parseInt(userReq) * (int) total) - (int) total;

												//list users in table
												for (Comments comment : list) {
													//body words must not be more than 10 to prevent disfigure table as it may be too long
													String editedBody = um.getWordCount(comment.getBody(), 15, "YES");
													//toggle approve button
													String toggleApprove = "";
													//bold unapproved
													String unapprovedFormat = "";
													//if already approved, button will be to unapprove
													if (comment.getStatus().equals("Published")) {
												toggleApprove = "<td>&nbsp; &nbsp; <a href='" + webAddress + "/CommentStatusToggle?id=" + comment.getId()
														+ "&task=Unapprove'>Unapprove</a></td>";
													} else {//else, button will be to approve
												toggleApprove = "<td>&nbsp; &nbsp; <a href='" + webAddress + "/CommentStatusToggle?id=" + comment.getId()
														+ "&task=Approve'>Approve</a></td>";
												unapprovedFormat = "style='font-weight:bold;'";
													}

													out.println("<tr>" + "<td " + unapprovedFormat + ">&nbsp; &nbsp; " + No++ + "</td>" + "<td " + unapprovedFormat
													+ ">&nbsp; &nbsp; " + comment.getId() + "</td>" + "<td " + unapprovedFormat + ">&nbsp; &nbsp; "
													+ editedBody + "</td>" + "<td>&nbsp; &nbsp; <a href='" + webAddress + "/post/"
													+ postDAO.getPostLinkWithId(comment.getComments_posts_id()) + "'>Click</a></td>" + toggleApprove
													+ "</tr>");
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

											//since we can request for /posts without stating the page number and to print 
											//pagination, we are just adding or subtracting the userReq(the number) in the 
											//link requested. So we must make sure there is a number
											//check for this and add number if there is no number, add / if its not there too
											String reqURI = "";

											//if there is already the number there
											if (request.getRequestURI().contains(userReq)) {
												//just return the whole link
												reqURI = request.getRequestURI();
											} else {//if no number
													//if there is a /
												if (request.getRequestURI().contains("comments/")) {
													//just ad the number
													reqURI = request.getRequestURI() + userReq;
												} else {//if not
													//add slash first then the number
													reqURI = request.getRequestURI() + "/" + userReq;
												}

											}

											//pagination for no parameter
											if (request.getParameter("search") == null && request.getParameter("status") == null) {
												//show pagination only if there is more than one page
												if (pageNum > 1) {
													//back button
													if (Integer.parseInt(userReq) > 1) {
												//minus one from the value when greater than one
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) - 1)) + ">&laquo;</a>");
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
														+ reqURI.replaceAll(userReq, String.valueOf(1)) + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//if page in the MIDDLE section, put link to the first page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(1)) + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//print all pages (constraint inside to prevent printing all)
													for (int i = 1; i <= pageNum; i++) {
												//put active class on the active link tab
												if (i == Integer.parseInt(userReq)) {
													out.println("<li class='page-item active'><a class='page-link' href="
															+ reqURI.replaceAll(userReq, String.valueOf(i)) + ">" + i + "</a>");
												}
												//print the number of pages we want, specified by the number added below
												//to constraint this, make sure its not a small number of pages for good UI, so, i define a small number as below 9
												//as i have used 9 to set the test for pageSec (page sections) above
												else if (i <= Integer.parseInt(userReq) + 2 && i >= Integer.parseInt(userReq) - 2 && pageNum > 8) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ reqURI.replaceAll(userReq, String.valueOf(i)) + ">" + i + "</a>");

												}
												//if small number of pages, just print everything
												else if (pageNum < 9) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ reqURI.replaceAll(userReq, String.valueOf(i)) + ">" + i + "</a>");
												}
													}

													//if page in the MIDDLE section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + ">" + pageNum + "</a>");
													}

													//if page in the BEGINNING section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + ">" + pageNum + "</a>");
													}

													//if page in the END section, put link to the last page, so if the last section is big, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageNum - 4 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + ">" + pageNum + "</a>");
													}
													//an extension of the above to show last page without dots when the page number gets to second to last
													if (Integer.parseInt(userReq) == pageNum - 3 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + ">" + pageNum + "</a>");
													}

													//forward button
													if (Integer.parseInt(userReq) < pageNum) {
												//add one to the value when less than the highest number
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) + 1)) + ">&raquo;</a>");
													}
												}
											}

											//pagination for status parameter
											if (request.getParameter("status") != null) {
												//show pagination only if there is more than one page
												if (pageNum > 1) {
													//back button
													if (Integer.parseInt(userReq) > 1) {
												//minus one from the value when greater than one
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) - 1)) + "?status="
														+ request.getParameter("status") + ">&laquo;</a>");
													}

													//gets three section of the total pages -BEGINNING, MIDDLE and END sections
													//for putting direct link to the farthest page
													int pageSec = pageNum / 3;

													//if page in the END section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													//using pageNum and not pageSec*3 in the test below as some devision may end up providing less than
													//the total number when multiplied by 3 since its integer division
													if (Integer.parseInt(userReq) <= pageNum && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println(
														"<li class='page-item'><a class='page-link' href=" + reqURI.replaceAll(userReq, String.valueOf(1))
																+ "?status=" + request.getParameter("status") + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//if page in the MIDDLE section, put link to the first page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println(
														"<li class='page-item'><a class='page-link' href=" + reqURI.replaceAll(userReq, String.valueOf(1))
																+ "?status=" + request.getParameter("status") + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//print all pages (constraint inside to prevent printing all)
													for (int i = 1; i <= pageNum; i++) {
												//put active class on the active link tab
												if (i == Integer.parseInt(userReq)) {
													out.println("<li class='page-item active'><a class='page-link' href="
															+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?status=" + request.getParameter("status")
															+ ">" + i + "</a>");
												}
												//print the number of pages we want, specified by the number added below
												//to constraint this, make sure its not a small number of pages for good UI, so, i define a small number as below 9
												//as i have used 9 to set the test for pageSec (page sections) above
												else if (i <= Integer.parseInt(userReq) + 2 && i >= Integer.parseInt(userReq) - 2 && pageNum > 8) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?status=" + request.getParameter("status")
															+ ">" + i + "</a>");

												}
												//if small number of pages, just print everything
												else if (pageNum < 9) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?status=" + request.getParameter("status")
															+ ">" + i + "</a>");
												}
													}

													//if page in the MIDDLE section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?status=" + request.getParameter("status")
														+ ">" + pageNum + "</a>");
													}

													//if page in the BEGINNING section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?status=" + request.getParameter("status")
														+ ">" + pageNum + "</a>");
													}

													//if page in the END section, put link to the last page, so if the last section is big, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageNum - 4 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?status=" + request.getParameter("status")
														+ ">" + pageNum + "</a>");
													}
													//an extension of the above to show last page without dots when the page number gets to second to last
													if (Integer.parseInt(userReq) == pageNum - 3 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?status=" + request.getParameter("status")
														+ ">" + pageNum + "</a>");
													}

													//forward button
													if (Integer.parseInt(userReq) < pageNum) {
												//add one to the value when less than the highest number
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) + 1)) + "?status="
														+ request.getParameter("status") + ">&raquo;</a>");
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
														+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) - 1)) + "?search="
														+ request.getParameter("search") + ">&laquo;</a>");
													}

													//gets three section of the total pages -BEGINNING, MIDDLE and END sections
													//for putting direct link to the farthest page
													int pageSec = pageNum / 3;

													//if page in the END section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													//using pageNum and not pageSec*3 in the test below as some devision may end up providing less than
													//the total number when multiplied by 3 since its integer division
													if (Integer.parseInt(userReq) <= pageNum && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println(
														"<li class='page-item'><a class='page-link' href=" + reqURI.replaceAll(userReq, String.valueOf(1))
																+ "?search=" + request.getParameter("search") + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//if page in the MIDDLE section, put link to the first page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println(
														"<li class='page-item'><a class='page-link' href=" + reqURI.replaceAll(userReq, String.valueOf(1))
																+ "?search=" + request.getParameter("search") + ">" + 1 + "</a>");
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
													}

													//print all pages (constraint inside to prevent printing all)
													for (int i = 1; i <= pageNum; i++) {
												//put active class on the active link tab
												if (i == Integer.parseInt(userReq)) {
													out.println("<li class='page-item active'><a class='page-link' href="
															+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?search=" + request.getParameter("search")
															+ ">" + i + "</a>");
												}
												//print the number of pages we want, specified by the number added below
												//to constraint this, make sure its not a small number of pages for good UI, so, i define a small number as below 9
												//as i have used 9 to set the test for pageSec (page sections) above
												else if (i <= Integer.parseInt(userReq) + 2 && i >= Integer.parseInt(userReq) - 2 && pageNum > 8) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?search=" + request.getParameter("search")
															+ ">" + i + "</a>");

												}
												//if small number of pages, just print everything
												else if (pageNum < 9) {
													out.println("<li class='page-item'><a class='page-link' href="
															+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?search=" + request.getParameter("search")
															+ ">" + i + "</a>");
												}
													}

													//if page in the MIDDLE section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?search=" + request.getParameter("search")
														+ ">" + pageNum + "</a>");
													}

													//if page in the BEGINNING section, put link to the last page, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageSec && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?search=" + request.getParameter("search")
														+ ">" + pageNum + "</a>");
													}

													//if page in the END section, put link to the last page, so if the last section is big, include dots for good UI
													//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
													if (Integer.parseInt(userReq) <= pageNum - 4 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?search=" + request.getParameter("search")
														+ ">" + pageNum + "</a>");
													}
													//an extension of the above to show last page without dots when the page number gets to second to last
													if (Integer.parseInt(userReq) == pageNum - 3 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?search=" + request.getParameter("search")
														+ ">" + pageNum + "</a>");
													}

													//forward button
													if (Integer.parseInt(userReq) < pageNum) {
												//add one to the value when less than the highest number
												out.println("<li class='page-item'><a class='page-link' href="
														+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) + 1)) + "?search="
														+ request.getParameter("search") + ">&raquo;</a>");
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