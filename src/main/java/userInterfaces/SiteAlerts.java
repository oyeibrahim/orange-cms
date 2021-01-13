package userInterfaces;

import java.io.IOException;
//import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SiteAlerts  extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	public String showAlert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		//add boostrap design for different state
		String warningPre = "<div class='alert alert-warning alert-dismissible fade show' role='alert'>";
		
		String successPre = "<div class='alert alert-success alert-dismissible fade show' role='alert'>";

		String dangerPre = "<div class='alert alert-danger alert-dismissible fade show' role='alert'>";

		String infoPre = "<div class='alert alert-info alert-dismissible fade show' role='alert'>";
		
		String post = "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>" + 
				"    <span aria-hidden='true'>&times;</span>" + 
				"  </button>" + 
				"</div>";
		
		
		//check the session for the message
		//set in LoginController
		if (session.getAttribute("LoginErrorMessage") != null){
			//store the message in a string so it can be returned after invalidating the session
			String message =session.getAttribute("LoginErrorMessage").toString();
			//invalidate session
			session.removeAttribute("LoginErrorMessage");
			//return the message
			return warningPre + message + post;
		}
		
		//set in LoginController
		else if (session.getAttribute("LoginDatabaseErrorMessage") != null){
			String message =session.getAttribute("LoginDatabaseErrorMessage").toString();
			session.removeAttribute("LoginDatabaseErrorMessage");
			return dangerPre + message + post;
		}
		
		//set in profile
		else if (session.getAttribute("UserNotFound") != null){
			String message = session.getAttribute("UserNotFound").toString();
			session.removeAttribute("UserNotFound");
			return infoPre + message + post;
		}
		
		//set in LoginController
//		else if (session.getAttribute("LoginSuccessMessage") != null){
//			String message = session.getAttribute("LoginSuccessMessage").toString();
//			//remove the session attribute
//			session.removeAttribute("LoginSuccessMessage");
//			return successPre + message + post;
//			}
		
		//set in RegistrationController
		else if (session.getAttribute("EmailExistErrorMessage") != null){
			String message = session.getAttribute("EmailExistErrorMessage").toString();
			session.removeAttribute("EmailExistErrorMessage");
			return warningPre + message + post;
		}
		
		//set in RegistrationController
		else if (session.getAttribute("UsernameExistErrorMessage") != null){
			String message = session.getAttribute("UsernameExistErrorMessage").toString();
			session.removeAttribute("UsernameExistErrorMessage");
			return warningPre + message + post;
		}
		
		//set in RegistrationController
		else if (session.getAttribute("RegistrationDatabaseErrorMessage") != null){
			String message = session.getAttribute("RegistrationDatabaseErrorMessage").toString();
			session.removeAttribute("RegistrationDatabaseErrorMessage");
			return dangerPre + message + post;
		}
		
		//set in RegistrationController
		else if (session.getAttribute("RegistrationSuccessMessage") != null){
			String message = session.getAttribute("RegistrationSuccessMessage").toString();
			session.removeAttribute("RegistrationSuccessMessage");
			return successPre + message + post;
		}
		
		//set in PasswordReset & activate
		else if (session.getAttribute("ActivationSuccessMessage") != null){
			String message = session.getAttribute("ActivationSuccessMessage").toString();
			session.removeAttribute("ActivationSuccessMessage");
			return successPre + message + post;
		}
		
		//set in PasswordReset & password-reset-receiver & activate
		else if (session.getAttribute("ActivationErrorMessage") != null){
			String message = session.getAttribute("ActivationErrorMessage").toString();
			session.removeAttribute("ActivationErrorMessage");
			return warningPre + message + post;
		}
		
		//set in PasswordReset & password-reset-receiver & PasswordResetRequestController & resend-confirmation-email & activate
		else if (session.getAttribute("ActivationDatabaseErrorMessage") != null){
			String message = session.getAttribute("ActivationDatabaseErrorMessage").toString();
			session.removeAttribute("ActivationDatabaseErrorMessage");
			return dangerPre + message + post;
		}
		
		//set in LoginController
		else if (session.getAttribute("AccountUnconfirmed") != null){
			String message = session.getAttribute("AccountUnconfirmed").toString();
			session.removeAttribute("AccountUnconfirmed");
			return warningPre + message + post;
		}
		
		//set in PasswordResetRequestController & resend-confirmation-email
		else if (session.getAttribute("MessageSent") != null){
			String message = session.getAttribute("MessageSent").toString();
			session.removeAttribute("MessageSent");
			return successPre + message + post;
		}
		
		//set in password-reset-receiver
		else if (session.getAttribute("SetPasswordMessage") != null){
			String message = session.getAttribute("SetPasswordMessage").toString();
			session.removeAttribute("SetPasswordMessage");
			return infoPre + message + post;
		}
		
		//set in PasswordResetRequestController
		else if (session.getAttribute("NoPasswordResetPermissionMessage") != null){
			String message = session.getAttribute("NoPasswordResetPermissionMessage").toString();
			session.removeAttribute("NoPasswordResetPermissionMessage");
			return warningPre + message + post;
		}
		
		//set in ProfileImageUpload & UserDataUpdate
		else if (session.getAttribute("ProfileUpdatedMessage") != null){
			String message = session.getAttribute("ProfileUpdatedMessage").toString();
			session.removeAttribute("ProfileUpdatedMessage");
			return successPre + message + post;
		}
		
		//set in ProfileImageUpload & UserDataUpdate
		else if (session.getAttribute("ProfileUpdateErrorMessage") != null){
			String message = session.getAttribute("ProfileUpdateErrorMessage").toString();
			session.removeAttribute("ProfileUpdateErrorMessage");
			return warningPre + message + post;
		}
		
		//set in ProfileImageUpload & UserDataUpdate
		else if (session.getAttribute("ProfileUpdateDatabaseErrorMessage") != null){
			String message = session.getAttribute("ProfileUpdateDatabaseErrorMessage").toString();
			session.removeAttribute("ProfileUpdateDatabaseErrorMessage");
			return dangerPre + message + post;
		}
		
		//set in RegistrationController
		else if (session.getAttribute("RegistrationErrorMessage") != null){
			String message = session.getAttribute("RegistrationErrorMessage").toString();
			session.removeAttribute("RegistrationErrorMessage");
			return warningPre + message + post;
		}
		
		
		//outside return
		return null;
		
	}
}
