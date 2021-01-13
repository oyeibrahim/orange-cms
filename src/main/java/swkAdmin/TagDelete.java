package swkAdmin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataBaseDAO.PostsDAO;
import dataBaseDAO.TagsDAO;

/**
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/TagDelete")
public class TagDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//set session
		HttpSession session = request.getSession();

		TagsDAO tgDAO = new TagsDAO();

		PostsDAO postDAO = new PostsDAO();
		
		try {
			//get the tag name
			String tagName = tgDAO.getTagName(session.getAttribute("TagID").toString());
			
			//update all posts to remove the tag from them
			
			//remove the tag from posts //add a comma in front to remove the comma too
			postDAO.updateTagOnDelete(tagName+"," , "");
			
			//change all empty tag to null
			postDAO.updateEmptyTagToNull();
			
			//delete the tag
			int result = tgDAO.deleteTag(session.getAttribute("TagID").toString());

			if(result > 0) {//if successful

				//set session
				session.setAttribute("ProfileUpdatedMessage", "tag deleted successfully");
				session.removeAttribute("TagAction");
				session.removeAttribute("TagID");
				response.sendRedirect("swk-admin/tags/1/");
				return;

			}else {//if fail

				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error deleting the tag");
				response.sendRedirect("swk-admin/tags/1/");
				return;
			}
		} catch (Exception e) {
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("swk-admin/tags/1/");
			return;
		}


	}

}
