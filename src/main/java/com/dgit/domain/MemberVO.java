package com.dgit.domain;

import java.util.Date;

public class MemberVO {//DB의 모든 자료를 가지고 있읍(회원가입용)
	/* FIELDS */
	private int uno;
	private String uid;
	private String upw;
	private String uname;
	private String uemail;
	private String utel;
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
	public String getUpw() {
		return upw;
	}
	public void setUpw(String upw) {
		this.upw = upw;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUemail() {
		return uemail;
	}
	public void setUemail(String uemail) {
		this.uemail = uemail;
	}
	public String getUtel() {
		return utel;
	}
	public void setUtel(String utel) {
		this.utel = utel;
	}
	public Date getUregdate() {
		return uregdate;
	}
	public void setUregdate(Date uregdate) {
		this.uregdate = uregdate;
	}
	@Override
	public String toString() {
		return "MemberVO [uno=" + uno + ", uid=" + uid + ", upw=" + upw + ", uname=" + uname + ", uemail=" + uemail
				+ ", utel=" + utel + ", uregdate=" + uregdate + "]";
	}	
}
