/**
 * 
 */
package utilities;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * @author Abu 'Abdur-Rahman
 * 
 * Used to send email since mail sending is slow, it uses a thread
 */
public class MailDispatcher implements Runnable {
	
	private String host="mail.baykservices.com";
	private final String user="admin@baykservices.com"; 
	private final String password="4444Player#";
	
	//used in the run method
	String to;
	String subject;
	String content;
	
	//use constructor to set the fields.
	public MailDispatcher(String to, String subject, String content) {
		super();
		this.to = to;
		this.subject = subject;
		this.content = content;
	}
	
	
	//mail sending method 
	/////// not necessary to use parameters here since they are in a field but for clarity
	public boolean sendMail(String to, String subject, String content) {
		
		//Get the session object  
		Properties props = new Properties();  
		props.put("mail.smtp.host",host);  
		props.put("mail.smtp.auth", "true");  
		props.put("mail.smtp.port", "26");
		props.put("mail.smtp.starttls.enable", "true");

		Session session = Session.getInstance(props,  
				new javax.mail.Authenticator() {  
			protected PasswordAuthentication getPasswordAuthentication() {  
				return new PasswordAuthentication(user,password);  
			}  
		});  

		//Compose the message  
		try {  
			MimeMessage message = new MimeMessage(session);  
			message.setFrom(new InternetAddress(user,"BAYK Services"));  
			message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));  
			message.setSubject(subject);
			
			//message.setText("Cointick platform welcomes pre-registration on the site");
			
			message.setContent(content, "text/html");

			//send the message  
			Transport.send(message);  

			//System.out.println("message sent successfully...");  
			return true;

		} catch (MessagingException | UnsupportedEncodingException e) {
			//e.printStackTrace();
			return false;
		}  
		
	}
	


	//run method
	@Override
	public void run() {
		
		//call send mail passing in the fields
		sendMail(to, subject, content);
	}
	
}
