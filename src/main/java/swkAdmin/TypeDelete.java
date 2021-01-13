package swkAdmin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataBaseDAO.TypesDAO;

/**
 * Servlet implementation class UserInfoEdit
 */
@WebServlet("/TypeDelete")
public class TypeDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//set session
		HttpSession session = request.getSession();

		TypesDAO tpDAO = new TypesDAO();

		try {

			int result = tpDAO.deleteType(session.getAttribute("TypeID").toString());

			if(result > 0) {//if successful

				//set session
				session.setAttribute("ProfileUpdatedMessage", "Type deleted successfully");
				session.removeAttribute("TypeAction");
				session.removeAttribute("TypeID");
				response.sendRedirect("swk-admin/types/1/");
				return;

			}else {//if fail

				//set session
				session.setAttribute("ProfileUpdateErrorMessage", "There was an error deleting the type");
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
