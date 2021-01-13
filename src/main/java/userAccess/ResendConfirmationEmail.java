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
 * Servlet implementation class ResendConfirmationEmail
 */
@WebServlet("/resend-confirmation-email")
public class ResendConfirmationEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String email = request.getParameter("email");
		String username = request.getParameter("username");
		
		//generate new activation code
		UtilityMethods um = new UtilityMethods();
		String activationHash = um.getRandomAlphaNumericString(60);
		
		//to update activation code
		Users newUser = new Users();
		newUser.setEmail(email);
		newUser.setActivationCode(activationHash);
		
		//set session
		HttpSession session = request.getSession();
		
		UsersDAO user = new UsersDAO();
		
		try {
			//first chance the activation code
			int result = user.updateActivationCode(newUser);
			
			if(result > 0) {
				//then prepare activation link
				Users u = user.getUserEmailResend(email);
	
				String address = request.getRequestURL().toString();
				String pre = address.substring(0, address.indexOf("/resend-confirmation-email"));
				
				String activationLink = pre + "/activate?email=" + email + "&key=" + u.getActivationCode() + "&username=" + username;
				
				
				//**********send mail in another thread**********//
				
				//get message to send
				MailTemplates template = new MailTemplates();
				///////////////////////////////////DYNAMIC (Username and activation link)//////////////////////////////////////////////////////
				String content = template.accountActivation(u.getUsername(), activationLink);
				//end
				
				
				//create the object and pass in the required parameters (to, subject, content)
				MailDispatcher mail = new MailDispatcher(email, "Verify your email for BAYK", content);

				//create new thread with MailDispatcher class object
				Thread mailThread = new Thread(mail);
				
				//start the thread
				mailThread.start();

				//**********End send mail**********//
				
				
				//set session
				session.setAttribute("MessageSent", "Sent successfully, please check your email and click the activation link to activate your account");
				response.sendRedirect("LoginPage.jsp");
			}
		} catch (Exception e) {
			//e.printStackTrace();
			//set session
			session.setAttribute("ActivationDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("LoginPage.jsp");
		}
		
		
	}
}
