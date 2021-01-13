package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dataBaseModel.Posts;

public class PostsDAO {


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

	//fetch all posts with pagination //status for fetching only posts with the specified status //to fetch all use "All" as status
	public List<Posts> getAllPost(String status, int start, int total) throws Exception {

		Connect();

		List<Posts> list=new ArrayList<Posts>(); 
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from posts ORDER BY created DESC limit " + start + "," + total;
		}else {//else, fetch the posts with status requested
			query = "Select * from posts where status= '" + status + "' ORDER BY created DESC limit " + start + "," + total;
		}
		
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Posts post = new Posts();  
			//set data to the model object created
			post.setId(rs.getLong("id"));
			post.setLink(rs.getString("link"));
			post.setType(rs.getString("type"));
			post.setTitle(rs.getString("title"));
			post.setPicture(rs.getString("picture"));
			post.setCategories(rs.getString("categories"));
			post.setExcerpt(rs.getString("excerpt"));
			post.setBody(rs.getString("body"));
			post.setTags(rs.getString("tags"));
			post.setStatus(rs.getString("status"));
			post.setUsername(rs.getString("username"));
			post.setPosts_users_id(rs.getLong("posts_users_id"));
			post.setDate_time(rs.getString("date_time"));
			post.setCreated(rs.getString("created"));
			post.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(post);
		}

		st.close();
		con.close();

		return list;
	}
	
	
	//fetch each users post with pagination
	public List<Posts> getUserPosts(long userID, String status, int start, int total) throws Exception {

		Connect();

		List<Posts> list=new ArrayList<Posts>();  
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from posts where posts_users_id= '" + userID + "' ORDER BY created DESC limit " + start + "," + total;
		}else {//else, fetch the posts with status requested
			query = "Select * from posts where posts_users_id= '" + userID + "' and status= '" + status + "' ORDER BY created DESC limit " + start + "," + total;
		}
		
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Posts post = new Posts();  
			//set data to the model object created
			post.setId(rs.getLong("id"));
			post.setLink(rs.getString("link"));
			post.setType(rs.getString("type"));
			post.setTitle(rs.getString("title"));
			post.setPicture(rs.getString("picture"));
			post.setCategories(rs.getString("categories"));
			post.setExcerpt(rs.getString("excerpt"));
			post.setBody(rs.getString("body"));
			post.setTags(rs.getString("tags"));
			post.setStatus(rs.getString("status"));
			post.setUsername(rs.getString("username"));
			post.setPosts_users_id(rs.getLong("posts_users_id"));
			post.setDate_time(rs.getString("date_time"));
			post.setCreated(rs.getString("created"));
			post.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(post);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch posts with type with pagination
	public List<Posts> getPostsWithType(String type, String status, int start, int total) throws Exception {

		Connect();

		List<Posts> list=new ArrayList<Posts>();  

		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from posts where type= '" + type + "' ORDER BY created DESC limit " + start + "," + total;
		}else {//else, fetch the posts with status requested
			query = "Select * from posts where type= '" + type + " and status= '" + status + "' ORDER BY created DESC limit " + start + "," + total;
		}
		
		
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Posts post = new Posts();  
			//set data to the model object created
			post.setId(rs.getLong("id"));
			post.setLink(rs.getString("link"));
			post.setType(rs.getString("type"));
			post.setTitle(rs.getString("title"));
			post.setPicture(rs.getString("picture"));
			post.setCategories(rs.getString("categories"));
			post.setExcerpt(rs.getString("excerpt"));
			post.setBody(rs.getString("body"));
			post.setTags(rs.getString("tags"));
			post.setStatus(rs.getString("status"));
			post.setUsername(rs.getString("username"));
			post.setPosts_users_id(rs.getLong("posts_users_id"));
			post.setDate_time(rs.getString("date_time"));
			post.setCreated(rs.getString("created"));
			post.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(post);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch posts with category with pagination
	public List<Posts> getPostsWithCategory(String category, String status, int start, int total) throws Exception {

		Connect();

		List<Posts> list=new ArrayList<Posts>();  

		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from posts where categories like '%" + category + "%' ORDER BY created DESC limit " + start + "," + total;
		}else {//else, fetch the posts with status requested
			query = "Select * from posts where categories like '%" + category + "%' and status= '" + status + "' ORDER BY created DESC limit " + start + "," + total;
		}
		
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Posts post = new Posts();  
			//set data to the model object created
			post.setId(rs.getLong("id"));
			post.setLink(rs.getString("link"));
			post.setType(rs.getString("type"));
			post.setTitle(rs.getString("title"));
			post.setPicture(rs.getString("picture"));
			post.setCategories(rs.getString("categories"));
			post.setExcerpt(rs.getString("excerpt"));
			post.setBody(rs.getString("body"));
			post.setTags(rs.getString("tags"));
			post.setStatus(rs.getString("status"));
			post.setUsername(rs.getString("username"));
			post.setPosts_users_id(rs.getLong("posts_users_id"));
			post.setDate_time(rs.getString("date_time"));
			post.setCreated(rs.getString("created"));
			post.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(post);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch posts with tag with pagination
	public List<Posts> getPostsWithTag(String tag, String status, int start, int total) throws Exception {

		Connect();

		List<Posts> list=new ArrayList<Posts>();  
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from posts where tags like '%" + tag + "%' ORDER BY created DESC limit " + start + "," + total;
		}else {//else, fetch the posts with status requested
			query = "Select * from posts where tags like '%" + tag + "%' and status= '" + status + "' ORDER BY created DESC limit " + start + "," + total;
		}
		
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Posts post = new Posts();  
			//set data to the model object created
			post.setId(rs.getLong("id"));
			post.setLink(rs.getString("link"));
			post.setType(rs.getString("type"));
			post.setTitle(rs.getString("title"));
			post.setPicture(rs.getString("picture"));
			post.setCategories(rs.getString("categories"));
			post.setExcerpt(rs.getString("excerpt"));
			post.setBody(rs.getString("body"));
			post.setTags(rs.getString("tags"));
			post.setStatus(rs.getString("status"));
			post.setUsername(rs.getString("username"));
			post.setPosts_users_id(rs.getLong("posts_users_id"));
			post.setDate_time(rs.getString("date_time"));
			post.setCreated(rs.getString("created"));
			post.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(post);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch search posts with pagination
	public List<Posts> getPostsWithSearch(String search, String status, int start, int total) throws Exception {

		Connect();

		List<Posts> list=new ArrayList<Posts>();  
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from posts where link like '%" + search + "%' or type like '%" + search + "%' or "
					+ "title like '%" + search + "%' or categories like '%" + search + "%' or excerpt like '%" + search + "%' or body like '%" + search + "%' or "
					+ "tags like '%" + search + "%' or username like '%" + search + "%' ORDER BY created DESC limit " + start + "," + total;
			
		}else {//else, fetch the posts with status requested
			
			query = "Select * from posts where (status='" + status + "') and (link like '%" + search + "%' or type like '%" + search + "%' or "
					+ "title like '%" + search + "%' or categories like '%" + search + "%' or excerpt like '%" + search + "%' or body like '%" + search + "%' or "
					+ "tags like '%" + search + "%' or username like '%" + search + "%') ORDER BY created DESC limit " + start + "," + total;
			
		}
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Posts post = new Posts();  
			//set data to the model object created
			post.setId(rs.getLong("id"));
			post.setLink(rs.getString("link"));
			post.setType(rs.getString("type"));
			post.setTitle(rs.getString("title"));
			post.setPicture(rs.getString("picture"));
			post.setCategories(rs.getString("categories"));
			post.setExcerpt(rs.getString("excerpt"));
			post.setBody(rs.getString("body"));
			post.setTags(rs.getString("tags"));
			post.setStatus(rs.getString("status"));
			post.setUsername(rs.getString("username"));
			post.setPosts_users_id(rs.getLong("posts_users_id"));
			post.setDate_time(rs.getString("date_time"));
			post.setCreated(rs.getString("created"));
			post.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(post);
		}

		st.close();
		con.close();

		return list;
	}
	
	
	//fetch search user posts with pagination
	public List<Posts> getSearchUserPosts(String search, long id, String status, int start, int total) throws Exception {

		Connect();

		List<Posts> list=new ArrayList<Posts>();  
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "Select * from posts where (posts_users_id='" + id + "') and (link like '%" + search + "%' or type like '%" + search + "%' or "
					+ "title like '%" + search + "%' or categories like '%" + search + "%' or excerpt like '%" + search + "%' or body like '%" + search + "%' or "
					+ "tags like '%" + search + "%' or username like '%" + search + "%') ORDER BY created DESC limit " + start + "," + total;
			
		}else {//else, fetch the posts with status requested
			
			query = "Select * from posts where (posts_users_id='" + id + "' and status='" + status + "') and (link like '%" + search + "%' or type like '%" + search + "%' or "
					+ "title like '%" + search + "%' or categories like '%" + search + "%' or excerpt like '%" + search + "%' or body like '%" + search + "%' or "
					+ "tags like '%" + search + "%' or username like '%" + search + "%') ORDER BY created DESC limit " + start + "," + total;
			
		}
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Posts post = new Posts();  
			//set data to the model object created
			post.setId(rs.getLong("id"));
			post.setLink(rs.getString("link"));
			post.setType(rs.getString("type"));
			post.setTitle(rs.getString("title"));
			post.setPicture(rs.getString("picture"));
			post.setCategories(rs.getString("categories"));
			post.setExcerpt(rs.getString("excerpt"));
			post.setBody(rs.getString("body"));
			post.setTags(rs.getString("tags"));
			post.setStatus(rs.getString("status"));
			post.setUsername(rs.getString("username"));
			post.setPosts_users_id(rs.getLong("posts_users_id"));
			post.setDate_time(rs.getString("date_time"));
			post.setCreated(rs.getString("created"));
			post.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(post);
		}

		st.close();
		con.close();

		return list;
	}
	
	
	//fetch post with link
	public Posts getPost(String link) throws Exception {

		Connect();

		String query = "Select * from posts where link= '" + link + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		//use Post class to send the data
		Posts post = new Posts();  

		//while there is a data
		if(rs.next()) {
			//get data from DB
			//set data to the model object created
			post.setId(rs.getLong("id"));
			post.setLink(rs.getString("link"));
			post.setType(rs.getString("type"));
			post.setTitle(rs.getString("title"));
			post.setPicture(rs.getString("picture"));
			post.setCategories(rs.getString("categories"));
			post.setExcerpt(rs.getString("excerpt"));
			post.setBody(rs.getString("body"));
			post.setTags(rs.getString("tags"));
			post.setStatus(rs.getString("status"));
			post.setUsername(rs.getString("username"));
			post.setPosts_users_id(rs.getLong("posts_users_id"));
			post.setDate_time(rs.getString("date_time"));
			post.setCreated(rs.getString("created"));
			post.setUpdated(rs.getString("updated"));
		}

		st.close();
		con.close();

		return post;
	}
	
	//fetch post with id
	public Posts getPostWithId(String id) throws Exception {

		Connect();

		String query = "Select * from posts where id= '" + id + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		//use Post class to send the data
		Posts post = new Posts();  

		//while there is a data
		if(rs.next()) {
			//get data from DB
			//set data to the model object created
			post.setId(rs.getLong("id"));
			post.setLink(rs.getString("link"));
			post.setType(rs.getString("type"));
			post.setTitle(rs.getString("title"));
			post.setPicture(rs.getString("picture"));
			post.setCategories(rs.getString("categories"));
			post.setExcerpt(rs.getString("excerpt"));
			post.setBody(rs.getString("body"));
			post.setTags(rs.getString("tags"));
			post.setStatus(rs.getString("status"));
			post.setUsername(rs.getString("username"));
			post.setPosts_users_id(rs.getLong("posts_users_id"));
			post.setDate_time(rs.getString("date_time"));
			post.setCreated(rs.getString("created"));
			post.setUpdated(rs.getString("updated"));
		}

		st.close();
		con.close();

		return post;
	}
	
	//fetch post with id
	public String getPostLinkWithId(long id) throws Exception {

		Connect();

		String query = "Select link from posts where id= '" + id + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		if(rs.next()) {

			return rs.getString(1);
			
		}

		st.close();
		con.close();

		return "";
	}

	//count all posts for pagination
	public double countAllPosts(String status) throws Exception {

		Connect();
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from posts";
		}else {//else, fetch the posts with status requested
			query = "select count(*) from posts where status= '" + status + "'";
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
	
	//count all posts for a user
	public double countUserPosts(long userID, String status) throws Exception {

		Connect();
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from posts where posts_users_id=" + userID;
		}else {//else, fetch the posts with status requested
			
			query = "select count(*) from posts where posts_users_id='" + userID + "' and status= '" + status + "'";
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
	
	//count all posts for a type
	public double countTypePosts(String type, String status) throws Exception {

		Connect();
	
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from posts where type= '" + type + "'";
		}else {//else, fetch the posts with status requested
			query = "select count(*) from posts where type= '" + type + "' and status= '" + status + "'";
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
	
	//count all posts for a category
	public double countCategoryPosts(String category, String status) throws Exception {

		Connect();
	
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from posts where categories like '%" + category + "%'";
		}else {//else, fetch the posts with status requested
			query = "Select count(*) from posts where categories like '%" + category + "%' and status= '" + status + "'";
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
	
	//count all posts for a tag
	public double countTagPosts(String tag, String status) throws Exception {

		Connect();
	
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from posts where tags like '%" + tag + "%'";
		}else {//else, fetch the posts with status requested
			query = "Select count(*) from posts where tags like '%" + tag + "%' and status= '" + status + "'";
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
	
	//count all posts for a search
	public double countSearchPosts(String search, String status) throws Exception {

		Connect();
	
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from posts where link like '%" + search + "%' or type like '%" + search + "%' "
					+ "or title like '%" + search + "%' or categories like '%" + search + "%' or excerpt like '%" + search + "%' or body like '%" + search + "%' or "
					+ "tags like '%" + search + "%' or username like '%" + search + "%'";
			
		}else {//else, fetch the posts with status requested
			
			query = "Select count(*) from posts where (status='" + status + "') and (link like '%" + search + "%' or type like '%" + search + "%' or "
					+ "title like '%" + search + "%' or categories like '%" + search + "%' or excerpt like '%" + search + "%' or body like '%" + search + "%' or "
					+ "tags like '%" + search + "%' or username like '%" + search + "%')";
			
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
	
	
	//count all user posts for a search
	public double countSearchUserPosts(String search, long id, String status) throws Exception {

		Connect();
	
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(status.equals("All")) {//if All, fetch all
			query = "select count(*) from posts where (posts_users_id='" + id + "') and (link like '%" + search + "%' or type like '%" + search + "%' "
					+ "or title like '%" + search + "%' or categories like '%" + search + "%' or excerpt like '%" + search + "%' or body like '%" + search + "%' or "
					+ "tags like '%" + search + "%' or username like '%" + search + "%')";
			
		}else {//else, fetch the posts with status requested
			
			query = "Select count(*) from posts where (posts_users_id='" + id + "' and status='" + status + "') and (link like '%" + search + "%' or type like '%" + search + "%' or "
					+ "title like '%" + search + "%' or categories like '%" + search + "%' or excerpt like '%" + search + "%' or body like '%" + search + "%' or "
					+ "tags like '%" + search + "%' or username like '%" + search + "%')";
			
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
	
	
	//check if post exist with id
	public boolean checkPostWithId(String id) throws Exception {

		Connect();

		String query = "Select * from posts where id= '" + id + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);  

		//while there is a data
		if(rs.next()) {
			return true;
		}

		st.close();
		con.close();

		return false;
	}
	
	
	//check if post exist with link
	public boolean checkPostWithLink(String link) throws Exception {

		Connect();

		String query = "Select * from posts where link= '" + link + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);  

		//while there is a data
		if(rs.next()) {
			return true;
		}

		st.close();
		con.close();

		return false;
	}
	
	//-----------------------------------------End Fetch-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//




	//-----------------------------------------Inserts-------------------------------------------------//

	//add new post
	public int addPost(Posts post) throws Exception {

		Connect();

		String query = "insert into posts (link,type,title,picture,categories,excerpt,body,tags,status,username,posts_users_id,date_time) values (?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);


		pst.setString(1, post.getLink());
		pst.setString(2, post.getType());
		pst.setString(3, post.getTitle());
		pst.setString(4, post.getPicture());
		pst.setString(5, post.getCategories());
		pst.setString(6, post.getExcerpt());
		pst.setString(7, post.getBody());
		pst.setString(8, post.getTags());
		pst.setString(9, post.getStatus());
		pst.setString(10, post.getUsername());
		pst.setLong(11, post.getPosts_users_id());
		pst.setString(12, post.getDate_time());
		
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

	//Update Post
	public int updatePost(Posts post) throws Exception {

		Connect();
		
		String query = "";
		
		//if picture is part of what will be updated
		if(post.getPicture() != null) {
			query = "update posts set link = ?,title = ?, picture = ?,categories = ?,excerpt = ?,body = ?,tags = ? where id = '" + post.getId() + "'";
		}
		else {//if not
			query = "update posts set link = ?,title = ?,categories = ?,excerpt = ?,body = ?,tags = ? where id = '" + post.getId() + "'";
		}
		
		PreparedStatement pst = con.prepareStatement(query);
		
		//if picture is part of what will be updated
		if(post.getPicture() != null) {
			//get the values to add to db from placeholder class
			pst.setString(1, post.getLink());
			pst.setString(2, post.getTitle());
			pst.setString(3, post.getPicture());
			pst.setString(4, post.getCategories());
			pst.setString(5, post.getExcerpt());
			pst.setString(6, post.getBody());
			pst.setString(7, post.getTags());
		}else {//if not
			//get the values to add to db from placeholder class
			pst.setString(1, post.getLink());
			pst.setString(2, post.getTitle());
			pst.setString(3, post.getCategories());
			pst.setString(4, post.getExcerpt());
			pst.setString(5, post.getBody());
			pst.setString(6, post.getTags());
		}

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	
	//Update post status
	public int updatePostStatus(Posts post) throws Exception {

		Connect();

		String query = "update posts set status = ? where id = '" + post.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, post.getStatus());

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	//Update post type
	public int updatePostType(Posts post) throws Exception {

		Connect();

		String query = "update posts set type = ? where id = '" + post.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, post.getType());

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	//Update post type and status together
	public int updatePostTypeStatus(Posts post) throws Exception {

		Connect();

		String query = "update posts set type = ?, status = ? where id = '" + post.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, post.getType());
		pst.setString(2, post.getStatus());
		
		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();
		

		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	
	
	//-----Special methods for handling category and tags delete-----//
	//on category delete, update all posts to remove the category from them
	public int updateCategoryOnDelete(String catOld, String catNew) throws Exception {

		Connect();
		
		//use sql replace() method
		String query = "update posts set categories = replace(categories, '" + catOld + "', '" + catNew + "')";

		Statement st = con.createStatement();
		//execute and get number rows affected
		int NumberOfRowsAffected = st.executeUpdate(query);
		

		st.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	
	//on category delete, any post with no more category will be converted to Uncategorised
	public int updateEmptyNullCategoryToUncategorised() throws Exception {

		Connect();
		
		//use sql coalesce() method //add a comma in front
		String query = "update posts set categories = COALESCE(NULLIF(categories,''), 'Uncategorised,')";

		Statement st = con.createStatement();
		//execute and get number rows affected
		int NumberOfRowsAffected = st.executeUpdate(query);
		

		st.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	
	//on tag delete, update all posts to remove the tag from them
	public int updateTagOnDelete(String tagOld, String tagNew) throws Exception {

		Connect();
		
		//use sql replace() method
		String query = "update posts set tags = replace(tags, '" + tagOld + "', '" + tagNew + "')";

		Statement st = con.createStatement();
		//execute and get number rows affected
		int NumberOfRowsAffected = st.executeUpdate(query);
		

		st.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	//on category delete, any post with no more category will be converted to Uncategorised
	public int updateEmptyTagToNull() throws Exception {

		Connect();
		
		//use sql nullif() method
		String query = "update posts set tags = NULLIF(tags,'')";

		Statement st = con.createStatement();
		//execute and get number rows affected
		int NumberOfRowsAffected = st.executeUpdate(query);
		

		st.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}

	//-----------------------------------------End Update-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//




	//-----------------------------------------Delete-------------------------------------------------//

	//delete post
	public int deletePost(String id) throws Exception {

		Connect();

		String query = "delete from posts where id=" + id;

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
