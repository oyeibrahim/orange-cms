/*
 * DataBase Access Class
 * 
 * @Author Oyetunji Ibrahim
 * 
 * @Date 04/12/2019
 */
package dataBaseDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import dataBaseModel.Users;

public class UsersDAO {

	// email exist
	public static final String EMAIL_EXIST = "YESe";
	// username exist or both username and email exist
	public static final String USERNAME_EXIST = "YESu";
	// both don't exist
	public static final String NOT_EXIST = "No";

	// email exist id
	public static final int EMAIL_EXIST_NUM = 5000;
	// username exist id or both username and email exist id
	public static final int USERNAME_EXIST_NUM = 6000;

	Connection con;

	// using constructor will disable closing connection after each method when you
	// want
	// to use more than one method in an operation. It will tell you the connection
	// is closed
	// in the first method called
	// so use a method like this and call it in all method. This will allow
	// reopening the connection
	// whenever you need it so you can call many methods in one operation. Just make
	// sure you
	// call this method below each method you are using
	public void Connect() throws Exception {
		String url = "jdbc:mysql://localhost:3306/baykdb?serverTimezone=UTC";
		String username = "root";
		String password = "";

		Class.forName("com.mysql.cj.jdbc.Driver");

		con = DriverManager.getConnection(url, username, password);
	}

	// -----------------------------------------Fetch-------------------------------------------------//

	/*
	 * Logging in access------------------------------------------------------ get
	 * user from DB for logging in so requires password
	 * 
	 * @param email User's email
	 * 
	 * @param password User's password
	 * 
	 * @return User User data from db
	 */
	public Users getSecureUser(Users userData) throws Exception {
		Connect();

		// get user data
		String email = userData.getEmail();
		String password = userData.getPassword();

		// use User class to send the data
		Users user = new Users();
		// the query
		String query = "Select * from users where email= '" + email + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {
			// get user data from DB
			String firstname = rs.getString("firstname");
			String lastname = rs.getString("lastname");
			String username = rs.getString("username");
			String mail = rs.getString("email");
			int active = rs.getInt("active");
			String tag = rs.getString("tag");

			// the hashed password from DB
			String hashedPassword = rs.getString("password");

			// Now check if password is correct by checking the password passed in with the
			// hashed DB password
			// the BCrypt method returns true if the hashed and un-hashed password match
			if (BCrypt.checkpw(password, hashedPassword)) {
				// if password is correct, check if active
				if (active == 0) {

					// if not active, then return active
					user.setUsername(username);
					user.setEmail(mail);
					user.setActive(active);
				} else if (active == 1) {

					// if active, then return user data
					user.setFirstname(firstname);
					user.setLastname(lastname);
					user.setUsername(username);
					user.setEmail(mail);
					user.setActive(active);
					user.setTag(tag);

				}
			}
		}

		st.close();
		con.close();

		// return user data
		return user;

	}

	// get user data from email for resending confirmation
	public Users getUserEmailResend(String email) throws Exception {

		Connect();
		// use User class to send the data
		Users user = new Users();
		// the query
		String query = "Select * from users where email= '" + email + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {
			// check to ensure the user hasn't confirmed his account
			if (rs.getInt("active") == 0) {
				// get user data from DB
				String username = rs.getString("username");
				String code = rs.getString("activation_code");

				// set user data to User class
				user.setUsername(username);
				user.setActivationCode(code);
			}

		}

		st.close();
		con.close();

		return user;
	}

	// get user data from email for resending confirmation
	public Users getUserPasswordReset(String email) throws Exception {

		Connect();
		// use User class to send the data
		Users user = new Users();
		// the query
		String query = "Select * from users where email= '" + email + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {
			// check to ensure the user hasn't confirmed his account
			if (rs.getInt("active") == 1) {
				// get user data from DB
				String username = rs.getString("username");
				String code = rs.getString("activation_code");
				String mail = rs.getString("email");

				// set user data to User class
				user.setUsername(username);
				user.setActivationCode(code);
				user.setEmail(mail);
			}

		}

		st.close();
		con.close();

		return user;
	}

