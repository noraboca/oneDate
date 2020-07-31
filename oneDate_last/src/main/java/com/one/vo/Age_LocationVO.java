package com.one.vo;

public class Age_LocationVO {
	private int age;
	private double distance;
	
	public Age_LocationVO() {
		// TODO Auto-generated constructor stub
	}
	
	public Age_LocationVO(int age, double distance) {
		super();
		this.age = age;
		this.distance = distance;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
	public int getDistance() {
		return (int)distance;
	}
	
}
