package dataBaseModel;

public class Wallets {

	
	private long id;
	private double bayk;
	private double bayk_hold;
	private double ctk;
	private double ctk_hold;
	private String username;
	private long wallets_user_id;
	
	
	
	
	public double getBayk_hold() {
		return bayk_hold;
	}
	public void setBayk_hold(double bayk_hold) {
		this.bayk_hold = bayk_hold;
	}
	public double getCtk_hold() {
		return ctk_hold;
	}
	public void setCtk_hold(double ctk_hold) {
		this.ctk_hold = ctk_hold;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public double getBayk() {
		return bayk;
	}
	public void setBayk(double bayk) {
		this.bayk = bayk;
	}
	public double getCtk() {
		return ctk;
	}
	public void setCtk(double ctk) {
		this.ctk = ctk;
	}
	public long getWallets_user_id() {
		return wallets_user_id;
	}
	public void setWallets_user_id(long wallets_user_id) {
		this.wallets_user_id = wallets_user_id;
	}
	
	
	
	
	
}
