package com.one.project;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.one.service.UserService;
import com.one.vo.FileVO;
import com.one.vo.UserVO;

@Controller
public class LoginController {
	
	@Autowired
	private UserService service;
	@Autowired
	private ServletContext app;
	@Autowired
	private HttpSession session;
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private NaverController naverController;
	@Autowired
	private KakaoController kakaoController;
	
	@Autowired
	JavaMailSender mailSender;
	
	// 로그인 첫 화면 요청 메소드
	@RequestMapping(value = "/index", method = { RequestMethod.GET, RequestMethod.POST })
	public String index(Model model) {

		// 구글 사이트키
		String googleSiteKey = "6Ld4ZfUUAAAAALq_ZVlFNlFHw2hc9HRbeijRPMv0";
		// 카카오 인증 URL 생성
		String kakaoUrl = kakaoController.getAuthorizationUrl(session);
		// 네이버 인증 URL 생성
		String naverUrl = naverController.getAuthorizationUrl(session);

//			System.out.println("카카오:" + kakaoUrl);
//			System.out.println("네이버:" + naverUrl);

		model.addAttribute("googleSiteKey", googleSiteKey);
		model.addAttribute("kakaoUrl", kakaoUrl);
		model.addAttribute("naverUrl", naverUrl);

		return "index";
	}

	@RequestMapping(value="/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model) {
		
		String kakaoUrl = kakaoController.getAuthorizationUrl(session);
		String naverUrl = naverController.getAuthorizationUrl(session); 
		model.addAttribute("kakaoUrl", kakaoUrl);
		model.addAttribute("naverUrl", naverUrl);
		
		return "login";
	}
	
	@RequestMapping(value="/loginCheck")
	public String loginCheck(@RequestParam("emailOrId")String emailOrId, 
			@RequestParam("password")String password, Model model) {

		UserVO vo = service.selectUser(emailOrId, password);
		
		if(vo == null) {
			String kakaoUrl = kakaoController.getAuthorizationUrl(session);
			String naverUrl = naverController.getAuthorizationUrl(session); 
			model.addAttribute("kakaoUrl", kakaoUrl);
			model.addAttribute("naverUrl", naverUrl);
			model.addAttribute("emailOrId", emailOrId);
			return "loginError";
		}
		
		model.addAttribute("userId", vo.getId());
		session.setAttribute("vo", vo);
		
		return "home";
	}
	
	@RequestMapping(value="/losePw")
	public String lodePw(Model model) {
		return "losePw";
	}
	
//	@RequestMapping(value="/pwCode")
//	public String pwCode(Model model) {
//		return "pwCode";
//	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signup(Model model) throws Exception {

		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		model.addAttribute("name", name);
		model.addAttribute("email", email);

