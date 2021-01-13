package dataBaseModel;

public class Referral {

	
	private long id;
	private String code;
	private int referrals;
	private int pending;
	private String referred_by;
	private String username;
	private long referral_user_id;
	
	
	
	
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getReferrals() {
		return referrals;
	}
	public void setReferrals(int referrals) {
		this.referrals = referrals;
	}
	public String getReferred_by() {
		return referred_by;
	}
	public void setReferred_by(String referred_by) {
		this.referred_by = referred_by;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public long getReferral_user_id() {
		return referral_user_id;
	}
	public void setReferral_user_id(long referral_user_id) {
		this.referral_user_id = referral_user_id;
	}
	public int getPending() {
		return pending;
	}
	public void setPending(int pending) {
		this.pending = pending;
	}
	
	
	
	
	
}
