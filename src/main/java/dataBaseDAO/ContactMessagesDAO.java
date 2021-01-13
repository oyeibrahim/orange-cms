package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dataBaseModel.ContactMessages;

public class ContactMessagesDAO {


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
	
	//fetch all contact messages
	public List<ContactMessages> getAllMessages(String seen_status, int start, int total) throws Exception {

		Connect();

		List<ContactMessages> list=new ArrayList<ContactMessages>();  
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(seen_status.equals("All")) {//if All, fetch all
			query = "Select * from contact_messages ORDER BY created DESC limit " + start + "," + total;
		}else {//else, fetch the posts with status requested
			query = "Select * from contact_messages where seen_status='" + seen_status + "' ORDER BY created DESC limit " + start + "," + total;
		}

		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			ContactMessages message = new ContactMessages();  
			//set data to the model object created
			message.setId(rs.getLong("id"));
			message.setName(rs.getString("name"));
			message.setEmail(rs.getString("email"));
			message.setPurpose(rs.getString("purpose"));
			message.setTitle(rs.getString("title"));
			message.setMessage(rs.getString("message"));
			message.setSeen_status(rs.getString("seen_status"));
			message.setDate_time(rs.getString("date_time"));
			message.setCreated(rs.getString("created"));
			//add each object to list
			list.add(message);
		}

		st.close();
		con.close();

		return list;
	}
	
	
	//fetch search messages with pagination
	public List<ContactMessages> getSearchMessages(String search, String seen_status, int start, int total) throws Exception {

		Connect();

		List<ContactMessages> list=new ArrayList<ContactMessages>();  
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(seen_status.equals("All")) {//if All, fetch all
			query = "Select * from contact_messages where name like '%" + search + "%' or email like '%" + search + "%' or "
					+ "purpose like '%" + search + "%' or title like '%" + search + "%' or message like '%" + search + "%' "
							+ "ORDER BY created DESC limit " + start + "," + total;
			
		}else {//else, fetch the posts with status requested
			
			query = "Select * from contact_messages where (seen_status='" + seen_status + "') and (name like '%" + search + "%' "
					+ "or email like '%" + search + "%' or purpose like '%" + search + "%' or title like '%" + search + "%' "
							+ "or message like '%" + search + "%') ORDER BY created DESC limit " + start + "," + total;
			
		}
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			ContactMessages message = new ContactMessages();  
			//set data to the model object created
			message.setId(rs.getLong("id"));
			message.setName(rs.getString("name"));
			message.setEmail(rs.getString("email"));
			message.setPurpose(rs.getString("purpose"));
			message.setTitle(rs.getString("title"));
			message.setMessage(rs.getString("message"));
			message.setSeen_status(rs.getString("seen_status"));
			message.setDate_time(rs.getString("date_time"));
			message.setCreated(rs.getString("created"));
			//add each object to list
			list.add(message);
		}

		st.close();
		con.close();

		return list;
	}
	
	

	//fetch message
	public ContactMessages getMessage(String id) throws Exception {

		Connect();

		
		ContactMessages message = new ContactMessages();  
		
		String query = "Select * from contact_messages where id= '" + id + "'";

		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			
			//set data to the model object created
			message.setId(rs.getLong("id"));
			message.setName(rs.getString("name"));
			message.setEmail(rs.getString("email"));
			message.setPurpose(rs.getString("purpose"));
			message.setTitle(rs.getString("title"));
			message.setMessage(rs.getString("message"));
			message.setSeen_status(rs.getString("seen_status"));
			message.setDate_time(rs.getString("date_time"));
			message.setCreated(rs.getString("created"));
		}

		st.close();
		con.close();

		return message;
	}
	
	
	
	//check if message exist
	public boolean checkMessageWithId(String id) throws Exception {

		Connect();
		
		String query = "Select * from contact_messages where id= '" + id + "'";

		
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
	
	
	//get all contacts email
	public List<String> getAllContactsEmail() throws Exception {

		Connect();
		
		List<String> list=new ArrayList<String>();  
		
		//set query with condition
		String query= "select email from contact_messages";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
		while(rs.next()) {
			//create new object on every instance
			String email = rs.getString("email");
			
			list.add(email);
		}

		st.close();
		con.close();

		return list;
	}

	
	
	//count all messages for pagination
	public double countAllMessages(String seen_status) throws Exception {

		Connect();
		
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(seen_status.equals("All")) {//if All, fetch all
			query = "select count(*) from contact_messages";
		}else {//else, fetch the posts with status requested
			query = "select count(*) from contact_messages where seen_status= '" + seen_status + "'";
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
	
	//count all messages for a search
	public double countSearchMessages(String search, String seen_status) throws Exception {

		Connect();
	
		String query = "";
		
		//set query as fit for different status, "All" fetches all status
		if(seen_status.equals("All")) {//if All, fetch all
			query = "select count(*) from contact_messages where name like '%" + search + "%' or email like '%" + search + "%' "
					+ "or purpose like '%" + search + "%' or title like '%" + search + "%' or message like '%" + search + "%'";
			
		}else {//else, fetch the posts with status requested
			
			query = "Select count(*) from contact_messages where (seen_status='" + seen_status + "') and (name like '%" + search + "%' "
					+ "or email like '%" + search + "%' or purpose like '%" + search + "%' or title like '%" + search + "%' "
							+ "or message like '%" + search + "%')";
			
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
	
	

	//-----------------------------------------End Fetch-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//




	//-----------------------------------------Inserts-------------------------------------------------//

	//add new contact message
	public int addContactMessage(ContactMessages message) throws Exception {

		Connect();

		//the comments_users_id will be 0 if an anonymous user
		String query = "insert into contact_messages (name,email,purpose,title,message,seen_status,date_time) values (?,?,?,?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);


		pst.setString(1, message.getName());
		pst.setString(2, message.getEmail());
		pst.setString(3, message.getPurpose());
		pst.setString(4, message.getTitle());
		pst.setString(5, message.getMessage());
		pst.setString(6, message.getSeen_status());
		pst.setString(7, message.getDate_time());
		
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

	//Update message seen status
	public int updateMessageSeenStatus(ContactMessages cm) throws Exception {

		Connect();

		String query = "update contact_messages set seen_status = ? where id = '" + cm.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, cm.getSeen_status());

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

	//delete message
	public int deleteMessage(String id) throws Exception {

		Connect();

		String query = "delete from contact_messages where id=" + id;

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
