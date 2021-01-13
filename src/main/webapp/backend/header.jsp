
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="dataBaseModel.Users"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<%!public String umBaseUrlForHeader(HttpServletRequest request, String path) {
		if ((request.getServerPort() == 80) || (request.getServerPort() == 443)) {
			return request.getScheme() + "://" + request.getServerName() + request.getContextPath() + path;
		} else {
			return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath() + path;
		}
	}%>



<%--Cache control--%>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
%>

<%-- // Only logged in allowed--%>
<%
	if (session.getAttribute("Username") == null || session.getAttribute("Firstname") == null
		|| session.getAttribute("Email") == null) {

	response.sendRedirect(umBaseUrlForHeader(request, "/login"));
	//to prevent moving forward after this
	return;
}
%>

<%-- // Only Admin allowed--%>
<%
	UsersDAO Users = new UsersDAO();
Users user = Users.getUserProfile(session.getAttribute("Username").toString());
if (!user.getTag().equals("admin")) {

	response.sendRedirect("../index.jsp");
	//to prevent moving forward after this
	return;
}
%>

<%-- // end--%>



<%-- HTML CODE --%>

<%-- Print page title --%>



<div
	class="d-flex justify-content-between pt-3 pb-2 mb-3 border-bottom tog-fix"
	id="tog-fix">

	<%-- Small screen side navbar button --%>
	<%-- Use any element to open the sidenav hidden on medium screen up with bootstrap class(d-md-none d-lg-none d-xl-none) --%>
	<button
		class="navbar-toggler navbar-toggler-left d-md-none d-lg-none d-xl-none"
		type="button" style="margin-left: 20px;">
		<div class="row" style="margin-top: -8px;">
			<span style="font-size: 30px; cursor: pointer" onclick="openNav()">&#9776;</span>
		</div>
	</button>

	&emsp;
	<%-- page title --%>
	<div class="">
		<h4 class="h5">Sydewalka Orange CMS Admin</h4>
	</div>
	<div class="text-right">
		<ul
			class="nav navbar-nav flex-row justify-content-center flex-nowrap menu-border">
			<li class="nav-item"><a class="nav-link"
				href="<%=umBaseUrlForHeader(request, "/home")%>"><strong>Home</strong></a></li>
			&emsp;
			<li class="nav-item"><a class="nav-link"
				href="<%=umBaseUrlForHeader(request, "/profile/" + session.getAttribute("Username"))%>">
					<strong>Profile</strong>
			</a></li>
		</ul>
	</div>

</div>



<%-- End Print page title --%>
