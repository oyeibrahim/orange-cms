package userAccess;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataBaseDAO.UsersDAO;
import dataBaseModel.Users;
import utilities.MailDispatcher;
import utilities.MailTemplates;
import utilities.UtilityMethods;

/**
 * Servlet implementation class PasswordResetRequestController
 */
@WebServlet("/PasswordResetRequestController")
public class PasswordResetRequestController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String email = request.getParameter("email");
		
		//set session
		HttpSession session = request.getSession();
		

		//generate new activation code
		UtilityMethods um = new UtilityMethods();
		String activationHash = um.getRandomAlphaNumericString(60);

		//to update activation code
		Users newUser = new Users();
		newUser.setEmail(email);
		newUser.setActivationCode(activationHash);

		

		UsersDAO user = new UsersDAO();

		try {

			Users u = user.getUserEmail(newUser.getEmail());
			if(u.getEmail() == null && u.getUsername() == null) {
				//set session
				session.setAttribute("NoPasswordResetPermissionMessage", "No user was found with the email you provided, please register!");
				response.sendRedirect("RegistrationPage.jsp");
			}else {

				//first change the activation code
				int result = user.updateActivationCode(newUser);

				if(result > 0) {
					//then prepare the password reset link
					Users us = user.getUserPasswordReset(email);

					String address = request.getRequestURL().toString();
					String pre = address.substring(0, address.indexOf("/PasswordResetRequestController"));

					String activationLink = pre + "/password-reset-receiver?email=" + email + "&key=" + us.getActivationCode() + "&username=" + us.getUsername();

					
					//**********send mail in another thread**********//
					
					//get message to send from templates class
					MailTemplates template = new MailTemplates();
					////////////////////////////////////////DYNAMIC (Username and Activation link)/////////////////////////////////////////////////
					String content = template.resetPasswordRequest(us.getUsername(), activationLink);
					//end
					
					
					//create the object and pass in the required parameters (to, subject, content)
					MailDispatcher mail = new MailDispatcher(email, "Password Reset", content);

					//create new thread with MailDispatcher class object
					Thread mailThread = new Thread(mail);
					
					//start the thread
					mailThread.start();

					//**********End send mail**********//
					
					
					//set session
					session.setAttribute("MessageSent", "Sent successfully, please check your email for the next step");
					response.sendRedirect("LoginPage.jsp");
				}
			}
		} catch (Exception e) {
			//e.printStackTrace();
			//set session
			session.setAttribute("ActivationDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("LoginPage.jsp");
		}

	}

}
