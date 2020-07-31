package com.one.mybatis;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.one.dao.MessageDAO;
import com.one.vo.MessageVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class MessageDAOTest {
	
	@Autowired
	private MessageDAO dao;
	
	@Test
	public void sendMessage() {
		MessageVO vo = new MessageVO("good:)", "kgu67878", "lee1234");
		dao.insertMessage(vo);
	}
	
	@Test
	public void showMessages() {
		List<MessageVO> list = dao.selectAllMessage("kgu67878", "lee1234");
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).getUser_send()+": "+list.get(i).getText());
		}
	}
}
