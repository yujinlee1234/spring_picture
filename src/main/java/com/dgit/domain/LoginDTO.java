package com.dgit.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

public class LoginDTO {//로그인 후 가지고 다닐 정보
	/* FIELDS */
	private int uno;
	private String uid;
	private String uname;
	private Date uregdate;
	/* GET/SET */
	public int getUno() {
		return uno;
	}
	public void setUno(int uno) {
		this.uno = uno;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public Date getUregdate() {
		return uregdate;
	}
	public void setUregdate(Date uregdate) {
		this.uregdate = uregdate;
	}
	@Override
	public String toString() {
		return "LoginDTO [uno=" + uno + ", uid=" + uid + ", uname=" + uname + ", uregdate=" + uregdate + "]";
	}
	public String getUregdateText(){
		SimpleDateFormat regFormat = new SimpleDateFormat("MMM d일, yyyy");
		return regFormat.format(this.uregdate);
	}
	public LoginDTO(int uno, String uid, String uname, Date uregdate) {
		super();
		this.uno = uno;
		this.uid = uid;
		this.uname = uname;
		this.uregdate = uregdate;
	}
	
	
}
