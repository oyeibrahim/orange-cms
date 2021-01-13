package swkAdmin;

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

import dataBaseDAO.UsersDAO;
import dataBaseDAO.WalletsDAO;
import dataBaseDAO.WalletsHistoryDAO;
import dataBaseModel.WalletsHistory;

/**
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/UserWalletEditAdmin")
public class UserWalletEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		//get requests
		double Amount= Double.parseDouble(request.getParameter("amount"));
		String CoinTemp= request.getParameter("coin");
		String Coin = CoinTemp.substring(CoinTemp.indexOf("(")+1, CoinTemp.indexOf(")"));
		String Status= request.getParameter("status");
		String Action= request.getParameter("action");
		String Details= request.getParameter("details");
		String Operation = request.getParameter("operation");
		
		//get id
		long id = Long.parseLong(session.getAttribute("editingUserID").toString());
		
		//get date
		LocalDate unformattedDate = LocalDate.now(ZoneId.of("GMT"));
		LocalTime time = LocalTime.now(ZoneId.of("GMT"));

		DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		String date = unformattedDate.format(myFormatObj);

		String dateTime = "Date: " + date + " Time: " + time;
		
		String Username = "";
		
		//database access
		UsersDAO UserDAO = new UsersDAO();
		WalletsDAO WalletsDAO = new WalletsDAO();
		WalletsHistoryDAO WalletsHistoryDAO = new WalletsHistoryDAO();
		
		
		//add the user and get return int of rows affected (added)
		try {
			
			//get username from id
			Username = UserDAO.getUsername(id);
			
			//history
			WalletsHistory wh = new WalletsHistory();
			wh.setAction(Action);
			wh.setAmount(Amount);
			wh.setCoin(Coin);
			wh.setDate_time(dateTime);
			wh.setDetails(Details);
			wh.setHistory_user_id(id);
			wh.setStatus(Status);
			wh.setUsername(Username);
			
			int result1 = 0;
			int result2 = 0;
			
			if (Coin.equals("BAYK") && Operation.equals("ADD")) {
				//add
				result1 = WalletsDAO.addBAYK(Username, Amount);
				//set history
				result2 = WalletsHistoryDAO.addWalletHistory(wh);
			}
			if (Coin.equals("BAYK") && Operation.equals("SUBTRACT")) {
				//add
				result1 = WalletsDAO.subtractBAYK(Username, Amount);
				//set history
				result2 = WalletsHistoryDAO.addWalletHistory(wh);
			}
			if (Coin.equals("BAYK_HOLD") && Operation.equals("ADD")) {
				//add
				result1 = WalletsDAO.addBaykHold(Username, Amount);
				//no history needed for hold
				//result2 = WalletsHistoryDAO.addWalletHistory(wh);
				result2 = 1;
			}
			if (Coin.equals("BAYK_HOLD") && Operation.equals("SUBTRACT")) {
				//add
				result1 = WalletsDAO.subtractBaykHold(Username, Amount);
				//no history needed for hold
				//result2 = WalletsHistoryDAO.addWalletHistory(wh);
				result2 = 1;
			}
			
			
			
			
			if (Coin.equals("CTK") && Operation.equals("ADD")) {
				//add
				result1 = WalletsDAO.addCTK(Username, Amount);
				//set history
				result2 = WalletsHistoryDAO.addWalletHistory(wh);
			}
			if (Coin.equals("CTK") && Operation.equals("SUBTRACT")) {
				//add
				result1 = WalletsDAO.subtractCTK(Username, Amount);
				//set history
				result2 = WalletsHistoryDAO.addWalletHistory(wh);
			}
			if (Coin.equals("CTK_HOLD") && Operation.equals("ADD")) {
				//add
				result1 = WalletsDAO.addCtkHold(Username, Amount);
				//no history needed for hold
				//result2 = WalletsHistoryDAO.addWalletHistory(wh);
				result2 = 1;
			}
			if (Coin.equals("CTK_HOLD") && Operation.equals("SUBTRACT")) {
				//add
				result1 = WalletsDAO.subtractCtkHold(Username, Amount);
				//no history needed for hold
				//result2 = WalletsHistoryDAO.addWalletHistory(wh);
				result2 = 1;
			}
			
			
			
			
			
			

			if(result1 > 0 && result2 > 0) {//if successful

				//set session
				session.setAttribute("ProfileUpdatedMessage", "Wallet updated successfully");
				session.removeAttribute("editingUserID");
				response.sendRedirect("swk-admin/user-edit?u=" + Username);

			}else {//if fail

				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error updating the Wallet");
				response.sendRedirect("swk-admin/user-edit?u=" + Username);

			}
		} catch (Exception e) {
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("swk-admin/user-edit?u=" + Username);
		}
		
	}

}
