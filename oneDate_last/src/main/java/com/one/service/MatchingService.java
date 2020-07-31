package com.one.service;

import java.util.List;

import com.one.vo.LikesVO;
import com.one.vo.MatchedUserVO;
import com.one.vo.UserVO;

public interface MatchingService {
	public List<LikesVO> showWhoLikesMe(int user_idx);
	public List<UserVO> showMyMatches(int user_idx);
	public boolean matchingAlgorithm(int user_idx,int interested_idx); 
	
}
