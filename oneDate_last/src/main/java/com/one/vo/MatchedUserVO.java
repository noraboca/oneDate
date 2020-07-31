package com.one.vo;

public class MatchedUserVO {
	private int idx;
	private int user_idx;
	private String matched_user_id;
	
	public MatchedUserVO() {
		// TODO Auto-generated constructor stub
	}

	public MatchedUserVO(int user_idx, String matched_user_id) {
		super();
		this.user_idx = user_idx;
		this.matched_user_id = matched_user_id;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getMatched_user_id() {
		return matched_user_id;
	}
	public void setMatched_user_id(String matched_user_id) {
		this.matched_user_id = matched_user_id;
	}
	
	
}
