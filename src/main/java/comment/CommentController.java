package comment;

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

import dataBaseDAO.CommentsDAO;
import dataBaseDAO.UsersDAO;
import dataBaseModel.Comments;

/**
 * Servlet implementation class CommentController
 */
@WebServlet("/CommentController")
public class CommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		//get redirect link
		String link = session.getAttribute("PostLink").toString();
		
		CommentsDAO comDAO = new CommentsDAO();
		Comments comment = new Comments();
		
		UsersDAO userDAO = new UsersDAO();
		
		//if posting as anonymous
		//check that the name and email is filled
		if(session.getAttribute("Username") == null ||
		   		session.getAttribute("Firstname") == null ||
		   		session.getAttribute("Email") == null) {
			if(request.getParameter("name") == null || request.getParameter("email") == null) {
				//return error if not filled
				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "Name and Email must be filled");
				response.sendRedirect("/post/");
				return;
			}else {//if filled, set parameters, default status is Pending for anonymous comment
				//set name and email as username
				comment.setUsername("Name: " + request.getParameter("name") + " Email: " + request.getParameter("email"));
				
				comment.setStatus("Pending");
				
				//the id will be zero if anonymous comment
				comment.setComments_users_id(0);
			}
		}
		
		//set the body
		comment.setBody(request.getParameter("comment"));
		//set post id
		comment.setComments_posts_id(Long.parseLong(session.getAttribute("PostID").toString()));
		
		//get date
		LocalDate unformattedDate = LocalDate.now(ZoneId.of("GMT"));
		LocalTime time = LocalTime.now(ZoneId.of("GMT"));
				
		DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		String date = unformattedDate.format(myFormatObj);
				
		String dateTime = "Date: " + date + " Time: " + time;
		
		//set date time
		comment.setDate_time(dateTime);
		
		try {
			
			//to set status for logged in user 
			//it will be pending if user doesn't have an existing published comment else it will be published directly
			//first check to be sure user is logged in
			if(session.getAttribute("Username") != null ||
			   		session.getAttribute("Firstname") != null ||
			   		session.getAttribute("Email") != null) {
				
				//set username
				comment.setUsername(session.getAttribute("Username").toString());
				//set id to the logged in user's id
				comment.setComments_users_id(userDAO.getId(session.getAttribute("Username").toString()));
				
				//check if user have an existing published comment
				if(comDAO.checkUserPublishedComment(userDAO.getId(session.getAttribute("Username").toString()))) {
					comment.setStatus("Published");
				}else {
					comment.setStatus("Pending");
				}
				
			}
			
			
			
			//add to db
			int result = comDAO.addComment(comment);
			
			
			if(result>0) {
				
				//remove session
				if(session.getAttribute("PostID") != null) {
					session.removeAttribute("PostID");
				}
				if(session.getAttribute("PostLink") != null) {
					session.removeAttribute("PostLink");
				}
				
				//set session //tell the user if comment pending
				if(comment.getStatus().equals("Pending")) {
					session.setAttribute("ProfileUpdatedMessage", "Your comment was submitted successfully but is currently pending "
							+ "approval, it will be published as soon as it is approved");
				}else {
					session.setAttribute("ProfileUpdatedMessage", "Your comment was submitted successfully and published");
				}
				
				response.sendRedirect("post/" + link);
				
				
			}else {
				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error submitting the comment");
				response.sendRedirect("post/" + link);
			}
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("post/" + link);
		}
		
		
	}
		

}
