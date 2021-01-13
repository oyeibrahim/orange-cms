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

import dataBaseDAO.TagsDAO;
import dataBaseDAO.UsersDAO;
import dataBaseModel.Tags;

/**
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/TagCreateEdit")
public class TagCreateEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		//get requests
		String name = request.getParameter("tagName");

		//Tag can't have a comma, check for that
		if(name.contains(",")) {
			//set session
			session.setAttribute("ProfileUpdateErrorMessage", "Tag cannot have a comma");
			response.sendRedirect("swk-admin/tags/1/");
			return;
		}
		
		
		UsersDAO usersDAO = new UsersDAO();
		
		
		
		//set to the Users Model class
		Tags tag = new Tags();
		tag.setName(name);
		
		//database access
		TagsDAO tgDAO = new TagsDAO();
		
		//if we are creating a new Tag
		if (session.getAttribute("TagAction").equals("create")) {
			
			
			//check if already exist
			try {
				if (tgDAO.checkTag(name)) {
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "Tag already exist");
					response.sendRedirect("swk-admin/tags/1/");
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
			tag.setDate_time(dateTime);
			//set username
			tag.setUsername(session.getAttribute("Username").toString());
			
			//add the data and get return int of rows affected (added)
			try {
				//get id of user through session username
				 long id = usersDAO.getId(session.getAttribute("Username").toString());
				//set id
				 tag.setTags_users_id(id);
				
				int result = tgDAO.addTag(tag);
	
				if(result > 0) {//if successful
	
					//set session
					session.setAttribute("ProfileUpdatedMessage", "Tag added successfully");
					session.removeAttribute("TagAction");
					response.sendRedirect("swk-admin/tags/1/");
					return;
	
				}else {//if fail
	
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "There was an error adding the tag");
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
		
		
		
		
		
		
		//if we are updating a Tag
		if (session.getAttribute("TagAction").equals("update")) {
			//add the data and get return int of rows affected (added)
			//get tag id
			long tagID = Long.parseLong(session.getAttribute("TagID").toString());
			tag.setId(tagID);
			try {
				int result = tgDAO.updateTag(tag);
	
				if(result > 0) {//if successful
	
					//set session
					session.setAttribute("ProfileUpdatedMessage", "Tag updated successfully");
					session.removeAttribute("TagAction");
					session.removeAttribute("TagID");
					response.sendRedirect("swk-admin/tags/1/");
					return;
	
				}else {//if fail
	
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "There was an error updating the tag");
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

}
