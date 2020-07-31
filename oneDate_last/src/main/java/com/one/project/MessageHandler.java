package com.one.project;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.one.service.MessageService;


@RequestMapping("/chat")
public class MessageHandler extends TextWebSocketHandler{

	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	Map<String, Object> map = new HashMap<String, Object>();


	private static Logger logger = LoggerFactory.getLogger(MessageHandler.class);

	@Autowired
	MessageService service;


	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		logger.info("{} 연결됨", session.getId());
		sessionList.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		

		
		JSONObject object = new JSONObject(message.getPayload());
		String type = object.getString("type");
		
		String user;
		
		if(type != null && type.equals("register")) {
			user = object.getString("userid");
			map.put(user, session);
		}else {
			user = object.getString("userid");
			String target = object.getString("target");
			WebSocketSession ws = (WebSocketSession) map.get(target);
			String msg = object.getString("message");
			service.sendMessage(msg, user, target);
			logger.info("{} : {}",session.getId(),message.getPayload());
			if(ws != null) {
				ws.sendMessage(new TextMessage(user+": "+msg));
			}
		}

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		logger.info("{} 연결 끊김",session.getId());
		sessionList.remove(session);

	}
}






















