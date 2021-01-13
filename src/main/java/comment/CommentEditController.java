package comment;

import java.io.IOException;
import java.io.PrintWriter;

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
@WebServlet("/CommentEditController")
public class CommentEditController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		//get redirect link
		String Redirectlink = session.getAttribute("redirectLink").toString();
		
		
		CommentsDAO comDAO = new CommentsDAO();
		Comments comment = new Comments();
		UsersDAO usDAO = new UsersDAO();
		
		
		
		
		try {
			
			long commentId = Long.parseLong(session.getAttribute("commentID").toString());
			long userId = usDAO.getId(session.getAttribute("Username").toString());
			
			//must be the owner of the post or an admin //the next if statements are just to check this
			if(!comDAO.checkUserOwnComment(commentId, userId) && !usDAO.checkAdmin(userId, session.getAttribute("Username").toString())) {
				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "You don't have permission to edit the comment");
				response.sendRedirect(Redirectlink);
				return;
			}
			
			if(!comDAO.checkUserOwnComment(commentId, userId)) {
				if(!usDAO.checkAdmin(userId, session.getAttribute("Username").toString())) {
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "You don't have permission to edit the comment");
					response.sendRedirect(Redirectlink);
					return;
				}
				
			}
			
			if(!usDAO.checkAdmin(userId, session.getAttribute("Username").toString())) {
				if(!comDAO.checkUserOwnComment(commentId, userId)) {
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "You don't have permission to edit the comment");
					response.sendRedirect(Redirectlink);
					return;
				}
				
			}
			
			
			
			//set the body
			comment.setBody(request.getParameter("commentUpdate"));
			//set comment id
			comment.setId(commentId);
			
			//add to db
			int result = comDAO.updateComment(comment);
			
			
			if(result>0) {
				
				//remove session
				if(session.getAttribute("PostID") != null) {
					session.removeAttribute("PostID");
				}
				if(session.getAttribute("PostLink") != null) {
					session.removeAttribute("PostLink");
				}
				if(session.getAttribute("redirectLink") != null) {
					session.removeAttribute("redirectLink");
				}
				
				//set session
				session.setAttribute("ProfileUpdatedMessage", "Your edit was successful");
				
				response.sendRedirect(Redirectlink);
				
				
			}else {
				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error editing the comment");
				response.sendRedirect(Redirectlink);
			}
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect(Redirectlink);
		}
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("query").equals("commentReq")) {
			CommentsDAO comDAO = new CommentsDAO();
			
			//set session
			HttpSession session = request.getSession();
			session.setAttribute("commentID", request.getParameter("id"));
			
			try {
				
				Comments comment = comDAO.getComment(request.getParameter("id"));
				
				PrintWriter out = response.getWriter();
				
				out.println(comment.getBody());
				
				
			} catch (Exception e) {
				//e.printStackTrace();
			}
		
		}
		
		
	}
		

}
