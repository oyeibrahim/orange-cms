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
@WebServlet("/PostTypeStatusEdit")
public class PostTypeStatusEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		//get requests and add to model
		Posts post = new Posts();
		post.setType(request.getParameter("type"));
		post.setStatus(request.getParameter("status"));
				
		String postID = session.getAttribute("editingPostID").toString();
		
		//set post id
		post.setId(Long.parseLong(postID));
		
		PostsDAO postDAO = new PostsDAO();
		
		
		try {
			int result = postDAO.updatePostTypeStatus(post);

			if(result > 0) {//if successful

				//set session
				session.setAttribute("ProfileUpdatedMessage", "Post updated successfully");
				session.removeAttribute("editingPostID");
				response.sendRedirect("swk-admin/post-edit?id=" + postID);

			}else {//if fail

				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error updating the post");
				response.sendRedirect("swk-admin/post-edit?id=" + postID);

			}
		} catch (Exception e) {
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("swk-admin/post-edit?id=" + postID);
		}
		
	}

}
