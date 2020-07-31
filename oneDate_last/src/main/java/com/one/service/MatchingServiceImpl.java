package com.one.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.one.dao.MatchingDAO;
import com.one.dao.UserDAO;
import com.one.vo.LikesVO;
import com.one.vo.MatchedUserVO;
import com.one.vo.UserVO;

public class MatchingServiceImpl implements MatchingService {

	
	@Autowired
	UserDAO u_dao;
	
	@Autowired
	MatchingDAO dao;
	
	public MatchingServiceImpl(UserDAO u_dao, MatchingDAO dao) {
		this.u_dao = u_dao;
		this.dao = dao;
	}
	
	@Override
	public List<LikesVO> showWhoLikesMe(int user_idx) {
		return dao.selectLikes(user_idx);
	}

	@Override
	public List<UserVO> showMyMatches(int user_idx) {
		
		List<MatchedUserVO> list = dao.selectMatchs(user_idx);
		List<UserVO> user_list = new ArrayList<UserVO>();
		for (int i = 0; i < list.size(); i++) {
			UserVO vo = u_dao.selectUser(list.get(i).getMatched_user_id());
			user_list.add(vo);
		}
		return user_list;
	}

	@Override
	public boolean matchingAlgorithm(int user_idx, int interested_idx) {
		List<LikesVO> list = dao.selectLikes(user_idx);// 사용자를 좋아하는 사람들의 목록 불러오기
		
		for (int i = 0; i < list.size(); i++) {
			
			//서로 좋아요를 눌렀는지의 여부
			if(list.get(i).getWho() == u_dao.selectUser(interested_idx).getIdx()) {
				//like 해당 회원 라이크 정보 초기화
				dao.deleteLike(user_idx, interested_idx);

				//회원 매칭
				MatchedUserVO matchedUserVO = new MatchedUserVO(user_idx, u_dao.selectUser(interested_idx).getId());
				dao.insertMatch(matchedUserVO);
				matchedUserVO = new MatchedUserVO(interested_idx, u_dao.selectUser(user_idx).getId());
				dao.insertMatch(matchedUserVO);
				
				return true;
			}
		}
		//false 시, 라이크를 눌렀다는 정보만 입력
		LikesVO vo = new LikesVO(user_idx, interested_idx);
		dao.insertLike(vo);

		return false;
	}

}






















