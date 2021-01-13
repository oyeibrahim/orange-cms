package userInterfaces;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ProfileImageUpload
 */
@WebServlet("/KYCupdate")
public class KYCupdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		//NOT AVAILABLE FOR NOW
		if (true) {
			//set session
			session.setAttribute("ProfileUpdateErrorMessage", "This feature is now available for now");
			response.sendRedirect("Identity.jsp");
			//to prevent moving forward after this
			return;
		}
		
		
		
//		//get username from session
//		String username = session.getAttribute("Username").toString();
//		
//		//get requests
//		//String gender= request.getParameter("gender");
//		//String country= request.getParameter("country");
//		String dateOfBirth= request.getParameter("date_of_birth");
//		//String about= request.getParameter("about");
//		
//		//check form validation
//		if (dateOfBirth.length() < 4) {
//			//set session
//			session.setAttribute("ProfileUpdateErrorMessage", "Some fields too short, please input a longer value");
//			response.sendRedirect("Settings.jsp");
//		}
//		
//		Users userModel = new Users();
//		
//		userModel.setUsername(username);
//		//userModel.setGender(gender);
//		//userModel.setCountry(country);
//		userModel.setBirth(dateOfBirth);
//		//userModel.setAbout(about);
//		
//		UsersDAO user = new UsersDAO();
//		
//		try {
//			//execute the update
//			int result = user.updateUserData(userModel);
//			
//			if(result > 0) {//if successful
//				
//				//set session
//				session.setAttribute("ProfileUpdatedMessage", "Profile updated successfully");
//				response.sendRedirect("profile/" + username);
//				
//			}else {//if fail
//				
//				//set session
//				session.setAttribute("ProfileUpdateErrorMessage", "There was an error updating your profile");
//				response.sendRedirect("Settings.jsp");
//				
//			}
//		} 
//		catch (Exception e) {//database error
//			//e.printStackTrace();
//
//			//set session
//			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
//			response.sendRedirect("Settings.jsp");
//		}
		
		
	}

}
