<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="dataBaseDAO.ReferralDAO"
	import="dataBaseModel.Referral" import="dataBaseDAO.UsersDAO"
	import="dataBaseModel.Users" import="dataBaseModel.Posts"
	import="dataBaseDAO.PostsDAO" import="dataBaseModel.Comments"
	import="dataBaseDAO.CommentsDAO" import="utilities.UtilityMethods"
	import="java.util.List" import="userInterfaces.SiteAlerts"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Orange | Single Post - <%= request.getPathInfo().substring(1) %></title>


</head>
<body>

	<%--Import Header--%>
	<%@ include file="header.jsp"%>


	<%
		//deals with more than one / after the link issue

	//get the link requested
	String userReq = request.getPathInfo().substring(1);

	if (userReq.contains("/")) {

		//deal with case where there are more than one / at end
		//get the full link which will include the /s
		String userReq2 = request.getRequestURI();

		//from that, get the username with the /s... check for one / below
		userReq2 = userReq2.substring(userReq2.indexOf("/post") + 6);

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
	%>

	<%
		//fetch post
	PostsDAO postDAO = new PostsDAO();

	//check if post exist first
	if (!postDAO.checkPostWithLink(userReq)) {//if it doesn't
		response.sendError(404, "oops!! the post you requested doesn't exist");
		return;
	}

	//get the post
	Posts post = postDAO.getPost(userReq);

	//set the session for post id
	session.setAttribute("PostID", post.getId());
	//set the session for post link
	session.setAttribute("PostLink", post.getLink());

	UsersDAO userDAO = new UsersDAO();
	Users user = userDAO.getUserProfile(post.getUsername());

	CommentsDAO comDAO = new CommentsDAO();

	//set redirect link
	//if no parameter
	if (request.getParameter("cp") == null) {
		session.setAttribute("redirectLink", request.getRequestURI());
	}
	//if there is a parameter
	if (request.getParameter("cp") != null) {
		session.setAttribute("redirectLink", request.getRequestURI() + "?cp=" + request.getParameter("cp"));
	}
	%>

	<div
		class="d-flex justify-content-left flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">

		<%-- page title --%>
		&emsp;
		<h1 class="h2">Post</h1>
	</div>



	<%-- the whole page for holding main view and widget--%>
	<div class="col-sm-12 container img-thumbnail bg-grey"
		style="padding: 10px;">
		<div class="row">

			<%-- main view --%>
			<div class="container col-sm-8">
				<%-- the margin is responsible for the space between in mobile --%>
				<div class="shadow"
					style="margin-bottom: 50px; padding: 10px; border-radius: 20px; background-color: white;">

					<%-- //print error message --%>

					<%
						//check if there are messages to print
					if (session.getAttribute("ProfileUpdatedMessage") != null || session.getAttribute("ProfileUpdateErrorMessage") != null
							|| session.getAttribute("ProfileUpdateDatabaseErrorMessage") != null) {
						//use the class for printing messages
						SiteAlerts sa = new SiteAlerts();
						//call the method ang get its result
						String message = sa.showAlert(request, response);
						out.println("<hr>");
						out.println(message);
					}
					%>
					<%-- End error message printing --%>

					<hr>
					<%-- title --%>
					<h2 class="text-center"><%=post.getTitle()%></h2>


					<br>
					<%-- image --%>
					<div class="text-center img-thumbnail">
						<img src="<%=webAddress + post.getPicture()%>"
							class="text-center img-fluid img-thumbnail"
							style="width: 900px; max-height: 500px; background-color: grey;"
							alt="Picture for post : <%=post.getTitle()%>">
					</div>


					<br>
					<hr>




					<div class="row">
						<%-- owner --%>
						<div class="col-sm-6 img-thumbnail">
							<p class="text-center">
								BY :
								<%=user.getLastname() + " " + user.getFirstname()%></p>
						</div>

						<%-- category --%>
						<%
							//get categories splited
						String[] catSplit = post.getCategories().split(",");
						%>
						<div class="col-sm-6 img-thumbnail">
							<p class="text-center">
								CATEGORY :
								<%
								for (int i = 0; i < catSplit.length; i++) {
								out.println("<span class='img-thumbnail'>" + catSplit[i] + "</span>");
							}
							%>
							</p>
						</div>
					</div>



					<hr>



					<div class="row">

						<%
							String created = um.formatDbDate(post.getCreated().substring(0, post.getCreated().indexOf(" ")), "E, MMM dd yyyy");
						String updated = um.formatDbDate(post.getUpdated().substring(0, post.getUpdated().indexOf(" ")), "E, MMM dd yyyy");
						%>

						<%-- created --%>
						<div class="col-sm-6 img-thumbnail">
							<p class="text-center">
								Posted :
								<%=created%></p>
						</div>

						<%-- updated --%>
						<div class="col-sm-6 img-thumbnail">
							<p class="text-center">
								Last update :
								<%=updated%></p>
						</div>
					</div>


					<hr>
					<%-- excerpt --%>
					<div>
						<h6><%=post.getExcerpt()%></h6>
					</div>


					<hr>
					<%-- body --%>
					<div>
						<%=post.getBody()%>
					</div>


					<br>


					<%-- tag //check if exist--%>

					<p>
						tags :
						<%
						if (post.getTags() != null) {
						//get tags splited
						String[] tagSplit = post.getTags().split(",");

						for (int i = 0; i < tagSplit.length; i++) {
							out.println("<span class='img-thumbnail'>" + tagSplit[i] + "</span>");
						}
					}
					%>
					</p>
					<hr>




					<%-- comment submission form --%>
					<div style='padding: 20px;' id='commentSubmission'>
						<form class='needs-validation'
							action='<%=webAddress%>/CommentController' method='post'
							id='auth-form' novalidate>

							<%-- don't show name and email if user logged in --%>
							<c:if
								test="${sessionScope['Username'] == null && sessionScope['Email'] == null && sessionScope['Firstname'] == null}">
								<div class='form-row' style='margin-bottom: 10px;'>

									<div class='col'>
										<h6>Name:</h6>
										<input type='text' id='inputName'
											class='form-control form-control-sm' name='name' required>
									</div>


									<div class='col'>
										<h6>Email:</h6>
										<input type='text' id='inputEmail'
											class='form-control form-control-sm' name='email' required>
									</div>

								</div>
							</c:if>


							<div class='form-label-group'>
								<h6>Comment:</h6>
								<textarea class='form-control' id='inputComment' rows='6'
									name='comment' required></textarea>
							</div>


							<button class="btn btn-lg btn-primary btn-block" type="submit"
								id="submit-btn">Submit</button>
							<button class="btn btn-lg btn-primary btn-block" id="submit-ani"
								disabled>
								<span class="spinner-grow spinner-grow-sm"></span> Submitting
								comment...
							</button>


						</form>
					</div>



					<%-- comment edit form --%>
					<div style='padding: 20px; display: none;' id='commentEdit'>
						<form class='needs-validation'
							action='<%=webAddress%>/CommentEditController' method='post'
							id='auth-form' novalidate>

							<div class='form-label-group'>
								<h6>Edit Comment:</h6>
								<textarea class='form-control' id='inputCommentEdit' rows='6'
									name='commentUpdate' required></textarea>
							</div>


							<button class="btn btn-lg btn-primary btn-block" type="submit"
								id="submit-btn">Submit Edit</button>
							<button class="btn btn-lg btn-primary btn-block" id="submit-ani"
								disabled>
								<span class="spinner-grow spinner-grow-sm"></span> Submitting...
							</button>


						</form>
					</div>


					<hr>
					<hr>



					<%
						//get the user request for comment page
					String comReq = "";
					//if no request, set to 1
					if (request.getParameter("cp") == null) {
						comReq = "1";
					} else {
						comReq = request.getParameter("cp");
					}

					//get the total comment number
					double count = comDAO.countPostComments(post.getId(), "Published");

					//total number of comments per page
					double total = 10;

					//Do total page to list calculation

					//do the page number calculation
					//divide the number of history by the total to display on each page
					//make both double so if their is a decimal place we can get it
					double pageNumTemp = count / total;

					//round up to higher value in case it is double(has decimal places)
					int pageNum = (int) Math.ceil(pageNumTemp);

					if (pageNum > 0) {
						//check if the user hasn't requested a wrong or non existense page number
						//if too much, set to the last page
						if (Integer.parseInt(comReq) > pageNum) {
							//userReq = String.valueOf(pageNum);
							//get requested url and replace the wrong request number with the maximum page available
							response.sendRedirect(request.getRequestURI() + "?cp=" + pageNum);
							return;
						} //if too small, set to the first page
						else if (Integer.parseInt(comReq) < 1) {
							//comReq = String.valueOf(1);
							//just go to request URI as the parameter is ?cp= and won't be in the URI
							response.sendRedirect(request.getRequestURI());
							return;
						}
					}

					//multiply request by number of post per page then subtract answer by number of post per page
					int start = (Integer.parseInt(comReq) * (int) total) - (int) total;

					List<Comments> list = comDAO.getPostComments(post.getId(), "Published", start, (int) total);

					for (Comments comment : list) {
						//handle printing name for anonymous user which include name and email
						String name = "";
						if (comment.getUsername().contains("Name:")) {
							name = comment.getUsername().substring(comment.getUsername().indexOf("Name: ") + 6,
							comment.getUsername().indexOf(" Email:"));
						} else {
							name = comment.getUsername();
						}

						//for printing edit button
						String editButton = "";
						//ensure user is logged in and is the owner of the comment admin can edit all
						if (session.getAttribute("Username") != null || session.getAttribute("Firstname") != null
						|| session.getAttribute("Email") != null) {
							//ensure user is the owner
							if (session.getAttribute("Username").equals(comment.getUsername())
							&& userDAO.getId(session.getAttribute("Username").toString()) == comment.getComments_users_id()) {
						//using on click to employ ajax to fetch the comment and put in the box for editing
						String reqParam = "?cp=" + comReq + "&mode=comment-edit";
						editButton = "<a onclick='fetchComment(\"" + comment.getId()
								+ "\")' style='cursor: pointer; color:blue;'>Edit</a>";
							}
							//admin can edit all
							if (user.getTag().equals("admin")) {
						//using on click to employ ajax to fetch the comment and put in the box for editing
						editButton = "<a onclick='fetchComment(\"" + comment.getId()
								+ "\")' style='cursor: pointer; color:blue;'>Edit User Comment</a>";
							}
						}

						out.println(
						"<div>" + "<h6>" + name + "</h6>" + "<p>" + comment.getBody() + "</p>" + editButton + "</div>" + "<hr>");
					}
					%>

					<script type="text/javascript">
						function fetchComment(e) {

							if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
								xhr = new XMLHttpRequest();
							} else {// code for IE6, IE5
								xhr = new ActiveXObject("Microsoft.XMLHTTP");
							}

							xhr.onreadystatechange = function() {
								if (xhr.readyState == 4 && xhr.status == 200) {
									document
											.getElementById("commentSubmission").style.display = "none";
									document.getElementById("commentEdit").style.display = "block";

									document.getElementById("inputCommentEdit").value = xhr.responseText;
									document.getElementById("inputCommentEdit")
											.focus();
								}
							}

							xhr.open("GET",
									"../CommentEditController?query=commentReq&id="
											+ e, true);

							//preven console warning in firefox
							xhr.overrideMimeType("text/html");

							xhr.send();
						}
					</script>

					<%-- Pagination --%>
					<nav>
						<ul class="pagination pagination-sm justify-content-center"
							id="pagination-demo">

							<%
								//Pagination

							//since its a GET request, we do the addition and subtraction here for forward and backward button

							int reqAdd = Integer.parseInt(comReq) + 1;
							int reqSubtract = Integer.parseInt(comReq) - 1;

							//pagination

							//show pagination only if there is more than one page
							if (pageNum > 1) {
								//back button
								if (Integer.parseInt(comReq) > 1) {
									//minus one from the value when greater than one
									out.println("<li class='page-item'><a class='page-link' href=" + request.getRequestURI() + "?cp=" + reqSubtract
									+ ">&laquo;</a>");
								}

								//gets three section of the total pages -BEGINNING, MIDDLE and END sections
								//for putting direct link to the farthest page
								int pageSec = pageNum / 3;

								//if page in the END section, put link to the last page, include dots for good UI
								//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
								//using pageNum and not pageSec*3 in the test below as some devision may end up providing less than
								//the total number when multiplied by 3 since its integer division
								if (Integer.parseInt(comReq) <= pageNum && Integer.parseInt(comReq) > pageSec * 2 && pageNum > 8) {
									out.println("<li class='page-item'><a class='page-link' href=" + request.getRequestURI() + "?cp=" + 1 + ">" + 1
									+ "</a>");
									out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								}

								//if page in the MIDDLE section, put link to the first page, include dots for good UI
								//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
								if (Integer.parseInt(comReq) <= pageSec * 2 && Integer.parseInt(comReq) > pageSec && pageNum > 8) {
									out.println("<li class='page-item'><a class='page-link' href=" + request.getRequestURI() + "?cp=" + 1 + ">" + 1
									+ "</a>");
									out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								}

								//print all pages (constraint inside to prevent printing all)
								for (int i = 1; i <= pageNum; i++) {
									//put active class on the active link tab
									if (i == Integer.parseInt(comReq)) {
								out.println("<li class='page-item active'><a class='page-link' href=" + request.getRequestURI() + "?cp=" + i
										+ ">" + i + "</a>");
									}
									//print the number of pages we want, specified by the number added below
									//to constraint this, make sure its not a small number of pages for good UI, so, i define a small number as below 9
									//as i have used 9 to set the test for pageSec (page sections) above
									else if (i <= Integer.parseInt(comReq) + 2 && i >= Integer.parseInt(comReq) - 2 && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=" + request.getRequestURI() + "?cp=" + i + ">"
										+ i + "</a>");

									}
									//if small number of pages, just print everything
									else if (pageNum < 9) {
								out.println("<li class='page-item'><a class='page-link' href=" + request.getRequestURI() + "?cp=" + i + ">"
										+ i + "</a>");
									}
								}

								//if page in the MIDDLE section, put link to the last page, include dots for good UI
								//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
								if (Integer.parseInt(comReq) <= pageSec * 2 && Integer.parseInt(comReq) > pageSec && pageNum > 8) {
									out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
									out.println("<li class='page-item'><a class='page-link' href=" + request.getRequestURI() + "?cp=" + pageNum
									+ ">" + pageNum + "</a>");
								}

								//if page in the BEGINNING section, put link to the last page, include dots for good UI
								//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
								if (Integer.parseInt(comReq) <= pageSec && pageNum > 8) {
									out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
									out.println("<li class='page-item'><a class='page-link' href=" + request.getRequestURI() + "?cp=" + pageNum
									+ ">" + pageNum + "</a>");
								}

								//if page in the END section, put link to the last page, so if the last section is big, include dots for good UI
								//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
								if (Integer.parseInt(comReq) <= pageNum - 4 && Integer.parseInt(comReq) > pageSec * 2 && pageNum > 8) {
									out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
									out.println("<li class='page-item'><a class='page-link' href=" + request.getRequestURI() + "?cp=" + pageNum
									+ ">" + pageNum + "</a>");
								}
								//an extension of the above to show last page without dots when the page number gets to second to last
								if (Integer.parseInt(comReq) == pageNum - 3 && Integer.parseInt(comReq) > pageSec * 2 && pageNum > 8) {
									out.println("<li class='page-item'><a class='page-link' href=" + request.getRequestURI() + "?cp=" + pageNum
									+ ">" + pageNum + "</a>");
								}

								//forward button
								if (Integer.parseInt(comReq) < pageNum) {
									//add one to the value when less than the highest number
									out.println("<li class='page-item'><a class='page-link' href=" + request.getRequestURI() + "?cp=" + reqAdd
									+ ">&raquo;</a>");
								}
							}
							%>
						</ul>
					</nav>
					<%-- End Pagination --%>




					<hr>
				</div>
			</div>
			<%-- end main view --%>


			<%--Import Widget --%>
			<%@ include file="widget.jsp"%>
		</div>

	</div>


	<%--Import Footer --%>
	<%@ include file="footer.jsp"%>
</body>
</html>