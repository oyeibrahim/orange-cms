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

import dataBaseDAO.CategoriesDAO;
import dataBaseDAO.UsersDAO;
import dataBaseModel.Categories;

/**
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/CategoryCreateEdit")
public class CategoryCreateEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		//get requests
		String name = request.getParameter("categoryName");
		
		//Category can't have a comma, check for that
		if(name.contains(",")) {
			//set session
			session.setAttribute("ProfileUpdateErrorMessage", "Category cannot have a comma");
			response.sendRedirect("swk-admin/categories/1/");
			return;
		}
		
		
		UsersDAO usersDAO = new UsersDAO();
		
		
		
		//set to the Users Model class
		Categories category = new Categories();
		category.setName(name);
		
		//database access
		CategoriesDAO ctDAO = new CategoriesDAO();
		
		//if we are creating a new Category
		if (session.getAttribute("CategoryAction").equals("create")) {

			
			//check if already exist
			try {
				if (ctDAO.checkCategory(name)) {
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "Category already exist");
					response.sendRedirect("swk-admin/categories/1/");
					return;
				}
			} catch (Exception e1) {}
			
			
			
			//get date
			LocalDate unformattedDate = LocalDate.now(ZoneId.of("GMT"));
			LocalTime time = LocalTime.now(ZoneId.of("GMT"));

			DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			String date = unformattedDate.format(myFormatObj);

			String dateTime = "Date: " + date + " Time: " + time;
			//set date
			category.setDate_time(dateTime);
			//set username
			category.setUsername(session.getAttribute("Username").toString());
			
			//add the data and get return int of rows affected (added)
			try {
				//get id of user through session username
				 long id = usersDAO.getId(session.getAttribute("Username").toString());
				//set id
				category.setCategories_users_id(id);
				
				int result = ctDAO.addCategory(category);
	
				if(result > 0) {//if successful
	
					//set session
					session.setAttribute("ProfileUpdatedMessage", "Category added successfully");
					session.removeAttribute("CategoryAction");
					response.sendRedirect("swk-admin/categories/1/");
					return;
	
				}else {//if fail
	
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "There was an error adding the category");
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
		
		
		
		
		
		
		//if we are updating a Category
		if (session.getAttribute("CategoryAction").equals("update")) {
			//add the data and get return int of rows affected (added)
			//get category id
			long categoryID = Long.parseLong(session.getAttribute("CategoryID").toString());
			category.setId(categoryID);
			try {
				int result = ctDAO.updateCategory(category);
	
				if(result > 0) {//if successful
	
					//set session
					session.setAttribute("ProfileUpdatedMessage", "Category updated successfully");
					session.removeAttribute("CategoryAction");
					session.removeAttribute("CategoryID");
					response.sendRedirect("swk-admin/categories/1/");
					return;
	
				}else {//if fail
	
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "There was an error updating the category");
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

}
