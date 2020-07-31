package com.one.vo;

public class MessageVO {
	private int idx;
	private String text;
	private String ts;
	private String user_send;
	private String user_receive;
	
	public MessageVO() {
		// TODO Auto-generated constructor stub
	}
	
	public MessageVO(String text, String user_send, String user_receive) {
		super();
		this.text = text;
		this.user_send = user_send;
		this.user_receive = user_receive;
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getTs() {
		return ts;
	}
	public void setTs(String ts) {
		this.ts = ts;
	}
	public String getUser_send() {
		return user_send;
	}
	public void setUser_send(String user_send) {
		this.user_send = user_send;
	}
	public String getUser_receive() {
		return user_receive;
	}
	public void setUser_receive(String user_receive) {
		this.user_receive = user_receive;
	}
	
	
	
}
