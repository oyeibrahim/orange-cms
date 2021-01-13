<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.ReferralDAO"
	import="dataBaseModel.Referral" import="dataBaseDAO.UsersDAO"
	import="dataBaseModel.Users" import="dataBaseModel.Posts"
	import="dataBaseDAO.PostsDAO" import="utilities.UtilityMethods"
	import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Orange | Posts Page</title>


</head>
<body>

	<%--Import Header--%>
	<%@ include file="header.jsp"%>


	<%
		String userReq = "";
	//there may not be a request, so first check for that
	if (request.getPathInfo() != null) {
		//deals with more than one / after the link issue

		//get the link requested
		userReq = request.getPathInfo().substring(1);

		if (userReq.contains("/")) {

			//deal with case where there are more than one / at end
			//get the full link which will include the /s
			String userReq2 = request.getRequestURI();

			//from that, get the username with the /s... check for one / below
			userReq2 = userReq2.substring(userReq2.indexOf("/posts") + 7);

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

		//in case just only / and nothing after the request will be an empty string and will
		//throw an error when we try to do n operation on it later. so set it to 1 if that is the case
		if (userReq.isEmpty()) {
			userReq = "1";
		}

	} else {//if no request, set to first page
		userReq = "1";
	}

	//initialise the DAO
	PostsDAO postDAO = new PostsDAO();

	UsersDAO userDAO = new UsersDAO();

	//if its a Author posts request, check if the author exist
	if (request.getParameter("author") != null) {
		//check existence, if user doesn't exist, return 404 error
		if (!userDAO.checkUserWithUsername(request.getParameter("author"))) {
			response.sendError(404, "Oops!! The requested user not found");
			return;
		}

	}

	//get the total post number
	//placeholder
	double count = 0;
	//------------------------------------------------------------
	//handle count if there is or isn't a parameter as the total number will be different with both

	if (request.getParameter("category") == null && request.getParameter("tag") == null
			&& request.getParameter("type") == null && request.getParameter("author") == null
			&& request.getParameter("search") == null) {
		count = postDAO.countAllPosts("Published");
	} else if (request.getParameter("category") != null) {
		count = postDAO.countCategoryPosts(request.getParameter("category"), "Published");
	}

	else if (request.getParameter("tag") != null) {
		count = postDAO.countTagPosts(request.getParameter("tag"), "Published");
	}

	else if (request.getParameter("type") != null) {
		count = postDAO.countTypePosts(request.getParameter("type"), "Published");
	}

	else if (request.getParameter("author") != null) {
		//get the user ID and pass in
		count = postDAO.countUserPosts(userDAO.getId(request.getParameter("author")), "Published");
	}

	else if (request.getParameter("search") != null) {
		count = postDAO.countSearchPosts(request.getParameter("search"), "Published");
	} else {//if any other apart from the listed, just return the whole post
		count = postDAO.countAllPosts("Published");
	}
	//------------------------------------------------------------

	//total number of posts per page
	double total = 4;

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

			//handle for each case
			if (request.getParameter("category") == null && request.getParameter("tag") == null
			&& request.getParameter("type") == null && request.getParameter("author") == null
			&& request.getParameter("search") == null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)));
		return;
			} else if (request.getParameter("category") != null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?category="
				+ request.getParameter("category"));
		return;
			}

			else if (request.getParameter("tag") != null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?tag="
				+ request.getParameter("tag"));
		return;
			}

			else if (request.getParameter("type") != null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?type="
				+ request.getParameter("type"));
		return;
			}

			else if (request.getParameter("author") != null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?author="
				+ request.getParameter("author"));
		return;
			}

			else if (request.getParameter("search") != null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)) + "?search="
				+ request.getParameter("search"));
		return;
			} else {//if any other apart from the listed, just return the whole post
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(pageNum)));
		return;
			}

		} //if too small, set to the first page
		else if (Integer.parseInt(userReq) < 1) {
			//userReq = String.valueOf(1);

			//handle for each case
			if (request.getParameter("category") == null && request.getParameter("tag") == null
			&& request.getParameter("type") == null && request.getParameter("author") == null
			&& request.getParameter("search") == null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(1)));
		return;
			} else if (request.getParameter("category") != null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(1)) + "?category="
				+ request.getParameter("category"));
		return;
			}

			else if (request.getParameter("tag") != null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(1)) + "?tag="
				+ request.getParameter("tag"));
		return;
			}

			else if (request.getParameter("type") != null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(1)) + "?type="
				+ request.getParameter("type"));
		return;
			}

			else if (request.getParameter("author") != null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(1)) + "?author="
				+ request.getParameter("author"));
		return;
			}

			else if (request.getParameter("search") != null) {
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(1)) + "?search="
				+ request.getParameter("search"));
		return;
			} else {//if any other apart from the listed, just return the whole post
		response.sendRedirect(request.getRequestURI().replaceAll(userReq, String.valueOf(1)));
		return;
			}
		}
	}
	%>


	<div
		class="d-flex justify-content-left flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">

		<%-- page title will be unique to each parameter  --%>
		&emsp;
		<%
			if (request.getParameter("category") == null && request.getParameter("tag") == null
				&& request.getParameter("type") == null && request.getParameter("author") == null
				&& request.getParameter("search") == null) {
			out.println("<h1 class='h2'>Posts</h1>");
		} else if (request.getParameter("category") != null) {
			out.println("<h1 class='h2'>Category : " + request.getParameter("category") + "</h1>");
		}

		else if (request.getParameter("tag") != null) {
			out.println("<h1 class='h2'>Tag : " + request.getParameter("tag") + "</h1>");
		}

		else if (request.getParameter("type") != null) {
			out.println("<h1 class='h2'>Type : " + request.getParameter("type") + "</h1>");
		}

		else if (request.getParameter("author") != null) {
			out.println("<h1 class='h2'>Author : " + userDAO.getName(request.getParameter("author"), "L/F") + "</h1>");
		}

		else if (request.getParameter("search") != null) {
			out.println("<h1 class='h2'>Search : " + request.getParameter("search") + "</h1>");
		} else {//if any other apart from the listed, just return the whole post
			out.println("<h1 class='h2'>All Post</h1>");
		}
		%>




	</div>



	<%-- the whole page for holding main view and widget--%>
	<div class="col-sm-12 container img-thumbnail" style="padding: 10px;">
		<div class="row">

			<%-- main view --%>
			<div class="container col-sm-8">
				<%-- the margin is responsible for the space between in mobile --%>
				<div class="img-thumbnail"
					style="margin-bottom: 50px; padding: 10px;">
					<hr>

					<div class='album py-5 bg-light'>
						<div class='container'>

							<div class='row'>
								<%-- DATA Display--%>
								<%
									//display the data

								//if no post found

								if (request.getParameter("category") == null && request.getParameter("tag") == null
										&& request.getParameter("type") == null && request.getParameter("author") == null
										&& request.getParameter("search") == null) {
									//if no post
									if (count < 1) {
										out.println("<div class='col-sm-12 text-center'> <h2>404</h2><h3>Oops! No post found</h3> </div>");
									}
								} else if (request.getParameter("category") != null) {
									if (count < 1) {
										out.println(
										"<div class='col-sm-12 text-center'> <h2>404</h2><h3>Oops! No post found with the requested category</h3> </div>");
									}
								}

								else if (request.getParameter("tag") != null) {
									if (count < 1) {
										out.println(
										"<div class='col-sm-12 text-center'> <h2>404</h2><h3>Oops! No post found with the requested tag</h3> </div>");
									}
								}

								else if (request.getParameter("type") != null) {
									if (count < 1) {
										out.println(
										"<div class='col-sm-12 text-center'> <h2>404</h2><h3>Oops! No post found with the requested type</h3> </div>");
									}
								}

								else if (request.getParameter("author") != null) {
									if (count < 1) {
										out.println(
										"<div class='col-sm-12 text-center'> <h2>404</h2><h3>Oops! The requested author hasn't published any post</h3> </div>");
									}
								}

								else if (request.getParameter("search") != null) {
									if (count < 1) {
										out.println(
										"<div class='col-sm-12 text-center'> <h2>404</h2><h3>Oops! No post found with the search query</h3> </div>");
									}
								} else {//if any other apart from the listed, just return the whole post
									if (count < 1) {
										out.println("<div class='col-sm-12 text-center'> <h2>404</h2><h3>Oops! No post found</h3> </div>");
									}
								}

								//no parameter
								if (request.getParameter("category") == null && request.getParameter("tag") == null
										&& request.getParameter("type") == null && request.getParameter("author") == null
										&& request.getParameter("search") == null) {

									//multiply request by number of post per page then subtract answer by number of post per page
									int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

									//get data from db
									List<Posts> list = postDAO.getAllPost("Published", start, (int) total);

									//list posts
									for (Posts post : list) {
										//process activated and unactivated
										out.println("<div class='col-sm-6' style='margin-bottom:20px;'>" + "<div class='card box-shadow'>"
										+ "<img src='" + webAddress + post.getPicture()
										+ "' class='card-img-top img-thumbnail text-center img-fluid img-thumbnail' style='max-height: 260px; background-color:grey;' alt='Picture for post : "
										+ post.getTitle() + "'>"

										+ "<div class='card-body'>" + "<h4 class='card-text'>" + post.getTitle() + "</h4>" + "<hr>"
										+ "<p class='card-text'>" + um.getWordCount(post.getExcerpt(), 30, "YES") + "</p>"
										+ "<div class='d-flex justify-content-between align-items-center'>" + "<div class='btn-group'>"
										+ "<a href='" + webAddress + "/post/" + post.getLink()
										+ "' class='btn btn-sm btn-outline-secondary'>Read</a>" + "</div>"
										+ "<small class='text-muted'>9 mins</small>" + "</div>" + "</div>"

										+ "</div>" + "</div>" + "<hr style='color:red background-color:red'>");
									}
								}

								//category request
								else if (request.getParameter("category") != null) {

									//multiply request by number of post per page then subtract answer by number of post per page
									int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

									//get data from db
									List<Posts> list = postDAO.getPostsWithCategory(request.getParameter("category"), "Published", start, (int) total);

									//list posts
									for (Posts post : list) {
										//process activated and unactivated
										out.println("<div class='col-sm-6' style='margin-bottom:20px;'>" + "<div class='card box-shadow'>"
										+ "<img src='" + webAddress + post.getPicture()
										+ "' class='card-img-top img-thumbnail text-center img-fluid img-thumbnail' style='max-height: 260px; background-color:grey;' alt='Picture for post : "
										+ post.getTitle() + "'>"

										+ "<div class='card-body'>" + "<h4 class='card-text'>" + post.getTitle() + "</h4>" + "<hr>"
										+ "<p class='card-text'>" + um.getWordCount(post.getExcerpt(), 30, "YES") + "</p>"
										+ "<div class='d-flex justify-content-between align-items-center'>" + "<div class='btn-group'>"
										+ "<a href='" + webAddress + "/post/" + post.getLink()
										+ "' class='btn btn-sm btn-outline-secondary'>Read</a>" + "</div>"
										+ "<small class='text-muted'>9 mins</small>" + "</div>" + "</div>"

										+ "</div>" + "</div>" + "<hr style='color:red background-color:red'>");
									}
								}

								//tag request
								else if (request.getParameter("tag") != null) {

									//multiply request by number of post per page then subtract answer by number of post per page
									int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

									//get data from db
									List<Posts> list = postDAO.getPostsWithTag(request.getParameter("tag"), "Published", start, (int) total);

									//list posts
									for (Posts post : list) {
										//process activated and unactivated
										out.println("<div class='col-sm-6' style='margin-bottom:20px;'>" + "<div class='card box-shadow'>"
										+ "<img src='" + webAddress + post.getPicture()
										+ "' class='card-img-top img-thumbnail text-center img-fluid img-thumbnail' style='max-height: 260px; background-color:grey;' alt='Picture for post : "
										+ post.getTitle() + "'>"

										+ "<div class='card-body'>" + "<h4 class='card-text'>" + post.getTitle() + "</h4>" + "<hr>"
										+ "<p class='card-text'>" + um.getWordCount(post.getExcerpt(), 30, "YES") + "</p>"
										+ "<div class='d-flex justify-content-between align-items-center'>" + "<div class='btn-group'>"
										+ "<a href='" + webAddress + "/post/" + post.getLink()
										+ "' class='btn btn-sm btn-outline-secondary'>Read</a>" + "</div>"
										+ "<small class='text-muted'>9 mins</small>" + "</div>" + "</div>"

										+ "</div>" + "</div>" + "<hr style='color:red background-color:red'>");
									}
								}

								//type request
								else if (request.getParameter("type") != null) {

									//multiply request by number of post per page then subtract answer by number of post per page
									int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

									//get data from db
									List<Posts> list = postDAO.getPostsWithType(request.getParameter("type"), "Published", start, (int) total);

									//list posts
									for (Posts post : list) {
										//process activated and unactivated
										out.println("<div class='col-sm-6' style='margin-bottom:20px;'>" + "<div class='card box-shadow'>"
										+ "<img src='" + webAddress + post.getPicture()
										+ "' class='card-img-top img-thumbnail text-center img-fluid img-thumbnail' style='max-height: 260px; background-color:grey;' alt='Picture for post : "
										+ post.getTitle() + "'>"

										+ "<div class='card-body'>" + "<h4 class='card-text'>" + post.getTitle() + "</h4>" + "<hr>"
										+ "<p class='card-text'>" + um.getWordCount(post.getExcerpt(), 30, "YES") + "</p>"
										+ "<div class='d-flex justify-content-between align-items-center'>" + "<div class='btn-group'>"
										+ "<a href='" + webAddress + "/post/" + post.getLink()
										+ "' class='btn btn-sm btn-outline-secondary'>Read</a>" + "</div>"
										+ "<small class='text-muted'>9 mins</small>" + "</div>" + "</div>"

										+ "</div>" + "</div>" + "<hr style='color:red background-color:red'>");
									}
								}

								//author request
								else if (request.getParameter("author") != null) {

									//multiply request by number of post per page then subtract answer by number of post per page
									int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

									//get data from db
									List<Posts> list = postDAO.getUserPosts(userDAO.getId(request.getParameter("author")), "Published", start,
									(int) total);

									//list posts
									for (Posts post : list) {
										//process activated and unactivated
										out.println("<div class='col-sm-6' style='margin-bottom:20px;'>" + "<div class='card box-shadow'>"
										+ "<img src='" + webAddress + post.getPicture()
										+ "' class='card-img-top img-thumbnail text-center img-fluid img-thumbnail' style='max-height: 260px; background-color:grey;' alt='Picture for post : "
										+ post.getTitle() + "'>"

										+ "<div class='card-body'>" + "<h4 class='card-text'>" + post.getTitle() + "</h4>" + "<hr>"
										+ "<p class='card-text'>" + um.getWordCount(post.getExcerpt(), 30, "YES") + "</p>"
										+ "<div class='d-flex justify-content-between align-items-center'>" + "<div class='btn-group'>"
										+ "<a href='" + webAddress + "/post/" + post.getLink()
										+ "' class='btn btn-sm btn-outline-secondary'>Read</a>" + "</div>"
										+ "<small class='text-muted'>9 mins</small>" + "</div>" + "</div>"

										+ "</div>" + "</div>" + "<hr style='color:red background-color:red'>");
									}
								}

								//search request
								else if (request.getParameter("search") != null) {

									//multiply request by number of post per page then subtract answer by number of post per page
									int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

									//get data from db
									List<Posts> list = postDAO.getPostsWithSearch(request.getParameter("search"), "Published", start, (int) total);

									//list posts
									for (Posts post : list) {
										//process activated and unactivated
										out.println("<div class='col-sm-6' style='margin-bottom:20px;'>" + "<div class='card box-shadow'>"
										+ "<img src='" + webAddress + post.getPicture()
										+ "' class='card-img-top img-thumbnail text-center img-fluid img-thumbnail' style='max-height: 260px; background-color:grey;' alt='Picture for post : "
										+ post.getTitle() + "'>"

										+ "<div class='card-body'>" + "<h4 class='card-text'>" + post.getTitle() + "</h4>" + "<hr>"
										+ "<p class='card-text'>" + um.getWordCount(post.getExcerpt(), 30, "YES") + "</p>"
										+ "<div class='d-flex justify-content-between align-items-center'>" + "<div class='btn-group'>"
										+ "<a href='" + webAddress + "/post/" + post.getLink()
										+ "' class='btn btn-sm btn-outline-secondary'>Read</a>" + "</div>"
										+ "<small class='text-muted'>9 mins</small>" + "</div>" + "</div>"

										+ "</div>" + "</div>" + "<hr style='color:red background-color:red'>");
									}
								}

								else {//if any other apart from the listed, just return the whole post

									//multiply request by number of post per page then subtract answer by number of post per page
									int start = (Integer.parseInt(userReq) * (int) total) - (int) total;

									//get data from db
									List<Posts> list = postDAO.getAllPost("Published", start, (int) total);

									//list posts
									for (Posts post : list) {
										//process activated and unactivated
										out.println("<div class='col-sm-6' style='margin-bottom:20px;'>" + "<div class='card box-shadow'>"
										+ "<img src='" + webAddress + post.getPicture()
										+ "' class='card-img-top img-thumbnail text-center img-fluid img-thumbnail' style='max-height: 260px; background-color:grey;' alt='Picture for post : "
										+ post.getTitle() + "'>"

										+ "<div class='card-body'>" + "<h4 class='card-text'>" + post.getTitle() + "</h4>" + "<hr>"
										+ "<p class='card-text'>" + um.getWordCount(post.getExcerpt(), 30, "YES") + "</p>"
										+ "<div class='d-flex justify-content-between align-items-center'>" + "<div class='btn-group'>"
										+ "<a href='" + webAddress + "/post/" + post.getLink()
										+ "' class='btn btn-sm btn-outline-secondary'>Read</a>" + "</div>"
										+ "<small class='text-muted'>9 mins</small>" + "</div>" + "</div>"

										+ "</div>" + "</div>" + "<hr style='color:red background-color:red'>");
									}
								}
								%>
							</div>
						</div>
					</div>



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
								if (request.getRequestURI().contains("posts/")) {
									//just ad the number
									reqURI = request.getRequestURI() + userReq;
								} else {//if not
									//add slash first then the number
									reqURI = request.getRequestURI() + "/" + userReq;
								}

							}

							//pagination for no parameter
							if (request.getParameter("category") == null && request.getParameter("tag") == null
									&& request.getParameter("type") == null && request.getParameter("author") == null
									&& request.getParameter("search") == null) {
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

							//pagination for category parameter
							else if (request.getParameter("category") != null) {
								//show pagination only if there is more than one page
								if (pageNum > 1) {
									//back button
									if (Integer.parseInt(userReq) > 1) {
								//minus one from the value when greater than one
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) - 1)) + "?category="
										+ request.getParameter("category") + ">&laquo;</a>");
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
												+ "?category=" + request.getParameter("category") + ">" + 1 + "</a>");
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
									}

									//if page in the MIDDLE section, put link to the first page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
								out.println(
										"<li class='page-item'><a class='page-link' href=" + reqURI.replaceAll(userReq, String.valueOf(1))
												+ "?category=" + request.getParameter("category") + ">" + 1 + "</a>");
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
									}

									//print all pages (constraint inside to prevent printing all)
									for (int i = 1; i <= pageNum; i++) {
								//put active class on the active link tab
								if (i == Integer.parseInt(userReq)) {
									out.println("<li class='page-item active'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?category="
											+ request.getParameter("category") + ">" + i + "</a>");
								}
								//print the number of pages we want, specified by the number added below
								//to constraint this, make sure its not a small number of pages for good UI, so, i define a small number as below 9
								//as i have used 9 to set the test for pageSec (page sections) above
								else if (i <= Integer.parseInt(userReq) + 2 && i >= Integer.parseInt(userReq) - 2 && pageNum > 8) {
									out.println("<li class='page-item'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?category="
											+ request.getParameter("category") + ">" + i + "</a>");

								}
								//if small number of pages, just print everything
								else if (pageNum < 9) {
									out.println("<li class='page-item'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?category="
											+ request.getParameter("category") + ">" + i + "</a>");
								}
									}

									//if page in the MIDDLE section, put link to the last page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?category="
										+ request.getParameter("category") + ">" + pageNum + "</a>");
									}

									//if page in the BEGINNING section, put link to the last page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?category="
										+ request.getParameter("category") + ">" + pageNum + "</a>");
									}

									//if page in the END section, put link to the last page, so if the last section is big, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageNum - 4 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?category="
										+ request.getParameter("category") + ">" + pageNum + "</a>");
									}
									//an extension of the above to show last page without dots when the page number gets to second to last
									if (Integer.parseInt(userReq) == pageNum - 3 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?category="
										+ request.getParameter("category") + ">" + pageNum + "</a>");
									}

									//forward button
									if (Integer.parseInt(userReq) < pageNum) {
								//add one to the value when less than the highest number
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) + 1)) + "?category="
										+ request.getParameter("category") + ">&raquo;</a>");
									}
								}
							}

							//pagination for tag parameter
							else if (request.getParameter("tag") != null) {
								//show pagination only if there is more than one page
								if (pageNum > 1) {
									//back button
									if (Integer.parseInt(userReq) > 1) {
								//minus one from the value when greater than one
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) - 1)) + "?tag="
										+ request.getParameter("tag") + ">&laquo;</a>");
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
												+ "?tag=" + request.getParameter("tag") + ">" + 1 + "</a>");
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
									}

									//if page in the MIDDLE section, put link to the first page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
								out.println(
										"<li class='page-item'><a class='page-link' href=" + reqURI.replaceAll(userReq, String.valueOf(1))
												+ "?tag=" + request.getParameter("tag") + ">" + 1 + "</a>");
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
									}

									//print all pages (constraint inside to prevent printing all)
									for (int i = 1; i <= pageNum; i++) {
								//put active class on the active link tab
								if (i == Integer.parseInt(userReq)) {
									out.println("<li class='page-item active'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?tag=" + request.getParameter("tag") + ">"
											+ i + "</a>");
								}
								//print the number of pages we want, specified by the number added below
								//to constraint this, make sure its not a small number of pages for good UI, so, i define a small number as below 9
								//as i have used 9 to set the test for pageSec (page sections) above
								else if (i <= Integer.parseInt(userReq) + 2 && i >= Integer.parseInt(userReq) - 2 && pageNum > 8) {
									out.println("<li class='page-item'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?tag=" + request.getParameter("tag") + ">"
											+ i + "</a>");

								}
								//if small number of pages, just print everything
								else if (pageNum < 9) {
									out.println("<li class='page-item'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?tag=" + request.getParameter("tag") + ">"
											+ i + "</a>");
								}
									}

									//if page in the MIDDLE section, put link to the last page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?tag=" + request.getParameter("tag") + ">"
										+ pageNum + "</a>");
									}

									//if page in the BEGINNING section, put link to the last page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?tag=" + request.getParameter("tag") + ">"
										+ pageNum + "</a>");
									}

									//if page in the END section, put link to the last page, so if the last section is big, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageNum - 4 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?tag=" + request.getParameter("tag") + ">"
										+ pageNum + "</a>");
									}
									//an extension of the above to show last page without dots when the page number gets to second to last
									if (Integer.parseInt(userReq) == pageNum - 3 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?tag=" + request.getParameter("tag") + ">"
										+ pageNum + "</a>");
									}

									//forward button
									if (Integer.parseInt(userReq) < pageNum) {
								//add one to the value when less than the highest number
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) + 1)) + "?tag="
										+ request.getParameter("tag") + ">&raquo;</a>");
									}
								}
							}

							//pagination for type parameter
							else if (request.getParameter("type") != null) {
								//show pagination only if there is more than one page
								if (pageNum > 1) {
									//back button
									if (Integer.parseInt(userReq) > 1) {
								//minus one from the value when greater than one
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) - 1)) + "?type="
										+ request.getParameter("type") + ">&laquo;</a>");
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
												+ "?type=" + request.getParameter("type") + ">" + 1 + "</a>");
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
									}

									//if page in the MIDDLE section, put link to the first page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
								out.println(
										"<li class='page-item'><a class='page-link' href=" + reqURI.replaceAll(userReq, String.valueOf(1))
												+ "?type=" + request.getParameter("type") + ">" + 1 + "</a>");
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
									}

									//print all pages (constraint inside to prevent printing all)
									for (int i = 1; i <= pageNum; i++) {
								//put active class on the active link tab
								if (i == Integer.parseInt(userReq)) {
									out.println("<li class='page-item active'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?type=" + request.getParameter("type") + ">"
											+ i + "</a>");
								}
								//print the number of pages we want, specified by the number added below
								//to constraint this, make sure its not a small number of pages for good UI, so, i define a small number as below 9
								//as i have used 9 to set the test for pageSec (page sections) above
								else if (i <= Integer.parseInt(userReq) + 2 && i >= Integer.parseInt(userReq) - 2 && pageNum > 8) {
									out.println("<li class='page-item'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?type=" + request.getParameter("type") + ">"
											+ i + "</a>");

								}
								//if small number of pages, just print everything
								else if (pageNum < 9) {
									out.println("<li class='page-item'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?type=" + request.getParameter("type") + ">"
											+ i + "</a>");
								}
									}

									//if page in the MIDDLE section, put link to the last page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?type=" + request.getParameter("type")
										+ ">" + pageNum + "</a>");
									}

									//if page in the BEGINNING section, put link to the last page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?type=" + request.getParameter("type")
										+ ">" + pageNum + "</a>");
									}

									//if page in the END section, put link to the last page, so if the last section is big, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageNum - 4 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?type=" + request.getParameter("type")
										+ ">" + pageNum + "</a>");
									}
									//an extension of the above to show last page without dots when the page number gets to second to last
									if (Integer.parseInt(userReq) == pageNum - 3 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?type=" + request.getParameter("type")
										+ ">" + pageNum + "</a>");
									}

									//forward button
									if (Integer.parseInt(userReq) < pageNum) {
								//add one to the value when less than the highest number
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) + 1)) + "?type="
										+ request.getParameter("type") + ">&raquo;</a>");
									}
								}
							}

							//pagination for author parameter
							else if (request.getParameter("author") != null) {
								//show pagination only if there is more than one page
								if (pageNum > 1) {
									//back button
									if (Integer.parseInt(userReq) > 1) {
								//minus one from the value when greater than one
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) - 1)) + "?author="
										+ request.getParameter("author") + ">&laquo;</a>");
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
												+ "?author=" + request.getParameter("author") + ">" + 1 + "</a>");
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
									}

									//if page in the MIDDLE section, put link to the first page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
								out.println(
										"<li class='page-item'><a class='page-link' href=" + reqURI.replaceAll(userReq, String.valueOf(1))
												+ "?author=" + request.getParameter("author") + ">" + 1 + "</a>");
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
									}

									//print all pages (constraint inside to prevent printing all)
									for (int i = 1; i <= pageNum; i++) {
								//put active class on the active link tab
								if (i == Integer.parseInt(userReq)) {
									out.println("<li class='page-item active'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?author=" + request.getParameter("author")
											+ ">" + i + "</a>");
								}
								//print the number of pages we want, specified by the number added below
								//to constraint this, make sure its not a small number of pages for good UI, so, i define a small number as below 9
								//as i have used 9 to set the test for pageSec (page sections) above
								else if (i <= Integer.parseInt(userReq) + 2 && i >= Integer.parseInt(userReq) - 2 && pageNum > 8) {
									out.println("<li class='page-item'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?author=" + request.getParameter("author")
											+ ">" + i + "</a>");

								}
								//if small number of pages, just print everything
								else if (pageNum < 9) {
									out.println("<li class='page-item'><a class='page-link' href="
											+ reqURI.replaceAll(userReq, String.valueOf(i)) + "?author=" + request.getParameter("author")
											+ ">" + i + "</a>");
								}
									}

									//if page in the MIDDLE section, put link to the last page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec * 2 && Integer.parseInt(userReq) > pageSec && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?author=" + request.getParameter("author")
										+ ">" + pageNum + "</a>");
									}

									//if page in the BEGINNING section, put link to the last page, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageSec && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?author=" + request.getParameter("author")
										+ ">" + pageNum + "</a>");
									}

									//if page in the END section, put link to the last page, so if the last section is big, include dots for good UI
									//page must be more than 8 before putting this feature cause small number of pages don't need this, can be changed.
									if (Integer.parseInt(userReq) <= pageNum - 4 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href=''>.....</a>");
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?author=" + request.getParameter("author")
										+ ">" + pageNum + "</a>");
									}
									//an extension of the above to show last page without dots when the page number gets to second to last
									if (Integer.parseInt(userReq) == pageNum - 3 && Integer.parseInt(userReq) > pageSec * 2 && pageNum > 8) {
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(pageNum)) + "?author=" + request.getParameter("author")
										+ ">" + pageNum + "</a>");
									}

									//forward button
									if (Integer.parseInt(userReq) < pageNum) {
								//add one to the value when less than the highest number
								out.println("<li class='page-item'><a class='page-link' href="
										+ reqURI.replaceAll(userReq, String.valueOf(Integer.parseInt(userReq) + 1)) + "?author="
										+ request.getParameter("author") + ">&raquo;</a>");
									}
								}
							}

							//pagination for search parameter
							else if (request.getParameter("search") != null) {
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

							//if any other apart from the listed, just return the whole post
							else {
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