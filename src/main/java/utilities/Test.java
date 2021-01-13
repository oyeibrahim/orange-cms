package utilities;

public class Test {

	
	//static int count = 0;
	
	public static void main(String[] args) throws Exception {
		
		
//		TestCall tc = new TestCall();
		
		
		
		
//		UsersDAO u = new UsersDAO();
//		WalletsDAO w = new WalletsDAO();
//		
//		Users us  = u.getUserProfile("oyeibrahim");
//		
//		int res = w.addWallet(us);
//		
//		if(res > 0) System.out.println("Successful");
//		else System.out.println("fail");
		
		
			
//			String url = "jdbc:mysql://localhost:3306/baykdb?serverTimezone=UTC";
//			String uname = "root";
//			String password = "";
//
//			Class.forName("com.mysql.cj.jdbc.Driver");
//
//			Connection con = DriverManager.getConnection(url, uname, password);
//			
//			//the query
//			String query = "Select * from users where username= 'oyeibrahim'";
//
//			Statement st = con.createStatement();
//			ResultSet rs = st.executeQuery(query);
//
//			//if there is a result
//			if(rs.next()) {
//
//				//get user data from DB
//				String firstname = rs.getString("firstname");
//				String lastname = rs.getString("lastname");
//				String name = rs.getString("username");
//				String email = rs.getString("email");
//
//				System.out.println(firstname);
//				System.out.println(lastname);
//				System.out.println(name);
//				System.out.println(email);
//			}
		
		
		
		
//		Date date1 = new Date();
//		
//		//System.out.println(date1);
//		
//		LocalDate mydate = LocalDate.now(ZoneId.of("GMT"));
//		LocalTime time = LocalTime.now(ZoneId.of("GMT"));
//		
//		DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd/MM/yyyy");
//		
//		String date = mydate.format(myFormatObj);
//		
//		 String dateTime = "Date: " + date + " Time: " + time;
//		 
//
//		System.out.println(dateTime);
//		System.out.println("--------------------------------");
//		
//		int startDate = dateTime.indexOf("Date: ") + 6;
//		int endDate = dateTime.indexOf(" Time: ");
//		
//		String dateOnly = dateTime.substring(startDate, endDate);
//		
//		System.out.println(dateOnly);
//		System.out.println("--------------------------------");
//		
//		int startTime = dateTime.indexOf("Time: ") + 6;
//		int endTime = dateTime.length();
//		
//		String timeOnly = dateTime.substring(startTime, endTime);
//		
//		System.out.println(timeOnly);
//		System.out.println("--------------------------------");
//		
//		int startTimeWithoutMilli = dateTime.indexOf("Time: ") + 6;
//		int endTimeWithoutMilli = dateTime.indexOf(".");
//		
//		String timeOnlyWithoutMilli = dateTime.substring(startTimeWithoutMilli, endTimeWithoutMilli);
//		
//		System.out.println(timeOnlyWithoutMilli);
//		System.out.println("--------------------------------");
//		
//		///////////////////////////////////////////////////////////////////
//		
//		String[] first = date.split("/");
//		
//		System.out.println("------------Get Format From Date-----------------");
//		
//		int year = Integer.parseInt(first[2]);
//		int month = Integer.parseInt(first[1]);
//		int day = Integer.parseInt(first[0]);
//		
//		LocalDate testDate = LocalDate.of(year, month, day);
//		
//		DateTimeFormatter formatObj = DateTimeFormatter.ofPattern("E, MMM dd yyyy");
//		
//		String formatDate = testDate.format(formatObj);
//		
//		System.out.println(formatDate);
//		System.out.println("--------------------------------");

		
		
		
		
		
		
//		
//		UtilityMethods um = new UtilityMethods();
//		for(int i=0; i<50; i++) {
//		String hash = um.getRandomAlphaNumericString(60);
//		System.out.println(hash);
//		}
		
		
//		String created = "";
//		String updated ="";
//		
//		String url = "jdbc:mysql://localhost:3306/baykdb?serverTimezone=UTC";
//		String uname = "root";
//		String password = "";
//
//		Class.forName("com.mysql.cj.jdbc.Driver");
//
//		Connection con = DriverManager.getConnection(url, uname, password);
//
//			//get if it exist
//			String query = "Select * from users where email = 'oyetunjiibrahim@gmail.com' and username = 'oyeibrahim'";
//
//			Statement st = con.createStatement();
//			ResultSet rs = st.executeQuery(query);
//
//			//if there is a result
//			if(rs.next()) {
//				
//				System.out.println(rs.getString("created"));
//				//System.out.println(rs.getString("updated"));
//				
//				created = rs.getString("created");
//				updated = rs.getString("updated");
//				
//				con.close();
//				
//			}else
//
//				System.out.println("false");
//			
//			
//			String createdDate = updated.substring(0,created.indexOf(" "));
//			System.out.println(createdDate);
//			
//			String[] split = createdDate.split("-");
//			
//			int year = Integer.parseInt(split[0]);
//			int month = Integer.parseInt(split[1]);
//			int day = Integer.parseInt(split[2]);
//			
//			LocalDate placeholderDate = LocalDate.of(year, month, day);
//			
//			DateTimeFormatter formatObj = DateTimeFormatter.ofPattern("E, MMM dd yyyy");
//			
//			String formatedDate = placeholderDate.format(formatObj);
//
//			System.out.println(formatedDate);
		
		
//		UtilityMethods um = new UtilityMethods();
//		String date = "2020-2-25";
//		
//		String created = um.formatDbDate(date, "dd/M/yyyy");
//		
//		System.out.println(created);
		
		
//		UsersDAO user = new UsersDAO();
//		
//		Users newUser = user.getUserProfile("oyeibrahim");
//		String link = newUser.getProfilePicture();
//		System.out.println(link);
//		int ind = link.indexOf("/", link.indexOf("picture"));
//		String name = link.substring(ind+1);
//		
//		System.out.println(name);
		
		
		
		
		
		
//		String countries = "Afghanistan,Åland Islands,Albania,Algeria,American Samoa,Andorra,Angola,Anguilla,Antarctica,"
//				+ "Antigua And Barbuda,Argentina,Armenia,Aruba,Australia,Austria,Azerbaijan,Bahamas,Bahrain,Bangladesh,Barbados,"
//				+ "Belarus,Belgium,Belize,Benin,Bermuda,Bhutan,Bolivia,Bosnia And Herzegovina,Botswana,Bouvet Island,Brazil,"
//				+ "British Indian Ocean Territory,Brunei Darussalam,Bulgaria,Burkina Faso,Burundi,Cambodia,Cameroon,Canada,"
//				+ "Cape Verde,Cayman Islands,Central African Republic,Chad,Chile,China,Christmas Island,Cocos (Keeling) Islands,"
//				+ "Colombia,Comoros,Congo,Congo; The Democratic Republic Of The,Cook Islands,Costa Rica,Cote D'ivoire,Croatia,Cuba,"
//				+ "Cyprus,Czechia,Denmark,Djibouti,Dominica,Dominican Republic,Ecuador,Egypt,El Salvador,Equatorial Guinea,Eritrea,"
//				+ "Estonia,Ethiopia,Falkland Islands (Malvinas),Faroe Islands,Fiji,Finland,France,French Guiana,French Polynesia,"
//				+ "French Southern Territories,Gabon,Gambia,Georgia,Germany,Ghana,Gibraltar,Greece,Greenland,Grenada,Guadeloupe,"
//				+ "Guam,Guatemala,Guernsey,Guinea,Guinea-bissau,Guyana,Haiti,Heard Island And Mcdonald Islands,"
//				+ "Holy See (Vatican City State),Honduras,Hong Kong,Hungary,Iceland,India,Indonesia,Iran; Islamic Republic Of,"
//				+ "Iraq,Ireland,Isle Of Man,Israel,Italy,Jamaica,Japan,Jersey,Jordan,Kazakhstan,Kenya,Kiribati,Korea;"
//				+ " Democratic People's Republic Of,Korea; Republic Of,Kuwait,Kyrgyzstan,Lao People's Democratic Republic,Latvia,"
//				+ "Lebanon,Lesotho,Liberia,Libyan Arab Jamahiriya,Liechtenstein,Lithuania,Luxembourg,Macao,Macedonia; "
//				+ "The Former Yugoslav Republic Of,Madagascar,Malawi,Malaysia,Maldives,Mali,Malta,Marshall Islands,"
//				+ "Martinique,Mauritania,Mauritius,Mayotte,Mexico,Micronesia; Federated States Of,Moldova; Republic Of,"
//				+ "Monaco,Mongolia,Montenegro,Montserrat,Morocco,Mozambique,Myanmar,Namibia,Nauru,Nepal,Netherlands,"
//				+ "Netherlands Antilles,New Caledonia,New Zealand,Nicaragua,Niger,Nigeria,Niue,Norfolk Island,"
//				+ "Northern Mariana Islands,Norway,Oman,Pakistan,Palau,Palestinian Territory; Occupied,Panama,Papua New Guinea,"
//				+ "Paraguay,Peru,Philippines,Pitcairn,Poland,Portugal,Puerto Rico,Qatar,Reunion,Romania,Russian Federation,Rwanda,"
//				+ "Saint Helena,Saint Kitts And Nevis,Saint Lucia,Saint Pierre And Miquelon,Saint Vincent And The Grenadines,Samoa,"
//				+ "San Marino,Sao Tome And Principe,Saudi Arabia,Senegal,Serbia,Seychelles,Sierra Leone,Singapore,Slovakia,Slovenia,"
//				+ "Solomon Islands,Somalia,South Africa,South Georgia And The South Sandwich Islands,Spain,Sri Lanka,Sudan,Suriname,"
//				+ "Svalbard And Jan Mayen,Swaziland,Sweden,Switzerland,Syrian Arab Republic,Taiwan; Province Of China,Tajikistan,"
//				+ "Tanzania; United Republic Of,Thailand,Timor-leste,Togo,Tokelau,Tonga,Trinidad And Tobago,Tunisia,Turkey,"
//				+ "Turkmenistan,Turks And Caicos Islands,Tuvalu,Uganda,Ukraine,United Arab Emirates,United Kingdom,United States,"
//				+ "United States Minor Outlying Islands,Uruguay,Uzbekistan,Vanuatu,Venezuela,Viet Nam,Virgin Islands;"
//				+ " British,Virgin Islands; U.S.,Wallis And Futuna,Western Sahara,Yemen,Zambia,Zimbabwe";
//		
//		String[] eachC = countries.split(",");
//		
//		for(String i : eachC) {
//			System.out.println(i);
//		}
		
		
		
//		String data = "a7t8Y2.f&8h5";
//		String data2 = "ajdgjdbUTUBdh";
//		String ed1 = data.toUpperCase();
//		String ed2 = data2.toUpperCase();
//		
//		System.out.println(ed1);
//		System.out.println(ed2);
		
//		String data = "ref_by:HR56HGT-1-";
//		
//		int Start = data.indexOf("ref_by:") + 7;
//		int End = data.indexOf("-1-");
//		
//		String ed = data.substring(Start, End);
//		System.out.println(ed);
		
		
//		
//		UtilityMethods um = new UtilityMethods();
//		
//		
//		String refCode;
//		String tempCode = um.getRandomAlphaNumericString(7).toUpperCase();
//		System.out.println("First tempCode : " + tempCode);
//		int i= 0;
//		int j = 2;
//		
//		while (i<10 && j==2) {
//			tempCode = um.getRandomAlphaNumericString(7).toUpperCase();
//			
//			System.out.println(i + "th tempCode : " + tempCode);
//			
//			i++;
//		}
//		
//		refCode = tempCode;
//		
//		System.out.println("refCode :----> " + refCode);
		


		
		//--------------------------------------------SCHEDULLING-----------------------------------------//
		
		//Runnable rn = new TestCall();
		
//		Runnable rn = () -> {
//			//---------------without calling another class---------------//
//			UtilityMethods um = new UtilityMethods();
//			String tempCode = um.getRandomAlphaNumericString(7).toUpperCase();
//			System.out.println(tempCode);
//			//------------------------------//
//			
//			//---------------calling another class---------------//
//			TestCall ts =new TestCall();
//			ts.Prime();
//			//------------------------------//
//			
//			count++;
//		};
		
//		Runnable rn2 = new Runnable() {
//			public void run() {
//				TestCall ts =new TestCall();
//				ts.Prime();
//				count++;
//			}
//		};
//		
//		
//		
//		ScheduledExecutorService execService = Executors.newScheduledThreadPool(1);
//		
//		
//		execService.scheduleAtFixedRate(rn2, 0, 1, TimeUnit.SECONDS);
//		
//		while (count <= 10) {
//			//System.out.println("In while loop, count is currently :" + count);
//			Thread.sleep(1000);
//			if (count == 5) {
//				execService.shutdown();
//				System.out.println("In if statement, count is currently :" + count);
//				break;
//			}
//			//System.out.println("END, count is currently :" + count);
//		}
//		
		
		//--------------------------------------------END SCHEDULLING-----------------------------------------//
		
		
		
		
//		String t1 = "";
//		String t2 = "dummy text";
//		
//		System.out.println("t2 test : ");
//		System.out.println("Is t1 empty? " + t1.isEmpty());
//		System.out.println("Is t1 not empty? " + !t1.isEmpty());
//		
//		System.out.println("t2 test : ");
//		System.out.println("Is t2 empty? " + t2.isEmpty());
//		System.out.println("Is t2 not empty? " + !t2.isEmpty());
		
		
		
		
//		String list = "the,boy,is,very,good,";
//		
//		String[] part = list.split(",");
//		
//		System.out.println("Length = " + part.length);
//		System.out.println(part.length > 5);
//		
//		for(int i=0; i<part.length; i++)
//		System.out.println("Word at " + i + "= " + part[i]);
		
		
		
//		String url = "jdbc:mysql://localhost:3306/baykdb?serverTimezone=UTC";
//		String uname = "root";
//		String password = "";
//
//		Class.forName("com.mysql.cj.jdbc.Driver");
//
//		Connection con = DriverManager.getConnection(url, uname, password);
//		
//		String catOld = "try,";
//		String catNew = "";
//		
//		//the query
//		//String query =  "update site_structure set text_value3 = replace(text_value3, '" + catOld + "', '" + catNew + "')";
//		//String query =  "update site_structure set text_value1 = COALESCE(NULLIF(text_value1,''), '" + catNew + "')";
//		String query =  "update site_structure set text_value1 = NULLIF(text_value1,'')";
//
//		Statement st = con.createStatement();
//		System.out.println(st.executeUpdate(query));

		
		
//		//String link = "The boy's ball is ! oh Kin'd \"The Quote\" and / so malicious ";
//		
//		String link ="Theboy[]";
//		
//		link = link.replaceAll("[$ &+£\\[\\]\',:;=?@#|\"'<>.^*/()%!-]", "-");
//		System.out.println(link);
//		
//		
//		do {
//			link = link.replaceAll("--", "-");
//		}while(link.contains("--"));
//		
//		System.out.println(link);
//		
//		if(link.endsWith("-")) {
//			link = link.substring(0, link.length()-1);
//		}
//
//		System.out.println(link);
		
		
		
//		String input = "A new Payment Service Act in Singapore has mandated licensing of Cryptocurrency institutions in the state to oversee the activities and meet up with the Financial Action Task Force (FAFT) Standards.";
//		
//		String input2 = "Blockchain and Cryptocurrency are often mixed and treated as an entity and both used interchangeably to mean one another albeit this isn?t the case and though it?s like that, this simple assumption may be causing Cryptocurrency and Blockchain some individual development problems which will have benefitted the other and by individual development, I mean the adoption of one of them which to some seem like adoption of Blockchain is automatically adoption of Cryptocurrency.";
//		
//		String[] words = input.split("\\s+");
//		
//		System.out.println(words.length);
//		
//		String output = "";
//		
//		for(int i=0;i<5;i++) {
//			output = output + words[i] +" ";
//		}
//		output = output.trim();
//		
//		System.out.println(output);
		
		


		
		
		
		
		
		
		
		
		
	}

}
