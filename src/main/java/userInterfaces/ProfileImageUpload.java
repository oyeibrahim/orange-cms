package userInterfaces;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dataBaseDAO.UsersDAO;
import dataBaseModel.Users;
import utilities.UtilityMethods;

/**
 * Servlet implementation class ProfileImageUpload
 */
@WebServlet("/ProfileImageUpload")
public class ProfileImageUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//to get path name
		//String pathBase = request.getContextPath();
		
		//set session
		HttpSession session = request.getSession();
		//get username from session
		String username = session.getAttribute("Username").toString();
		
		
		try {
			
			//create ServletFileUpload
			ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
			
			//get the file list from request
			List<FileItem> multifiles = sf.parseRequest(request);
			
			//iterate over the list to save the file one by one
			for (FileItem item : multifiles) {
				//if file size is bigger than 1MB
				long size = item.getSize();
				if(size > 1048576) {
					
					//set session
					session.setAttribute("ProfileUpdateErrorMessage", "Error updating your profile picture : Image size too big, Please select an image not bigger than 1MB in size");
					response.sendRedirect("Settings.jsp");
					
				}else {//size is within 1MB
					
					//get the extension so we can save it with the extension and be able
					//to modify the name
					String type = item.getContentType();
					String extension = type.substring(type.indexOf("/") + 1);
					
					//get random string to add to the name so the files won't throw an error for
					//having the same name
					UtilityMethods um = new UtilityMethods();
					String randomNo = um.getRandomAlphaNumericString(6);
					
					//saving path
					//String path = "C:/Users/Oyeibraheem/Documents/web-apps/BAYK-Platform/WebContent/lib/profile-picture/";
					String path = "C:\\Users\\Oyeibraheem\\Documents\\WebAppUploads\\ProfileImages\\";
					
					//file new name
					String name = username + "-" + randomNo + "." + extension;
					//profile picture link
					String profilePicture = "/lib/profile-picture/" + name;
					
					//save the files in a folder path with any name
					item.write(new File(path + name));
					
					Users userModel = new Users();
					
					userModel.setUsername(username);
					userModel.setProfilePicture(profilePicture);
					
					UsersDAO user = new UsersDAO();
					
					//get previous image with another Users class instance to delete the image after adding new image
					Users newUser = user.getUserProfile(username);
					String link = newUser.getProfilePicture();
					
					//execute the update
					int result = user.updateProfilePicture(userModel);
					
					if (result > 0) {//if successful
						
						//get the previous image from link
						int ind = link.indexOf("/", link.indexOf("picture"));
						String prevImage = link.substring(ind+1);
						
						//if previous image is not the default image
						if(!prevImage.equals("default_user.png")) {
							
							//get the path
							File f= new File(path + prevImage);
							//delete
							f.delete();
						}

						//set session
						session.setAttribute("ProfileUpdatedMessage", "Profile updated successfully");
						response.sendRedirect("profile/" + username);
						
					}else {//if fail
						
						//set session
						session.setAttribute("ProfileUpdateErrorMessage", "There was an error updating your profile");
						response.sendRedirect("Settings.jsp");
						
					}
				}
				
			}
		}
		catch(Exception e) {//database error
			//e.printStackTrace();
			
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("Settings.jsp");
		}
		
	}

}
