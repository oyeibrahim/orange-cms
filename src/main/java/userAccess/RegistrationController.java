/*
 * Control site registration
 * 
 * @Author Oyetunji Ibrahim
 * 
 * @Date 04/12/2019
 */

package userAccess;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import dataBaseDAO.ReferralDAO;
import dataBaseDAO.UsersDAO;
import dataBaseModel.Users;
import utilities.MailDispatcher;
import utilities.MailTemplates;
import utilities.UtilityMethods;


@WebServlet("/RegistrationController")
public class RegistrationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get requests
		String Username= request.getParameter("username");
		String Email= request.getParameter("email");
		String Firstname= request.getParameter("firstname");
		String Lastname= request.getParameter("lastname");
		String Gender= request.getParameter("gender");
		String Country= request.getParameter("country");
		//this is plain text, encoded below
		String Password= request.getParameter("password");
		
		//set session
		HttpSession session = request.getSession();
		
		
		
		//check form validation
		if (Username.length() < 2 || Firstname.length() < 2 || Lastname.length() < 2) {
			//set session
			session.setAttribute("RegistrationErrorMessage", "Some fields too short, please input a longer value");
			response.sendRedirect("RegistrationPage.jsp");
			//to prevent moving forward after this
			return;
		}
		if (Password.length() < 7) {
			//set session
			session.setAttribute("RegistrationErrorMessage", "Password too short");
			response.sendRedirect("RegistrationPage.jsp");
			return;
		}
		if (Email.indexOf("@") == -1) {
			//set session
			session.setAttribute("RegistrationErrorMessage", "Invalid email, please check and enter your email again");
			response.sendRedirect("RegistrationPage.jsp");
			return;
		}
		if (Gender.length() < 3 || Country.length() < 3) {
			//set session
			session.setAttribute("RegistrationErrorMessage", "Invalid input for Gender or Country");
			response.sendRedirect("RegistrationPage.jsp");
			return;
		}
		
		//encode the password
		String hashedPassword = BCrypt.hashpw(Password, BCrypt.gensalt());
		
		//generate activation code
		UtilityMethods um = new UtilityMethods();
		String activationHash = um.getRandomAlphaNumericString(60);
		
		//set default profile picture
		String profilePicture = "/lib/profile-picture/default_user.png";
		
		
		//get date
		LocalDate unformattedDate = LocalDate.now(ZoneId.of("GMT"));
		LocalTime time = LocalTime.now(ZoneId.of("GMT"));
		
		DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		String date = unformattedDate.format(myFormatObj);
		
		String dateTime = "Date: " + date + " Time: " + time;
		
		//set to the Users Model class
		Users user = new Users();
		user.setUsername(Username);
		user.setEmail(Email);
		user.setFirstname(Firstname);
		user.setLastname(Lastname);
		user.setGender(Gender);
		user.setCountry(Country);
		//encoded password
		user.setPassword(hashedPassword);
		user.setJoined(dateTime);
		user.setActivationCode(activationHash);
		user.setProfilePicture(profilePicture);
		user.setPlatformTag("BAYK");
		user.setActive(0);
		
		//set temp data for referral code if exist
		String tempData;
		if (session.getAttribute("RefCode") != null) {
			String pre = "ref_by:";
			String post = "-1-";
			//full temp_data
			tempData = pre + session.getAttribute("RefCode").toString() + post;
			
			//set to Users Model
			user.setTemp_data(tempData);
			
			//update pending number for referrer
			ReferralDAO referral = new ReferralDAO();
			
			try {
				referral.addPending(session.getAttribute("RefCode").toString());
			}catch(Exception e) {}
			
			
		}//if no referral code, set to none
		else {
			user.setTemp_data("ref_by:none-1-");
		}

		
		
		try {//exception for UsersDAO class
			//database access
			UsersDAO UserDAO = new UsersDAO();
			//add the user and get return int of rows affected (added)
			int result = UserDAO.addUser(user);
			//if email exist
			if (result == UsersDAO.EMAIL_EXIST_NUM) {
				//System.out.println("-------------------------Caught Email------------------------");
				//set session
				session.setAttribute("EmailExistErrorMessage", "User already registered please login");
				response.sendRedirect("RegistrationPage.jsp");
			}
			//if username exist
			else if (result == UsersDAO.USERNAME_EXIST_NUM) {
				//System.out.println("-------------------------Caught Username------------------------");
				//set session
				session.setAttribute("UsernameExistErrorMessage", "Username taken, Please choose a new username");
				response.sendRedirect("RegistrationPage.jsp");
			}
			//if registration goes well
			else if (result > 0 && result < 1000) {//Registration successful
				
				
				//prepare the activation link
				String address = request.getRequestURL().toString();
				String pre = address.substring(0, address.indexOf("/RegistrationController"));
				
				String activationLink = pre + "/activate?email=" + Email + "&key=" + activationHash + "&username=" + Username;
				
				
				//**********send mail in another thread**********//
				
				//get message to send from templates class
				MailTemplates template = new MailTemplates();
				////////////////////////////////////////DYNAMIC (Username and activation link)/////////////////////////////////////////////////
				String content = template.accountActivation(Username, activationLink);
				//end

				//create the object and pass in the required parameters (to, subject, content)
				MailDispatcher mail = new MailDispatcher(Email, "Verify your email for BAYK", content);

				//create new thread with MailDispatcher class object
				Thread mailThread = new Thread(mail);
				
				//start the thread
				mailThread.start();

				//**********End send mail**********//
				
				
				//set session
				session.setAttribute("RegistrationSuccessMessage", "Registration Successful, an activation mail has been sent to your email address, please click the link provided to activate your account");
				response.sendRedirect("LoginPage.jsp");
			}

			
		} catch (Exception e) {//error in database access
			//e.printStackTrace();
			//set session
			session.setAttribute("RegistrationDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("RegistrationPage.jsp");
		}
		
	}//end post

}
