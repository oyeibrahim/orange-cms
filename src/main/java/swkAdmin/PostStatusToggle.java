package swkAdmin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataBaseDAO.PostsDAO;
import dataBaseModel.Posts;

/**
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/PostStatusToggle")
public class PostStatusToggle extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		String redirect = session.getAttribute("redirect").toString();
		
		//get requests and add to model
		Posts post = new Posts();
		post.setId(Long.parseLong(request.getParameter("id")));
		
		
		if(request.getParameter("task").equals("Unapprove")) {
			post.setStatus("Pending");
		}else {
			post.setStatus("Published");
		}
		
		
		PostsDAO postDAO = new PostsDAO();
		
		
		try {
			int result = postDAO.updatePostStatus(post);

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
