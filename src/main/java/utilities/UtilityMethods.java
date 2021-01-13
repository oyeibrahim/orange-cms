package utilities;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

/**
 * Servlet implementation class UtilityMethods
 */
@WebServlet("/UtilityMethods")
public class UtilityMethods extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 * Checks if two links are equal
	 * 
	 * @param first  First string to compare
	 * @param second Second word string to compare
	 * @return boolean
	 */
	public boolean checkLink(String first, String second) {

		if (first.equals(second) && second.equals(first)) {
			return true;
		}
		return false;
	}

	/**
	 * 
	 * used to print "active" for navbar items using the method above to check link
	 * equality
	 * 
	 * @param first  First string to compare
	 * @param second Second word string to compare
	 * @return String "active navbar-active"
	 */
	public String printActive(String first, String second) {
		if (checkLink(first, second)) {
			return "active navbar-active";
		}

		return "";
	}

	/**
	 * 
	 * generate a random string of length n
	 * 
	 * @param n length of the String to produce
	 * @return String Random Alpha-Numeric String
	 */
	public String getRandomAlphaNumericString(int n) {

		// chose a Character random from this String
		String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvxyz";

		// create StringBuffer size of AlphaNumericString
		StringBuilder sb = new StringBuilder(n);

		for (int i = 0; i < n; i++) {

			// generate a random number between
			// 0 to AlphaNumericString variable length
			int index = (int) (AlphaNumericString.length() * Math.random());

			// add Character one by one in end of sb
			sb.append(AlphaNumericString.charAt(index));
		}

		return sb.toString();
	}

	/**
	 * 
	 * get all countries
	 * 
	 * @return Array of all Countries
	 */
	public String[] getCountries() {

		String countries = "Afghanistan,Åland Islands,Albania,Algeria,American Samoa,Andorra,Angola,Anguilla,Antarctica,"
				+ "Antigua And Barbuda,Argentina,Armenia,Aruba,Australia,Austria,Azerbaijan,Bahamas,Bahrain,Bangladesh,Barbados,"
				+ "Belarus,Belgium,Belize,Benin,Bermuda,Bhutan,Bolivia,Bosnia And Herzegovina,Botswana,Bouvet Island,Brazil,"
				+ "British Indian Ocean Territory,Brunei Darussalam,Bulgaria,Burkina Faso,Burundi,Cambodia,Cameroon,Canada,"
				+ "Cape Verde,Cayman Islands,Central African Republic,Chad,Chile,China,Christmas Island,Cocos (Keeling) Islands,"
				+ "Colombia,Comoros,Congo,Congo; The Democratic Republic Of The,Cook Islands,Costa Rica,Cote D'ivoire,Croatia,Cuba,"
				+ "Cyprus,Czechia,Denmark,Djibouti,Dominica,Dominican Republic,Ecuador,Egypt,El Salvador,Equatorial Guinea,Eritrea,"
				+ "Estonia,Ethiopia,Falkland Islands (Malvinas),Faroe Islands,Fiji,Finland,France,French Guiana,French Polynesia,"
				+ "French Southern Territories,Gabon,Gambia,Georgia,Germany,Ghana,Gibraltar,Greece,Greenland,Grenada,Guadeloupe,"
				+ "Guam,Guatemala,Guernsey,Guinea,Guinea-bissau,Guyana,Haiti,Heard Island And Mcdonald Islands,"
				+ "Holy See (Vatican City State),Honduras,Hong Kong,Hungary,Iceland,India,Indonesia,Iran; Islamic Republic Of,"
				+ "Iraq,Ireland,Isle Of Man,Israel,Italy,Jamaica,Japan,Jersey,Jordan,Kazakhstan,Kenya,Kiribati,Korea;"
				+ " Democratic People's Republic Of,Korea; Republic Of,Kuwait,Kyrgyzstan,Lao People's Democratic Republic,Latvia,"
				+ "Lebanon,Lesotho,Liberia,Libyan Arab Jamahiriya,Liechtenstein,Lithuania,Luxembourg,Macao,Macedonia; "
				+ "The Former Yugoslav Republic Of,Madagascar,Malawi,Malaysia,Maldives,Mali,Malta,Marshall Islands,"
				+ "Martinique,Mauritania,Mauritius,Mayotte,Mexico,Micronesia; Federated States Of,Moldova; Republic Of,"
				+ "Monaco,Mongolia,Montenegro,Montserrat,Morocco,Mozambique,Myanmar,Namibia,Nauru,Nepal,Netherlands,"
				+ "Netherlands Antilles,New Caledonia,New Zealand,Nicaragua,Niger,Nigeria,Niue,Norfolk Island,"
				+ "Northern Mariana Islands,Norway,Oman,Pakistan,Palau,Palestinian Territory; Occupied,Panama,Papua New Guinea,"
				+ "Paraguay,Peru,Philippines,Pitcairn,Poland,Portugal,Puerto Rico,Qatar,Reunion,Romania,Russian Federation,Rwanda,"
				+ "Saint Helena,Saint Kitts And Nevis,Saint Lucia,Saint Pierre And Miquelon,Saint Vincent And The Grenadines,Samoa,"
				+ "San Marino,Sao Tome And Principe,Saudi Arabia,Senegal,Serbia,Seychelles,Sierra Leone,Singapore,Slovakia,Slovenia,"
				+ "Solomon Islands,Somalia,South Africa,South Georgia And The South Sandwich Islands,Spain,Sri Lanka,Sudan,Suriname,"
				+ "Svalbard And Jan Mayen,Swaziland,Sweden,Switzerland,Syrian Arab Republic,Taiwan; Province Of China,Tajikistan,"
				+ "Tanzania; United Republic Of,Thailand,Timor-leste,Togo,Tokelau,Tonga,Trinidad And Tobago,Tunisia,Turkey,"
				+ "Turkmenistan,Turks And Caicos Islands,Tuvalu,Uganda,Ukraine,United Arab Emirates,United Kingdom,United States,"
				+ "United States Minor Outlying Islands,Uruguay,Uzbekistan,Vanuatu,Venezuela,Viet Nam,Virgin Islands;"
				+ " British,Virgin Islands; U.S.,Wallis And Futuna,Western Sahara,Yemen,Zambia,Zimbabwe";

		String[] eachCountry = countries.split(",");

		return eachCountry;
	}

	/**
	 * 
	 * format an inputted date of format 27/12/2019 in the format we want
	 * 
	 * @param date   the date to format
	 * @param format the format of the result
	 * @return String formated date
	 */
	public String formatDate(String date, String format) {

		// split the string
		String[] split = date.split("/");
		// change to integer
		int year = Integer.parseInt(split[2]);
		int month = Integer.parseInt(split[1]);
		int day = Integer.parseInt(split[0]);
		// get the date
		LocalDate placeholderDate = LocalDate.of(year, month, day);
		// put in the format you want
		DateTimeFormatter formatObj = DateTimeFormatter.ofPattern(format);
		// implement the format
		String formatedDate = placeholderDate.format(formatObj);

		return formatedDate;

	}

	/**
	 * 
	 * format an inputted date of format 2020-02-25 (Database style) in the format
	 * we want
	 * 
	 * @param date   the date to format
	 * @param format the format of the result
	 * @return String formated date
	 */
	public String formatDbDate(String date, String format) {

		// split the string
		String[] split = date.split("-");
		// change to integer
		int year = Integer.parseInt(split[0]);
		int month = Integer.parseInt(split[1]);
		int day = Integer.parseInt(split[2]);
		// get the date
		LocalDate placeholderDate = LocalDate.of(year, month, day);
		// put in the format you want
		DateTimeFormatter formatObj = DateTimeFormatter.ofPattern(format);
		// implement the format
		String formatedDate = placeholderDate.format(formatObj);

		return formatedDate;

	}

	/**
	 * 
	 * process a sentence to deliver not more than the @param count number of words
	 * 
	 * @param input       the String to shorten
	 * @param count       number of words to make up the result String
	 * @param includeDots YES/NO to include three dots at the end of the shortened
	 *                    result String
	 * @return String the shortened String
	 */
	public String getWordCount(String input, int count, String includeDots) {

		String output = "";

		// split the sentence by whitespace
		String[] words = input.split("\\s+");

		// if the sentence is the same or less than the word count requested
		// then just return the word
		if (words.length <= count) {
			return input;
		} else {// if more than count requested, then process to get the count number of words
			for (int i = 0; i < count; i++) {
				// put space in front of each word
				output = output + words[i] + " ";
			}
			// remove the last space
			output = output.trim();

			// if we are to include dots, then include it
			if (includeDots.equals("YES")) {
				output = output + "...";
			}

			return output;

		}

	}

	/**
	 * 
	 * process a sentence to deliver not more than the @param count number of
	 * alphabets
	 * 
	 * @param input       the String to shorten
	 * @param count       number of words to make up the result String
	 * @param includeDots YES/NO to include three dots at the end of the shortened
	 *                    result String
	 * @return String the shortened String
	 */
	public String getAlphabetCount(String input, int count, String includeDots) {

		String output = "";

		if (input.length() <= count) {
			return input;
		} else {

			for (int i = 0; i <= count; i++) {
				output = output + input.charAt(i);
			}

			// if we are to include dots, then include it
			if (includeDots.equals("YES")) {
				output = output + "...";
			}

			return output;
		}

	}

	/**
	 * [Externally Sourced] Gotten from:
	 * http://www.java2s.com/Code/Java/Servlets/GetBaseUrlforservlet.htm NOT UNIT
	 * TESTED Returns the URL (including query parameters) minus the scheme, host,
	 * and context path. This method probably be moved to a more general purpose
	 * class. [MODIFIED]
	 */
	public String getRelativeUrl(HttpServletRequest request) {

		String baseUrl = null;

		if ((request.getServerPort() == 80) || (request.getServerPort() == 443))
			baseUrl = request.getScheme() + "://" + request.getServerName() + request.getContextPath();
		else
			baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath();

		StringBuffer buf = request.getRequestURL();

		return buf.substring(baseUrl.length());
	}

	/**
	 * [Externally Sourced] Gotten from:
	 * http://www.java2s.com/Code/Java/Servlets/GetBaseUrlforservlet.htm NOT UNIT
	 * TESTED Returns the base url (e.g, <tt>http://myhost:8080/myapp</tt>) suitable
	 * for using in a base tag or building reliable urls.
	 */
	public String getBaseUrl(HttpServletRequest request) {
		if ((request.getServerPort() == 80) || (request.getServerPort() == 443))
			return request.getScheme() + "://" + request.getServerName() + request.getContextPath();
		else
			return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath();
	}

	/**
	 * 
	 * Get the base url and add a provided path to it
	 * 
	 * @param request HttpServletRequest
	 * @param path    the path to concatenate to the base URL
	 * @return String the base URL concatenated with requested path
	 */
	public String baseUrl(HttpServletRequest request, String path) {
		if ((request.getServerPort() == 80) || (request.getServerPort() == 443))
			return request.getScheme() + "://" + request.getServerName() + request.getContextPath() + path;
		else
			return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath() + path;
	}

	/**
	 * 
	 * returns the full URL path without query String
	 * 
	 * @param request HttpServletRequest
	 * @return String full URL path
	 */
	public String fullPath(HttpServletRequest request) {
		return this.getBaseUrl(request) + this.getRelativeUrl(request);
	}

	/**
	 * 
	 * returns the full URL path with query String
	 * 
	 * @param request HttpServletRequest
	 * @return String full URL path
	 */
	public String fullPathWithQueryString(HttpServletRequest request) {
		return this.getBaseUrl(request) + this.getRelativeUrlWithQueryString(request);
	}

	/**
	 * 
	 * relative URL with query String
	 * 
	 * @param request HttpServletRequest
	 * @return
	 */
	public String getRelativeUrlWithQueryString(HttpServletRequest request) {

		String baseUrl = null;

		if ((request.getServerPort() == 80) || (request.getServerPort() == 443))
			baseUrl = request.getScheme() + "://" + request.getServerName() + request.getContextPath();
		else
			baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath();

		StringBuffer buf = request.getRequestURL();

		if (request.getQueryString() != null) {
			buf.append("?");
			buf.append(request.getQueryString());
		}

		return buf.substring(baseUrl.length());
	}

	/**
	 * [Externally Sourced] Gotten from:
	 * http://www.java2s.com/Code/Java/Servlets/GetBaseUrlforservlet.htm Returns the
	 * file specified by <tt>path</tt> as returned by
	 * <tt>ServletContext.getRealPath()</tt>.
	 */
	public File getRealFile(HttpServletRequest request, String path) {

		return new File(request.getSession().getServletContext().getRealPath(path));
	}

}