	// get user availability with email and activation code
	public boolean checkUserWithCode(Users user) throws Exception {

		Connect();

		// get if it exist
		String query = "Select * from users where email = '" + user.getEmail() + "' and activation_code = '"
				+ user.getActivationCode() + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {

			con.close();

			return true;

		}

		return false;

	}

	// get user availability with username
	public boolean checkUserWithUsername(String username) throws Exception {

		Connect();

		// get if it exist
		String query = "Select * from users where username = '" + username + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {

			con.close();

			return true;

		}

		return false;

	}

	// check if admin
	public boolean checkAdmin(long id, String username) throws Exception {

		Connect();

		// get if it exist
		String query = "Select * from users where id = '" + id + "' and username='" + username + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {
			// if admin
			if (rs.getString("tag").equals("admin")) {

				return true;

			}
			con.close();

		}

		return false;

	}

	// get user's name from username //format F/L return Firstname Lastname, format
	// L/F return Lastname Firstname
	public String getName(String username, String format) throws Exception {

		Connect();

		// get if it exist
		String query = "Select * from users where username = '" + username + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {

			String Firstname = rs.getString("firstname");
			String Lastname = rs.getString("lastname");

			st.close();
			con.close();

			// return according to format requested
			if (format.equals("F/N")) {
				return Firstname + " " + Lastname;
			} else {
				return Lastname + " " + Firstname;
			}

		}

		return "";
	}

	// get username from id
	public String getUsername(long id) throws Exception {

		Connect();

		// get if it exist
		String query = "Select * from users where id = '" + id + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {

			String username = rs.getString("username");

			st.close();
			con.close();

			return username;
		}

		return "";
	}

	// get id from username
	public long getId(String username) throws Exception {

		Connect();

		// get if it exist
		String query = "Select * from users where username = '" + username + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {

			long id = rs.getLong("id");

			st.close();
			con.close();

			return id;
		}

		return -1;
	}

	/*
	 * Public profile view------------------------------------------------------ get
	 * user from DB for public viewing on public profile no password needed
	 * 
	 * @param username Username of a user
	 * 
	 * @return User User data from db
	 */
	public Users getUserProfile(String username) throws Exception {

		Connect();
		// use User class to send the data
		Users user = new Users();
		// the query
		String query = "Select * from users where username= '" + username + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {

			// get user data from DB & set to User class
			user.setId(rs.getLong("id"));
			user.setFirstname(rs.getString("firstname"));
			user.setLastname(rs.getString("lastname"));
			user.setUsername(rs.getString("username"));
			user.setEmail(rs.getString("email"));
			user.setProfilePicture(rs.getString("profile_picture"));
			user.setGender(rs.getString("gender"));
			user.setCountry(rs.getString("country"));
			user.setBirth(rs.getString("date_of_birth"));
			user.setAbout(rs.getString("about"));
			user.setJoined(rs.getString("joined"));
			user.setPlatformTag(rs.getString("platform_tag"));
			user.setTag(rs.getString("tag"));
			user.setTemp_data(rs.getString("temp_data"));
		}

		st.close();
		con.close();

		return user;
	}

	// admin get user
	public Users getUserProfileAdmin(String username) throws Exception {

		Connect();
		// use User class to send the data
		Users user = new Users();
		// the query
		String query = "Select * from users where username= '" + username + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {

			// get user data from DB & set to User class
			user.setId(rs.getLong("id"));
			user.setFirstname(rs.getString("firstname"));
			user.setLastname(rs.getString("lastname"));
			user.setUsername(rs.getString("username"));
			user.setEmail(rs.getString("email"));
			user.setPassword(rs.getString("password"));
			user.setProfilePicture(rs.getString("profile_picture"));
			user.setGender(rs.getString("gender"));
			user.setCountry(rs.getString("country"));
			user.setBirth(rs.getString("date_of_birth"));
			user.setAbout(rs.getString("about"));
			user.setJoined(rs.getString("joined"));
			user.setActivationCode(rs.getString("activation_code"));
			user.setActive(rs.getInt("active"));
			user.setPlatformTag(rs.getString("platform_tag"));
			user.setTag(rs.getString("tag"));
			user.setTemp_data(rs.getString("temp_data"));
		}

		st.close();
		con.close();

		return user;
	}

