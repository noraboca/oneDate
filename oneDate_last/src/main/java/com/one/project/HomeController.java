package com.one.project;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.maps.errors.ApiException;
import com.one.service.MatchingService;
import com.one.service.MessageService;
import com.one.service.UserService;
import com.one.vo.Age_LocationVO;
import com.one.vo.MessageVO;
import com.one.vo.UserVO;


@Controller
public class HomeController {

	@Autowired
	HttpSession session;

	@Autowired
	UserService user_service;

	@Autowired
	MessageService message_service;

	@Autowired
	MatchingService matching_service;

	//	@RequestMapping(value = "/", method = { RequestMethod.GET, RequestMethod.POST })
	//	public String home(Model model) {
	//		
	//		
	//		return "home";
	//	}

	@RequestMapping("/toMain")
	public String main(Model model,String userId) {

		session.setAttribute("sender", userId);

		UserVO myvo = user_service.getUserInfo(userId);
		session.setAttribute("myLocation", myvo.getAddress());
		session.setAttribute("myInfo", myvo);

		List<UserVO> candidate_list = user_service.showAllUserByGender(myvo.getInterested_gender(),myvo.getIdx());


		Map<String, Age_LocationVO> age_Location_map = new HashMap<String, Age_LocationVO>();
		AgeConverter converter = new AgeConverter();		

		for (int i = 0; i < candidate_list.size(); i++) {
			int age = converter.getAge(candidate_list.get(i).getBirth_day());

			double distance = 0;
			//	google api
			if(myvo.getAddress() != null && candidate_list.get(i).getAddress() != null) {
				distance = GoogleGeoCoder.calcDistance(myvo.getAddress(), candidate_list.get(i).getAddress());
			}
			Age_LocationVO age_LocationVO = new Age_LocationVO(age, distance);
			age_Location_map.put(candidate_list.get(i).getId(), age_LocationVO);

		}
		session.setAttribute("candidate_list", candidate_list);
		session.setAttribute("age_Location_map", age_Location_map);




		int user_idx = user_service.getUserIndexByID(userId);
		List<UserVO> matched_member_List = matching_service.showMyMatches(user_idx);

		Map<String,MessageVO> last_messagge_list = new HashMap<String, MessageVO>();

		//TODO 됐나...?
		for (int i = 0; i <matched_member_List.size(); i++) {
			last_messagge_list.put( matched_member_List.get(i).getId(),
					message_service.getLastMessage(userId, matched_member_List.get(i).getId()));	
		}


		session.setAttribute("last_messagge_list", last_messagge_list);
		session.setAttribute("matched_member_List", matched_member_List);


		return "main";
	}

	@RequestMapping("/matches")
	public String matchList(Model model,String userId) {

		session.setAttribute("sender", userId);
		UserVO myvo = user_service.getUserInfo(userId);
		session.setAttribute("myLocation", myvo.getAddress());
		session.setAttribute("myInfo", myvo);

		List<UserVO> candidate_list = user_service.showAllUserByGender(myvo.getInterested_gender(),myvo.getIdx());


		Map<String, Age_LocationVO> age_Location_map = new HashMap<String, Age_LocationVO>();
		AgeConverter converter = new AgeConverter();		

		for (int i = 0; i < candidate_list.size(); i++) {
			int age = converter.getAge(candidate_list.get(i).getBirth_day());

			double distance = 0;
			//	google api
			if(myvo.getAddress() != null && candidate_list.get(i).getAddress() != null) {
				distance = GoogleGeoCoder.calcDistance(myvo.getAddress(), candidate_list.get(i).getAddress());
			}
			Age_LocationVO age_LocationVO = new Age_LocationVO(age, distance);
			age_Location_map.put(candidate_list.get(i).getId(), age_LocationVO);

		}
		session.setAttribute("candidate_list", candidate_list);
		session.setAttribute("age_Location_map", age_Location_map);




		int user_idx = user_service.getUserIndexByID(userId);
		List<UserVO> matched_member_List = matching_service.showMyMatches(user_idx);

		Map<String,MessageVO> last_messagge_list = new HashMap<String, MessageVO>();

		//TODO  �̺κ� �ٽ��ѹ� ���� ���
		for (int i = 0; i <matched_member_List.size(); i++) {
			last_messagge_list.put( matched_member_List.get(i).getId(),
					message_service.getLastMessage(userId, matched_member_List.get(i).getId()));	
		}


		session.setAttribute("last_messagge_list", last_messagge_list);
		session.setAttribute("matched_member_List", matched_member_List);


		return "matches";
	}






