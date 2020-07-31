package com.one.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.one.vo.MessageVO;

public class MessageDAOImpl implements MessageDAO {
	
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void insertMessage(MessageVO vo) {
		sqlSession.insert("com.one.mapper.MessageMapper.insertMessage",vo);
	}

	@Override
	public List<MessageVO> selectAllMessage(String user1, String user2) {
		Map<String,String> map = new HashMap<String, String>();
		map.put("user1", user1);
		map.put("user2", user2);
		return sqlSession.selectList("com.one.mapper.MessageMapper.selectAllMessage",map);
	}

	@Override
	public MessageVO selectLastMessage(String user1, String user2) {
		Map<String,String> map = new HashMap<String, String>();
		map.put("user1", user1);
		map.put("user2", user2);
		return sqlSession.selectOne("com.one.mapper.MessageMapper.selectLastMessage", map);
	}

}
















