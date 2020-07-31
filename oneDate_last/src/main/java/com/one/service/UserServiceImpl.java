package com.one.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.one.dao.UserDAO;
import com.one.vo.UserVO;

public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO dao;
	
	public UserServiceImpl(UserDAO dao) {
		this.dao = dao;
	}
	
	@Override
	public int getUserIndexByID(String id) {
		return dao.selectUserIdx(id);
	}

	@Override
	public List<UserVO> showAllUserByGender(String gender_interested,int user_idx) {
		if(gender_interested.equalsIgnoreCase("b")) {
			//TODO
			
		}
		
		return dao.selectAllUserByGender(gender_interested,user_idx);
	}

	@Override
	public UserVO getUserInfo(String id) {
		return dao.selectUser(id);
	}

	@Override
	public UserVO getUserInfo(int idx) {
		return dao.selectUser(idx);
	}

	@Override
	public UserVO selectUser(String emailOrId, String password) {
		return dao.selectUser(emailOrId, password);
	}
	
	@Override
	public UserVO searchUser(String nameOrId, String email) {
		return dao.searchUser(nameOrId, email);
	}
	

	@Override
	public int insertUser(UserVO vo) {
		return dao.insertUser(vo);
	}

	@Override
	public int updateUser(UserVO vo) {
		return dao.updateUser(vo);
	}

	@Override
	public void deleteUser(int idx) {
		dao.deleteUser(idx);
	}

	@Override
	public int countRowsEmail(String email) {
		return dao.countRowsEmail(email);
	}

	@Override
	public int countRowsId(String id) {
		return dao.countRowsId(id);
	}

}
