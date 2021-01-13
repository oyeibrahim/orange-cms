<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.ReferralDAO"
	import="dataBaseModel.Referral"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="frontend/asset-import.jsp"%>

<title>Sydewalka | Orange CMS</title>
</head>
<body>

	<%--Import Header--%>
	<%@ include file="frontend/header.jsp"%>


	<%--Handle referral if code provided--%>
	<%
		//if ref parameter is available
	if (request.getParameter("ref") != null) {
		String code = request.getParameter("ref");

		//access referral DAO
		ReferralDAO refDAO = new ReferralDAO();

		//check if the code exist
		int exist = refDAO.checkCode(code);

		if (exist == 1) {
			//if code exist, then get set session
			session.setAttribute("RefCode", code);
		}
	}
	%>


	<%--Jumbotron --%>
	<div class="jumbotron text-center jumbo-front">
		<h1>Orange CMS Java Servlet</h1>
		<br>

		<p>by Sydewalka</p>
		<br>
		<h3>Homepage</h3>
		<br>
		<p>Contains all info about the CMS</p>
		<button type="button" class="btn btn-info" id="site-button">Learn
			More</button>
		&emsp;
		<button type="button" class="btn btn-info" id="site-button">Join
			Us</button>

	</div>
	<%--end Jumbotron --%>



	<%-- Three columns of text below the carousel --%>
	<div class="text-center bg-grey"
		style="padding: 20px; padding-top: 100px; padding-bottom: 100px; margin-top: -30px; margin-bottom: -15px;">
		<div class="row text-center">
			<div class="col-lg-4">
				<i class="fas fa-globe-americas fa-10x"></i>
				<h2>Heading</h2>
				<p>Donec sed odio dui. Etiam porta sem malesuada magna mollis
					euismod. Nullam id dolor id nibh ultricies vehicula ut id elit.
					Morbi leo risus, porta ac consectetur ac, vestibulum at eros.
					Praesent commodo cursus magna.</p>
				<p>
					<a class="btn btn-secondary" id="site-button" href="#"
						role="button">View details »</a>
				</p>
			</div>
			<%-- /.col-lg-4 --%>
			<div class="col-lg-4">
				<i class="fas fa-globe-americas fa-10x"></i>
				<h2>Heading</h2>
				<p>Duis mollis, est non commodo luctus, nisi erat porttitor
					ligula, eget lacinia odio sem nec elit. Cras mattis consectetur
					purus sit amet fermentum. Fusce dapibus, tellus ac cursus commodo,
					tortor mauris condimentum nibh.</p>
				<p>
					<a class="btn btn-secondary" id="site-button" href="#"
						role="button">View details »</a>
				</p>
			</div>
			<%-- /.col-lg-4 --%>
			<div class="col-lg-4">
				<i class="fas fa-globe-americas fa-10x"></i>
				<h2>Heading</h2>
				<p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in,
					egestas eget quam. Vestibulum id ligula porta felis euismod semper.
					Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum
					nibh, ut fermentum massa justo sit amet risus.</p>
				<p>
					<a class="btn btn-secondary" id="site-button" href="#"
						role="button">View details »</a>
				</p>
			</div>
			<%-- /.col-lg-4 --%>
		</div>
	</div>
	<%-- /.row --%>


	<%--section 1 --%>
	<div class=""
		style="padding: 20px; padding-top: 100px; padding-bottom: 100px; margin-top: -30px;">
		<div class="row">
			<div class="col-sm-8">
				<h2>About Company Page</h2>
				<h4>Lorem ipsum dolor sit amet, consectetur adipiscing elit,
					sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
					Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat.</h4>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
					enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat. Excepteur sint occaecat
					cupidatat non proident, sunt in culpa qui officia deserunt mollit
					anim id est laborum consectetur adipiscing elit, sed do eiusmod
					tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
					minim veniam, quis nostrud exercitation ullamco laboris nisi ut
					aliquip ex ea commodo consequat.</p>
				<button class="btn btn-default btn-lg">Get in Touch</button>
			</div>
			<div class="col-sm-4" style="font-size: 24px;">
				<img src="<%out.println(webAddress);%>/lib/assets/newyork.jpg"
					class="img-thumbnail" alt="New York">
			</div>
		</div>
	</div>
	<%--end section 1 --%>


	<%--section 2 --%>
	<div class="bg-grey"
		style="padding: 20px; padding-top: 100px; padding-bottom: 100px; margin-top: -30px;">
		<div class="row">
			<div class="col-sm-4" style="font-size: 24px;">
				<img src="<%out.println(webAddress);%>/lib/assets/paris.jpg"
					class="img-thumbnail" alt="Paris">
			</div>
			<div class="col-sm-8">
				<h2>Our Values</h2>
				<h4>
					<strong>MISSION:</strong> Our mission lorem ipsum dolor sit amet,
					consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
					labore et dolore magna aliqua. Ut enim ad minim veniam, quis
					nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
					consequat.
				</h4>
				<p>
					<strong>VISION:</strong> Our vision Lorem ipsum dolor sit amet,
					consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
					labore et dolore magna aliqua. Ut enim ad minim veniam, quis
					nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
					consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit,
					sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
					Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat.
				</p>
			</div>
		</div>
	</div>
	<%--end section 2 --%>

	<%--Services --%>
	<div class="text-center"
		style="padding: 20px; padding-top: 100px; padding-bottom: 100px; margin-top: -30px;">
		<h2>SERVICES</h2>
		<h4>What we offer</h4>
		<br>
		<div class="row">
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-off"></span> <i
					class="fas fa-globe-americas"></i>
				<h4>POWER</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-heart"></span> <i
					class="fas fa-globe-americas"></i>
				<h4>LOVE</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-lock"></span> <i
					class="fas fa-globe-americas"></i>
				<h4>JOB DONE</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
		</div>
		<br> <br>
		<div class="row">
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-leaf"></span> <i
					class="fas fa-globe-americas" style="color: #f4511e;"></i>
				<h4>GREEN</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-certificate"></span> <i
					class="fas fa-globe-americas" style="color: #f4511e;"></i>
				<h4>CERTIFIED</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
			<div class="col-sm-4">
				<span class="glyphicon glyphicon-wrench"></span> <i
					class="fas fa-globe-americas" style="color: #f4511e;"></i>
				<h4>HARD WORK</h4>
				<p>Lorem ipsum dolor sit amet..</p>
			</div>
		</div>
	</div>
	<%--end Services --%>

	<%--Portfolio --%>
	<div class="text-center bg-grey"
		style="padding: 20px; padding-top: 100px; padding-bottom: 100px; margin-top: -30px;">
		<h2>Portfolio</h2>
		<h4>What we have created</h4>
		<div class="row text-center">
			<div class="col-sm-4">
				<div class="img-thumbnail" style="margin-bottom: 10px;">
					<img src="<%out.println(webAddress);%>/lib/assets/paris.jpg"
						class="img-thumbnail" alt="Paris">
					<div class="img-thumbnail">
						<p>
							<strong>Paris</strong>
						</p>
						<hr>
						<p>Yes, we built Paris</p>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="img-thumbnail" style="margin-bottom: 10px;">
					<img src="<%out.println(webAddress);%>/lib/assets/newyork.jpg"
						class="img-thumbnail" alt="New York">
					<div class="img-thumbnail">
						<p>
							<strong>New York</strong>
						</p>
						<hr>
						<p>We built New York</p>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="img-thumbnail" style="margin-bottom: 10px;">
					<img src="<%out.println(webAddress);%>/lib/assets/sanfran.jpg"
						class="img-thumbnail" alt="San Francisco">
					<div class="img-thumbnail">
						<p>
							<strong>San Francisco</strong>
						</p>
						<hr>
						<p>Yes, San Fran is ours</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%--end Portfolio --%>

	<%--Carousel --%>
	<h2 class="text-center">What our customers say</h2>
	<div id="demo" class="carousel slide text-center" data-ride="carousel">

		<%-- Indicators --%>
		<ul class="carousel-indicators">
			<li data-target="#demo" data-slide-to="0" class="active"></li>
			<li data-target="#demo" data-slide-to="1"></li>
			<li data-target="#demo" data-slide-to="2"></li>
		</ul>

		<%-- The slideshow --%>
		<div class="carousel-inner" role="listbox">
			<div class="carousel-item active">
				<h4 class="spacer">
					"This company is the best. I am so happy with the result!"<br>
					<span style="font-style: normal;">Michael Roe, Vice
						President, Comment Box</span>
				</h4>
			</div>
			<div class="carousel-item">
				<h4 class="spacer">
					"One word... WOW!!"<br> <span style="font-style: normal;">John
						Doe, Salesman, Rep Inc</span>
				</h4>
			</div>
			<div class="carousel-item">
				<h4 class="spacer">
					"Could I... BE any more happy with this company?"<br> <span
						style="font-style: normal;">Chandler Bing, Actor,
						FriendsAlot</span>
				</h4>
			</div>
		</div>

		<%-- Left and right controls --%>
		<a class="carousel-control-prev" href="#demo" data-slide="prev"> <span
			class="carousel-control-prev-icon"><i
				class="fas fa-chevron-left" style="color: #f4511e;"></i></span>
		</a> <a class="carousel-control-next" href="#demo" data-slide="next">
			<span class="carousel-control-next-icon"><i
				class="fas fa-chevron-right" style="color: #f4511e;"></i></span>
		</a>

	</div>
	<%--end Carousel --%>

	<%--Import Footer --%>
	<%@ include file="frontend/footer.jsp"%>
</body>
</html>