package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dataBaseModel.SiteStructure;

public class SiteStructureDAO {


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

	//fetch all settings
	public List<SiteStructure> getAllStructures(int start, int total) throws Exception {

		Connect();

		List<SiteStructure> list=new ArrayList<SiteStructure>();  
		
		String query = "Select * from site_structure ORDER BY created DESC limit " + start + "," + total;
			
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			SiteStructure structure = new SiteStructure();
			//set data to the model object created
			//set structure data to structure class
			structure.setId(rs.getLong("id"));
			structure.setName(rs.getString("name"));
			structure.setText_value1(rs.getString("text_value1"));
			structure.setText_value2(rs.getString("text_value2"));
			structure.setText_value3(rs.getString("text_value3"));
			structure.setNum_value1(rs.getDouble("num_value1"));
			structure.setNum_value2(rs.getDouble("num_value2"));
			structure.setNum_value3(rs.getDouble("num_value3"));
			structure.setCreated(rs.getString("created"));
			structure.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(structure);
		}

		st.close();
		con.close();

		return list;
	}
	
	//fetch search settings
	public List<SiteStructure> getSearchStructures(String search, int start, int total) throws Exception {

		Connect();

		List<SiteStructure> list=new ArrayList<SiteStructure>();  
		
		
		String query = "Select * from site_structure where name like '%" + search + "%' or text_value1 like '%" + search + "%' or "
				+ "text_value2 like '%" + search + "%' or text_value3 like '%" + search + "%' or num_value1 like '%" + search + "%' or "
				+ "num_value2 like '%" + search + "%' or num_value3 like '%" + search + "%' "
				+ "ORDER BY created DESC limit " + start + "," + total;
			
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			SiteStructure structure = new SiteStructure();
			//set data to the model object created
			//set structure data to structure class
			structure.setId(rs.getLong("id"));
			structure.setName(rs.getString("name"));
			structure.setText_value1(rs.getString("text_value1"));
			structure.setText_value2(rs.getString("text_value2"));
			structure.setText_value3(rs.getString("text_value3"));
			structure.setNum_value1(rs.getDouble("num_value1"));
			structure.setNum_value2(rs.getDouble("num_value2"));
			structure.setNum_value3(rs.getDouble("num_value3"));
			structure.setCreated(rs.getString("created"));
			structure.setUpdated(rs.getString("updated"));
			//add each object to list
			list.add(structure);
		}

		st.close();
		con.close();

		return list;
	}
	
	//get a structure with id
	public SiteStructure getStructureWithId(String id) throws Exception {
		
		Connect();
		
		SiteStructure structure = new SiteStructure();
		
		String query = "Select * from site_structure where id= '" + id + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		if(rs.next()) {
			//set structure data to structure class
			structure.setId(rs.getLong("id"));
			structure.setName(rs.getString("name"));
			structure.setText_value1(rs.getString("text_value1"));
			structure.setText_value2(rs.getString("text_value2"));
			structure.setText_value3(rs.getString("text_value3"));
			structure.setNum_value1(rs.getDouble("num_value1"));
			structure.setNum_value2(rs.getDouble("num_value2"));
			structure.setNum_value3(rs.getDouble("num_value3"));
			structure.setCreated(rs.getString("created"));
			structure.setUpdated(rs.getString("updated"));
		}
		
		st.close();
		con.close();
		
		return structure;
	}
	
	//get a structure with name
	public SiteStructure getStructure(String name) throws Exception {
		
		Connect();
		
		SiteStructure structure = new SiteStructure();
		
		String query = "Select * from site_structure where name= '" + name + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		if(rs.next()) {
			//set structure data to structure class
			structure.setId(rs.getLong("id"));
			structure.setName(rs.getString("name"));
			structure.setText_value1(rs.getString("text_value1"));
			structure.setText_value2(rs.getString("text_value2"));
			structure.setText_value3(rs.getString("text_value3"));
			structure.setNum_value1(rs.getDouble("num_value1"));
			structure.setNum_value2(rs.getDouble("num_value2"));
			structure.setNum_value3(rs.getDouble("num_value3"));
			structure.setCreated(rs.getString("created"));
			structure.setUpdated(rs.getString("updated"));
		}
		
		st.close();
		con.close();
		
		return structure;
	}
	
	//check if structure exist
	public boolean checkStructureWithId(String id) throws Exception {

		Connect();
		
		String query = "Select * from site_structure where id= '" + id + "'";

		
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
	
	
	
	//count all structures for pagination
	public double countAllStructures() throws Exception {

		Connect();
		
		String query = "select count(*) from site_structure";
		
		
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
	
	//count all structures for a search
	public double countSearchStructures(String search) throws Exception {

		Connect();
	
		String query = "Select count(*) from site_structure where name like '%" + search + "%' or text_value1 like '%" + search + "%' or "
				+ "text_value2 like '%" + search + "%' or text_value3 like '%" + search + "%' or num_value1 like '%" + search + "%' or "
				+ "num_value2 like '%" + search + "%' or num_value3 like '%" + search + "%'";
		
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

	//add new structure
	public int addStructure(SiteStructure ss) throws Exception {

		Connect();
		
		
		String query = "insert into site_structure (name,text_value1,text_value2,text_value3,num_value1,num_value2,num_value3) values (?,?,?,?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);


		pst.setString(1, ss.getName());
		pst.setString(2, ss.getText_value1());
		pst.setString(3, ss.getText_value2());
		pst.setString(4, ss.getText_value3());
		pst.setDouble(5, ss.getNum_value1());
		pst.setDouble(6, ss.getNum_value2());
		pst.setDouble(7, ss.getNum_value3());

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
	
	//update structure
	public int updateStructure(SiteStructure ss) throws Exception {

		Connect();

		String query = "update site_structure set name = ?,text_value1 = ?,text_value2 = ?,text_value3 = ?,num_value1 = ?,num_value2 = ?,num_value3 = ? where id ='" + ss.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, ss.getName());
		pst.setString(2, ss.getText_value1());
		pst.setString(3, ss.getText_value2());
		pst.setString(4, ss.getText_value3());
		pst.setDouble(5, ss.getNum_value1());
		pst.setDouble(6, ss.getNum_value2());
		pst.setDouble(7, ss.getNum_value3());

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();

		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	//-----------------------------------------End Update-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//

	
	
	
	//-----------------------------------------Delete-------------------------------------------------//

	//delete structure
	public int deleteStructure(String id) throws Exception {

		Connect();

		String query = "delete from site_structure where id=" + id;

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
