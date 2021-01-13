package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dataBaseModel.Comments;

public class CommentsDAO {


	Connection con;


	//to connect
	public void Connect()  throws Exception {
		String url = "jdbc:mysql://localhost:3306/baykdb?serverTimezone=UTC";
		String username = "root";
		String password = "";

		Class.forName("com.mysql.cj.jdbc.Driver");

		con = DriverManager.getConnection(url, username, password);
	}
	
	

	//-----------------------------------------Fetch-------------------------------------------------//

	//fetch post comment with pagination
	public List<Comments> getPostComments(long postID, String status, int start, int total) throws Exception {

		Connect();

		List<Comments> list=new ArrayList<Comments>();  
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from comments where comments_posts_id= '" + postID + "' ORDER BY created DESC limit " + start + "," + total;
		}else {//else, fetch the posts with status requested
			query = "Select * from comments where comments_posts_id= '" + postID + "' and status='" + status + "' ORDER BY created DESC limit " + start + "," + total;
		}

		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Comments comment = new Comments();  
			//set data to the model object created
			comment.setId(rs.getLong("id"));
			comment.setBody(rs.getString("body"));
			comment.setStatus(rs.getString("status"));
			comment.setUsername(rs.getString("username"));
			comment.setComments_users_id(rs.getLong("comments_users_id"));
			comment.setComments_posts_id(rs.getLong("comments_posts_id"));
			comment.setDate_time(rs.getString("date_time"));
			comment.setCreated(rs.getString("created"));
			comment.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(comment);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch all comments with pagination
	public List<Comments> getAllComments(String status, int start, int total) throws Exception {

		Connect();

		List<Comments> list=new ArrayList<Comments>();  
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from comments ORDER BY created DESC limit " + start + "," + total;
		}else {//else, fetch the posts with status requested
			query = "Select * from comments where status='" + status + "' ORDER BY created DESC limit " + start + "," + total;
		}

		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Comments comment = new Comments();  
			//set data to the model object created
			comment.setId(rs.getLong("id"));
			comment.setBody(rs.getString("body"));
			comment.setStatus(rs.getString("status"));
			comment.setUsername(rs.getString("username"));
			comment.setComments_users_id(rs.getLong("comments_users_id"));
			comment.setComments_posts_id(rs.getLong("comments_posts_id"));
			comment.setDate_time(rs.getString("date_time"));
			comment.setCreated(rs.getString("created"));
			comment.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(comment);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch search comments with pagination
	public List<Comments> getSearchComments(String search, String status, int start, int total) throws Exception {

		Connect();

		List<Comments> list=new ArrayList<Comments>();  
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from comments where body like '%" + search + "%' "
					+ "or username like '%" + search + "%' ORDER BY created DESC limit " + start + "," + total;
			
		}else {//else, fetch the posts with status requested
			
			query = "Select * from comments where (status='" + status + "') and (body like '%" + search + "%' "
					+ "or username like '%" + search + "%') ORDER BY created DESC limit " + start + "," + total;
			
		}
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Comments comment = new Comments();  
			//set data to the model object created
			comment.setId(rs.getLong("id"));
			comment.setBody(rs.getString("body"));
			comment.setStatus(rs.getString("status"));
			comment.setUsername(rs.getString("username"));
			comment.setComments_users_id(rs.getLong("comments_users_id"));
			comment.setComments_posts_id(rs.getLong("comments_posts_id"));
			comment.setDate_time(rs.getString("date_time"));
			comment.setCreated(rs.getString("created"));
			comment.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(comment);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch search user comments with pagination
	public List<Comments> getSearchUserComments(String search, long id, String status, int start, int total) throws Exception {

		Connect();

		List<Comments> list=new ArrayList<Comments>();  
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from comments where (comments_users_id='" + id + "') and "
					+ "(body like '%" + search + "%') ORDER BY created DESC limit " + start + "," + total;
			
		}else {//else, fetch the posts with status requested
			
			query = "Select * from comments where (comments_users_id='" + id + "' and status='" + status + "') and "
					+ "(body like '%" + search + "%') ORDER BY created DESC limit " + start + "," + total;
			
		}
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Comments comment = new Comments();  
			//set data to the model object created
			comment.setId(rs.getLong("id"));
			comment.setBody(rs.getString("body"));
			comment.setStatus(rs.getString("status"));
			comment.setUsername(rs.getString("username"));
			comment.setComments_users_id(rs.getLong("comments_users_id"));
			comment.setComments_posts_id(rs.getLong("comments_posts_id"));
			comment.setDate_time(rs.getString("date_time"));
			comment.setCreated(rs.getString("created"));
			comment.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(comment);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch user comment with pagination
	public List<Comments> getUserComments(long userID, String status, int start, int total) throws Exception {

		Connect();

		List<Comments> list=new ArrayList<Comments>();  
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from comments where comments_users_id= '" + userID + "' ORDER BY created DESC limit " + start + "," + total;
		}else {//else, fetch the posts with status requested
			query = "Select * from comments where comments_users_id= '" + userID + "' and status='" + status + "' ORDER BY created DESC limit " + start + "," + total;
		}

		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Comments comment = new Comments();  
			//set data to the model object created
			comment.setId(rs.getLong("id"));
			comment.setBody(rs.getString("body"));
			comment.setStatus(rs.getString("status"));
			comment.setUsername(rs.getString("username"));
			comment.setComments_users_id(rs.getLong("comments_users_id"));
			comment.setComments_posts_id(rs.getLong("comments_posts_id"));
			comment.setDate_time(rs.getString("date_time"));
			comment.setCreated(rs.getString("created"));
			comment.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(comment);
		}

		st.close();
		con.close();

		return list;
	}
	
	
	//fetch comment
	public Comments getComment(String id) throws Exception {

		Connect();

		
		Comments comment = new Comments();  
		
		String query = "Select * from comments where id= '" + id + "'";

		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			
			//set data to the model object created
			comment.setId(rs.getLong("id"));
			comment.setBody(rs.getString("body"));
			comment.setStatus(rs.getString("status"));
			comment.setUsername(rs.getString("username"));
			comment.setComments_users_id(rs.getLong("comments_users_id"));
			comment.setComments_posts_id(rs.getLong("comments_posts_id"));
			comment.setDate_time(rs.getString("date_time"));
			comment.setCreated(rs.getString("created"));
			comment.setUpdated(rs.getString("updated"));
		}

		st.close();
		con.close();

		return comment;
	}
	
	
	//get all anonymous comments email
	public List<String> getAllAnonymousCommentsEmail() throws Exception {

		Connect();
		
		List<String> list=new ArrayList<String>();  
		
		//set query with condition
		String query= "select username from comments where comments_users_id='0'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//create new object on every instance
			String username = rs.getString("username");
			
			list.add(username);
		}

		st.close();
		con.close();

		return list;
	}

	
	
	//count post comments for pagination
	public double countPostComments(long postID, String status) throws Exception {

		Connect();
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from comments where comments_posts_id=" + postID;
		}else {//else, fetch the posts with status requested
			query = "select count(*) from comments where comments_posts_id='" + postID + "' and status='" + status + "'";
		}

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//if there is a data
		if(rs.next()) {
			//get total from db
			double count = rs.getInt(1);

			return count;
		}

		st.close();
		con.close();

		return -1;
	}
	
	//count all comments for pagination
	public double countAllComments(String status) throws Exception {

		Connect();
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from comments";
		}else {//else, fetch the posts with status requested
			query = "select count(*) from comments where status= '" + status + "'";
		}

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//if there is a data
		if(rs.next()) {
			//get total from db
			double count = rs.getInt(1);

			return count;
		}

		st.close();
		con.close();

		return -1;
	}
	
	//count all comments for a search
	public double countSearchComments(String search, String status) throws Exception {

		Connect();
	
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from comments where body like '%" + search + "%' or username like '%" + search + "%'";
			
		}else {//else, fetch the posts with status requested
			
			query = "Select count(*) from comments where (status='" + status + "') and (body like '%" + search + "%' or username like '%" + search + "%')";
			
		}
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//if there is a data
		if(rs.next()) {
			//get total from db
			double count = rs.getInt(1);

			return count;
		}

		st.close();
		con.close();

		return -1;
	}
	
	
	//count all user comments for a search
	public double countSearchUserComments(String search, long id, String status) throws Exception {

		Connect();
	
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from comments where (comments_users_id='" + id + "') and (body like '%" + search + "%')";
			
		}else {//else, fetch the posts with status requested
			
			query = "Select count(*) from comments where (comments_users_id='" + id + "' and status='" + status + "') and (body like '%" + search + "%')";
			
		}

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//if there is a data
		if(rs.next()) {
			//get total from db
			double count = rs.getInt(1);

			return count;
		}

		st.close();
		con.close();

		return -1;
	}
	
	
	//count user comments for pagination
	public double countUserComments(long userID, String status) throws Exception {

		Connect();
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from comments where comments_users_id=" + userID;
		}else {//else, fetch the posts with status requested
			query = "select count(*) from comments where comments_users_id='" + userID + "' and status='" + status + "'";
		}

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//if there is a data
		if(rs.next()) {
			//get total from db
			double count = rs.getInt(1);

			return count;
		}

		st.close();
		con.close();

		return -1;
	}
	
	
	//check if user have previous approved comment
	public boolean checkUserPublishedComment(long userID) throws Exception {

		Connect(); 
		
		String query = "Select * from comments where comments_users_id= '" + userID + "' and status='Published'";
		
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//if there is a data
		if(rs.next()) {
			//return true
			return true;
		}

		st.close();
		con.close();

		return false;
	}
	
	//check if user own the comment
	public boolean checkUserOwnComment(long commentID, long userID) throws Exception {

		Connect(); 
		
		String query = "Select * from comments where id= '" + commentID + "' and comments_users_id='" + userID + "'";
		
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//if there is a data
		if(rs.next()) {
			//return true
			return true;
		}

		st.close();
		con.close();

		return false;
	}

	//-----------------------------------------End Fetch-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//




	//-----------------------------------------Inserts-------------------------------------------------//

	//add new comment
	public int addComment(Comments comment) throws Exception {

		Connect();

		//the comments_users_id will be 0 if an anonymous user
		String query = "insert into comments (body,status,username,comments_users_id,comments_posts_id,date_time) values (?,?,?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);


		pst.setString(1, comment.getBody());
		pst.setString(2, comment.getStatus());
		pst.setString(3, comment.getUsername());
		pst.setLong(4, comment.getComments_users_id());
		pst.setLong(5, comment.getComments_posts_id());
		pst.setString(6, comment.getDate_time());
		
		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;
	}

	//-----------------------------------------End Insert-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//







	//-----------------------------------------Update-------------------------------------------------//

	//Update Comment
	public int updateComment(Comments comment) throws Exception {

		Connect();

		String query = "update comments set body = ? where id = '" + comment.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, comment.getBody());

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	
	//Update comment status
	public int updateCommentStatus(Comments comment) throws Exception {

		Connect();

		String query = "update comments set status = ? where id = '" + comment.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, comment.getStatus());

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}


	//-----------------------------------------End Update-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//




	//-----------------------------------------Delete-------------------------------------------------//

	//delete comment
	public int deleteComment(String id) throws Exception {

		Connect();

		String query = "delete from comments where id=" + id;

		Statement st = con.createStatement();
		//execute and get number rows affected
		int NumberOfRowsAffected = st.executeUpdate(query);

		st.close();
		con.close();

		//return number of rows affected
		return NumberOfRowsAffected;
	}


	//-----------------------------------------End Delete-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//


}
