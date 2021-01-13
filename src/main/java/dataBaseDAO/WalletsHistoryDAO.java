package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dataBaseModel.WalletsHistory;

public class WalletsHistoryDAO {


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
	public List<WalletsHistory> getHistory(String username, int start, int total) throws Exception {

		Connect();

		List<WalletsHistory> list=new ArrayList<WalletsHistory>();  

		String query = "Select * from wallets_history where username= '" + username + "' ORDER BY timestamp DESC limit " + start + "," + total;

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		//while there is a data
		while(rs.next()) {
			//get data from DB
			//create new object on every instance
			WalletsHistory wh = new WalletsHistory();  
			//set data to the model object created
            wh.setId(rs.getLong("id"));
            wh.setAmount(rs.getDouble("amount")); 
            wh.setCoin(rs.getString("coin")); 
            wh.setAction(rs.getString("action")); 
            wh.setStatus(rs.getString("status"));
            wh.setDetails(rs.getString("details")); 
            wh.setDate_time(rs.getString("date_time"));
            //add each object to list
            list.add(wh);
		}

		st.close();
		con.close();

		return list;
	}
	
	//count all history for pagination
	public double countHistory(String username) throws Exception {

		Connect();

		String query = "select count(*) from wallets_history where username= '" + username + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//while there is a data
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

	//add new history
	public int addWalletHistory(WalletsHistory history) throws Exception {
		
		Connect();
		
		String query = "insert into wallets_history (amount,coin,action,details,status,date_time,username,history_user_id) values (?,?,?,?,?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);
		
		
		pst.setDouble(1, history.getAmount());
		pst.setString(2, history.getCoin());
		pst.setString(3, history.getAction());
		pst.setString(4, history.getDetails());
		pst.setString(5, history.getStatus());
		pst.setString(6, history.getDate_time());
		pst.setString(7, history.getUsername());
		pst.setLong(8, history.getHistory_user_id());
		
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




	//-----------------------------------------End Update-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//

	
	
	
	//-----------------------------------------Delete-------------------------------------------------//




	//-----------------------------------------End Delete-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//


}