	// count all users //non is for no tag
	public double countUsers(String tag) throws Exception {

		Connect();

		// set query with condition
		String query = "";

		if (tag.equals("non")) {// if no tag selected
			// count all users
			query = "select count(*) from users";
		} else {// if tag selected
				// count only users with that tag
			query = "select count(*) from users where tag= '" + tag + "'";
		}

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// while there is a data
		if (rs.next()) {
			// get total from db
			double count = rs.getInt(1);

			return count;
		}

		st.close();
		con.close();

		return -1;
	}

	// count all unconfirmed users
	public double countUnconfirmedUsers() throws Exception {

		Connect();

		// set query with condition
		String query = "select count(*) from users where active= '" + 0 + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// while there is a data
		if (rs.next()) {
			// get total from db
			double count = rs.getInt(1);

			return count;
		}

		st.close();
		con.close();

		return -1;
	}

	// count search users
	public double countSearchUsers(String search, String tag) throws Exception {

		Connect();

		// set query with condition
		String query = "";

		if (tag.equals("non")) {// if no tag selected
			// count all users
			query = "select count(*) from users where username like '%" + search + "%' or firstname like '%" + search
					+ "%' or " + "lastname like '%" + search + "%' or email like '%" + search + "%' or gender like '%"
					+ search + "%' or " + "country like '%" + search + "%' or about like '%" + search + "%' or "
					+ "platform_tag like '%" + search + "%'";
		} else {// if tag selected
				// count only users with that tag
			query = "select count(*) from users where(tag = '" + tag + "') and (username like '%" + search
					+ "%' or firstname like '%" + search + "%' or " + "lastname like '%" + search
					+ "%' or email like '%" + search + "%' or gender like '%" + search + "%' or " + "country like '%"
					+ search + "%' or about like '%" + search + "%' or " + "platform_tag like '%" + search + "%')";
		}

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// while there is a data
		if (rs.next()) {
			// get total from db
			double count = rs.getInt(1);

			return count;
		}

		st.close();
		con.close();

		return -1;
	}

	// get all users for admin dashboard user list
	public List<Users> getAllUsers(String tag, int start, int total) throws Exception {

		Connect();

		List<Users> list = new ArrayList<Users>();

		// set query with condition
		String query = "";

		if (tag.equals("non")) {// if no tag selected
			// get all users
			query = "select * from users ORDER BY firstname DESC limit " + start + "," + total;
		} else {// if tag selected
				// get only users with that tag
			query = "select * from users where tag= '" + tag + "' ORDER BY firstname DESC limit " + start + "," + total;
		}

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// while there is a data
		while (rs.next()) {
			// create new object on every instance
			Users user = new Users();
			// set data to the model object created
			user.setId(rs.getLong("id"));
			user.setFirstname(rs.getString("firstname"));
			user.setLastname(rs.getString("lastname"));
			user.setUsername(rs.getString("username"));
			user.setEmail(rs.getString("email"));
			user.setProfilePicture(rs.getString("profile_picture"));
			user.setGender(rs.getString("gender"));
			user.setCountry(rs.getString("country"));
			user.setBirth(rs.getString("date_of_birth"));
			user.setAbout(rs.getString("about"));
			user.setJoined(rs.getString("joined"));
			user.setPlatformTag(rs.getString("platform_tag"));
			user.setActive(rs.getInt("active"));
			user.setTag(rs.getString("tag"));
			user.setTemp_data(rs.getString("temp_data"));

			list.add(user);
		}

		st.close();
		con.close();

		return list;
	}

	// get all users email
	public List<String> getAllUsersEmail() throws Exception {

		Connect();

		List<String> list = new ArrayList<String>();

		// set query with condition
		String query = "select email from users";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// while there is a data
		while (rs.next()) {
			// create new object on every instance
			String email = rs.getString("email");

			list.add(email);
		}

		st.close();
		con.close();

		return list;
	}

