package com.one.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.one.vo.UserVO;

public class UserDAOImpl implements UserDAO {
	
	private SqlSession sqlSession;
	
	public void setSqlsession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public int insertUser(UserVO vo) {
		return sqlSession.insert("com.one.mapper.UserMapper.insertUser",vo);
	}

	@Override
	public UserVO selectUser(String emailOrId, String password) {
		Map<String, String>map = new HashMap<String, String>();
		map.put("emailOrId", emailOrId);
		map.put("password", password);
		return sqlSession.selectOne("com.one.mapper.UserMapper.selectUser", map);
	}

	@Override
	public UserVO selectUser(int idx) {
		return sqlSession.selectOne("com.one.mapper.UserMapper.selectUserByIdx", idx);
	}

	@Override
	public UserVO selectUser(String id) {
		return sqlSession.selectOne("com.one.mapper.UserMapper.selectUserById", id);
	}

	@Override
	public int selectUserIdx(String id) {
		return sqlSession.selectOne("com.one.mapper.UserMapper.selectUserIdx", id);
	}

	@Override
	public List<UserVO> selectAllUserByGender(String gender,int idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		map.put("gender", gender);
		return sqlSession.selectList("com.one.mapper.UserMapper.selectAllUserByGender", map);
	}
	

	@Override
	public UserVO searchUser(String nameOrId, String email) {
		Map<String, String>map = new HashMap<String, String>();
		map.put("nameOrId", nameOrId);
		map.put("email", email);
		return sqlSession.selectOne("com.one.mapper.UserMapper.searchUser", map);
	}

	@Override
	public int updateUser(UserVO vo) {
		return sqlSession.update("com.one.mapper.UserMapper.updateUser", vo);
	}

	@Override
	public void deleteUser(int idx) {
		sqlSession.delete("com.one.mapper.UserMapper.deleteUser", idx);
	}

	@Override
	public int countRowsEmail(String email) {
		return sqlSession.selectOne("com.one.mapper.UserMapper.countRowsEmail", email);
	}

	@Override
	public int countRowsId(String id) {
		return sqlSession.selectOne("com.one.mapper.UserMapper.countRowsId", id);
	}

}
