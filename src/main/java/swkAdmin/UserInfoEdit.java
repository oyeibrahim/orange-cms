package swkAdmin;

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
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/UserInfoEditAdmin")
public class UserInfoEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		//get requests
		String Username= request.getParameter("username");
		String Firstname= request.getParameter("firstname");
		String Lastname= request.getParameter("lastname");
		String Gender= request.getParameter("gender");
		String Country= request.getParameter("country");
		String Genesis= request.getParameter("genesis");
		String Picture= request.getParameter("picturelocation");
		String ActivationCode= request.getParameter("activationcode");
		String Activated= request.getParameter("activated");
		String PlatformLevel= request.getParameter("level");
		
		//set to the Users Model class
		Users user = new Users();
		user.setId(Long.parseLong(session.getAttribute("editingUserID").toString()));
		user.setUsername(Username);
		user.setFirstname(Firstname);
		user.setLastname(Lastname);
		user.setGender(Gender);
		user.setCountry(Country);
		user.setPlatformTag(Genesis);
		user.setProfilePicture(Picture);
		user.setActivationCode(ActivationCode);
		if(Activated.equals("YES")) {
			user.setActive(1);
		}else {
			user.setActive(0);
		}
		user.setTag(PlatformLevel);
		
		
		
		//database access
		UsersDAO UserDAO = new UsersDAO();
		//add the user and get return int of rows affected (added)
		try {
			int result = UserDAO.updateUserDataAdmin(user);

			if(result > 0) {//if successful

				//set session
				session.setAttribute("ProfileUpdatedMessage", "User updated successfully");
				session.removeAttribute("editingUserID");
				response.sendRedirect("swk-admin/user-edit?u=" + Username);

			}else {//if fail

				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error updating the user data");
				response.sendRedirect("swk-admin/user-edit?u=" + Username);

			}
		} catch (Exception e) {
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("swk-admin/user-edit?u=" + Username);
		}
		
	}

}