	// get all unconfirmed users for admin dashboard user list
	public List<Users> getAllUnconfirmedUsers(int start, int total) throws Exception {

		Connect();

		List<Users> list = new ArrayList<Users>();

		// set query with condition
		String query = "select * from users where active= '" + 0 + "' ORDER BY firstname DESC limit " + start + ","
				+ total;

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// while there is a data
		while (rs.next()) {
			// create new object on every instance
			Users user = new Users();
			// set data to the model object created
			user.setId(rs.getLong("id"));
			user.setFirstname(rs.getString("firstname"));
			user.setLastname(rs.getString("lastname"));
			user.setUsername(rs.getString("username"));
			user.setEmail(rs.getString("email"));
			user.setProfilePicture(rs.getString("profile_picture"));
			user.setGender(rs.getString("gender"));
			user.setCountry(rs.getString("country"));
			user.setBirth(rs.getString("date_of_birth"));
			user.setAbout(rs.getString("about"));
			user.setJoined(rs.getString("joined"));
			user.setPlatformTag(rs.getString("platform_tag"));
			user.setActive(rs.getInt("active"));
			user.setTag(rs.getString("tag"));
			user.setTemp_data(rs.getString("temp_data"));

			list.add(user);
		}

		st.close();
		con.close();

		return list;
	}

	// search users for admin dashboard user list
	public List<Users> searchUsers(String search, String tag, int start, int total) throws Exception {

		Connect();

		List<Users> list = new ArrayList<Users>();

		// set query with condition
		String query = "";

		if (tag.equals("non")) {// if no tag selected
			// get searched users
			query = "Select * from users where username like '%" + search + "%' or firstname like '%" + search
					+ "%' or " + "lastname like '%" + search + "%' or email like '%" + search + "%' or gender like '%"
					+ search + "%' or " + "country like '%" + search + "%' or about like '%" + search + "%' or "
					+ "platform_tag like '%" + search + "%' ORDER BY firstname DESC limit " + start + "," + total;

		} else {// if tag selected
				// get searched users //check the tag so only those with the tag are added
			query = "Select * from users where(tag = '" + tag + "') and (username like '%" + search
					+ "%' or firstname like '%" + search + "%' or " + "lastname like '%" + search
					+ "%' or email like '%" + search + "%' or gender like '%" + search + "%' or " + "country like '%"
					+ search + "%' or about like '%" + search + "%' or " + "platform_tag like '%" + search
					+ "%') ORDER BY firstname DESC limit " + start + "," + total;

		}

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// while there is a data
		while (rs.next()) {
			// create new object on every instance
			Users user = new Users();
			// set data to the model object created
			user.setId(rs.getLong("id"));
			user.setFirstname(rs.getString("firstname"));
			user.setLastname(rs.getString("lastname"));
			user.setUsername(rs.getString("username"));
			user.setEmail(rs.getString("email"));
			user.setProfilePicture(rs.getString("profile_picture"));
			user.setGender(rs.getString("gender"));
			user.setCountry(rs.getString("country"));
			user.setBirth(rs.getString("date_of_birth"));
			user.setAbout(rs.getString("about"));
			user.setJoined(rs.getString("joined"));
			user.setPlatformTag(rs.getString("platform_tag"));
			user.setActive(rs.getInt("active"));
			user.setTag(rs.getString("tag"));
			user.setTemp_data(rs.getString("temp_data"));

			list.add(user);

		}

		st.close();
		con.close();

		return list;
	}

	// --------Sub to below----------//
	/*
	 * used privately to check email availability
	 * 
	 * @param email Email of the user
	 * 
	 * @return User User data from db
	 */
	public Users getUserEmail(String email) throws Exception {

		Connect();
		// use User class to send the data
		Users user = new Users();
		// the query
		String query = "Select * from users where email= '" + email + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {
			// set user data to User class
			user.setFirstname(rs.getString("firstname"));
			user.setLastname(rs.getString("lastname"));
			user.setUsername(rs.getString("username"));
			user.setEmail(rs.getString("email"));
		}

		st.close();
		con.close();

		return user;
	}

