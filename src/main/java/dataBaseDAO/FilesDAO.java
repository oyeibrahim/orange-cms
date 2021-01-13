package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dataBaseModel.Files;

public class FilesDAO {


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
	public List<Files> getFiles(int start, int total) throws Exception {

		Connect();

		List<Files> list=new ArrayList<Files>();  

		String query = "Select * from files ORDER BY created DESC limit " + start + "," + total;

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Files file = new Files();  
			//set data to the model object created
			file.setId(rs.getLong("id"));
			file.setType(rs.getString("type"));
			file.setExtension(rs.getString("extension"));
			file.setPath(rs.getString("path"));
			file.setName(rs.getString("name"));
			file.setUsage_count(rs.getLong("usage_count"));
			file.setUsername(rs.getString("username"));
			file.setFiles_users_id(rs.getLong("files_users_id"));
			file.setDate_time(rs.getString("date_time"));
			file.setCreated(rs.getString("created"));
			file.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(file);
		}

		st.close();
		con.close();

		return list;
	}
	
	
	//fetch with username with pagination
	public List<Files> getUserFiles(String username, int start, int total) throws Exception {

		Connect();

		List<Files> list=new ArrayList<Files>();  

		String query = "Select * from files where username='" + username  + "' ORDER BY created DESC limit " + start + "," + total;

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Files file = new Files();  
			//set data to the model object created
			file.setId(rs.getLong("id"));
			file.setType(rs.getString("type"));
			file.setExtension(rs.getString("extension"));
			file.setPath(rs.getString("path"));
			file.setName(rs.getString("name"));
			file.setUsage_count(rs.getLong("usage_count"));
			file.setUsername(rs.getString("username"));
			file.setFiles_users_id(rs.getLong("files_users_id"));
			file.setDate_time(rs.getString("date_time"));
			file.setCreated(rs.getString("created"));
			file.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(file);
		}

		st.close();
		con.close();

		return list;
	}
	
	
	
	//fetch file with any query that can be String like name or long like id
	public Files getFile(String question, String wordMatch, long numMatch) throws Exception {

		Connect(); 
		
		String query = "";
		
		//if we are querying String
		if(!wordMatch.isEmpty()) {
			query = "Select * from files where " + question + "='" + wordMatch + "'";
		}else {//else if long
			query = "Select * from files where " + question + "='" + numMatch + "'";
		}

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		Files file = new Files(); 

		//if there is a data
		if(rs.next()) {
			//get data from DB 
			//set data to the model object created
			file.setId(rs.getLong("id"));
			file.setType(rs.getString("type"));
			file.setExtension(rs.getString("extension"));
			file.setPath(rs.getString("path"));
			file.setName(rs.getString("name"));
			file.setUsage_count(rs.getLong("usage_count"));
			file.setUsername(rs.getString("username"));
			file.setFiles_users_id(rs.getLong("files_users_id"));
			file.setDate_time(rs.getString("date_time"));
			file.setCreated(rs.getString("created"));
			file.setUpdated(rs.getString("updated"));
		}

		st.close();
		con.close();

		return file;
	}
	
	
	
	
	
	
	

	//count all files for pagination
	public double countFiles() throws Exception {

		Connect();

		String query = "select count(*) from files";

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
	
	
	//count user files for pagination
	public double countUserFiles(String username) throws Exception {

		Connect();

		String query = "select count(*) from files where username='" + username + "'";

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

	//add new file
	public int addFile(Files file) throws Exception {

		Connect();
		
		String query = "insert into files (type,extension,path,name,alt,usage_count,username,files_users_id,date_time) values (?,?,?,?,?,?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);

		
		pst.setString(1, file.getType());
		pst.setString(2, file.getExtension());
		pst.setString(3, file.getPath());
		pst.setString(4, file.getName());
		pst.setString(5, file.getAlt());
		pst.setLong(6, file.getUsage_count());
		pst.setString(7, file.getUsername());
		pst.setLong(8, file.getFiles_users_id());
		pst.setString(9, file.getDate_time());

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

	//Update file
	public int updateFile(Files file) throws Exception {

		Connect();

		String query = "update files set path = ?, name = ? where id = '" + file.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, file.getPath());
		pst.setString(2, file.getName());

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	
	//Update Usage Count
	public int updateFileUsageCount(String path, int num) throws Exception {

		Connect();

		String query = "update files set usage_count = ? where 	path = '" + path + "'";

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
	
	
	//Add Usage Count
	public int addFileUsageCount(String path, int num) throws Exception {

		Connect();

		String query = "update files set usage_count = usage_count + " + num + " where path = ?";
		

		PreparedStatement pst = con.prepareStatement(query);

		//set the name
		pst.setString(1, path);

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	//Subtract Usage Count
	public int subtractFileUsageCount(String path, int num) throws Exception {


		Connect();
		
		//check if post_count is not zero before subtracting
		String query1 = "Select * from files where path='" + path + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query1);

		//if there is a data
		if(rs.next()) {
			//if not zero then do the subtraction
			if(rs.getLong("usage_count") != 0) {
				String query2 = "update files set usage_count = usage_count - " + num + " where path = ?";


				PreparedStatement pst = con.prepareStatement(query2);

				//set the name
				pst.setString(1, path);

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

	//delete file
	public int deleteFile(String path) throws Exception {

		Connect();

		String query = "delete from files where path=" + path;

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
