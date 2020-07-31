package com.one.dao;

import java.util.List;

import com.one.vo.UserVO;

public interface UserDAO {

	public UserVO selectUser(String emailOrId, String password);
	public UserVO selectUser(String id);
	public UserVO selectUser(int idx);
	public int selectUserIdx(String id);
	public List<UserVO> selectAllUserByGender(String gender,int idx);
	public UserVO searchUser(String nameOrId, String email);
	public int insertUser(UserVO vo);
	public int updateUser(UserVO vo);
	public void deleteUser(int idx);
	public int countRowsEmail(String email);
	public int countRowsId(String id);

}
