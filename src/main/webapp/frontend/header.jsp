
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="utilities.UtilityMethods"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<%--Import css&js assets--%>
<%-- <%@ include file="AssetImport.jsp" %> --%>



<header>
	<%
		//Load utility methods
	UtilityMethods um = new UtilityMethods();
	%>
	<nav
		class="navbar navbar-light navbar-expand-md bg-light justify-content-right shadow">

		<a href="<%=um.baseUrl(request, "")%>" class="navbar-brand mr-0"><img
			class="nav-image" style="max-height: 70px; padding-left: 10px;"
			src="<%=um.baseUrl(request, "")%>/lib/assets/settings/swk-medium.png"
			alt="Sydewalka Logo"></a>

		<button class="navbar-toggler ml-1" type="button"
			data-toggle="collapse" data-target="#collapsingNavbar2"
			aria-controls="navbarNavDropdown" aria-expanded="false"
			aria-label="Toggle navigation">
			<%-- <span class="navbar-toggler-icon"></span> --%>
			<%-- <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span> --%>

			<i class="fas fa-bars"></i>
		</button>


		<div
			class="navbar-collapse collapse justify-content-between align-items-center w-100"
			id="collapsingNavbar2">
			<br>
			<ul class="navbar-nav mx-auto text-left">
				<%-- Code to set active navbar. Prints active class for each item --%>
				<li
					class="nav-item nav-hover <%=um.printActive(um.getRelativeUrl(request), "/")%><%=um.printActive(um.getRelativeUrl(request), "")%>">
					<a class="nav-link" href="<%=um.baseUrl(request, "/")%>">
						&nbsp;<strong>HOME</strong>&nbsp;
				</a> <!--  <span class="sr-only">(Current)</span> ///before a tag -->
				</li>
				<li
					class="nav-item nav-hover <%out.println(um.printActive(um.getRelativeUrl(request), "/about-us"));%>">
					<a class="nav-link" href="<%=um.baseUrl(request, "/about-us")%>">
						&nbsp;<strong>ABOUT US</strong>&nbsp;
				</a>
				</li>
				<li
					class="nav-item nav-hover <%out.println(um.printActive(um.getRelativeUrl(request), "/contact-us"));%>">
					<a class="nav-link" href="<%=um.baseUrl(request, "/contact-us")%>">
						&nbsp;<strong>CONTACT US</strong>&nbsp;
				</a>
				</li>
				<li
					class="nav-item nav-hover <%out.println(um.printActive(um.getRelativeUrl(request), "/backend/home"));%>">
					<a class="nav-link" href="<%=um.baseUrl(request, "/backend/home.jsp")%>">
						&nbsp;<strong>ADMIN</strong>&nbsp;
				</a>
				</li>

			</ul>

			<%
				//To print active class on the navbar items and set link
			String loginPage = um.baseUrl(request, "/login");

			String regPage = um.baseUrl(request, "/register");

			String profilePage = um.baseUrl(request, "/profile/" + session.getAttribute("Username"));

			//to use in JSTL to print page link
			//set to page Context so it can become an available variable within this page
			pageContext.setAttribute("loginPage", loginPage);
			pageContext.setAttribute("regPage", regPage);
			pageContext.setAttribute("profilePage", profilePage);

			//check and print active class if true
			String loginActive = um.printActive(um.fullPath(request), loginPage);
			String regActive = um.printActive(um.fullPath(request), regPage);
			String profileActive = um.printActive(um.fullPath(request), profilePage);

			//to use in JSTL to print active class
			pageContext.setAttribute("loginActive", loginActive);
			pageContext.setAttribute("regActive", regActive);
			pageContext.setAttribute("profileActive", profileActive);
			%>

			<%--Show login and register only if the user is not logged in --%>
			<%--Use variables above to set link and print active class --%>

			<c:if
				test="${sessionScope['Username'] == null && sessionScope['Email'] == null}">
				<ul
					class="nav navbar-nav flex-row justify-content-center flex-nowrap">
					<li
						class="nav-item nav-hover menu-border <c:out value='${loginActive}' /> "><a
						class="nav-link" href="<c:out value='${loginPage}' />"><i
							class="fas fa-sign-in-alt"></i> <strong>Login</strong></a></li> &emsp;
					<li
						class="nav-item nav-hover menu-border <c:out value='${regActive}' /> "><a
						class="nav-link" href="<c:out value='${regPage}' />"><i
							class="fas fa-user-edit"></i> <strong>Signup</strong></a></li>
				</ul>
			</c:if>

			<%--Show account and logout only if the user is logged in --%>
			<%--Use variables above to set link and print active class --%>

			<c:if
				test="${sessionScope['Username'] != null && sessionScope['Email'] != null}">
				<ul
					class='nav navbar-nav flex-row justify-content-center flex-nowrap'>
					<li
						class="nav-item nav-hover menu-border <c:out value='${profileActive}' /> "><a
						class="nav-link" href="<c:out value='${profilePage}' />"><i
							class="fas fa-user-circle"></i> <strong>Account</strong></a></li> &emsp;
					<li class="nav-item nav-hover menu-border"><a class="nav-link"
						href="<%=um.baseUrl(request, "/logout")%>"><i
							class="fas fa-sign-out-alt"></i> <strong>Logout</strong></a></li>
				</ul>
			</c:if>

		</div>

	</nav>
</header>