	// --------Sub to below----------//

	// to check if user already exist before registering
	// we are checking for unique username and email
	// returns "YESu" if username exist or "YESe" if email already exist or "No" if
	// user doesn't exist
	// these variables are defined above
	public String userExist(String username, String email) throws Exception {
		// use method above to check db for username
		Users uname = getUserProfile(username);
		// use method above to check db for email
		Users uemail = getUserEmail(email);

		// if username exist
		// username by db equals this username.. you must check if its not null first so
		// it won't return null pointer exception
		// use uname //also check they are not only different with case, so convert to
		// lowercase and check
		if (uname.getUsername() != null
				&& uname.getUsername().toString().toLowerCase().equals(username.toLowerCase())) {
			return USERNAME_EXIST;
		}
		// if email exist
		// email by db equals this email.. you must check if its not null first so
		// it won't return null pointer exception
		// use uemail
		else if (uemail.getEmail() != null && uemail.getEmail().toString().equals(email)) {
			return EMAIL_EXIST;
		}
		// else if user didn't exist
		return NOT_EXIST;
	}
	// -----------------------------------------End
	// Fetch-------------------------------------------------//
	// ----------------------------------------------------------------------------------------------------//

	// -----------------------------------------Inserts-------------------------------------------------//

	/*
	 * add user to DB------------------------------------------------------
	 * 
	 * @param user User object
	 * 
	 * @return rows affected
	 */
	public int addUser(Users user) throws Exception {

		String userExist = userExist(user.getUsername(), user.getEmail());

		Connect();

		// if username exist or both username and email exist
		if (userExist.equals(USERNAME_EXIST)) {
			// return the id
			return USERNAME_EXIST_NUM;
		}
		// if email exist
		else if (userExist.equals(EMAIL_EXIST)) {
			// return the id
			return EMAIL_EXIST_NUM;
		}
		// if user doesn't exist before
		else if (userExist.equals(NOT_EXIST)) {
			// DataBase
			// one way
			// String query = "insert into users values (?,?,?,?,?,?)";
			// another way
			String query = "insert into users (username,firstname,lastname,email,password,gender,country,joined,profile_picture,activation_code,platform_tag,active,temp_data) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement pst = con.prepareStatement(query);

			// get the values to add to db from placeholder class
			// if you use the first way, use this to set id, it doesn't matter
			// as it is zero, it will still increment in the database according
			// to the last id in the database
			// pst.setInt(1, 0);
			pst.setString(1, user.getUsername());
			pst.setString(2, user.getFirstname());
			pst.setString(3, user.getLastname());
			pst.setString(4, user.getEmail());
			pst.setString(5, user.getPassword());
			pst.setString(6, user.getGender());
			pst.setString(7, user.getCountry());
			pst.setString(8, user.getJoined());
			pst.setString(9, user.getProfilePicture());
			pst.setString(10, user.getActivationCode());
			pst.setString(11, user.getPlatformTag());
			pst.setInt(12, user.getActive());
			pst.setString(13, user.getTemp_data());

			// execute and get number of users added
			int NumberOfRowsAffected = pst.executeUpdate();

			pst.close();
			con.close();

			// return number of users added
			return NumberOfRowsAffected;
		}
		return -1;
	}

	// -----------------------------------------End
	// Insert-------------------------------------------------//
	// ----------------------------------------------------------------------------------------------------//

	// -----------------------------------------Update-------------------------------------------------//
	// to change to active and confirmed account
	public int updateActive(Users user) throws Exception {

		Connect();

		// get if it exist
		String query = "Select * from users where email = '" + user.getEmail() + "' and activation_code = '"
				+ user.getActivationCode() + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {

			String query2 = "update users set active='1' where email = ? and activation_code = ?";
			PreparedStatement pst = con.prepareStatement(query2);

			// get the values to add to db from placeholder class
			pst.setString(1, user.getEmail());
			pst.setString(2, user.getActivationCode());

			// execute and get number of users added
			int NumberOfRowsAffected = pst.executeUpdate();

			st.close();
			pst.close();
			con.close();

			// return number of users added
			return NumberOfRowsAffected;

		}

		return -1;

	}

