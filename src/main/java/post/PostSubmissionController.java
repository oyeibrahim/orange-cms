package post;

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

import dataBaseDAO.CategoriesDAO;
import dataBaseDAO.FilesDAO;
import dataBaseDAO.PostsDAO;
import dataBaseDAO.TagsDAO;
import dataBaseDAO.TypesDAO;
import dataBaseDAO.UsersDAO;
import dataBaseModel.Files;
import dataBaseModel.Posts;
import dataBaseModel.Tags;
import utilities.UtilityMethods;

/**
 * Servlet implementation class ProfileImageUpload
 */
@WebServlet("/PostSunmissionController")
public class PostSubmissionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		//set session
		HttpSession session = request.getSession();
		//get username from session
		String username = session.getAttribute("Username").toString();
		
		UsersDAO user = new UsersDAO();
		
		//initialise PostsDAO
		PostsDAO postDAO = new PostsDAO();
		
		try {
			//get userID
			long userID = user.getId(username);
			
			Posts post = new Posts();
			
			//get date
			LocalDate unformattedDate = LocalDate.now(ZoneId.of("GMT"));
			LocalTime time = LocalTime.now(ZoneId.of("GMT"));
			
			DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			String date = unformattedDate.format(myFormatObj);
			
			String dateTime = "Date: " + date + " Time: " + time;
			
			
			//create ServletFileUpload
			ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
			
			//get the file list from request
			List<FileItem> multifiles = sf.parseRequest(request);
			
			//iterate over the list to save the file one by one
			for (FileItem item : multifiles) {
					//if its a form field and not file			
				if(item.isFormField()) {
					
					//if current item is an existing image for post image
					if(item.getFieldName().equals("existingImage")) {
						//add the image to the post
						post.setPicture(item.getString());
						//increment image usage count
						FilesDAO fDAO = new FilesDAO();
						fDAO.addFileUsageCount(item.getString(), 1);
					}
					
					//if current item is title
					if(item.getFieldName().equals("title")) {
						//adds the post title
						post.setTitle(item.getString());
					}
					
					//if current item is link
					if(item.getFieldName().equals("link")) {
						String link = item.getString();
						
						//replace special characters with (-)
						link = link.replaceAll("[$ &+£\\[\\]\',:;=?@#|\"'<>.^*/()%!-]", "-");
						
						//check for case where there is more than one (-) together
						do {
							link = link.replaceAll("--", "-");
						}while(link.contains("--"));
						
						//if it ends with (-) remove it
						if(link.endsWith("-")) {
							link = link.substring(0, link.length()-1);
						}
						
						//then add the link
						post.setLink(link);
					}
					
					//if current item is excerpt
					if(item.getFieldName().equals("excerpt")) {
						//add the excerpt
						post.setExcerpt(item.getString());
					}
					
					//if current item is body
					if(item.getFieldName().equals("body")) {
						//add the body
						post.setBody(item.getString());
					}
					
					//if current item is categories
					if(item.getFieldName().equals("categories")) {
						CategoriesDAO ctDAO = new CategoriesDAO();
						//if no category selected, set it to Uncategorised
						//Note that having db default as Uncategorised will still throw an error
						//of null if it isn't added here
						if(item.getString().isEmpty()) {
							//comma must be in front as its the split tool
							post.setCategories("Uncategorised,");
							ctDAO.addCategoryPostCount("Uncategorised", 1);
						}
						else{//add the categories list to post
							post.setCategories(item.getString());
							
							//since categories can't be new, just increase the post number of the categories
							//comma is splitting tool
							String[] catList = item.getString().split(",");
							
							//first check that not more than expected 5 categories was entered
							if(catList.length > 5) {
								//set session
								session.setAttribute("ProfileUpdateErrorMessage", "Categories can't be more than 5 !!!");
								response.sendRedirect("CreatePost.jsp");
								return;
							}
							
							//iterate and increase each count
							for(int i=0; i<catList.length; i++) {
								ctDAO.addCategoryPostCount(catList[i], 1);
							}
						}
					}
					
					//if current item is tags
					if(item.getFieldName().equals("tags")) {
						
						TagsDAO tgDAO = new TagsDAO();
						//if tags is selected
						if(!item.getString().isEmpty()) {
							//add the tags list to post
							post.setTags(item.getString());
							
							//get each tag
							//comma is splitting tool
							String[] tagList = item.getString().split(",");
							
							//first check that not more than expected 10 tags was entered
							if(tagList.length > 10) {
								//set session
								session.setAttribute("ProfileUpdateErrorMessage", "Tags can't be more than 10 !!!");
								response.sendRedirect("CreatePost.jsp");
								return;
							}
							
							//add any new tag to tag list and increment its post count
							//for existing tags, just increment the post count
							for(int i=0; i<tagList.length; i++) {
								//if tag already exist
								if (tgDAO.checkTag(tagList[i])) {
									//increase the count
									tgDAO.addTagPostCount(tagList[i], 1);
								}else {//if not
									//add the new tag to db
									Tags tg = new Tags();
									tg.setName(tagList[i]);
									tg.setUsername(username);
									tg.setTags_users_id(userID);
									tg.setDate_time(dateTime);
									tgDAO.addTag(tg);
									
									//then increment the count
									tgDAO.addTagPostCount(tagList[i], 1);
								}
							}
							
						}
					}
					
					//add the remaining data
					post.setType("Regular");
					
					//update count for post type
					TypesDAO tyDAO = new TypesDAO();
					tyDAO.addTypePostCount("Regular", 1);
					
					post.setStatus("Published");
					post.setUsername(username);
					post.setPosts_users_id(userID);
					post.setDate_time(dateTime);
					
					//remaining picture, it is set below
					
				}else {//if a file
					//if file size is bigger than 5MB
					long size = item.getSize();
					if(size > 5242880) {
						//set session
						session.setAttribute("ProfileUpdateErrorMessage", "Error updating your profile picture : Image size too big, Please select an image not bigger than 5MB in size");
						response.sendRedirect("CreatePost.jsp");
						return;
						
					}else {//size is within 5MB
						
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
						
						//add the picture to the post
						post.setPicture(pictureLink);
						
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
			
			//add to DAO
			int result = postDAO.addPost(post);
			
			//if successful
			if(result>0) {
				//remove the temporarily saved work since its in database now
				if(session.getAttribute("TitleTempStorage") != null) {
					session.removeAttribute("TitleTempStorage");
				}
				
				if(session.getAttribute("LinkTempStorage") != null) {
					session.removeAttribute("LinkTempStorage");
				}
				
				if(session.getAttribute("ExcerptTempStorage") != null) {
					session.removeAttribute("ExcerptTempStorage");
				}
				
				if(session.getAttribute("BodyTempStorage") != null) {
					session.removeAttribute("BodyTempStorage");
				}
				
				//set session
				session.setAttribute("ProfileUpdatedMessage", "Post submitted successfully");
				response.sendRedirect("CreatePost.jsp");
				
			}else {//if fail
				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error submitting the post");
				response.sendRedirect("CreatePost.jsp");
			}
			
			
			
		}
		catch(Exception e) {//database error
			//e.printStackTrace();
			
			//set session
			session.setAttribute("ProfileUpdateDatabaseErrorMessage", "An error occurred... Please try again!!!");
			response.sendRedirect("CreatePost.jsp");
		}
		
		
		
		
		
		
		
	}

}
