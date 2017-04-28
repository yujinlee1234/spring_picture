package com.dgit.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

public class PictureVO {
	/* FIELDS */
	private String fullname;
	private int uno;
	private Date regdate;
	/* GET/SET */
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public int getUno() {
		return uno;
	}
	public void setUno(int uno) {
		this.uno = uno;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getRegdateText(){
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		return sdf.format(regdate);
	}
}
