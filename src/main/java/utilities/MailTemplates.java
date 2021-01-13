/**
 * 
 */
package utilities;

/**
 * @author Abu 'Abdur-Rahman
 * 
 * Different email templates
 *
 */
public class MailTemplates {
	
	public String accountActivation(String username, String activationLink) {
		
		String emailActivationMail = "<!DOCTYPE html><html><head><title>BAYK Agricultral Services</title> </head> "
				+ "<body style='font-family: Verdana;'><!-- Start Container--><div style='padding-top: 20px; padding-bottom: 20px; "
				+ "padding-left: 10px; padding-right:10px; max-width: 700px; margin: auto;'><!-- Start Header -->"
				+ "<div style='text-align: center; background-color: #42ad42; color: white; padding: 10px; padding-top: 20px;"
				+ " border-radius: 20px; box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1);'><h3>BAYK Agricultural Services</h3>"
				+ "<hr style='background-color: grey; margin-bottom:5px;'><p style='margin-bottom:0px;'>Account Activation</p>"
				+ "</div><!-- End Header--><!-- Start Body --><div style='text-align: center; background-color: #f0f3f7; "
				+ "border-radius:20px; box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1); padding-top:20px; padding-bottom:30px; "
				+ "padding-right:10px; padding-left:10px; margin-top:10px; margin-bottom:10px; font-size:16px; word-wrap: break-word;'>"
				+ "<!-- ////Content/// --><h3 style='color: #182438; font-size: 26px; margin-top: 10px;'>Please confirm your email</h3><br/>"
				+ "<!-- ///////////////////////////////////////////////////////////////////-->"
				+ "Hi <b>"
				+ username
				+ "</b>,<br/><br/>Thanks for registering on BAYK Agricultural Services!<br/><br/>To get full access to your account, "
				+ "click the button below.<br/><br/>"
				+ "<!-- ///////////////////////////////////////////////////////////////////-->"
				+ "<a href='"
				+ activationLink
				+ "' style='text-decoration: none; background-color: #29b0d9; color: white; border-radius: 5px; padding:10px;'>"
				+ "Activate my account</a><br/><br/><br/>Or copy and paste this link to your browser:<br/>"
				+ "<!-- ///////////////////////////////////////////////////////////////////-->"
				+ "<div style='border-color:green; border:solid 1px green; border-radius:20px; padding:10px; background-color: #f7f9ff;"
				+ " margin-top:10px; font-size:14px;'><a href='"
				+ activationLink
				+ "' style='text-decoration: none;'>"
				+ activationLink
				+ "</a></div></div><!-- End Body--><!-- Start Footer --><div style='text-align: center; background-color: #1b1b1b;"
				+ " color: white; padding: 10px; padding-top: 20px; border-radius: 20px; box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1);'>"
				+ "<div style='text-align: center;'><div style='font-size:14px; color: #a0acb8; padding-left:20px; padding-right:10px;'>"
				+ "<p><a href='http://baykservices.com' style='text-decoration: none; color:white;'>BAYK Official Website</a></p>"
				+ "<p><a href='mailto:info@baykservices.com' style='text-decoration: none; color:white;'>info@baykservices.com</a></p>"
				+ "</div></div><hr style='background-color: grey; margin-bottom:5px; margin-top:40px;'><p style='font-size:12px;'>"
				+ "&emsp;<a href='https://twitter.com/BAYK_official/' style='text-decoration: none; color:white;'>Twitter</a>&emsp;"
				+ "<a href='https://www.facebook.com/BAYKofficial/' style='text-decoration: none; color:white;'>Facebook </a>&emsp;"
				+ "<a href='https://t.me/BAYKagriculture/' style='text-decoration: none; color:white;'>Telegram</a>&emsp;"
				+ "<a href='https://t.me/BAYKnews/' style='text-decoration: none; color:white;'>Announcement</a>&emsp;"
				+ "<a href='http://cointick.net' style='text-decoration: none; color:white;'>CoinTick</a></p>"
				+ "<p style='margin-bottom:-5px; font-size:12px;'>&emsp;"
				+ "<!-- ///////////////////////////////////////////////////////////////////-->"
				+ "<a href='' style='text-decoration: none; color:grey;'>Unsbscribe</a></p></div><!-- End Footer--></div>"
				+ "<!-- End Container--> </body> </html>";
		
		return emailActivationMail;
		
	}
	
	
	
public String accountActivated(String username) {
		
		String welcomeMail = "<!DOCTYPE html> <html> <head> <title>BAYK Agricultral Services</title> </head> "
				+ "<body style='font-family: Verdana;'> <!-- Start Container--> <div style='padding-top: 20px; padding-bottom: 20px;"
				+ " padding-left: 10px; padding-right:10px; max-width: 700px; margin: auto;'> <!-- Start Header --> "
				+ "<div style='text-align: center; background-color: #42ad42; color: white; padding: 10px; padding-top: 20px;"
				+ " border-radius: 20px; box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1);'> <h3>BAYK Agricultural Services</h3> "
				+ "<hr style='background-color: grey; margin-bottom:5px;'> <p style='margin-bottom:0px;'>Account Activated</p> "
				+ "</div> <!-- End Header--> <!-- Start Body --> <div style='text-align: center; background-color: #f0f3f7;"
				+ " border-radius:20px; box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1); padding-top:20px; padding-bottom:30px;"
				+ " padding-right:10px; padding-left:10px; margin-top:10px; margin-bottom:10px; font-size:16px; word-wrap: break-word;'> "
				+ "<!-- ////Content/// --> <h3 style='color: #182438; font-size: 26px; margin-top: 10px;'> "
				+ "Your account has been confirmed </h3> <br/> "
				+ "<!-- ///////////////////////////////////////////////////////////////////--> "
				+ "Hello <b>"
				+ username
				+ "</b>, <br/> <br/> Welcome to BAYK Agricultral Services . <br/> <br/> Your account was successfully activated. "
				+ "You can now enjoy all our services. </div> <!-- End Body--> <!-- Start Footer --> <div style='text-align: center;"
				+ " background-color: #1b1b1b; color: white; padding: 10px; padding-top: 20px; border-radius: 20px;"
				+ " box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1);'> <div style='text-align: center;'> <div style='font-size:14px;"
				+ " color: #a0acb8; padding-left:20px; padding-right:10px;'> "
				+ "<p><a href='http://baykservices.com' style='text-decoration: none; color:white;'>BAYK Official Website</a></p> "
				+ "<p><a href='mailto:info@baykservices.com' style='text-decoration: none; color:white;'>info@baykservices.com</a></p> </div> </div> "
				+ "<hr style='background-color: grey; margin-bottom:5px; margin-top:40px;'> "
				+ "<p style='font-size:12px;'> &emsp; <a href='https://twitter.com/BAYK_official/' style='text-decoration: none; color:white;'>Twitter</a> "
				+ "&emsp; <a href='https://www.facebook.com/BAYKofficial/' style='text-decoration: none; color:white;'>Facebook </a> "
				+ "&emsp; <a href='https://t.me/BAYKagriculture/' style='text-decoration: none; color:white;'>Telegram</a> "
				+ "&emsp; <a href='https://t.me/BAYKnews/' style='text-decoration: none; color:white;'>Announcement</a> "
				+ "&emsp; <a href='http://cointick.net' style='text-decoration: none; color:white;'>CoinTick</a> </p> "
				+ "<p style='margin-bottom:-5px; font-size:12px;'> &emsp; "
				+ "<!-- ///////////////////////////////////////////////////////////////////--> "
				+ "<a href='' style='text-decoration: none; color:grey;'>Unsbscribe</a> </p> </div> "
				+ "<!-- End Footer--> </div> <!-- End Container-->";
		
		return welcomeMail;
		
	}


public String resetPasswordRequest(String username, String activationLink) {

	String passwordResetRequest = "<!DOCTYPE html> <html> <head><title>BAYK Agricultral Services</title> </head> "
			+ "<body style='font-family: Verdana;'><!-- Start Container--><div style='padding-top: 20px; padding-bottom: 20px;"
			+ " padding-left: 10px; padding-right:10px; max-width: 700px; margin: auto;'><!-- Start Header -->"
			+ "<div style='text-align: center; background-color: #42ad42; color: white; padding: 10px; padding-top: 20px;"
			+ " border-radius: 20px; box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1);'><h3>BAYK Agricultural Services</h3>"
			+ "<hr style='background-color: grey; margin-bottom:5px;'><p style='margin-bottom:0px;'>Reset Password</p></div>"
			+ "<!-- End Header--><!-- Start Body --><div style='text-align: center; background-color: #f0f3f7; border-radius:20px;"
			+ " box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1); padding-top:20px; padding-bottom:30px; padding-right:10px;"
			+ " padding-left:10px; margin-top:10px; margin-bottom:10px; font-size:16px; word-wrap: break-word;'><!-- ////Content/// -->"
			+ "<h3 style='color: #182438; font-size: 26px; margin-top: 10px;'>Reset your password</h3><br/>"
			+ "<!-- ///////////////////////////////////////////////////////////////////-->Hi <b>"
			+ username
			+ "</b>,<br/><br/>You recently requested a password reset link<br/><br/>Click the button below to reset your password<br/>"
			+ "<br/><!-- ///////////////////////////////////////////////////////////////////-->"
			+ "<a href='"
			+ activationLink
			+ "' style='text-decoration: none; background-color: #29b0d9; color: white; border-radius: 5px;"
			+ " padding:10px;'>Reset Password</a><br/><br/><br/>Or copy and paste this link to your browser:<br/>"
			+ "<!-- ///////////////////////////////////////////////////////////////////--><div style='border-color:green;"
			+ " border:solid 1px green; border-radius:20px; padding:10px; background-color: #f7f9ff; margin-top:10px; font-size:14px;'><a href='"
			+ activationLink
			+ "' style='text-decoration: none;'>"
			+ activationLink
			+ "</a></div><br/><br/>Please ignore this message if you didn't request a password reset and contact an admin or change your"
			+ " password immediately<br/></div><!-- End Body--><!-- Start Footer --><div style='text-align: center; background-color: #1b1b1b;"
			+ " color: white; padding: 10px; padding-top: 20px; border-radius: 20px; box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1);'>"
			+ "<div style='text-align: center;'><div style='font-size:14px; color: #a0acb8; padding-left:20px; padding-right:10px;'>"
			+ "<p><a href='http://baykservices.com' style='text-decoration: none; color:white;'>BAYK Official Website</a></p>"
			+ "<p><a href='mailto:info@baykservices.com' style='text-decoration: none; color:white;'>info@baykservices.com</a></p></div></div>"
			+ "<hr style='background-color: grey; margin-bottom:5px; margin-top:40px;'><p style='font-size:12px;'>&emsp;"
			+ "<a href='https://twitter.com/BAYK_official/' style='text-decoration: none; color:white;'>Twitter</a>&emsp;"
			+ "<a href='https://www.facebook.com/BAYKofficial/' style='text-decoration: none; color:white;'>Facebook </a> &emsp;"
			+ "<a href='https://t.me/BAYKagriculture/' style='text-decoration: none; color:white;'>Telegram</a>&emsp;"
			+ "<a href='https://t.me/BAYKnews/' style='text-decoration: none; color:white;'>Announcement</a>&emsp;"
			+ "<a href='http://cointick.net' style='text-decoration: none; color:white;'>CoinTick</a></p><p style='margin-bottom:-5px; font-size:12px;'>"
			+ "&emsp;<!-- ///////////////////////////////////////////////////////////////////--><a href='' style='text-decoration: none;"
			+ " color:grey;'>Unsbscribe</a></p></div><!-- End Footer--></div><!-- End Container--> </body> </html>";

	return passwordResetRequest;

}


public String resetPasswordSuccess(String username) {

	String passwordResetSuccess = "<!DOCTYPE html> <html> <head>     <title>BAYK Agricultral Services</title> </head> "
			+ "<body style='font-family: Verdana;'> 	<!-- Start Container--> 	<div style='padding-top: 20px; padding-bottom: 20px;"
			+ " padding-left: 10px; padding-right:10px; max-width: 700px; margin: auto;'> 		<!-- Start Header --> 		"
			+ "<div style='text-align: center; background-color: #42ad42; color: white; padding: 10px; padding-top: 20px;"
			+ " border-radius: 20px; box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1);'> 			<h3>BAYK Agricultural Services</h3>"
			+ " 			<hr style='background-color: grey; margin-bottom:5px;'> 			<p style='margin-bottom:0px;'>Password "
			+ "changed</p> 		</div> 		<!-- End Header--> 		<!-- Start Body --> 		<div style='text-align: center;"
			+ " background-color: #f0f3f7; border-radius:20px; box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1); padding-top:20px;"
			+ " padding-bottom:30px; padding-right:10px; padding-left:10px; margin-top:10px; margin-bottom:10px; font-size:16px;"
			+ " word-wrap: break-word;'> 		 					<!-- ////Content/// --> 		<h3 style='color: #182438;"
			+ " font-size: 26px; margin-top: 10px;'> 			Your password was updated 		</h3> 		<br/> 		"
			+ "<!-- ///////////////////////////////////////////////////////////////////--> 		Hello <b>"
			+ username
			+ "</b>, 		<br/> 		<br/> 		 		Your password was changed successfully, you can now login to your account"
			+ " 		 		</div> 		<!-- End Body--> 		<!-- Start Footer --> 		<div style='text-align: center;"
			+ " background-color: #1b1b1b; color: white; padding: 10px; padding-top: 20px; border-radius: 20px;"
			+ " box-shadow: 0px 2px 4px 0px rgba(0,0,0,0.1);'> 			<div style='text-align: center;'> 				"
			+ "<div style='font-size:14px; color: #a0acb8; padding-left:20px; padding-right:10px;'>"
			+ "<p><a href='http://baykservices.com' style='text-decoration: none; color:white;'>BAYK Official Website</a></p>"
			+ "<p><a href='mailto:info@baykservices.com' style='text-decoration: none; color:white;'>info@baykservices.com</a></p>"
			+ " 				</div> 			</div> 			<hr style='background-color: grey; margin-bottom:5px; margin-top:40px;'>"
			+ " 			<p style='font-size:12px;'> 			&emsp; 			"
			+ "<a href='https://twitter.com/BAYK_official/' style='text-decoration: none; color:white;'>Twitter</a> 			&emsp;"
			+ " 			<a href='https://www.facebook.com/BAYKofficial/' style='text-decoration: none; color:white;'>Facebook </a>"
			+ " 			&emsp; 			<a href='https://t.me/BAYKagriculture/' style='text-decoration: none; color:white;'>Telegram</a>"
			+ " 			&emsp; 			<a href='https://t.me/BAYKnews/' style='text-decoration: none; color:white;'>Announcement</a>"
			+ " 			&emsp; 			<a href='http://cointick.net' style='text-decoration: none; color:white;'>CoinTick</a>"
			+ " 			</p> 			<p style='margin-bottom:-5px; font-size:12px;'> 			&emsp; 			"
			+ "<!-- ///////////////////////////////////////////////////////////////////--> 			"
			+ "<a href='' style='text-decoration: none; color:grey;'>Unsbscribe</a> 			</p> 		"
			+ "</div> 		<!-- End Footer--> 	</div> 	<!-- End Container--> </body> </html>";

	return passwordResetSuccess;

}




	
}
