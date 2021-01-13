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

import dataBaseDAO.TypesDAO;
import dataBaseDAO.UsersDAO;
import dataBaseModel.Types;

/**
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/TypeCreateEdit")
public class TypeCreateEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		//get requests
		String name = request.getParameter("typeName");
		
		
		UsersDAO usersDAO = new UsersDAO();
		
		
		
		//set to the Users Model class
		Types type = new Types();
		type.setName(name);
		
		//database access
		TypesDAO tpDAO = new TypesDAO();
		
		//if we are creating a new Type
		if (session.getAttribute("TypeAction").equals("create")) {
			
			
			//check if already exist
			try {
				if (tpDAO.checkType(name)) {
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "Type already exist");
					response.sendRedirect("swk-admin/types/1/");
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
			type.setDate_time(dateTime);
			//set username
			type.setUsername(session.getAttribute("Username").toString());
			
			//add the data and get return int of rows affected (added)
			try {
				//get id of user through session username
				 long id = usersDAO.getId(session.getAttribute("Username").toString());
				//set id
				 type.setTypes_users_id(id);
				
				int result = tpDAO.addType(type);
	
				if(result > 0) {//if successful
	
					//set session
					session.setAttribute("ProfileUpdatedMessage", "Type added successfully");
					session.removeAttribute("TypeAction");
					response.sendRedirect("swk-admin/types/1/");
					return;
	
				}else {//if fail
	
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "There was an error adding the type");
					response.sendRedirect("swk-admin/types/1/");
					return;
				}
			} catch (Exception e) {
				//set session
				session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
				response.sendRedirect("swk-admin/types/1/");
				return;
			}
		}
		
		
		
		
		
		
		//if we are updating a Type
		if (session.getAttribute("TypeAction").equals("update")) {
			//add the data and get return int of rows affected (added)
			//get tag id
			long typeID = Long.parseLong(session.getAttribute("TypeID").toString());
			type.setId(typeID);
			try {
				int result = tpDAO.updateType(type);
	
				if(result > 0) {//if successful
	
					//set session
					session.setAttribute("ProfileUpdatedMessage", "Type updated successfully");
					session.removeAttribute("TypeAction");
					session.removeAttribute("TypeID");
					response.sendRedirect("swk-admin/types/1/");
					return;
	
				}else {//if fail
	
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "There was an error updating the type");
					response.sendRedirect("swk-admin/types/1/");
					return;
	
				}
			} catch (Exception e) {
				//set session
				session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
				response.sendRedirect("swk-admin/types/1/");
				return;
			}
		}
		
		
		
		
		
		
	}

}
