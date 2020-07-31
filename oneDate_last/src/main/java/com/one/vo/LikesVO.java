package com.one.vo;

public class LikesVO {
	private int idx;
	private int who;
	private int whom;
	
	public LikesVO() {
		// TODO Auto-generated constructor stub
	}
	
	public LikesVO(int who, int whom) {
		this.who = who;
		this.whom = whom;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getWho() {
		return who;
	}
	public void setWho(int who) {
		this.who = who;
	}
	public int getWhom() {
		return whom;
	}
	public void setWhom(int whom) {
		this.whom = whom;
	}
	
	
}
