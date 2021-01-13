<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>


<%!// Utility Methods shouldn't be imported here since we will import it in header
	// and both header and this file will be imported to profile pages
	// a workaround is to create the method we need here
	public String umBaseUrlForProfileMenu(HttpServletRequest request, String path) {
		if ((request.getServerPort() == 80) || (request.getServerPort() == 443)) {
			return request.getScheme() + "://" + request.getServerName() + request.getContextPath() + path;
		} else {
			return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath() + path;
		}
	}

	public String makeActive(String first, String second, String activeString) {
		if (first.startsWith(second)) {
			return activeString;
		}

		return "";
	}

	public String relUrl(HttpServletRequest request) {

		String baseUrl = null;

		if ((request.getServerPort() == 80) || (request.getServerPort() == 443))
			baseUrl = request.getScheme() + "://" + request.getServerName() + request.getContextPath();
		else
			baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath();

		StringBuffer buf = request.getRequestURL();

		return buf.substring(baseUrl.length());
	}%>



<%-- Large screen navbar, hidden on medium screen down with bootstrap class(d-none d-md-block) --%>
<div class="navbar-expand-md col-md-2 bg-dark d-none d-md-block"
	style="margin-top: -50px; padding-bottom: 150px;">
	<nav class="navbar-dark">

		<!-- put navbar-nav also in div below to make the text box short -->
		<div class="mx-auto text-center"
			style="padding-top: 150px; padding-bottom: 150px;">

			&emsp; &emsp; &emsp;

			<ul class="navbar-nav mx-auto text-left flex-column nav-pills">
				<li
					class="nav-item <%=makeActive(relUrl(request), "/profile", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/profile/" + session.getAttribute("Username"))%>"
					class="nav-link">&nbsp;<i class='fas fa-user-circle'></i>&nbsp;<strong>Dashboard</strong></a>
				</li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/referral", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/referral")%>"
					class="nav-link">&nbsp;<i class='fas fa-user-friends'></i>&nbsp;<strong>Referral</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/settings", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/settings")%>"
					class="nav-link">&nbsp;<i class="fas fa-cog"></i>&nbsp;<strong>Settings</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/identity", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/identity")%>"
					class="nav-link">&nbsp;<i class='fas fa-user-edit'></i>&nbsp;<strong>Identity</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/create-post", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/create-post")%>"
					class="nav-link">&nbsp;<i class="fas fa-pen-square"></i>&nbsp;<strong>Create
							Post</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/my-posts", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/my-posts/1")%>"
					class="nav-link">&nbsp;<i class="far fa-newspaper"></i>&nbsp;<strong>My
							Posts</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/my-comments", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/my-comments/1")%>"
					class="nav-link">&nbsp;<i class="fas fa-comments"></i>&nbsp;<strong>My
							Comments</strong></a></li>
				<li class="nav-item"><a
					href="<%=umBaseUrlForProfileMenu(request, "/logout")%>"
					class="nav-link">&nbsp;<i class='fas fa-sign-out-alt'></i>&nbsp;<strong>Logout</strong></a></li>
			</ul>
		</div>
	</nav>

</div>
<%-- End Large screen navbar --%>


<%-- Small screen side navbar --%>
<div id="mySidenav" class="sidenav d-md-none d-lg-none d-xl-none">
	<ul class="navbar-nav nav-pills">
		<li class="nav-item"><a href="javascript:void(0)"
			class="closebtn" onclick="closeNav()">&times;</a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/profile/") + session.getAttribute("Username")%>"
			class="nav-link <%=makeActive(relUrl(request), "/profile", "active")%>">&nbsp;<i
				class='fas fa-user-circle'></i>&nbsp;<strong>Dashboard</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/referral")%>"
			class="nav-link <%=makeActive(relUrl(request), "/referral", "active profile-active")%>">&nbsp;<i
				class='fas fa-cog'></i>&nbsp;<strong>Referral</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/settings")%>"
			class="nav-link <%=makeActive(relUrl(request), "/settings", "active profile-active")%>">&nbsp;<i
				class='fas fa-sign-in-alt'></i>&nbsp;<strong>Settings</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/identity")%>"
			class="nav-link <%=makeActive(relUrl(request), "/identity", "active profile-active")%>">&nbsp;<i
				class='fas fa-user-edit'></i>&nbsp;<strong>Identity</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/create-post")%>"
			class="nav-link <%=makeActive(relUrl(request), "/create-post", "active profile-active")%>">&nbsp;<i
				class="fas fa-pen-square"></i>&nbsp;<strong>Create Post</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/my-posts/1")%>"
			class="nav-link <%=makeActive(relUrl(request), "/my-posts", "active profile-active")%>">&nbsp;<i
				class="far fa-newspaper"></i>&nbsp;<strong>My Posts</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/my-comments/1")%>"
			class="nav-link <%=makeActive(relUrl(request), "/my-comments", "active profile-active")%>">&nbsp;<i
				class="fas fa-comments"></i>&nbsp;<strong>My Comments</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/logout")%>"
			class="nav-link">&nbsp;<i class='fas fa-sign-out-alt'></i>&nbsp;<strong>Logout</strong></a></li>
	</ul>
</div>
<%-- End Small screen side navbar --%>