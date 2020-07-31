package com.one.dao;

import java.util.List;

import com.one.vo.MessageVO;

public interface MessageDAO {

	public void insertMessage(MessageVO vo);
	public List<MessageVO> selectAllMessage(String user1,String user2);
	public MessageVO selectLastMessage(String user1,String user2);
}
