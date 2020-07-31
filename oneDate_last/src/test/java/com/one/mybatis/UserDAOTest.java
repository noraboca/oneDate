package com.one.mybatis;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.one.dao.UserDAO;
import com.one.vo.UserVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class UserDAOTest {
	
	@Autowired
	private UserDAO dao;
	
	@Test
	public void testSelectUser() throws Exception {
		UserVO vo =null;
		if(vo != null) {
			System.out.println(vo.getId());
			System.out.println(vo.getPassword());
			System.out.println(vo.getName());
			System.out.println(vo.getGender());
			System.out.println(vo.getInterested_gender());
		}else {
			System.out.println("�α��� ����");
		}
	}
	
	@Test
	public void testInsertUser() throws Exception{
//		UserVO vo = new UserVO("최성길", "m", "f", "choi1234", "1234", "choi1234@naver.com", "1992-6-13", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("정성국", "m", "f", "jeong1234", "1234", "jeong1234@naver.com", "1991-5-3", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("강성혁", "m", "f", "kang1234", "1234", "kang1234@naver.com", "1990-11-3", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("조윤제", "m", "f", "joe1234", "1234", "joe1234@naver.com", "1989-5-7", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("윤호준", "m", "f", "yoon1234", "1234", "yoon1234@naver.com", "1993-4-23", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("장만석", "m", "f", "jang1234", "1234", "jang1234@naver.com", "1994-2-28", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("임도준", "m", "f", "lim1234", "1234", "lim1234@naver.com", "1995-3-3", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("신일섭", "m", "f", "sin1234", "1234", "sin1234@naver.com", "1996-10-23", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("한나래", "f", "m", "han1234", "1234", "han1234@naver.com", "1997-12-7", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("오윤희", "f", "m", "oh1234", "1234", "oh1234@naver.com", "1992-6-7", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("서희", "f", "m", "west1234", "1234", "west1234@naver.com", "1991-6-3", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("황구", "f", "m", "hwang1234", "1234", "hwang1234@naver.com", "1990-6-3", "download4");
//		dao.insertUser(vo);
//		vo = new UserVO("안도희", "f", "m", "ann1234", "1234", "ann1234@naver.com", "1989-3-8", "download4");
//		dao.insertUser(vo);
		UserVO vo = new UserVO("송건희", "f", "m", "song1234", "1234", "song1234@naver.com", "1988-4-3", "download4");
		dao.insertUser(vo);
		vo = new UserVO("유예은", "f", "m", "you1234", "1234", "you1234@naver.com", "1996-6-3", "download4");
		dao.insertUser(vo);
		vo = new UserVO("홍정연", "f", "m", "hong1234", "1234", "hong1234@naver.com", "1994-7-13", "download4");
		dao.insertUser(vo);
		vo = new UserVO("전영희", "f", "m", "jeon1234", "1234", "jeon1234@naver.com", "1998-8-29", "download4");
		dao.insertUser(vo);
		vo = new UserVO("고혜지", "f", "m", "go1234", "1234", "go1234@naver.com", "1997-4-15", "download4");
		dao.insertUser(vo);
		vo = new UserVO("문소리", "f", "m", "moon1234", "1234", "moon1234@naver.com", "1995-11-23", "download4");
		dao.insertUser(vo);
		vo = new UserVO("손희량", "f", "m", "son1234", "1234", "son1234@naver.com", "1996-9-23", "download4");
		dao.insertUser(vo);
		vo = new UserVO("양예희", "f", "m", "yang1234", "1234", "yang1234@naver.com", "1996-2-4", "download4");
		dao.insertUser(vo);
		vo = new UserVO("배두나", "f", "m", "bae1234", "1234", "bae1234@naver.com", "1992-1-3", "download4");
		dao.insertUser(vo);
		
	}

}







