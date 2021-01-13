package post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/PostTempSaving")
public class PostTempSaving extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//set session
		HttpSession session = request.getSession();
		
		//check if the session already exist and destroy it then set new value
		if(session.getAttribute("TitleTempStorage") != null) {
			//remove if it exist
			session.removeAttribute("TitleTempStorage");

			//set a new session for the new incoming value
			session.setAttribute("TitleTempStorage", request.getParameter("tempTitle"));
			
		}else {//if session doesn't exist before, just set a new session for the new incoming value
			session.setAttribute("TitleTempStorage", request.getParameter("tempTitle"));
		}
		
		

		//check if the session already exist and destroy it then set new value
		if(session.getAttribute("LinkTempStorage") != null) {
			//remove if it exist
			session.removeAttribute("LinkTempStorage");
			
			//set a new session for the new incoming value
			session.setAttribute("LinkTempStorage", request.getParameter("tempLink"));
		}else {//if session doesn't exist before, just set a new session for the new incoming value
			session.setAttribute("LinkTempStorage", request.getParameter("tempLink"));
		}
		
		

		//check if the session already exist and destroy it then set new value
		if(session.getAttribute("ExcerptTempStorage") != null) {
			//remove if it exist
			session.removeAttribute("ExcerptTempStorage");
			
			//set a new session for the new incoming value
			session.setAttribute("ExcerptTempStorage", request.getParameter("tempExcerpt"));
		}else {//if session doesn't exist before, just set a new session for the new incoming value
			session.setAttribute("ExcerptTempStorage", request.getParameter("tempExcerpt"));
		}
		
		
		
		//check if the session already exist and destroy it then set new value
		if(session.getAttribute("BodyTempStorage") != null) {
			//remove if it exist
			session.removeAttribute("BodyTempStorage");
			
			//set a new session for the new incoming value
			session.setAttribute("BodyTempStorage", request.getParameter("tempBody"));
		}else {//if session doesn't exist before, just set a new session for the new incoming value
			session.setAttribute("BodyTempStorage", request.getParameter("tempBody"));
		}

	}

	
}