	// to change activation code when new one is requested
	public int updateActivationCode(Users user) throws Exception {

		Connect();

		// get if it exist
		String query = "Select * from users where email = '" + user.getEmail() + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {

			String query2 = "update users set activation_code='" + user.getActivationCode() + "' where email = ?";
			PreparedStatement pst = con.prepareStatement(query2);

			// get the values to add to db from placeholder class
			pst.setString(1, user.getEmail());

			// execute and get number of users added
			int NumberOfRowsAffected = pst.executeUpdate();

			st.close();
			pst.close();
			con.close();

			// return number of users added
			return NumberOfRowsAffected;

		}
		return -1;
	}

	// change password
	public int updatePassword(Users user) throws Exception {

		Connect();

		// get if it exist
		String query = "Select * from users where email = '" + user.getEmail() + "' and activation_code = '"
				+ user.getActivationCode() + "'";

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		// if there is a result
		if (rs.next()) {

			String query2 = "update users set password='" + user.getPassword()
					+ "' where email = ? and activation_code = ?";
			PreparedStatement pst = con.prepareStatement(query2);

			// get the values to add to db from placeholder class
			pst.setString(1, user.getEmail());
			pst.setString(2, user.getActivationCode());

			// execute and get number of users added
			int NumberOfRowsAffected = pst.executeUpdate();

			st.close();
			pst.close();
			con.close();

			// return number of users added
			return NumberOfRowsAffected;

		}

		return -1;

	}

	// Update profile picture
	public int updateProfilePicture(Users user) throws Exception {

		Connect();

		String query = "update users set profile_picture='" + user.getProfilePicture() + "' where username = ?";

		PreparedStatement pst = con.prepareStatement(query);

		// get the values to add to db from placeholder class
		pst.setString(1, user.getUsername());

		// execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();

		pst.close();
		con.close();

		// return number of users added
		return NumberOfRowsAffected;

	}

	// Update User Data
	public int updateUserData(Users user) throws Exception {

		Connect();

		String query = "update users set about = ? where username = '" + user.getUsername() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		// get the values to add to db from placeholder class
		pst.setString(1, user.getAbout());

		// execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();

		pst.close();
		con.close();

		// return number of users added
		return NumberOfRowsAffected;

	}

	// Update User in Admin Panel
	public int updateUserDataAdmin(Users user) throws Exception {

		Connect();

		String query = "update users set username = ?,firstname = ?,lastname = ?,gender = ?,country = ?,platform_tag = ?,profile_picture = ?,activation_code = ?,active = ?,tag = ? where id = '"
				+ user.getId() + "'";

		PreparedStatement pst = con.prepareStatement(query);

		// get the values to add to db from placeholder class
		pst.setString(1, user.getUsername());
		pst.setString(2, user.getFirstname());
		pst.setString(3, user.getLastname());
		pst.setString(4, user.getGender());
		pst.setString(5, user.getCountry());
		pst.setString(6, user.getPlatformTag());
		pst.setString(7, user.getProfilePicture());
		pst.setString(8, user.getActivationCode());
		pst.setInt(9, user.getActive());
		pst.setString(10, user.getTag());

		// execute and get number of users added
		int NumberOfRowsAffected = pst.executeUpdate();

		pst.close();
		con.close();

		// return number of users added
		return NumberOfRowsAffected;

	}

	// -----------------------------------------End
	// Update-------------------------------------------------//
	// ----------------------------------------------------------------------------------------------------//

	// -----------------------------------------Delete-------------------------------------------------//

	// delete user
	public int deleteUser(String id) throws Exception {

		Connect();

		String query = "delete from users where id=" + id;

		Statement st = con.createStatement();
		// execute and get number rows affected
		int NumberOfRowsAffected = st.executeUpdate(query);

		st.close();
		con.close();

		// return number of rows affected
		return NumberOfRowsAffected;
	}

	// -----------------------------------------End
	// Delete-------------------------------------------------//
	// ----------------------------------------------------------------------------------------------------//

}
