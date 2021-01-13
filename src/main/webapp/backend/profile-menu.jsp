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
		<h2 class="text-center" style="color: white; padding-top: 50px;">Menu</h2>

		<!-- put navbar-nav also in div below to make the text box short -->
		<div class="mx-auto text-center"
			style="padding-top: 150px; padding-bottom: 150px;">

			<ul class="navbar-nav mx-auto text-left flex-column nav-pills">
				<li
					class="nav-item <%=makeActive(relUrl(request), "/backend/home.jsp", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/backend/home.jsp")%>"
					class="nav-link">&nbsp;<i class='fas fa-user-circle'></i>&nbsp;<strong>Dashboard</strong></a>
				</li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/backend/users", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/backend/users/1/")%>"
					class="nav-link">&nbsp;<i class='fas fa-user-friends'></i>&nbsp;<strong>Users</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/backend/admins", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/backend/admins/1/")%>"
					class="nav-link">&nbsp;<i class="fas fa-cog"></i>&nbsp;<strong>Admins</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/backend/posts", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/backend/posts/1/")%>"
					class="nav-link">&nbsp;<i class="far fa-newspaper"></i>&nbsp;<strong>Posts</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/backend/comments", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/backend/comments/1/")%>"
					class="nav-link">&nbsp;<i class="fas fa-comments"></i>&nbsp;<strong>Comments</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/backend/categories", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/backend/categories/1/")%>"
					class="nav-link">&nbsp;<i class='far fa-folder-open'></i>&nbsp;<strong>Categories</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/backend/tags", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/backend/tags/1/")%>"
					class="nav-link">&nbsp;<i class='fas fa-tag'></i>&nbsp;<strong>Tags</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/backend/types", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/backend/types/1/")%>"
					class="nav-link">&nbsp;<i class='far fa-folder-open'></i>&nbsp;<strong>Post
							Types</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/backend/contact-messages", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/backend/contact-messages/1/")%>"
					class="nav-link">&nbsp;<i class='fas fa-envelope'></i>&nbsp;<strong>Contact
							Messages</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/backend/db-settings", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/backend/db-settings/1/")%>"
					class="nav-link">&nbsp;<i class='fas fa-cog'></i>&nbsp;<strong>Settings</strong></a></li>
				<li
					class="nav-item <%=makeActive(relUrl(request), "/backend/email-list", "active profile-active")%>"><a
					href="<%=umBaseUrlForProfileMenu(request, "/backend/email-list.jsp")%>"
					class="nav-link">&nbsp;<i class='fas fa-envelope'></i>&nbsp;<strong>Email
							List</strong></a></li>
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
			href="<%=umBaseUrlForProfileMenu(request, "/backend/home.jsp")%>"
			class="nav-link <%=makeActive(relUrl(request), "/backend/home.jsp", "active")%>">&nbsp;<i
				class='fas fa-user-circle'></i>&nbsp;<strong>Dashboard</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/backend/users/1/")%>"
			class="nav-link <%=makeActive(relUrl(request), "/backend/users", "active profile-active")%>">&nbsp;<i
				class='fas fa-user-friends'></i>&nbsp;<strong>Users</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/backend/admins/1/")%>"
			class="nav-link <%=makeActive(relUrl(request), "/backend/admins", "active profile-active")%>">&nbsp;<i
				class='fas fa-cog'></i>&nbsp;<strong>Admins</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/backend/posts/1/")%>"
			class="nav-link <%=makeActive(relUrl(request), "/backend/posts", "active profile-active")%>">&nbsp;<i
				class='far fa-newspaper'></i>&nbsp;<strong>Posts</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/backend/comments/1/")%>"
			class="nav-link <%=makeActive(relUrl(request), "/backend/comments", "active profile-active")%>">&nbsp;<i
				class="fas fa-comments"></i>&nbsp;<strong>Comments</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/backend/categories/1/")%>"
			class="nav-link <%=makeActive(relUrl(request), "/backend/categories", "active profile-active")%>">&nbsp;<i
				class="far fa-folder-open"></i>&nbsp;<strong>Categories</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/backend/tags/1/")%>"
			class="nav-link <%=makeActive(relUrl(request), "/backend/tags", "active profile-active")%>">&nbsp;<i
				class="fas fa-tag"></i>&nbsp;<strong>Tags</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/backend/types/1/")%>"
			class="nav-link <%=makeActive(relUrl(request), "/backend/types", "active profile-active")%>">&nbsp;<i
				class="far fa-folder-open"></i>&nbsp;<strong>Post Types</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/backend/contact-messages/1/")%>"
			class="nav-link <%=makeActive(relUrl(request), "/backend/contact-messages", "active profile-active")%>">&nbsp;<i
				class="fas fa-envelope"></i>&nbsp;<strong>Contact Messages</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/backend/db-settings/1/")%>"
			class="nav-link <%=makeActive(relUrl(request), "/backend/db-settings", "active profile-active")%>">&nbsp;<i
				class="fas fa-cog"></i>&nbsp;<strong>Settings</strong></a></li>
		<li class="nav-item"><a
			href="<%=umBaseUrlForProfileMenu(request, "/backend/email-list.jsp")%>"
			class="nav-link <%=makeActive(relUrl(request), "/backend/email-list", "active profile-active")%>">&nbsp;<i
				class="fas fa-envelope"></i>&nbsp;<strong>Email List</strong></a></li>
	</ul>
</div>
<%-- End Small screen side navbar --%>