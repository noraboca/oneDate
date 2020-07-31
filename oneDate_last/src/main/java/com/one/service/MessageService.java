package com.one.service;

import java.util.List;

import com.one.vo.MessageVO;

public interface MessageService {

	public List<MessageVO> getMessageLogs(String sender,String receiver);
	public void sendMessage(String text,String sender,String receiver);
	public MessageVO getLastMessage(String sender, String receiver);
}