	@RequestMapping(value = "/toChat")
	public String message(Model model,String sender,String receiver) {


		if(sender == null) {
			sender = (String) session.getAttribute("receiver");
		}

		sender = (String)session.getAttribute("sender");

		if(receiver == null) {
			receiver = (String) session.getAttribute("receiver");
		}
		UserVO vo = user_service.getUserInfo(receiver);

		session.setAttribute("receiver_vo", vo);
		session.setAttribute("receiver", receiver);

		//����� ���� ��ȯ
		AgeConverter converter = new AgeConverter();



		int age = converter.getAge(vo.getBirth_day());


		//����� ��ġ ��ȯ
		String myLocation = (String)session.getAttribute("myLocation");


		double distance = 4;
		//google map api
		if(myLocation != null && vo.getAddress() != null)
		distance = GoogleGeoCoder.calcDistance(myLocation, vo.getAddress());



			session.setAttribute("distance", ((int)distance)+"km");
		session.setAttribute("receiver_age", age);
		List<MessageVO> m_list = message_service.getMessageLogs(sender, receiver);



		model.addAttribute("m_list", m_list);

		return "chat";
	}


	@RequestMapping("/main")
	@ResponseBody
	public HashMap<String, Object>  matchingSystem(@RequestParam HashMap<String, Object> param) {

		JSONObject object = new JSONObject(param);

		String id;
		int interested_idx=0;

		if(!param.isEmpty()) {
			id = (String) object.get("user");
			interested_idx = Integer.parseInt((String)object.get("interested_idx"));
			int user_idx = user_service.getUserIndexByID(id);

			UserVO interested_info = user_service.getUserInfo(interested_idx);
			UserVO my_info = user_service.getUserInfo(user_idx);

			param.put("img_src", interested_info.getMain_photo_src());
			param.put("newMatch", interested_info.getName());	
			boolean ismatched = matching_service.matchingAlgorithm(user_idx, interested_idx);

			//sms API
			if(ismatched) {

				String api_key = "NCS85IPDT6FNEAAC";
				String api_secret = "FVZSOUPFCEYFMWMIKPJAUC7DYDESF3QF";
				Coolsms coolsms = new Coolsms(api_key, api_secret);

				HashMap<String, String> set = new HashMap<String, String>();
				set.put("to", interested_info.getPhone()); // 

				set.put("from", "01088097864"); // 사업자 전화번호
				set.put("text", "[ondate] \n 축하드립니다! 어느회원과 매칭이 되었습니다!"); // 
				set.put("type", "sms"); // 

				System.out.println(set);

				org.json.simple.JSONObject result = coolsms.send(set); // ������&���۰���ޱ�

				if ((boolean)result.get("status") == true) {
					// �޽��� ������ ���� �� ���۰�� ���
					System.out.println("����");
					System.out.println(result.get("group_id")); // �׷���̵�
					System.out.println(result.get("result_code")); // ����ڵ�
					System.out.println(result.get("result_message")); // ��� �޽���
					System.out.println(result.get("success_count")); // �޽������̵�
					System.out.println(result.get("error_count")); // ������ ������ ������ �޽��� ��
				} else {
					// �޽��� ������ ����
					System.out.println("����");
					System.out.println(result.get("code")); // REST API �����ڵ�
					System.out.println(result.get("message")); // �����޽���
				}


			}


			param.put("ismatched", ismatched);
		}

		return param;
	}


	@RequestMapping("/toProfile")
	public String profile() {

		UserVO vo = (UserVO) session.getAttribute("myInfo");

		AgeConverter converter = new AgeConverter();		
		int age = converter.getAge(vo.getBirth_day());

		session.setAttribute("age", age);

		return "profile_menu";
	}


}































