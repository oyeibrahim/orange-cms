<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="dataBaseDAO.UsersDAO" import="dataBaseModel.Users"
	import="java.util.List" import="userInterfaces.SiteAlerts"
	import="dataBaseDAO.CategoriesDAO" import="dataBaseDAO.TagsDAO"
	import="dataBaseModel.Categories" import="dataBaseModel.Tags"
	import="dataBaseModel.Posts" import="dataBaseDAO.PostsDAO"
	import="dataBaseModel.SiteStructure"
	import="dataBaseDAO.SiteStructureDAO" import="dataBaseModel.Types"
	import="dataBaseDAO.TypesDAO"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%--Import css&js assets and favicon logo--%>
<%@ include file="asset-import.jsp"%>

<title>Orange | Edit Post - <%=request.getParameter("id")%></title>

</head>
<body>

	<%--Import Header--%>
	<%@ include file="header.jsp"%>

	<%--Cache control--%>
	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	%>

	<%--Can't access if not logged in--%>
	<%
		if (session.getAttribute("Username") == null || session.getAttribute("Firstname") == null
			|| session.getAttribute("Email") == null) {

		response.sendRedirect(um.baseUrl(request, "/login"));
		//to prevent moving forward after this
		return;
	}
	%>



	<%--Check if post exist--%>
	<%
		if (request.getParameter("id") == null) {

		session.setAttribute("ProfileUpdateErrorMessage", "No Post id provided");

		response.sendRedirect(um.baseUrl(request, "/create-post"));
		//to prevent moving forward after this
		return;
	}

	//initialise the DAO to check availability
	PostsDAO postDAO = new PostsDAO();

	UsersDAO userDAO = new UsersDAO();

	if (!postDAO.checkPostWithId(request.getParameter("id"))) {

		session.setAttribute("ProfileUpdateErrorMessage", "The requested post doesn't exist");

		response.sendRedirect(um.baseUrl(request, "/create-post"));
		//to prevent moving forward after this
		return;
	}

	//get post
	Posts post = postDAO.getPostWithId(request.getParameter("id"));
	%>

	<%
		//ensure editore is the post owner

	if (!post.getUsername().equals(session.getAttribute("Username"))
			&& post.getPosts_users_id() != userDAO.getId(session.getAttribute("Username").toString())) {

		session.setAttribute("ProfileUpdateErrorMessage", "You don't have permission to edit the post");

		response.sendRedirect(um.baseUrl(request, "/create-post"));
		//to prevent moving forward after this
		return;
	}
	%>

	<%
		//get other DAOs
	CategoriesDAO ctDAO = new CategoriesDAO();
	TagsDAO tgDAO = new TagsDAO();

	//put previous categories and tags in session to be used by controller
	//for updating thier post count //first check if tag exist as it may not exist
	session.setAttribute("prevCategories", post.getCategories());
	if (post.getTags() != null) {
		session.setAttribute("prevTags", post.getTags());
	}

	//set session for post picture
	session.setAttribute("postPicture", post.getPicture());

	//set session for post id
	session.setAttribute("editingPostID", request.getParameter("id"));
	%>

	<%-- HTML CODE  --%>

	<%--<br>
		<h2 class="jumbotron text-center jumbo-inner" style="color: black;">Profile</h2>--%>

	<div
		class="d-flex justify-content-left flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom shadow tog-fix"
		id="tog-fix">

		<%-- Small screen side navebar button --%>
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
		<h1 class="h2">Edit Post</h1>
	</div>


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

				<%-- Title --%>
				&emsp;
				<div class="text-left img-thumbnail">
					<h4>Edit post</h4>
				</div>

				<%-- Information --%>
				<div class="img-thumbnail bg-grey container"
					style="padding-top: 10px;">


					<%-- FORM START --%>
					<form class="needs-validation" autocomplete="off"
						action="PostUpdateController" method="post" id="auth-form"
						enctype="multipart/form-data" novalidate>


						<%-- --------------------------------------------------------------------------- --%>
						<hr>

						<h5>Image</h5>

						<label for="profilePicture" class="custom-file-upload"
							id="placeHolding"> <i class="fa fa-cloud-upload"></i>
							Click here to change the post image
						</label> <input type="file" id="profilePicture" accept="image/*"
							name="file" />


						<script type="text/javascript">
						
					   <%--change the interface value so user know when image selected --%>
					   $('#profilePicture').bind('change', function(){
						   if(this.files[0].size > 5242880){
						       <%--//alert("File is too big!");--%>
						       this.value = "";
						       document.getElementById("placeHolding").innerHTML= "<i class='fa fa-cloud-upload' style='color:red;'></i>  Selected image bigger than 5MB!!! Please select another";
						    }else{
					    	document.getElementById("placeHolding").innerHTML= "<i class='fa fa-cloud-upload' style='color:green;'></i>  Image Selected : " + document.getElementById("profilePicture").value;
						    }
					    })

					</script>

						<div class="text-center img-fluid img-thumbnail shadow"
							style="margin-top: 20px;">
							<img src="<%=webAddress + post.getPicture()%>"
								class="text-center img-fluid img-thumbnail shadow"
								style="width: 500px;">
							<p class="small">Existing image</p>
						</div>
						<%-- --------------------------------------------------------------------------- --%>


						<%-- --------------------------------------------------------------------------- --%>


						<hr>
						<h5>Title</h5>


						<div class="form-label-group">
							<input type="text" id="inputTitle" class="form-control shadow"
								placeholder="Title" value="<%=post.getTitle()%>" name="title"
								required> <label for="inputTitle">Title</label>
						</div>

						<%-- --------------------------------------------------------------------------- --%>

						<hr>
						<h5>Link</h5>
						<div class="form-label-group">
							<input type="text" id="inputLink" class="form-control shadow"
								placeholder="Link" value="<%=post.getLink()%>" name="link"
								required> <label for="inputLink">Link</label>
						</div>

						<%-- --------------------------------------------------------------------------- --%>
						<%-- Script for above two --%>

						<script type="text/javascript">
					
					<%-- make the title transfer to link with lowercase and all space replaced with (-) --%>
					<%-- transfer on the go --%>
					<%-- to get final string to use on change --%>
					var endStr = "";
					$('#inputTitle').bind('keyup', function(){
						document.getElementById("inputLink").value = "";
						var title = document.getElementById("inputTitle").value;
						<%-- replace all space, comma, question mark and others listed with (-) --%>
						var link = title.replace(/[$ &+£\[\]\',:;=?@#|\"'<>.^*/()%!-]/gi, "-");
						<%-- in case of more than one (-) in a place together , set the regex to check --%>
						var regex = /--/gi;
						<%-- check and always replace with one (-) while there are more than one (-) in a place together --%>
						do{
							link = link.replace(/--/gi, "-");
						} while(regex.test(link)){
							
						}
						
						<%-- check so it doesn't end with(-) in case there is special character at the end --%>
						if(link.endsWith("-")){
							link = link.substring(0,link.length-1);
						}
						
						endStr = link.toLowerCase();
						document.getElementById("inputLink").value = link.toLowerCase();
					});
					<%-- transfer when completed --%>
					$('#inputTitle').bind('change', function(){
						document.getElementById("inputLink").value = endStr;
					});
					</script>

						<%-- --------------------------------------------------------------------------- --%>

						<hr>
						<h5>Excerpt</h5>
						<%-- value for textarea is just the text placed within the textarea's tag --%>
						<%-- with tags next to each other, any space between will be counted as a space --%>
						<div class="form-label-group">
							<textarea class="form-control shadow" id="inputExcerpt" rows="6"
								name="excerpt" required><%=post.getExcerpt()%></textarea>
							<%-- <label for="inputExcerpt">Excerpt</label> --%>
						</div>

						<%-- --------------------------------------------------------------------------- --%>

						<hr>
						<h5>Post</h5>
						<%-- value for textarea is just the text placed within the textarea's tag --%>
						<%-- with tags next to each other, any space between will be counted as a space --%>
						<div class="form-label-group">
							<%-- <label for="body">Body</label> --%>
							<textarea class="form-control shadow" id="body" rows="25"
								name="body" required><%=post.getBody()%></textarea>
						</div>



						<script type="text/javascript">
						  tinymce.init({
						    selector: '#body',
						    plugins: "image media",
						    automatic_uploads: true,
						    images_reuse_filename: true,
						    //to check on blur
						    setup:function(ed) {
						        ed.on('blur', function(e) {
						        	//if new thing typed
						        	if (tinymce.activeEditor.isDirty()){
						        		//save to temp
						        		saveTempData();
						        	}
						        	    
						        });
						    },
						    images_upload_url : 'ImageUpload.php',
							automatic_uploads : false,

							images_upload_handler : function(blobInfo, success, failure) {
								var xhr, formData;

								xhr = new XMLHttpRequest();
								xhr.withCredentials = false;
								xhr.open('POST', 'ImageUpload.php');

								xhr.onload = function() {
									var json;

									if (xhr.status != 200) {
										failure('HTTP Error: ' + xhr.status);
										return;
									}

									json = JSON.parse(xhr.responseText);

									if (!json || typeof json.file_path != 'string') {
										failure('Invalid JSON: ' + xhr.responseText);
										return;
									}

									success(json.file_path);
								};

								formData = new FormData();
								formData.append('file', blobInfo.blob(), blobInfo.filename());

								xhr.send(formData);
							},
						  });
					  </script>




						<%-- --------------------------------------------------------------------------- --%>

						<hr>
						<h5>Categories</h5>

						<%-- UI --%>
						<%-- Comment out display style as categories will always exist unlike tags --%>
						<div class="container" id="UIcont"<%--style="display: none;"--%>>
							<div class="img-thumbnail row bg-grey" id="categoriesUI">
								<%
									String[] ctsL = post.getCategories().split(",");
								for (int i = 0; i < ctsL.length; i++) {
									out.println(
									"<p class='img-thumbnail small' style='border-color : green; background-color: #dfebe2; margin-right:5px;'>"
											+ ctsL[i]
											+ " <a onclick='deleteElement(this.parentNode)'  style='cursor: pointer;'>&times;</a></p>");
								}
								%>
							</div>
						</div>
						<%-- ------------------------- --%>
						<%-- real holder, transfered to db --%>
						<div class="form-label-group" style="display: none;">
							<input type="text" class="form-control" id="categories"
								value="<%=post.getCategories()%>" name="categories">
						</div>
						<%-- ------------------------- --%>
						<%-- select --%>
						<div class="form-label-group">
							<select class="form-control shadow" id="categoriesSelect"
								name="categoriesSelect">
								<option value="" selected disabled hidden=true></option>
								<%
									List<Categories> catList = ctDAO.getCategoriesNoPagination();
								for (Categories ct : catList) {
									out.println("<option>" + ct.getName() + "</option>");
								}
								%>
							</select>

						</div>

						<%-- --------------------------------------------------------------------------- --%>
						<%-- Script for above --%>

						<script type="text/javascript">
					function deleteElement(e){
						var domStr = e.innerHTML;
						<%-- put < so that it get the last space ocurrence --%>
						<%-- checking with the intensional space before <a> tag and < --%>
						var name = domStr.substring(0,domStr.indexOf(" <"));
						
						<%-- get hidden input value --%>
						var categories = document.getElementById("categories").value;
						
						<%-- removed the element from hidden input if its there --%>
						if(categories.includes(name)){
							<%-- add comma since there is comma in front of each word --%>
							var nCat = categories.replace(name+",","");
							document.getElementById("categories").value = nCat;
						}
						
						<%-- Enable picker if less than five temporarily, remove last comma below --%>
						var ctsTemp = document.getElementById("categories").value;
						<%-- remove the last comma to prevent adding an empty string to the end of the splitted string --%>
						var cts = ctsTemp.substring(0,ctsTemp.length-1);

						<%-- Comma is the splitting tool --%>
						var num = cts.split(",");

						if(num.length < 5){
							document.getElementById("categoriesSelect").disabled = false;
						}
						
						
						<%-- hide the UI container if all selection removed --%>
						<%-- using the hidden input length as the array is having an empty value --%>
						<%-- making the empty still give 1 in length, and then its kinda unstable --%>
						if(ctsTemp.length < 1){
							document.getElementById("UIcont").style.display = "none";
						}
						
						
						<%-- removed the element from UI --%>
						e.remove();
					};
					
					$('#categoriesSelect').bind('change', function addElement(){
						<%-- show container since a value will be placed in now --%>
						document.getElementById("UIcont").style.display = "block";
						
						<%-- grab hidden element value --%>
						var cts2 = document.getElementById("categories").value;
						
						<%-- if hidden element already contain the selected, then do nothing since we can't select twice --%>
						<%-- //add comma in front because I want to use .icludes() method --%>
						<%-- which will be true for every occurence even if inside another word, --%>
						<%-- like Crypto will test true with CryptoHubb, but to make it test only for distinct occurence --%>
						<%-- i am adding comma in front as it will mean that word is independent as comma is --%>
						<%-- always added in front of every new word before, for splitting --%>
						if(cts2.includes(document.getElementById("categoriesSelect").value + ",")){
							<%-- reset the picker to no value picked so onChange can be triggered the next time 
							even if selecting the same element as the previous --%>
							$("#categoriesSelect").val(null);
							<%-- return doing nothing --%>
							return;
						}else{
							<%-- grab UI existing HTML element --%>
							var existingUI = document.getElementById("categoriesUI").innerHTML;
							
							<%-- add the element to hidden input --%>
							document.getElementById("categories").value = document.getElementById("categories").value + document.getElementById("categoriesSelect").value + ",";
							
							<%-- add the new element to UI --%> <%-- NOTE: Space MUST be before the <a> tag, we are using it to get substring for item listed in this element --%>
							document.getElementById("categoriesUI").innerHTML= existingUI + " " + "<p class='img-thumbnail small' style='border-color : green; background-color: #dfebe2; margin-right:5px;'>" + document.getElementById("categoriesSelect").value +" <a onclick='deleteElement(this.parentNode)'  style='cursor: pointer;'>&times;</a></p>";
							
							<%-- grab hidden element value after adding the category temporarily, remove last comma below --%>
							var cts3Temp = document.getElementById("categories").value;
							<%-- remove the last comma to prevent adding an empty string to the end of the splitted string --%>
							var cts3 = cts3Temp.substring(0,cts3Temp.length-1);
							
							<%-- disable picker if five picked --%>
							var num = cts3.split(",");
							
							if(num.length == 5){
								document.getElementById("categoriesSelect").disabled = true;
							}
							
							<%-- reset the picker to no value picked so onChange can be triggered the next time 
							even if selecting the same element as the previous --%>
							$("#categoriesSelect").val(null);
						}
						
						
						
					});
					</script>

						<%-- --------------------------------------------------------------------------- --%>

						<hr>
						<h5>Tags</h5>

						<%-- UI --%>
						<%-- only show when there is an existing tag. this is achieved by printing --%>
						<%-- display none style when there is no tags from the db --%>
						<div class="container" id="UIcont2"
							<%if (post.getTags() == null) {
	out.println("style='display: none;'");
}%>>
							<div class="img-thumbnail row bg-grey" id="tagsUI">
								<%
									//check if its not null (i.e no tags exist before) before printing the values so it won't 
								//throw a null pointer exception if its null
								if (post.getTags() != null) {
									String[] tgsL = post.getTags().split(",");
									for (int i = 0; i < tgsL.length; i++) {
										out.println(
										"<p class='img-thumbnail small font-italic font-weight-lighter' style='border-color : green; background-color: #c1dedc; margin-right:5px;'>"
												+ tgsL[i]
												+ " <a onclick='deleteElement2(this.parentNode)' style='cursor: pointer;'>&times;</a></p>");
									}
								}
								%>
							</div>
						</div>

						<%-- ------------------------- --%>
						<%-- real holder, transfered to db --%>
						<div class="form-label-group" style="display: none;">
							<%-- if no tag before, don't print anything --%>
							<input type="text" class="form-control" id="tags"
								value="<%if (post.getTags() != null) {
	out.println(post.getTags());
}%>"
								name="tags">
						</div>
						<%-- ------------------------- --%>
						<%-- select --%>
						<div class="form-row row">
							<div class="col-md-11">
								<input type="text" id="tagsSelect" class="form-control shadow"
									placeholder="Enter new or existing tag - you can select up to 10 tags"
									name="tagsSelect">
							</div>
							<div class="col-md-1">
								<a class='img-thumbnail col-md-2' id="addTag"
									style='border-color: green; background-color: #32a852; cursor: pointer;'>ADD</a>
							</div>
						</div>

						<%-- --------------------------------------------------------------------------- --%>
						<%-- Script for above --%>



						<%-- Autocomplete --%>
						<script type="text/javascript">
  					<%-- Data --%>
  					var tagsData = [
  						<%//get tags data and print like a javascript data object. looks like this
//var countries = ["Afghanistan","Albania","Algeria","Andorra","Angola"];
List<Tags> tagList = tgDAO.getTagsNoPagination();
//used to detect the las element so we dont print a comma in front of it
int no = 1;
for (Tags tg : tagList) {
	//if we're not at the last element, then print a comma in front
	if (no < tagList.size()) {
		out.println("\"" + tg.getName() + "\"" + ",");
	} else {//don't print comma in front of the last element
		out.println("\"" + tg.getName() + "\"");
	}
	no++;
}%>
  					];
  					<%-- Function call --%>
  					autocomplete(document.getElementById("tagsSelect"), tagsData);
  					
  					
  					function autocomplete(inp, arr) {
  						<%--/*the autocomplete function takes two arguments,
  					  the text field element and an array of possible autocompleted values:*/--%>
  					  var currentFocus;
  					<%--/*execute a function when someone writes in the text field:*/--%>
  					  inp.addEventListener("input", function(e) {
  					      var a, b, i, val = this.value;
  					    <%--/*close any already open lists of autocompleted values*/--%>
  					      closeAllLists();
  					      if (!val) { return false;}
  					      currentFocus = -1;
  					    <%--/*create a DIV element that will contain the items (values):*/--%>
  					      a = document.createElement("DIV");
  					      a.setAttribute("id", this.id + "autocomplete-list");
  					      a.setAttribute("class", "autocomplete-items");
  					    <%--/*append the DIV element as a child of the autocomplete container:*/--%>
  					      this.parentNode.appendChild(a);
  					    <%--/*for each item in the array...*/--%>
  					      for (i = 0; i < arr.length; i++) {
  					    	<%--/*check if the item starts with the same letters as the text field value:*/--%>
  					        if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
  					        	<%--/*create a DIV element for each matching element:*/--%>
  					          b = document.createElement("DIV");
  					        <%--/*make the matching letters bold:*/--%>
  					          b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
  					          b.innerHTML += arr[i].substr(val.length);
  					        <%--/*insert a input field that will hold the current array item's value:*/--%>
  					          b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
  					        <%--/*execute a function when someone clicks on the item value (DIV element):*/--%>
  					              b.addEventListener("click", function(e) {
  					            	<%--/*insert the value for the autocomplete text field:*/--%>
  					              inp.value = this.getElementsByTagName("input")[0].value;
  					            <%--/*close the list of autocompleted values,
  					              (or any other open lists of autocompleted values:*/--%>
  					              closeAllLists();
  					          });
  					          a.appendChild(b);
  					        }
  					      }
  					  });
  					<%--/*execute a function presses a key on the keyboard:*/--%>
  					  inp.addEventListener("keydown", function(e) {
  					      var x = document.getElementById(this.id + "autocomplete-list");
  					      if (x) x = x.getElementsByTagName("div");
  					      if (e.keyCode == 40) {
  					    	<%--/*If the arrow DOWN key is pressed,
  					        increase the currentFocus variable:*/--%>
  					        currentFocus++;
  					      <%--/*and and make the current item more visible:*/--%>
  					        addActive(x);
  					      } else if (e.keyCode == 38) { //up--%>
  					    	<%--/*If the arrow UP key is pressed,
  					        decrease the currentFocus variable:*/--%>
  					        currentFocus--;
  					      <%--/*and and make the current item more visible:*/--%>
  					        addActive(x);
  					      } else if (e.keyCode == 13) {
  					    	<%--/*If the ENTER key is pressed, prevent the form from being submitted,*/--%>
  					        e.preventDefault();
  					        if (currentFocus > -1) {
  					        	<%--/*and simulate a click on the "active" item:*/--%>
  					          if (x) x[currentFocus].click();
  					        }
  					      }
  					  });
  					  function addActive(x) {
  						<%--/*a function to classify an item as "active":*/--%>
  					    if (!x) return false;
  					  <%--/*start by removing the "active" class on all items:*/--%>
  					    removeActive(x);
  					    if (currentFocus >= x.length) currentFocus = 0;
  					    if (currentFocus < 0) currentFocus = (x.length - 1);
  					  <%--/*add class "autocomplete-active":*/--%>
  					    x[currentFocus].classList.add("autocomplete-active");
  					  }
  					  function removeActive(x) {
  						<%--/*a function to remove the "active" class from all autocomplete items:*/--%>
  					    for (var i = 0; i < x.length; i++) {
  					      x[i].classList.remove("autocomplete-active");
  					    }
  					  }
  					  function closeAllLists(elmnt) {
  						<%--/*close all autocomplete lists in the document,
  					    except the one passed as an argument:*/--%>
  					    var x = document.getElementsByClassName("autocomplete-items");
  					    for (var i = 0; i < x.length; i++) {
  					      if (elmnt != x[i] && elmnt != inp) {
  					      x[i].parentNode.removeChild(x[i]);
  					    }
  					  }
  					}
  					<%--/*execute a function when someone clicks in the document:*/--%>
  					document.addEventListener("click", function (e) {
  					    closeAllLists(e.target);
  					});
  					} 
  					</script>



						<%-- UI tag select --%>
						<script type="text/javascript">
					function deleteElement2(e){
						var domStr = e.innerHTML;
						<%-- put < so that it get the last space ocurrence --%>
						<%-- checking with the intensional space before <a> tag and < --%>
						var name = domStr.substring(0,domStr.indexOf(" <"));
						
						<%-- get hidden input value --%>
						var tags = document.getElementById("tags").value;
						
						<%-- removed the element from hidden input if its there --%>
						if(tags.includes(name)){
							<%-- add comma since there is comma in front of each word --%>
							var nCat = tags.replace(name+",","");
							document.getElementById("tags").value = nCat;
						}
						
						<%-- Enable picker if less than ten --%>
						<%-- grab hidden element value after adding the tag temporarily, remove last comma below --%>
						var ctsTemp = document.getElementById("tags").value;
						<%-- remove the last comma to prevent adding an empty string to the end of the splitted string --%>
						var cts = ctsTemp.substring(0,ctsTemp.length-1);
						
						<%-- Comma is the splitting tool --%>
						var num = cts.split(",");
						
						if(num.length < 10){
							document.getElementById("tagsSelect").disabled = false;
						}
						
						
						<%-- hide the UI container if all selection removed --%>
						<%-- using the hidden input length as the array is having an empty value --%>
						<%-- making the empty still give 1 in length, and then its kinda unstable --%>
						if(ctsTemp.length < 1){
							document.getElementById("UIcont2").style.display = "none";
						}
						
						
						<%-- removed the element from UI --%>
						e.remove();
					};
					
					$('#addTag').bind('click', function addElement2(){
						<%-- show container since a value will be placed in now --%>
						document.getElementById("UIcont2").style.display = "block";
						
						<%-- grab hidden element value --%>
						var cts2 = document.getElementById("tags").value;
						
						<%-- if hidden element already con tain the selected, then do nothing since we can't select twice --%>
						<%-- //add comma in front because I want to use .icludes() method --%>
						<%-- which will be true for every occurence even if inside another word, --%>
						<%-- like Crypto will test true with CryptoHubb, but to make it test only for distinct occurence --%>
						<%-- i am adding comma in front as it will mean that word is independent as comma is --%>
						<%-- always added in front of every new word before, for splitting --%>
						if(cts2.includes(document.getElementById("tagsSelect").value + ",")){
							<%-- reset the picker to no value picked so onChange can be triggered the next time 
							even if selecting the same element as the previous --%>
							$("#tagsSelect").val("");
							<%-- return doing nothing --%>
							return;
						}else{
							<%-- grab UI existing HTML element --%>
							var existingUI = document.getElementById("tagsUI").innerHTML;
							
							<%-- add the element to hidden input --%>
							document.getElementById("tags").value = document.getElementById("tags").value + document.getElementById("tagsSelect").value + ",";
							
							<%-- add the new element to UI --%> <%-- NOTE: Space MUST be before the <a> tag, we are using it to get substring for item listed in this element --%>
							document.getElementById("tagsUI").innerHTML= existingUI + " " + "<p class='img-thumbnail small font-italic font-weight-lighter' style='border-color : green; background-color: #c1dedc; margin-right:5px;'>" + document.getElementById("tagsSelect").value +" <a onclick='deleteElement2(this.parentNode)' style='cursor: pointer;'>&times;</a></p>";
							
							<%-- grab hidden element value after adding the tag temporarily, remove last comma below --%>
							var cts3Temp = document.getElementById("tags").value;
							<%-- remove the last comma to prevent adding an empty string to the end of the splitted string --%>
							var cts3 = cts3Temp.substring(0,cts3Temp.length-1);
							
							<%-- disable picker if ten picked --%>
							var num = cts3.split(",");
							
							if(num.length == 10){
								document.getElementById("tagsSelect").disabled = true;
							}
							
							<%-- reset the picker to no value picked so onChange can be triggered the next time 
							even if selecting the same element as the previous --%>
							$("#tagsSelect").val("");
						}
						
						
						
					});
					</script>

						<%-- --------------------------------------------------------------------------- --%>

						<hr>

						<button type="submit" class="btn btn-primary shadow"
							id="submit-btn">Update Post</button>
						<button class="btn btn-primary" id="submit-ani" disabled>
							<span class="spinner-grow spinner-grow-sm"></span> Submitting...
						</button>

						<%-- --------------------------------------------------------------------------- --%>
					</form>
					<%-- FORM END --%>


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