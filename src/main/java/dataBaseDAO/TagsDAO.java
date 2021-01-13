package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dataBaseModel.Tags;

public class TagsDAO {


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

	//fetch with pagination
	public List<Tags> getTags(int start, int total) throws Exception {

		Connect();

		List<Tags> list=new ArrayList<Tags>();  

		String query = "Select * from tags ORDER BY created DESC limit " + start + "," + total;

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Tags tag = new Tags();  
			//set data to the model object created
			tag.setId(rs.getLong("id"));
			tag.setName(rs.getString("name"));
			tag.setPost_count(rs.getLong("post_count"));
			tag.setUsername(rs.getString("username"));
			tag.setTags_users_id(rs.getLong("tags_users_id"));
			tag.setDate_time(rs.getString("date_time"));
			tag.setCreated(rs.getString("created"));
			tag.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(tag);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch without pagination
	public List<Tags> getTagsNoPagination() throws Exception {

		Connect();

		List<Tags> list=new ArrayList<Tags>();  

		String query = "Select * from tags ORDER BY created";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Tags tag = new Tags();  
			//set data to the model object created
			tag.setId(rs.getLong("id"));
			tag.setName(rs.getString("name"));
			tag.setPost_count(rs.getLong("post_count"));
			tag.setUsername(rs.getString("username"));
			tag.setTags_users_id(rs.getLong("tags_users_id"));
			tag.setDate_time(rs.getString("date_time"));
			tag.setCreated(rs.getString("created"));
			tag.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(tag);
		}

		st.close();
		con.close();

		return list;
	}
	
	//search tags with pagination
	public List<Tags> searchTags(String search, int start, int total) throws Exception {

		Connect();

		List<Tags> list=new ArrayList<Tags>();  

		String query = "Select * from tags where name like '%" + search + "%' or username like '%" + search + "%' ORDER BY created DESC limit " + start + "," + total;

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Tags tag = new Tags();  
			//set data to the model object created
			tag.setId(rs.getLong("id"));
			tag.setName(rs.getString("name"));
			tag.setPost_count(rs.getLong("post_count"));
			tag.setUsername(rs.getString("username"));
			tag.setTags_users_id(rs.getLong("tags_users_id"));
			tag.setDate_time(rs.getString("date_time"));
			tag.setCreated(rs.getString("created"));
			tag.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(tag);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch tag
	public Tags getTag(long id) throws Exception {

		Connect(); 

		String query = "Select * from tags where id='" + id + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		Tags tag = new Tags(); 

		//if there is a data
		if(rs.next()) {
			//get data from DB 
			//set data to the model object created
			tag.setId(rs.getLong("id"));
			tag.setName(rs.getString("name"));
			tag.setPost_count(rs.getLong("post_count"));
			tag.setUsername(rs.getString("username"));
			tag.setTags_users_id(rs.getLong("tags_users_id"));
			tag.setDate_time(rs.getString("date_time"));
			tag.setCreated(rs.getString("created"));
			tag.setUpdated(rs.getString("updated"));
		}

		st.close();
		con.close();

		return tag;
	}
	
	//fetch tag name with id
	public String getTagName(String id) throws Exception {

		Connect();

		String query = "Select name from tags where id='" + id + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		String name = "";

		//if there is a data
		if(rs.next()) {
			//get data from DB
			name = rs.getString("name");
		}

		st.close();
		con.close();

		return name;
	}
	
	//check if tag exist
	public boolean checkTag(String name) throws Exception {

		Connect(); 

		String query = "Select * from tags where name='" + name + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//if there is a data
		if(rs.next()) {
			return true;
		}

		st.close();
		con.close();

		return false;
	}

	//count all tags for pagination
	public double countTags() throws Exception {

		Connect();

		String query = "select count(*) from tags";

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
	
	//count search tags for pagination
	public double countSearchTags(String search) throws Exception {

		Connect();

		String query = "select count(*) from tags where name like '%" + search + "%' or username like '%" + search + "%'";

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

	//-----------------------------------------End Fetch-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//




	//-----------------------------------------Inserts-------------------------------------------------//

	//add new tag
	public int addTag(Tags tag) throws Exception {

		Connect();

		String query = "insert into tags (name,username,tags_users_id,date_time) values (?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);


		pst.setString(1, tag.getName());
		pst.setString(2, tag.getUsername());
		pst.setLong(3, tag.getTags_users_id());
		pst.setString(4, tag.getDate_time());

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

	//Update Tag
	public int updateTag(Tags tag) throws Exception {

		Connect();

		String query = "update tags set name = ? where id = '" + tag.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, tag.getName());

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	
	//Update Count
	public int updateTagPostCount(String name, int num) throws Exception {

		Connect();

		String query = "update tags set post_count = ? where name = '" + name + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setLong(1, num);

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	
	//Add Count
	public int addTagPostCount(String name, int num) throws Exception {

		Connect();

		String query = "update tags set post_count = post_count + " + num + " where name = ?";
		

		PreparedStatement pst = con.prepareStatement(query);

		//set the name
		pst.setString(1, name);

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	//Subtract Count
	public int subtractTagPostCount(String name, int num) throws Exception {

		Connect();

		//check if post_count is not zero before subtracting
		String query1 = "Select * from tags where name='" + name + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query1);

		//if there is a data
		if(rs.next()) {
			//if not zero then do the subtraction
			if(rs.getLong("post_count") != 0) {
				String query2 = "update tags set post_count = post_count - " + num + " where name = ?";
				

				PreparedStatement pst = con.prepareStatement(query2);

				//set the name
				pst.setString(1, name);

				//execute and get number of rows affected
				int NumberOfRowsAffected = pst.executeUpdate();


				pst.close();
				con.close();

				//return number of users added
				return NumberOfRowsAffected;
			}
		}
		
		return -1;

	}


	//-----------------------------------------End Update-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//




	//-----------------------------------------Delete-------------------------------------------------//

	//delete tag
	public int deleteTag(String id) throws Exception {

		Connect();

		String query = "delete from tags where id=" + id;

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
