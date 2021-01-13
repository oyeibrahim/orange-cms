<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>


<%-- Site footer --%>
<footer class="site-footer">
	<div class="container">
		<div class="row">
			<div class="col-sm-6 col-md-3 img-thumbnail"
				style="background-color: #26272b; border-color: rgba(100, 100, 100, 1)">

				<%
					String webAddress3 = request.getContextPath();
				%>

				<div class="text-center">
					<a href="<%out.println(webAddress3);%>/"
						class="navbar-brand mr-0"><img
						class="nav-image img-thumbnail text-center"
						style="max-height: 70px; padding: 2px; border-radius: 20px; border-color: rgba(100, 100, 100, 1);"
						src="<%out.println(webAddress3);%>/lib/assets/settings/swk-medium.png"
						alt="Sydewalka Logo"></a>
				</div>
				<hr>
				<p class="text-center">Sydewalka is a technological company that
					does all kinds of software services.</p>

			</div>

			<div class="col-xs-6 col-md-3">
				<h6>Useful Links</h6>
				<hr>
				<ul class="footer-links">
					<li><a href="http://scanfcode.com/category/c-language/">My
							one</a></li>
					<li><a
						href="http://scanfcode.com/category/front-end-development/">Text
							reg</a></li>
					<li><a
						href="http://scanfcode.com/category/back-end-development/">Demo
							design</a></li>
					<li><a
						href="http://scanfcode.com/category/java-programming-language/">Try
							luck</a></li>
					<li><a href="http://scanfcode.com/category/android/">Demo
							work</a></li>
					<li><a href="http://scanfcode.com/category/templates/">My
							reg</a></li>
				</ul>
			</div>

			<div class="col-xs-6 col-md-3">
				<h6>Categories</h6>
				<hr>
				<ul class="footer-links">
					<li><a href="http://scanfcode.com/category/c-language/">C</a></li>
					<li><a
						href="http://scanfcode.com/category/front-end-development/">UI
							Design</a></li>
					<li><a
						href="http://scanfcode.com/category/back-end-development/">PHP</a></li>
					<li><a
						href="http://scanfcode.com/category/java-programming-language/">Java</a></li>
					<li><a href="http://scanfcode.com/category/android/">Android</a></li>
					<li><a href="http://scanfcode.com/category/templates/">Templates</a></li>
				</ul>
			</div>

			<div class="col-xs-6 col-md-3">
				<h6>Quick Links</h6>
				<hr>
				<ul class="footer-links">
					<li><a href="http://scanfcode.com/about/">About Us</a></li>
					<li><a href="http://scanfcode.com/contact/">Contact Us</a></li>
					<li><a href="http://scanfcode.com/contribute-at-scanfcode/">Contribute</a></li>
					<li><a href="http://scanfcode.com/privacy-policy/">Privacy
							Policy</a></li>
					<li><a href="http://scanfcode.com/sitemap/">Sitemap</a></li>
				</ul>
			</div>
		</div>
		<hr>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-sm-6 col-xs-12">
				<p class="copyright-text">
					Copyright &copy; 2017 All Rights Reserved by <a href="http://sydewalka.com">Sydewalak</a>.
				</p>
			</div>

			<div class="col-md-4 col-sm-6 col-xs-12">
				<ul class="social-icons">
					<li><a class="facebook" href="#"><i
							class="fab fa-facebook-f"></i></a></li>
					<li><a class="twitter" href="#"><i class="fab fa-twitter"></i></a></li>
					<li><a class="dribbble" href="#"><i
							class="fab fa-telegram-plane"></i></a></li>
					<li><a class="linkedin" href="#"><i
							class="fas fa-bullhorn"></i></a></li>
				</ul>
			</div>
		</div>
	</div>
</footer>
