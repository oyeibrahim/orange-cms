package swkAdmin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataBaseDAO.CategoriesDAO;
import dataBaseDAO.PostsDAO;

/**
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/CategoryDelete")
public class CategoryDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//set session
		HttpSession session = request.getSession();

		CategoriesDAO ctDAO = new CategoriesDAO();
		
		PostsDAO postDAO = new PostsDAO();

		try {
			//get the category name
			String catName = ctDAO.getCategoryName(session.getAttribute("CategoryID").toString());
			
			//update all posts to remove the category from them 
			//if this is the only category left with the post, then change the post's category to Uncategorised and 
			//increase Uncategorised count
			
			//remove the category from posts //add a comma in front to remove the comma too
			postDAO.updateCategoryOnDelete(catName+"," , "");
			
			//change all posts with no category after the removal to Uncategorised category
			postDAO.updateEmptyNullCategoryToUncategorised();
			
			//update count for Uncategorised by counting all Uncategorised posts
			ctDAO.updateCategoryPostCount("Uncategorised", (int)postDAO.countCategoryPosts("Uncategorised", "All"));
			
			
			//delete the category
			int result = ctDAO.deleteCategory(session.getAttribute("CategoryID").toString());

			if(result > 0) {//if successful

				//set session
				session.setAttribute("ProfileUpdatedMessage", "Category deleted successfully");
				session.removeAttribute("CategoryAction");
				session.removeAttribute("CategoryID");
				response.sendRedirect("swk-admin/categories/1/");
				return;

			}else {//if fail

				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error deleting the category");
				response.sendRedirect("swk-admin/categories/1/");
				return;
			}
		} catch (Exception e) {
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("swk-admin/categories/1/");
			return;
		}


	}

}
