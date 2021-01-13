package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import dataBaseModel.Referral;

public class ReferralDAO {


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
	
	//get referral from DB
	public Referral getReferral(String code) throws Exception {
		
		Connect();
		
		Referral referral = new Referral();
		
		String query = "Select * from referral where code= '" + code + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		if(rs.next()) {
			//set referral data to Referral class
			referral.setId(rs.getLong("id"));
			referral.setCode(rs.getString("code"));
			referral.setReferrals(rs.getInt("referrals"));
			referral.setPending(rs.getInt("pending"));
			referral.setReferred_by(rs.getString("referred_by"));
			referral.setUsername(rs.getString("username"));
			referral.setReferral_user_id(rs.getLong("referral_user_id"));
		}
		
		st.close();
		con.close();
		
		return referral;
	}
	
	//get referral from DB with username
	public Referral getReferralWithUsername(String username) throws Exception {

		Connect();

		Referral referral = new Referral();

		String query = "Select * from referral where username= '" + username + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		if(rs.next()) {
			//set referral data to Referral class
			referral.setId(rs.getLong("id"));
			referral.setCode(rs.getString("code"));
			referral.setReferrals(rs.getInt("referrals"));
			referral.setPending(rs.getInt("pending"));
			referral.setReferred_by(rs.getString("referred_by"));
			referral.setUsername(rs.getString("username"));
			referral.setReferral_user_id(rs.getLong("referral_user_id"));
		}

		st.close();
		con.close();

		return referral;
	}
	
	//get only username
	public String getUsername(String code) throws Exception {
		
		Connect();
		
		String query = "Select * from referral where code= '" + code + "'";
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		if(rs.next()) {
			//get username data from DB
			String username = rs.getString("username");
			
			return username;
		}
		
		st.close();
		con.close();
		
		return "";
	}
	
	
	//check if referral code exist and return 1 if exist or 0 if not
	public int checkCode(String code) throws Exception {

		Connect();

		String query = "Select * from referral where code= '" + code + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		if(rs.next()) {
			st.close();
			con.close();
			
			return 1;
		}
		else {
			st.close();
			con.close();
			
			return 0;
		}
		
		
	}
	
	
	//check if count is not zero //used to check for subtracting
	public boolean isUsageCountZero(String path) throws Exception {

		Connect();

		String query = "Select * from files where path='" + path + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		//if there is a data
		if(rs.next()) {
			if(rs.getLong("usage_count") == 0) {
				return true;
			}
			
		}

		st.close();
		con.close();

		return false;
	}

	//-----------------------------------------End Fetch-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//




	//-----------------------------------------Inserts-------------------------------------------------//

	//add new referral row for the newly activated user
	public int addNewReferral(Referral ref) throws Exception {

		Connect();

		String query = "insert into referral (code,referred_by,username,referral_user_id) values (?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);


		pst.setString(1, ref.getCode());
		pst.setString(2, ref.getReferred_by());
		pst.setString(3, ref.getUsername());
		pst.setLong(4, ref.getReferral_user_id());

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

	//add to referrals
	public int addReferrals(String code) throws Exception {

		Connect();

		String query = "update referral set referrals= referrals + 1 where code = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, code);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}
	
	//subtract from referrals
	public int subtractReferrals(String code) throws Exception {

		Connect();
		
		//check if the count is not zero before subtracting
		String query1 = "Select * from referral where code='" + code + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query1);

		//if there is a data
		if(rs.next()) {
			//if not zero then do the subtraction
			if(rs.getLong("referrals") != 0) {
				String query2 = "update referral set referrals= referrals - 1 where code = ?";

				PreparedStatement pst = con.prepareStatement(query2);

				//get the values to add to db from placeholder class
				pst.setString(1, code);

				//execute and get number of users added
				int NumberOfRowsAffected = pst.executeUpdate();


				pst.close();
				con.close();

				//return number of users added
				return NumberOfRowsAffected;
			}
		}

		return -1;

	}
	
	//add to pending
	public int addPending(String code) throws Exception {

		Connect();

		String query = "update referral set pending= pending + 1 where code = ?";

		PreparedStatement pst = con.prepareStatement(query);

		//get the values to add to db from placeholder class
		pst.setString(1, code);

		//execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();


		pst.close();
		con.close();

		//return number of users added
		return NumberOfRowsAffected;

	}

	//subtract from pending
	public int subtractPending(String code) throws Exception {

		Connect();

		//check if the count is not zero before subtracting
		String query1 = "Select * from referral where code='" + code + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query1);

		//if there is a data
		if(rs.next()) {
			//if not zero then do the subtraction
			if(rs.getLong("pending") != 0) {
				String query2 = "update referral set pending= pending - 1 where code = ?";

				PreparedStatement pst = con.prepareStatement(query2);

				//get the values to add to db from placeholder class
				pst.setString(1, code);

				//execute and get number of users added
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




	//-----------------------------------------End Delete-------------------------------------------------//
	//----------------------------------------------------------------------------------------------------//


}
