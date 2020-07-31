package com.one.service;

import java.util.List;

import com.one.vo.UserVO;

public interface UserService {
	public int getUserIndexByID(String id);
	public UserVO getUserInfo(String id);
	public UserVO getUserInfo(int idx);
	public List<UserVO> showAllUserByGender(String gender,int user_idx);
	public UserVO selectUser(String emailOrId, String password);
	public UserVO searchUser(String nameOrId, String email);
	public int insertUser(UserVO vo);
	public int updateUser(UserVO vo);
	public void deleteUser(int idx);
	public int countRowsEmail(String email);
	public int countRowsId(String id);
}
