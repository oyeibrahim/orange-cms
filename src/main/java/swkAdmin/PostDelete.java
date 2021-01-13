package swkAdmin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataBaseDAO.CategoriesDAO;
import dataBaseDAO.FilesDAO;
import dataBaseDAO.PostsDAO;
import dataBaseDAO.TagsDAO;
import dataBaseDAO.TypesDAO;
import dataBaseModel.Posts;

/**
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/PostDelete")
public class PostDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//set session
		HttpSession session = request.getSession();

		PostsDAO postDAO = new PostsDAO();
		
		

		try {
			//get the post
			Posts post = postDAO.getPostWithId(session.getAttribute("editingPostID").toString());
			
			//-----------------------------------------------------------------------
			//reduce count for the post's categories
			String[] categories = post.getCategories().split(",");
			
			CategoriesDAO ctDAO = new CategoriesDAO();
			
			for(int i=0; i<categories.length; i++) {
				ctDAO.subtractCategoryPostCount(categories[i], 1);
			}
			//-----------------------------------------------------------------------
			
			//-----------------------------------------------------------------------
			//reduce count for the post's tags
			//first check if there is a tag as it may be null
			if(post.getTags() != null) {
				String[] tags = post.getTags().split(",");
				
				TagsDAO tgDAO = new TagsDAO();
				
				for(int i=0; i<tags.length; i++) {
					tgDAO.subtractTagPostCount(tags[i], 1);
				}
			}
			
			//-----------------------------------------------------------------------
			
			//-----------------------------------------------------------------------
			//reduce count for the post's type
			
			TypesDAO tyDAO = new TypesDAO();
			//pass in directly since we can only have one post
			tyDAO.subtractTypePostCount(post.getType(), 1);
			
			//-----------------------------------------------------------------------

			//-----------------------------------------------------------------------
			//reduce count for files usage count of the post's picture
			
			FilesDAO filesDAO = new FilesDAO();
			filesDAO.subtractFileUsageCount(post.getPicture(), 1);
			
			//-----------------------------------------------------------------------
			
			
			
			int result = postDAO.deletePost(session.getAttribute("editingPostID").toString());

			if(result > 0) {//if successful

				//set session
				session.setAttribute("ProfileUpdatedMessage", "Post deleted successfully");
				session.removeAttribute("editingPostID");
				response.sendRedirect("swk-admin/posts");
				return;

			}else {//if fail

				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error deleting the post");
				response.sendRedirect("swk-admin/posts");
				return;
			}
		} catch (Exception e) {
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("swk-admin/posts");
			return;
		}


	}

}
