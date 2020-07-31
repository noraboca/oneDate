package com.one.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.one.vo.LikesVO;
import com.one.vo.MatchedUserVO;

public class MatchingDAOImpl implements MatchingDAO {

	SqlSession sqlsession;

	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	@Override
	public void insertMatch(MatchedUserVO vo) {
		sqlsession.insert("com.one.mapper.MatchingMapper.insertMatch", vo);
	}

	@Override
	public List<MatchedUserVO> selectMatchs(int user_idx) {
		return sqlsession.selectList("com.one.mapper.MatchingMapper.selectMatchs", user_idx);
	}

	@Override
	public void insertLike(LikesVO vo) {
		sqlsession.insert("com.one.mapper.MatchingMapper.insertLike", vo);
	}

	@Override
	public void deleteLike(int user_idx1, int user_idx2) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("user_idx1", user_idx1);
		map.put("user_idx2", user_idx2);
		sqlsession.delete("com.one.mapper.MatchingMapper.deleteLike", map);
	}

	@Override
	public List<LikesVO> selectLikes(int user_idx) {
		return sqlsession.selectList("com.one.mapper.MatchingMapper.selectLikes",user_idx);
	}
	
	

}


















