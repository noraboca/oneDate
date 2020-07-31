package com.one.dao;

import java.util.List;

import com.one.vo.LikesVO;
import com.one.vo.MatchedUserVO;

public interface MatchingDAO {
	public void insertMatch(MatchedUserVO vo);
	public List<MatchedUserVO> selectMatchs(int user_idx);
	public void insertLike(LikesVO vo);
	public void deleteLike(int user_idx1,int user_idx2);
	public List<LikesVO> selectLikes(int user_idx);

}
