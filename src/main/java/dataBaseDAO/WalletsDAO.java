package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import dataBaseModel.Users;
import dataBaseModel.Wallets;

public class WalletsDAO {


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

	public Wallets getWallet(Users user) throws Exception {
		
		Connect();
		
		Wallets wallet = new Wallets();
		
		String query = "Select * from wallets where wallets_user_id= '" + user.getId() + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		if(rs.next()) {
			//get wallet data from DB
			long id = rs.getLong("id");
			double bayk = rs.getDouble("bayk");
			double bayk_hold = rs.getDouble("bayk_hold");
			double ctk = rs.getDouble("ctk");
			double ctk_hold = rs.getDouble("ctk_hold");
			String username = rs.getString("username");
			long user_id = rs.getLong("wallets_user_id");

			//set wallet data to Wallets class
			wallet.setId(id);
			wallet.setBayk(bayk);
			wallet.setBayk_hold(bayk_hold);
			wallet.setCtk(ctk);
			wallet.setCtk_hold(ctk_hold);
			wallet.setUsername(username);
			wallet.setWallets_user_id(user_id);
		}
		
		st.close();
		con.close();
		
		return wallet;
	}

	//-----------------------------------------End Fetch-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//




	//-----------------------------------------Inserts-------------------------------------------------//

	//add new wallet row for the newly activated user
	public int addWallet(Users user) throws Exception {
		
		Connect();
		
		String query = "insert into wallets (username,wallets_user_id) values (?,?)";
		PreparedStatement pst = con.prepareStatement(query);
		
		
		pst.setString(1, user.getUsername());
		pst.setLong(2, user.getId());
		
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

	//add to user's BAYK tokens
	public int addBAYK(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set bayk= bayk + " + num + " where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;
		
	}
	
	//subtract from user's BAYK tokens
	public int subtractBAYK(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set bayk= bayk - " + num + " where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;
		
	}
	
	//update user's BAYK tokens
	public int updateBAYK(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set bayk='" + num + "' where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;
		
	}
	
	
	
	//add to user's BAYK Hold tokens
	public int addBaykHold(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set bayk_hold= bayk_hold + " + num + " where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;
		
	}
	
	//subtract from user's BAYK Hold tokens
	public int subtractBaykHold(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set bayk_hold= bayk_hold - " + num + " where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;
		
	}
	
	//update user's BAYK Hold tokens
	public int updateBaykHold(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set bayk_hold='" + num + "' where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;
		
	}
	
	
	
	
	//add to user's CTK tokens
	public int addCTK(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set ctk= ctk + " + num + " where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;
		
	}
	
	//subtract from user's CTK tokens
	public int subtractCTK(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set ctk= ctk - " + num + " where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;
		
	}
	
	//update user's CTK tokens
	public int updateCTK(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set ctk='" + num + "' where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;
		
	}
	
	
	//add to user's CTK Hold tokens
	public int addCtkHold(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set ctk_hold= ctk_hold + " + num + " where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}

	//subtract from user's CTK Hold tokens
	public int subtractCtkHold(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set ctk_hold= ctk_hold - " + num + " where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}

	//update user's CTK Hold tokens
	public int updateCtkHold(String username, double num) throws Exception {

		Connect();

		String query = "update wallets set ctk_hold='" + num + "' where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, username);

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




	//-----------------------------------------End Delete-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//


}
