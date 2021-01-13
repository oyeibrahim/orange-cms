package dataBaseModel;

public class Comments {

	
	private long id;
	private String body;
	private String status;
	private String username;
	private long comments_users_id;
	private long comments_posts_id;
	private String date_time;
	private String created;
	private String updated;
	
	
	
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public long getComments_users_id() {
		return comments_users_id;
	}
	public void setComments_users_id(long comments_users_id) {
		this.comments_users_id = comments_users_id;
	}
	public long getComments_posts_id() {
		return comments_posts_id;
	}
	public void setComments_posts_id(long comments_posts_id) {
		this.comments_posts_id = comments_posts_id;
	}
	public String getDate_time() {
		return date_time;
	}
	public void setDate_time(String date_time) {
		this.date_time = date_time;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getUpdated() {
		return updated;
	}
	public void setUpdated(String updated) {
		this.updated = updated;
	}
	
	
	
		
}
