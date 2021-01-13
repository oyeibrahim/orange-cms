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

import dataBaseDAO.ReferralDAO;
import dataBaseDAO.SiteStructureDAO;
import dataBaseDAO.UsersDAO;
import dataBaseDAO.WalletsDAO;
import dataBaseDAO.WalletsHistoryDAO;
import dataBaseModel.Referral;
import dataBaseModel.SiteStructure;
import dataBaseModel.Users;
import dataBaseModel.WalletsHistory;
import utilities.MailDispatcher;
import utilities.MailTemplates;
import utilities.UtilityMethods;

/**
 * Servlet implementation class UserActivation
 */
@WebServlet("/activate")
public class UserActivation extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//get requests
		String Email= request.getParameter("email");
		String ActivationCode= request.getParameter("key");
		String Username= request.getParameter("username");
		
		//get date
		LocalDate unformattedDate = LocalDate.now(ZoneId.of("GMT"));
		LocalTime time = LocalTime.now(ZoneId.of("GMT"));

		DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		String date = unformattedDate.format(myFormatObj);

		String dateTime = "Date: " + date + " Time: " + time;
		
		//set to the Users Model class
		Users user = new Users();
		user.setEmail(Email);
		user.setActivationCode(ActivationCode);
		
		//set session
		HttpSession session = request.getSession();
		
		UsersDAO UserDAO = new UsersDAO();
		
		try {
			
			int result = UserDAO.updateActive(user);
			
			if(result > 0) {
				

				//**********create new wallet**********//
				WalletsDAO wallet = new WalletsDAO();
				
				Users u = UserDAO.getUserProfile(Username);
				
				wallet.addWallet(u);
				//**********End create new wallet**********//
				
				
				//**********create referral**********//
				ReferralDAO referral = new ReferralDAO();
				
				UtilityMethods um = new UtilityMethods();
				
				//get the this user's referral code
				
				String refCode;
				String tempCode = um.getRandomAlphaNumericString(7).toUpperCase();
				
				int codeStatus = referral.checkCode(tempCode);
				int tries = 0;
				
				while (codeStatus == 1 && tries <= 30000) {
					tempCode = um.getRandomAlphaNumericString(7).toUpperCase();
					
					codeStatus = referral.checkCode(tempCode);
					tries++;
				}
				
				refCode = tempCode;
				
				//get the referrer Username
				String referrerUsername;
				//get the temp data
				String crudeCode = u.getTemp_data();
				
				//if it doesn't contain none for referred_by
				if(!crudeCode.contains("ref_by:none")) {//set the referrer username and increment the referrers numbers
					int startIndex = crudeCode.indexOf("ref_by:") + 7;
					int endIndex = crudeCode.indexOf("-1-");
					String realCode = crudeCode.substring(startIndex, endIndex);
					
					referrerUsername = referral.getUsername(realCode);
					
					//remove from pending number
					referral.subtractPending(realCode);
					//increment referrer
					referral.addReferrals(realCode);
					
					//add bayk and ctk for the referrer
					
					//get amount from db
					SiteStructureDAO struc = new SiteStructureDAO();
					SiteStructure strucModel = new SiteStructure();
					strucModel = struc.getStructure("referral_token");
					
					//add
					wallet.addBAYK(referrerUsername, strucModel.getNum_value1());
					wallet.addCTK(referrerUsername, strucModel.getNum_value2());
					
					
				}else {//if none, just set an empty string
					referrerUsername = " ";
				}
				
				
				
				//get this user's id
				long userId = u.getId();
				
				//instantiate the model
				Referral refModel = new Referral();
				
				refModel.setCode(refCode);
				refModel.setReferred_by(referrerUsername);
				refModel.setUsername(Username);
				refModel.setReferral_user_id(userId);
				
				//execute
				referral.addNewReferral(refModel);
				
				//**********End create referral**********//
				
				
				//**********welcome token bonus**********//
				//add bayk and ctk for new registration
				
				//get amount from db
				SiteStructureDAO struc2 = new SiteStructureDAO();
				SiteStructure strucModel2 = new SiteStructure();
				strucModel2 = struc2.getStructure("welcome_token");
				
				//add
				wallet.addBAYK(Username, strucModel2.getNum_value1());
				wallet.addCTK(Username, strucModel2.getNum_value2());
				
				//add history
				WalletsHistoryDAO whDAO = new WalletsHistoryDAO();
				//add BAYK history
				WalletsHistory whBAYK = new WalletsHistory();
				whBAYK.setAmount(strucModel2.getNum_value1());
				whBAYK.setCoin("BAYK");
				whBAYK.setAction("Deposit");
				whBAYK.setDetails("BAYK bonus for registration");
				whBAYK.setStatus("completed");
				whBAYK.setDate_time(dateTime);
				whBAYK.setUsername(Username);
				whBAYK.setHistory_user_id(userId);
				
				whDAO.addWalletHistory(whBAYK);
				
				//add CTK history
				WalletsHistory whCTK = new WalletsHistory();
				whCTK.setAmount(strucModel2.getNum_value2());
				whCTK.setCoin("CTK");
				whCTK.setAction("Deposit");
				whCTK.setDetails("CTK bonus for registration");
				whCTK.setStatus("completed");
				whCTK.setDate_time(dateTime);
				whCTK.setUsername(Username);
				whCTK.setHistory_user_id(userId);
				
				whDAO.addWalletHistory(whCTK);
				//**********End welcome token bonus**********//
				
				
				//**********send mail in another thread**********//
				
				//get message to send
				MailTemplates template = new MailTemplates();
				/////////////////////////////////////DYNAMIC (Username)////////////////////////////////////////////////////
				String content = template.accountActivated(Username);
				//end
				
				
				//create the object and pass in the required parameters (to, subject, content)
				MailDispatcher mail = new MailDispatcher(Email, "Account Verified", content);

				//create new thread with MailDispatcher class object
				Thread mailThread = new Thread(mail);
				
				
				//start the thread
				mailThread.start();

				//**********End send mail**********//
				
				
				//**********change the activation code**********//
				//um has been initialised while creating referral code above
				String activationHash = um.getRandomAlphaNumericString(60);

				//to update activation code
				Users newUser = new Users();
				newUser.setEmail(Email);
				newUser.setActivationCode(activationHash);

				//update to new activation code
				UserDAO.updateActivationCode(newUser);

				//**********End change the activation code**********//
				
				
				//set session
				session.setAttribute("ActivationSuccessMessage", "Account activated successfully, please login below!");
				response.sendRedirect("LoginPage.jsp");
			} else if (result < 0) {
				
				//set session
				session.setAttribute("ActivationErrorMessage", "Account activation info provided is incorrect, please request a new activation email by trying to login");
				response.sendRedirect("LoginPage.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			//set session
			session.setAttribute("ActivationDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("LoginPage.jsp");
		}
		
	}

}
