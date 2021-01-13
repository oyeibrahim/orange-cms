package userAccess;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import dataBaseDAO.UsersDAO;
import dataBaseModel.Users;
import utilities.MailDispatcher;
import utilities.MailTemplates;
import utilities.UtilityMethods;

/**
 * Servlet implementation class PasswordReset
 */
@WebServlet("/PasswordReset")
public class PasswordReset extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//set session
		HttpSession session = request.getSession();
		
		String password = request.getParameter("password");
		
		//check form validation
		if (password.length() < 7) {
			//set session
			session.setAttribute("ActivationErrorMessage", "Error updating your password : Password too short");
			response.sendRedirect("LoginPage.jsp");
			//to prevent moving forward after this
			return;
		}
		
		//encode the password
		String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

		
		
		//get if user have permission by checking the session for values already set in PasswordResetReceiver
		if (session.getAttribute("email") == null || session.getAttribute("activationCode") == null || session.getAttribute("username") == null) {
			//set session
			session.setAttribute("NoPasswordResetPermissionMessage", "You don't have permission to reset the password, please click Forgot Password below to reset your password");
			response.sendRedirect("LoginPage.jsp");
		}else {
			String email = session.getAttribute("email").toString(); 
			String activationcode = session.getAttribute("activationCode").toString();
			String username = session.getAttribute("username").toString();

			Users user = new Users();
			user.setEmail(email);
			user.setActivationCode(activationcode);
			user.setPassword(hashedPassword);

			UsersDAO UserDAO = new UsersDAO();

			try {

				int result = UserDAO.updatePassword(user);
				if(result > 0) {
					
					//**********send mail in another thread**********//
					
					//get message to send from templates class
					MailTemplates template = new MailTemplates();
					//////////////////////////////////////////DYNAMIC (Username)///////////////////////////////////////////////
					String content = template.resetPasswordSuccess(username);
					//end
					
					//create the object and pass in the required parameters (to, subject, content)
					MailDispatcher mail = new MailDispatcher(email, "Password Updated", content);
					
					//create new thread with MailDispatcher class object
					Thread mailThread = new Thread(mail);
					
					//start the thread
					mailThread.start();
					
					//**********End send mail**********//
					
					
					//**********change the activation code**********//
					UtilityMethods um = new UtilityMethods();
					String activationHash = um.getRandomAlphaNumericString(60);

					//to update activation code
					Users newUser = new Users();
					newUser.setEmail(email);
					newUser.setActivationCode(activationHash);

					//update to new activation code
					UserDAO.updateActivationCode(newUser);
					
					//**********End change the activation code**********//

					//set session
					session.setAttribute("ActivationSuccessMessage", "Password changed successfully, please login below!");
					response.sendRedirect("LoginPage.jsp");
				} else if (result < 0) {

					//set session
					session.setAttribute("ActivationErrorMessage", "Password reset info provided is incorrect, please request a new email");
					response.sendRedirect("LoginPage.jsp");
				}
			} catch (Exception e) {
				//e.printStackTrace();
				session.setAttribute("ActivationDatabaseErrorMessage", "An error occurred... Please try again!!!");
				response.sendRedirect("LoginPage.jsp");
			}
		}
	}

}
