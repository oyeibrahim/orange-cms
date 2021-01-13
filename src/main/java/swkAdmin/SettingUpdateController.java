package swkAdmin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataBaseDAO.SiteStructureDAO;
import dataBaseModel.SiteStructure;

/**
 * Servlet implementation class CommentController
 */
@WebServlet("/SettingUpdateController")
public class SettingUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//set session
		HttpSession session = request.getSession();
		
		String redirectLink = session.getAttribute("structureRedirectLink").toString();
		
		
		SiteStructureDAO ssDAO = new SiteStructureDAO();
		SiteStructure ss = new SiteStructure();
		
		
		//set parameters
		if(session.getAttribute("structureTask").equals("Update")) {
			//this is only set in Update
			ss.setId(Long.parseLong(session.getAttribute("structureId").toString()));
		}
		
		ss.setName(request.getParameter("name"));
		ss.setText_value1(request.getParameter("text1"));
		ss.setText_value2(request.getParameter("text2"));
		ss.setText_value3(request.getParameter("text3"));
		
		//only do the conversion if they are not empty as it will return error converting from empty string
		//also ensure they are number
		if(!request.getParameter("num1").isEmpty()) {
			try {
				ss.setNum_value1(Double.parseDouble(request.getParameter("num1")));
			}catch(NumberFormatException nfe) {//catch not number exception
				session.setAttribute("ProfileUpdateDatabaseErrorMessage", "The Num values must be number");
				response.sendRedirect(redirectLink);
				return;
			}
			
		}
		if(!request.getParameter("num2").isEmpty()) {
			try {
				ss.setNum_value2(Double.parseDouble(request.getParameter("num2")));	
			}catch(NumberFormatException nfe) {//catch not number exception
				session.setAttribute("ProfileUpdateDatabaseErrorMessage", "The Num values must be number");
				response.sendRedirect(redirectLink);
				return;
			}
				
		}
		if(!request.getParameter("num3").isEmpty()) {
			try {
				ss.setNum_value3(Double.parseDouble(request.getParameter("num3")));
			}catch(NumberFormatException nfe) {//catch not number exception
				session.setAttribute("ProfileUpdateDatabaseErrorMessage", "The Num values must be number");
				response.sendRedirect(redirectLink);
				return;
			}
			
		}
		
		
		
		
		try {
			
			int result = 0;	
			
			//add to db //check if to add new or update
			if(session.getAttribute("structureTask").equals("Update")) {
				result = ssDAO.updateStructure(ss);
			}
			
			if(session.getAttribute("structureTask").equals("Create")) {
				result = ssDAO.addStructure(ss);
			}
			
			
			
			if(result>0) {
				
				
				//add to db //check if to add new or update
				if(session.getAttribute("structureTask").equals("Update")) {
					session.removeAttribute("structureTask");
					session.removeAttribute("structureRedirectLink");
					session.removeAttribute("structureId");
					
					session.setAttribute("ProfileUpdatedMessage", "Setting updated");
					response.sendRedirect(redirectLink);
					return;
				}
				
				if(session.getAttribute("structureTask").equals("Create")) {
					session.removeAttribute("structureTask");
					session.removeAttribute("structureRedirectLink");
					session.removeAttribute("structureId");
					
					
					session.setAttribute("ProfileUpdatedMessage", "Setting created");
					response.sendRedirect(redirectLink);
					return;
				}
				
				
				
			}else {
				//set session
				if(session.getAttribute("structureTask").equals("Update")) {
					session.removeAttribute("structureTask");
					session.removeAttribute("structureRedirectLink");
					session.removeAttribute("structureId");
					
					session.setAttribute("ProfileUpdateErrorMessage", "There was an error updating the setting");
					response.sendRedirect(redirectLink);
					return;
				}
				
				if(session.getAttribute("structureTask").equals("Create")) {
					session.removeAttribute("structureTask");
					session.removeAttribute("structureRedirectLink");
					session.removeAttribute("structureId");
					
					
					session.setAttribute("ProfileUpdateErrorMessage", "There was an error creating the setting");
					response.sendRedirect(redirectLink);
					return;
				}
			}
			
			
			
			
		} catch (Exception e) {
			//e.printStackTrace();
			//set session
			
			if(session.getAttribute("structureTask").equals("Update")) {
				session.removeAttribute("structureTask");
				session.removeAttribute("structureRedirectLink");
				session.removeAttribute("structureId");
				
				session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
				response.sendRedirect(redirectLink);
				return;
			}
			
			if(session.getAttribute("structureTask").equals("Create")) {
				session.removeAttribute("structureTask");
				session.removeAttribute("structureRedirectLink");
				session.removeAttribute("structureId");
				
				
				session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
				response.sendRedirect(redirectLink);
				return;
			}
		}
		
		
	}
		

}
