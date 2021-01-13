package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dataBaseModel.Categories;

public class CategoriesDAO {


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
	public List<Categories> getCategories(int start, int total) throws Exception {

		Connect();

		List<Categories> list=new ArrayList<Categories>();  

		String query = "Select * from categories ORDER BY created DESC limit " + start + "," + total;

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Categories category = new Categories();  
			//set data to the model object created
			category.setId(rs.getLong("id"));
			category.setName(rs.getString("name"));
			category.setPost_count(rs.getLong("post_count"));
			category.setUsername(rs.getString("username"));
			category.setCategories_users_id(rs.getLong("categories_users_id"));
			category.setDate_time(rs.getString("date_time"));
			category.setCreated(rs.getString("created"));
			category.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(category);
		}

		st.close();
		con.close();

		return list;
	}

	//fetch without pagination
	public List<Categories> getCategoriesNoPagination() throws Exception {

		Connect();

		List<Categories> list=new ArrayList<Categories>();  

		String query = "Select * from categories ORDER BY created";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Categories category = new Categories();  
			//set data to the model object created
			category.setId(rs.getLong("id"));
			category.setName(rs.getString("name"));
			category.setPost_count(rs.getLong("post_count"));
			category.setUsername(rs.getString("username"));
			category.setCategories_users_id(rs.getLong("categories_users_id"));
			category.setDate_time(rs.getString("date_time"));
			category.setCreated(rs.getString("created"));
			category.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(category);
		}

		st.close();
		con.close();

		return list;
	}

	//search categories with pagination
	public List<Categories> searchCategories(String search, int start, int total) throws Exception {

		Connect();

		List<Categories> list=new ArrayList<Categories>();  

		String query = "Select * from categories where name like '%" + search + "%' or username like '%" + search + "%' ORDER BY created DESC limit " + start + "," + total;

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			Categories category = new Categories();  
			//set data to the model object created
			category.setId(rs.getLong("id"));
			category.setName(rs.getString("name"));
			category.setPost_count(rs.getLong("post_count"));
			category.setUsername(rs.getString("username"));
			category.setCategories_users_id(rs.getLong("categories_users_id"));
			category.setDate_time(rs.getString("date_time"));
			category.setCreated(rs.getString("created"));
			category.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(category);
		}

		st.close();
		con.close();

		return list;
	}

	//fetch category with id
	public Categories getCategory(long id) throws Exception {

		Connect();

		String query = "Select * from categories where id='" + id + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		Categories category = new Categories(); 

		//if there is a data
		if(rs.next()) {
			//get data from DB
			//set data to the model object created
			category.setId(rs.getLong("id"));
			category.setName(rs.getString("name"));
			category.setPost_count(rs.getLong("post_count"));
			category.setUsername(rs.getString("username"));
			category.setCategories_users_id(rs.getLong("categories_users_id"));
			category.setDate_time(rs.getString("date_time"));
			category.setCreated(rs.getString("created"));
			category.setUpdated(rs.getString("updated"));
		}

		st.close();
		con.close();

		return category;
	}
	
	//fetch category name with id
	public String getCategoryName(String id) throws Exception {

		Connect();

		String query = "Select name from categories where id='" + id + "'";

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

	//check if category exist
	public boolean checkCategory(String name) throws Exception {

		Connect();

		String query = "Select * from categories where name='" + name + "'";

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

	//count all category for pagination
	public double countCategories() throws Exception {

		Connect();

		String query = "select count(*) from categories";

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
	
	//count search category for pagination
	public double countSearchCategories(String search) throws Exception {

		Connect();

		String query = "select count(*) from categories where name like '%" + search + "%' or username like '%" + search + "%'";

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

	//add new category
	public int addCategory(Categories category) throws Exception {

		Connect();

		String query = "insert into categories (name,username,categories_users_id,date_time) values (?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);


		pst.setString(1, category.getName());
		pst.setString(2, category.getUsername());
		pst.setLong(3, category.getCategories_users_id());
		pst.setString(4, category.getDate_time());

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

	//Update Category
	public int updateCategory(Categories category) throws Exception {

		Connect();

		String query = "update categories set name = ? where id = '" + category.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, category.getName());

		//execute and get number of rows affected
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	//Update Count
	public int updateCategoryPostCount(String name, int num) throws Exception {

		Connect();

		String query = "update categories set post_count = ? where name = '" + name + "'";

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
	public int addCategoryPostCount(String name, int num) throws Exception {

		Connect();

		String query = "update categories set post_count = post_count + " + num + " where name = ?";
		

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
	public int subtractCategoryPostCount(String name, int num) throws Exception {
		

		Connect();
		
		//check if post_count is not zero before subtracting
		String query1 = "Select * from categories where name='" + name + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query1);

		//if there is a data
		if(rs.next()) {
			//if not zero then do the subtraction
			if(rs.getLong("post_count") != 0) {
				String query2 = "update categories set post_count = post_count - " + num + " where name = ?";


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

	//delete category
	public int deleteCategory(String id) throws Exception {

		Connect();

		String query = "delete from categories where id=" + id;

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
