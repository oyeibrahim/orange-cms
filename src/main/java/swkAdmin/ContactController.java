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

import dataBaseDAO.ContactMessagesDAO;
import dataBaseModel.ContactMessages;

/**
 * Servlet implementation class CommentController
 */
@WebServlet("/ContactController")
public class ContactController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		
		ContactMessagesDAO cmDAO = new ContactMessagesDAO();
		ContactMessages cm = new ContactMessages();
		
		//confirm the user filled all fields
		if(request.getParameter("name") == null || request.getParameter("email") == null || 
				request.getParameter("purpose") == null || request.getParameter("title") == null ||
				request.getParameter("message") == null) {
			//set session
			session.setAttribute("ProfileUpdateErrorMessage", "All fields must be filled");
			response.sendRedirect("ContactUs.jsp");
		}
		
		//set parameters
		cm.setName(request.getParameter("name"));
		cm.setEmail(request.getParameter("email"));
		cm.setPurpose(request.getParameter("purpose"));
		cm.setTitle(request.getParameter("title"));
		cm.setMessage(request.getParameter("message"));
		cm.setSeen_status("Unread");
		
		//get date
		LocalDate unformattedDate = LocalDate.now(ZoneId.of("GMT"));
		LocalTime time = LocalTime.now(ZoneId.of("GMT"));
				
		DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		String date = unformattedDate.format(myFormatObj);
				
		String dateTime = "Date: " + date + " Time: " + time;
		
		//set date time
		cm.setDate_time(dateTime);
		
		try {
			
					
			
			//add to db
			int result = cmDAO.addContactMessage(cm);
			
			
			if(result>0) {
				
				

				session.setAttribute("ProfileUpdatedMessage", "Your Message was received, thanks for contacting us");
				response.sendRedirect("ContactUs.jsp");
				
				
			}else {
				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error submitting your message");
				response.sendRedirect("ContactUs.jsp");
			}
			
			
			
			
		} catch (Exception e) {
			//e.printStackTrace();
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("ContactUs.jsp");
		}
		
		
	}
		

}
