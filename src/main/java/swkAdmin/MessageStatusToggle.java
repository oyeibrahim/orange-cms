package swkAdmin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataBaseDAO.ContactMessagesDAO;
import dataBaseModel.ContactMessages;

/**
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/MessageStatusToggle")
public class MessageStatusToggle extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		String redirect = "";
		if(session.getAttribute("redirect") != null) {
			redirect = session.getAttribute("redirect").toString();
		}else {
			redirect = "/swk-admin/contact-messages/1/";
		}
		
		
		//get requests and add to model
		ContactMessages cm = new ContactMessages();
		cm.setId(Long.parseLong(request.getParameter("id")));
		
		
		if(request.getParameter("task").equals("MarkUnread")) {
			cm.setSeen_status("Unseen");
		}else {
			cm.setSeen_status("Seen");
		}
		
		
		ContactMessagesDAO cmDAO = new ContactMessagesDAO();
		
		
		try {
			int result = cmDAO.updateMessageSeenStatus(cm);

			if(result > 0) {//if successful

				//set session
				//session.setAttribute("ProfileUpdatedMessage", "Post updated successfully");
				session.removeAttribute("redirect");
				response.sendRedirect(redirect);

			}else {//if fail

				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error updating the status");
				response.sendRedirect(redirect);

			}
		} catch (Exception e) {
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect(redirect);
		}
		
	}

}
