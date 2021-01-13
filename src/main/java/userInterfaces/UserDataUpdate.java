package userInterfaces;

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
 * Servlet implementation class ProfileImageUpload
 */
@WebServlet("/UserDataUpdate")
public class UserDataUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//set session
		HttpSession session = request.getSession();
		
		//get username from session
		String username = session.getAttribute("Username").toString();
		
		//get requests
		String about= request.getParameter("about");
		
		//check form validation
		if (about.length() < 2) {
			//set session
			session.setAttribute("ProfileUpdateErrorMessage", "Can't update profile : text too short !!!");
			response.sendRedirect("Settings.jsp");
			//to prevent moving forward after this
			return;
		}
		if (about.length() > 200) {
			//set session
			session.setAttribute("ProfileUpdateErrorMessage", "Text too long, maximum allowed is 200 !!!");
			response.sendRedirect("Settings.jsp");
			//to prevent moving forward after this
			return;
		}
		
		Users userModel = new Users();
		
		userModel.setUsername(username);
		userModel.setAbout(about);
		
		UsersDAO user = new UsersDAO();
		
		try {
			//execute the update
			int result = user.updateUserData(userModel);
			
			if(result > 0) {//if successful
				
				//set session
				session.setAttribute("ProfileUpdatedMessage", "Profile updated successfully");
				response.sendRedirect("profile/" + username);
				
			}else {//if fail
				
				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error updating your profile");
				response.sendRedirect("Settings.jsp");
				
			}
		} 
		catch (Exception e) {//database error
			//e.printStackTrace();

			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("Settings.jsp");
		}
		
		
	}

}