		return "signup";
	}

	@RequestMapping(value = "/userInfo")
	public String userInfo(Model model) {
		
//		String name = (String)session.getAttribute("name");
//		String email = (String)session.getAttribute("email");
//		UserVO vo = service.searchUser(name, email);
		
		UserVO vo = (UserVO)session.getAttribute("vo");
		
		System.out.println(vo.getName());
		System.out.println(vo.getId());
		System.out.println(vo.getPassword());
		System.out.println(vo.getEmail());
		System.out.println(vo.getGender());
		System.out.println(vo.getInterested_gender());
		System.out.println(vo.getBirth_day());
		System.out.println(vo.getPhone());
		System.out.println(vo.getSms());
		System.out.println(vo.getAddress());
		System.out.println(vo.getHobby());
		System.out.println(vo.getMain_photo_src());
		System.out.println(vo.getSub1_photo_src());
		System.out.println(vo.getSub2_photo_src());
		System.out.println(vo.getSub3_photo_src());
		
		session.setAttribute("vo", vo);
		
		return "userInfo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkEmail", method = RequestMethod.POST) 
	public int checkEmail(HttpServletRequest request, Model model) { 
		String email = request.getParameter("email");
		int countRows = service.countRowsEmail(email); 
		session.setAttribute("email", email);
		return countRows; 
	}

	@ResponseBody
	@RequestMapping(value = "/checkId", method = RequestMethod.POST) 
	public int checkId(HttpServletRequest request, Model model) { 
		String id = request.getParameter("id");
		int countRows = service.countRowsId(id); 
		session.setAttribute("id", id);
		return countRows; 
	}


	@ResponseBody
	@RequestMapping(value="/sendCode", method=RequestMethod.POST)
	public String sendCode(@RequestParam("email")String email, Model model) throws Exception {
		
		System.out.println("email : " + email);
		
		String key = "";
		int n = (int)(Math.random() * 1000000);
		if(n < 100000) {
			n += 100000;
		}
		key = String.valueOf(n);
		
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[OneDate 인증 코드입니다]");
        sendMail.setText(new StringBuffer().append("<h1>이메일 주소 인증하기</h1>")
        		.append("<br><br>OneDate를 시작하려면 다음 인증 코드를 입력하세요.<br><br>")
        		.append("<h1>" + key + "</h1>")
        		.append("<br>감사합니다.")
        		.append("<br>OneDate").toString());
        sendMail.setFrom("noraboca@naver.com", "OneDate");
        sendMail.setTo(email);
        sendMail.send();
		        
        session.setAttribute("key", key);
        
		return key;
	}
	
	@RequestMapping(value="/pwSendCode", method = RequestMethod.POST )
	public String pwSendCode(@RequestParam("id")String id, @RequestParam("email")String email, 
			Model model) throws Exception {
		
		System.out.println(id);
		System.out.println(email);
		
		String key = "";
		int n = (int)(Math.random() * 1000000);
		if(n < 100000) {
			n += 100000;
		}
		key = String.valueOf(n);
		
        UserVO vo = service.searchUser(id, email);
        if(vo == null) {
        	return "losePwError";
        } 
        
        MailHandler sendMail = new MailHandler(mailSender);
        sendMail.setSubject("[OneDate 인증 코드입니다]");
        sendMail.setText(new StringBuffer().append("<h1>이메일 주소 인증하기</h1>")
        		.append("<br><br>OneDate를 시작하려면 다음 인증 코드를 입력하세요.<br><br>")
        		.append("<h1>" + key + "</h1>")
        		.append("<br>감사합니다.")
        		.append("<br>OneDate").toString());
        sendMail.setFrom("noraboca@naver.com", "OneDate");
        sendMail.setTo(email);
        sendMail.send();
        
        session.setAttribute("vo", vo);
        
        session.setAttribute("id", id);
        session.setAttribute("email", email);
        session.setAttribute("key", key);
        
        return "pwCode";
        
	}
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insert(UserVO vo, FileVO fileVo, Model model) throws Exception {
		
		// String filePath = "c:/upload";
		String filePath = app.getRealPath("/resources/upload/");
		System.out.println(filePath);
		//MultipartFile multipart = fileVo.getMultipart();
		MultipartFile[] arrMultipart = fileVo.getMultipart();
		String[] arrFilename = new String[arrMultipart.length];

		for (int i = 0; i < arrMultipart.length; i++) {

			String fileName = "(no files)";
			MultipartFile multipart = arrMultipart[i];
			if (multipart.isEmpty() == false) {
				fileName = multipart.getOriginalFilename();
				File file = new File(filePath, fileName);
				if (file.exists() == false) {
					file.mkdirs();
				}
				multipart.transferTo(file);
			}
			arrFilename[i] = fileName;
		}
		fileVo.setFilenames(arrFilename);
		
//		String fileName = "(no files)";
//		if(multipart.isEmpty() == false) {
//			fileName = multipart.getOriginalFilename();
//			File file = new File(filePath, fileName);
//			if(file.exists() == false) {
//				file.mkdirs();
//			}
//			multipart.transferTo(file);
//		}
//		fileVo.setFileName(fileName);
		
		vo.setMain_photo_src(arrFilename[0]);
		vo.setSub1_photo_src(arrFilename[1]);
		vo.setSub2_photo_src(arrFilename[2]);
		vo.setSub3_photo_src(arrFilename[3]);
		
		System.out.println(vo.getName());
		System.out.println(vo.getId());
		System.out.println(vo.getPassword());
		System.out.println(vo.getEmail());
		System.out.println(vo.getGender());
		System.out.println(vo.getInterested_gender());
		System.out.println(vo.getBirth_day());
		System.out.println(vo.getPhone());
		System.out.println(vo.getSms());
		System.out.println(vo.getAddress());
		System.out.println(vo.getHobby());
		System.out.println(vo.getMain_photo_src());
		System.out.println(vo.getSub1_photo_src());
		System.out.println(vo.getSub2_photo_src());
		System.out.println(vo.getSub3_photo_src());
		
		int result = service.insertUser(vo);
		System.out.println("return result : " + result);
		if(result > 0) {
			model.addAttribute("userId", vo.getId());
			session.setAttribute("vo", vo);
		}
		return "home";
	}
	
	@RequestMapping(value="/update")
	public String update(UserVO vo, FileVO fileVo, Model model) throws Exception {
		
		String filePath = app.getRealPath("/resources/upload/");
		System.out.println(filePath);
		MultipartFile[] arrMultipart = fileVo.getMultipart();
		String[] arrFilename = new String[arrMultipart.length];

		for (int i = 0; i < arrMultipart.length; i++) {

			String fileName = "(no files)";
			MultipartFile multipart = arrMultipart[i];
			if (multipart.isEmpty() == false) {
				fileName = multipart.getOriginalFilename();
				File file = new File(filePath, fileName);
				if (file.exists() == false) {
					file.mkdirs();
				}
				multipart.transferTo(file);
			}
			arrFilename[i] = fileName;
		}
		fileVo.setFilenames(arrFilename);
		
		vo.setMain_photo_src(arrFilename[0]);
		vo.setSub1_photo_src(arrFilename[1]);
		vo.setSub2_photo_src(arrFilename[2]);
		vo.setSub3_photo_src(arrFilename[3]);
		
		System.out.println(vo.getName());
		System.out.println(vo.getId());
		System.out.println(vo.getPassword());
		System.out.println(vo.getEmail());
		System.out.println(vo.getGender());
		System.out.println(vo.getInterested_gender());
		System.out.println(vo.getBirth_day());
		System.out.println(vo.getPhone());
		System.out.println(vo.getSms());
		System.out.println(vo.getAddress());
		System.out.println(vo.getHobby());
		System.out.println(vo.getMain_photo_src());
		System.out.println(vo.getSub1_photo_src());
		System.out.println(vo.getSub2_photo_src());
		System.out.println(vo.getSub3_photo_src());
		
		int result = service.updateUser(vo);
		System.out.println("return result : " + result);
		if(result > 0) {
			model.addAttribute("userId", vo.getId());
			session.setAttribute("vo", vo);
		}
		
		return "home";
	}
	
	@RequestMapping(value="/delete")
	public String delete(Model model) {
		int idx = 8;
		service.deleteUser(idx);
		System.out.println("�궘�젣 �셿猷�!");
		return "index";
	}
	
	@RequestMapping(value = "/kakaologin", produces = "application/json")
	public String kakaoLogin(@RequestParam("code") String code, Model model) {
		
		// 카카오 홈페이지에서 받은 결과 코드
		System.out.println("code:" + code);

		// 결과값을 node에 담아줌
		JsonNode node = kakaoController.getAccessToken(code);
		// accessToken에 사용자의 로그인한 모든 정보가 들어있음
		JsonNode accessToken = node.get("access_token");
		// 결과값 출력
		System.out.println("node:" + node);
		// 노드 안에 있는 access_token값을 꺼내 문자열로 변환
		String token = node.get("access_token").toString();
		// 세션에 담아준다.
		session.setAttribute("token", token);

		// 사용자의 정보
		JsonNode userInfo = kakaoController.getKakaoUserInfo(accessToken);
		
		// 유저정보 카카오에서 가져오기 Get properties
		JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");

		String name = properties.path("nickname").asText();
		String email = kakao_account.path("email").asText();
		String gender = kakao_account.path("gender").asText();
		String birthday = kakao_account.path("birthday").asText();
		String age = kakao_account.path("age_range").asText();
		String image = properties.path("profile_image").asText();

		System.out.println("nickname : " + name);
		System.out.println("email : " + email);
		System.out.println("gender : " + gender);
		System.out.println("birthday : " + birthday);
		System.out.println("age : " + age);
		System.out.println("image : " + image);
		
		UserVO vo = service.searchUser(name, email);
		
    	if(vo == null) {
    		session.setAttribute("name", name);
    		session.setAttribute("email", email);
    		session.setAttribute("gender", gender);
    		session.setAttribute("birthday", birthday);		// ex.mmdd
    		session.setAttribute("age", age);
    		//session.setAttribute("image", image);
    		
    		return "signup";
    	}
		
    	model.addAttribute("userId", vo.getId());
    	session.setAttribute("vo", vo);
    	
		return "home";
	}

	@RequestMapping(value = "/naverlogin", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state)
			throws IOException, ParseException {

		OAuth2AccessToken oauthToken;
		oauthToken = naverController.getAccessToken(session, code, state);
		
		// 1. 로그인 사용자 정보를 읽어온다.
		String apiResult = naverController.getUserProfile(oauthToken); // String형식의 json데이터
		
		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject)obj;
		
		// 3. 데이터 파싱
		JSONObject response_obj = (JSONObject)jsonObj.get("response");
		String name = (String)response_obj.get("name");
		String nickname = (String)response_obj.get("nickname");
		String email = (String)response_obj.get("email");
		String gender = (String)response_obj.get("gender");
		String age = (String)response_obj.get("age");
		String birthday = (String)response_obj.get("birthday");		// ex.mm-dd
		String profile_image = (String)response_obj.get("profile_image");
		
		System.out.println(name);
		System.out.println(nickname);
		System.out.println(email);
		System.out.println(gender);
		System.out.println(age);
		System.out.println(birthday);
		System.out.println(profile_image);
		
		UserVO vo = service.searchUser(name, email);
		if(vo == null) {
    		session.setAttribute("name", name);
    		session.setAttribute("email", email);
    		session.setAttribute("gender", gender);
    		session.setAttribute("birthday", birthday);
    		session.setAttribute("age", age);
    		//session.setAttribute("image", profile_image);
    		
    		return "signup";
    	}
		
		model.addAttribute("userId", vo.getId());
    	session.setAttribute("vo", vo);
    	
		return "home";
	}
	
	// 카카오 로그아웃 
//	@RequestMapping(value = "/logout", produces = "application/json")
//	public String Logout(HttpSession session) {
//
//		// 노드에 로그아웃한 결과값음 담아줌 매개변수는 세션에 잇는 token을 가져와 문자열로 변환
//		JsonNode node = kakaoController.logout(session.getAttribute("token").toString());
//		// 결과 값 출력
//		System.out.println("로그인 후 반환되는 아이디 : " + node.get("id"));
//		
//		return "redirect:/index";
//	}

	// 로그아웃
//	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
//	public String logout(HttpSession session) throws IOException {
//		System.out.println("여기는 logout");
//		session.invalidate();
//		
//		return "redirect:/index";
//	}
	
}
