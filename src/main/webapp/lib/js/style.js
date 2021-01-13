

/* ------------------------------------------------------- */
/* Profile page vertical menu */

/* Set the width of the side navigation to 250px */
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
  /* document.getElementById("main").style.backgroundColor = "rgba(0,0,0,0.4)";*/
  /*document.getElementById("tog-fix").classList.remove("fixed-top");*/
  document.getElementById("main").addEventListener("click", closeNav);
}

/* Set the width of the side navigation to 0 */
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
  /* document.getElementById("main").style.backgroundColor = "white";*/
  /* document.getElementById("tog-fix").classList.add("fixed-top");*/
}

/* ------------------------------------------------------- */





/* ------------------------------------------------------- */
/* Change the profile navbar to fixed and apply the css styling in my styles to it */
/*if (screen.width < 992){
	
	if ($(window).width() < 992)
	$(this).width() < 765
	$(window).width() < 750
	
	$(this).scrollTop() > $nav.height() + 30 && $(window).width() < 992
	
}*/
$(function () {
	$(document).scroll(function () {
		
		var $nav = $(".tog-fix");
		
		$nav.toggleClass('fixed-top fixed-top-scrolled', $(this).scrollTop() > $nav.height() + 30 && $(window).width() < 750);
		
	});
});

/* ------------------------------------------------------- */



/* ------------------------------------------------------- */
/* Form Validation and Submit button animation */

/* start animation, called inside the method below */
function beginAni() {
	var form = document.getElementById("auth-form");
	var button = document.getElementById("submit-btn");
	var anni = document.getElementById("submit-ani");
	
		
	if(form.classList.contains("ani-display")){
	  anni.style.display = "block";
	  button.style.display = "none";
	} 
}



/* Form Validation */

(function() {
  "use strict";
  window.addEventListener("load", function() {
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.getElementsByClassName("needs-validation");
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener("submit", function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add("was-validated");
        
        if (form.checkValidity() === true){
        	form.classList.add("ani-display");
        	$("#submit-btn").on('click', beginAni());
        }
      }, false);
    });
  }, false);
})();




/* ------------------------------------------------------- */



