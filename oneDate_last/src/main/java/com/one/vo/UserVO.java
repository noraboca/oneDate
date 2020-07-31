package com.one.vo;

public class UserVO {
	private int idx;
	private String name;
	private String id;
	private String password;
	private String gender;
	private String interested_gender;
	private String details;
	private String email;
	private String birth_day;
	private String reg_date;
	private String phone;
	private String address;
	private int sms;
	private String hobby;
	private String main_photo_src;
	private String sub1_photo_src;
	private String sub2_photo_src;
	private String sub3_photo_src;
	private String sub4_photo_src;
	
	
	public UserVO() {
		// TODO Auto-generated constructor stub
	}
	
	
	public UserVO(String name, String gender, String interested_gender, String id, String password, String email,
			String birth_day, String main_photo_src) {
		super();
		this.name = name;
		this.gender = gender;
		this.interested_gender = interested_gender;
		this.id = id;
		this.password = password;
		this.email = email;
		this.birth_day = birth_day;
		this.main_photo_src = main_photo_src;
	}
	
	
	
	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getInterested_gender() {
		return interested_gender;
	}
	public void setInterested_gender(String interested_gender) {
		this.interested_gender = interested_gender;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getBirth_day() {
		return birth_day;
	}
	public void setBirth_day(String birth_day) {
		this.birth_day = birth_day;
	}
	public String getMain_photo_src() {
		return main_photo_src;
	}
	public void setMain_photo_src(String main_photo_src) {
		this.main_photo_src = main_photo_src;
	}
	public String getSub1_photo_src() {
		return sub1_photo_src;
	}
	public void setSub1_photo_src(String sub1_photo_src) {
		this.sub1_photo_src = sub1_photo_src;
	}
	public String getSub2_photo_src() {
		return sub2_photo_src;
	}
	public void setSub2_photo_src(String sub2_photo_src) {
		this.sub2_photo_src = sub2_photo_src;
	}
	public String getSub3_photo_src() {
		return sub3_photo_src;
	}
	public void setSub3_photo_src(String sub3_photo_src) {
		this.sub3_photo_src = sub3_photo_src;
	}
	public String getSub4_photo_src() {
		return sub4_photo_src;
	}
	public void setSub4_photo_src(String sub4_photo_src) {
		this.sub4_photo_src = sub4_photo_src;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public int getSms() {
		return sms;
	}


	public void setSms(int sms) {
		this.sms = sms;
	}


	public String getHobby() {
		return hobby;
	}


	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	
	
	
	
}
