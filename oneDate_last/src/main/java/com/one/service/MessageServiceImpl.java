package com.one.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.one.dao.MessageDAO;
import com.one.vo.MessageVO;

public class MessageServiceImpl implements MessageService {

	
	@Autowired
	MessageDAO dao;
	
	public MessageServiceImpl(MessageDAO dao) {
		this.dao = dao;
	}
	
	@Override
	public List<MessageVO> getMessageLogs(String sender,String receiver) {
		return dao.selectAllMessage(sender, receiver);
	}

	@Override
	public void sendMessage(String text,String sender,String receiver) {
		MessageVO vo = new MessageVO(text, sender, receiver);
		dao.insertMessage(vo);
	}

	@Override
	public MessageVO getLastMessage(String sender, String receiver) {
		return dao.selectLastMessage(sender, receiver);
	}

}
