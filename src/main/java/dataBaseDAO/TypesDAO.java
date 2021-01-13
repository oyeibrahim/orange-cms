package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dataBaseModel.Types;

public class TypesDAO {


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
	public List<Types> getTypes(int start, int total) throws Exception {

		Connect();

		List<Types> list=new ArrayList<Types>();  

		String query = "Select * from types ORDER BY created DESC limit " + start + "," + total;

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Types type = new Types();  
			//set data to the model object created
			type.setId(rs.getLong("id"));
			type.setName(rs.getString("name"));
			type.setPost_count(rs.getLong("post_count"));
			type.setUsername(rs.getString("username"));
			type.setTypes_users_id(rs.getLong("types_users_id"));
			type.setDate_time(rs.getString("date_time"));
			type.setCreated(rs.getString("created"));
			type.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(type);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch without pagination
	public List<Types> getTypesNoPagination() throws Exception {

		Connect();

		List<Types> list=new ArrayList<Types>();  

		String query = "Select * from types ORDER BY created";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Types type = new Types();  
			//set data to the model object created
			type.setId(rs.getLong("id"));
			type.setName(rs.getString("name"));
			type.setPost_count(rs.getLong("post_count"));
			type.setUsername(rs.getString("username"));
			type.setTypes_users_id(rs.getLong("types_users_id"));
			type.setDate_time(rs.getString("date_time"));
			type.setCreated(rs.getString("created"));
			type.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(type);
		}

		st.close();
		con.close();

		return list;
	}
	
	//search types with pagination
	public List<Types> searchTypes(String search, int start, int total) throws Exception {

		Connect();

		List<Types> list=new ArrayList<Types>();  

		String query = "Select * from types where name like '%" + search + "%' or username like '%" + search + "%' ORDER BY created DESC limit " + start + "," + total;

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Types type = new Types();  
			//set data to the model object created
			type.setId(rs.getLong("id"));
			type.setName(rs.getString("name"));
			type.setPost_count(rs.getLong("post_count"));
			type.setUsername(rs.getString("username"));
			type.setTypes_users_id(rs.getLong("types_users_id"));
			type.setDate_time(rs.getString("date_time"));
			type.setCreated(rs.getString("created"));
			type.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(type);
		}

		st.close();
		con.close();

		return list;
	}

	//fetch type
	public Types getType(long id) throws Exception {

		Connect(); 

		String query = "Select * from types where id='" + id + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		Types type = new Types(); 

		//while there is a data
		while(rs.next()) {
			//get data from DB 
			//set data to the model object created
			type.setId(rs.getLong("id"));
			type.setName(rs.getString("name"));
			type.setPost_count(rs.getLong("post_count"));
			type.setUsername(rs.getString("username"));
			type.setTypes_users_id(rs.getLong("types_users_id"));
			type.setDate_time(rs.getString("date_time"));
			type.setCreated(rs.getString("created"));
			type.setUpdated(rs.getString("updated"));
		}

		st.close();
		con.close();

		return type;
	}
	
	//fetch type name with id
	public String getTypeName(String id) throws Exception {

		Connect();

		String query = "Select name from types where id='" + id + "'";

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
	
	//check if type exist
	public boolean checkType(String name) throws Exception {

		Connect(); 

		String query = "Select * from types where name='" + name + "'";

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
	
	//count all types for pagination
	public double countTypes() throws Exception {

		Connect();

		String query = "select count(*) from types";

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
	
	//count search types for pagination
	public double countSearchTypes(String search) throws Exception {

		Connect();

		String query = "select count(*) from types where name like '%" + search + "%' or username like '%" + search + "%'";

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

	//add new type
	public int addType(Types type) throws Exception {

		Connect();

		String query = "insert into types (name,username,types_users_id,date_time) values (?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);


		pst.setString(1, type.getName());
		pst.setString(2, type.getUsername());
		pst.setLong(3, type.getTypes_users_id());
		pst.setString(4, type.getDate_time());

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

	//Update Type
	public int updateType(Types type) throws Exception {

		Connect();

		String query = "update types set name = ? where id = '" + type.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, type.getName());

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	
	
	//Update Count
	public int updateTypePostCount(String name, int num) throws Exception {

		Connect();

		String query = "update types set post_count = ? where name = '" + name + "'";

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
	public int addTypePostCount(String name, int num) throws Exception {

		Connect();

		String query = "update types set post_count = post_count + " + num + " where name = ?";
		

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
	public int subtractTypePostCount(String name, int num) throws Exception {

		Connect();

		//check if post_count is not zero before subtracting
		String query1 = "Select * from types where name='" + name + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query1);

		//if there is a data
		if(rs.next()) {
			//if not zero then do the subtraction
			if(rs.getLong("post_count") != 0) {
				String query2 = "update types set post_count = post_count - " + num + " where name = ?";
				

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

	//delete type
	public int deleteType(String id) throws Exception {

		Connect();

		String query = "delete from types where id=" + id;

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
