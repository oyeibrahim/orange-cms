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
 * Servlet implementation class PasswordResetReceiver
 */
@WebServlet("/password-reset-receiver")
public class PasswordResetReceiver extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//get requests
		String Email= request.getParameter("email");
		String ActivationCode= request.getParameter("key");
		String Username= request.getParameter("username");

		//set to the Users Model class
		Users user = new Users();
		user.setEmail(Email);
		user.setActivationCode(ActivationCode);
		user.setUsername(Username);

		//set session
		HttpSession session = request.getSession();

		UsersDAO UserDAO = new UsersDAO();

		try {

			boolean result = UserDAO.checkUserWithCode(user);

			if(result) {

				
				//set session
				session.setAttribute("SetPasswordMessage", "Set your new password below!");
				
				session.setAttribute("email", Email);
				session.setAttribute("activationCode", ActivationCode);
				session.setAttribute("username", Username);
				
				response.sendRedirect("PasswordReset.jsp");
			} else if (!result) {

				//set session
				session.setAttribute("ActivationErrorMessage", "Password Reset info provided is incorrect, please request a new email");
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
