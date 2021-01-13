package utilities;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
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

import dataBaseDAO.FilesDAO;
import dataBaseDAO.UsersDAO;
import dataBaseModel.Files;

/**
 * Servlet implementation class ProfileImageUpload
 */
@WebServlet("/InPostImageUpload")
public class InPostImageUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//to get path name
		//String pathBase = request.getContextPath();
		
		//get date
		LocalDate unformattedDate = LocalDate.now(ZoneId.of("GMT"));
		LocalTime time = LocalTime.now(ZoneId.of("GMT"));
		
		DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		String date = unformattedDate.format(myFormatObj);
		
		String dateTime = "Date: " + date + " Time: " + time;
		
		//set session
		HttpSession session = request.getSession();
		//get username from session
		String username = session.getAttribute("Username").toString();
		
		
		
		try {
			UsersDAO usDAO = new UsersDAO();
			long userID = usDAO.getId(username);
			
			//create ServletFileUpload
			ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
			
			//get the file list from request
			List<FileItem> multifiles = sf.parseRequest(request);
			
			//iterate over the list to save the file one by one
			for (FileItem item : multifiles) {
								
				if(item.isFormField()) {

					
				}else {
					//if file size is bigger than 1MB
					long size = item.getSize();
					if(size > 1048576) {
						
						//set session
						session.setAttribute("ProfileUpdateErrorMessage", "Error updating your profile picture : Image size too big, Please select an image not bigger than 1MB in size");
						response.sendRedirect("CreatePost.jsp");
						
					}else {//size is within 1MB

						//get the extension so we can save it with the extension and be able
						//to modify the name
						String mediaType = item.getContentType();
						String extension = mediaType.substring(mediaType.indexOf("/") + 1);
						
						//get random string to add to the name so the files won't throw an error for
						//having the same name
						UtilityMethods um = new UtilityMethods();
						String randomNo = um.getRandomAlphaNumericString(6);
						
						//saving path
						String savingPath = "C:\\Users\\Oyeibraheem\\Documents\\WebAppUploads\\Files\\";

						String originalName = item.getName();
						
						//file new name //it will be the original file name plus randomNo
						String fileNewName = originalName.substring(0, originalName.lastIndexOf(".")) + "-" + randomNo + "." + extension;
						
						//save the file in a folder path with the name
						item.write(new File(savingPath + fileNewName));
						
						//Add the link to files database and get it for post
						//get the link
						String pictureLink = "/lib/upload/" + fileNewName;
						
						//Files db model
						Files fileModel = new Files();
						//set type, like image or video
						fileModel.setType(mediaType.substring(0, mediaType.indexOf("/")));
						fileModel.setExtension(extension);
						fileModel.setPath(pictureLink);
						fileModel.setName(fileNewName);
						fileModel.setUsage_count(1);
						fileModel.setUsername(username);
						fileModel.setFiles_users_id(userID);
						fileModel.setDate_time(dateTime);
						
						//add to files db
						FilesDAO flDAO = new FilesDAO();
						flDAO.addFile(fileModel);
						
					}
				}
				
			}
		}
		catch(Exception e) {//database error
			//e.printStackTrace();
			
			//set session
			//session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			//response.sendRedirect("Settings.jsp");
		}
		
	}

}
