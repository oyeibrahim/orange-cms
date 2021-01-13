/*
 * Control logging in
 * 
 * @Author Oyetunji Ibrahim
 * 
 * @Date 04/12/2019
 */

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

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//get requests
		String Email= request.getParameter("email");
		String Password= request.getParameter("password");
		
		//set to the Users Model class
		Users user = new Users();
		user.setEmail(Email);
		user.setPassword(Password);
		
		//set session
		HttpSession session = request.getSession();
		
		try {//exception for UsersDAO class
			//database access
			UsersDAO Users = new UsersDAO();
			Users u = Users.getSecureUser(user);

			//if database return an object
			//i.e username returned by db is not null and is equal to this username
			//also case sensitive so "Adeyemi" is different from "adeyemi"
			//also check if account activated
			if (u.getEmail() != null && u.getEmail().toString().equals(Email) && u.getActive() != 0) {
								
				String username = u.getUsername();

				//set sessions
				session.setAttribute("Username", username);
				session.setAttribute("Firstname", u.getFirstname());
				session.setAttribute("Email", u.getEmail());
				session.setAttribute("LoginSuccessMessage", "Login Successful!");
				
				//redirect to profile
				//concatenate the username to form the link
				response.sendRedirect("profile/" + username);

			}//if user is not activated
			else if(u.getEmail() != null && u.getEmail().toString().equals(Email) && u.getActive() == 0) {
					
				
				//get resend confirmation address
				String address = request.getRequestURL().toString();
				String pre = address.substring(0, address.indexOf("/LoginController"));
				String link = pre + "/resend-confirmation-email?email=" + u.getEmail() + "&username=" + u.getUsername();
				//set session
				session.setAttribute("AccountUnconfirmed", "Your account hasn't been confirmed, please click the confirmation link in the email sent to you. To resend the account confirmation email <a href='" + link + "'>CLICK HERE</a>");
				response.sendRedirect("LoginPage.jsp");

			}else {//login not successful

				//set session
				session.setAttribute("LoginErrorMessage", "Invalid Email or Password!!!");
				response.sendRedirect("LoginPage.jsp");

			}
		} catch (Exception e) {//error in database access
			//e.printStackTrace();
			//set session
			session.setAttribute("LoginDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("LoginPage.jsp");
		}

	}//end post
		
	

}
