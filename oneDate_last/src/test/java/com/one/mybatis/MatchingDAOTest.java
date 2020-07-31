package com.one.mybatis;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.one.dao.MatchingDAO;
import com.one.dao.UserDAO;
import com.one.vo.LikesVO;
import com.one.vo.MatchedUserVO;
import com.one.vo.UserVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class MatchingDAOTest {

	@Autowired
	UserDAO u_dao;

	@Autowired
	MatchingDAO dao;
	
	public MatchingDAOTest(MatchingDAO dao, UserDAO u_dao) {
		this.dao = dao;
		this.u_dao = u_dao;
	}

//	@Test
//	public void insertLikeTest() {
//		LikesVO vo = new LikesVO(4, 1);
//		dao.insertLike(vo);
//	}

//	@Test
//	public void showMYLikesTest() {
//		int userIdx = 1;
//		List<LikesVO> myLikeList = dao.selectLikes(userIdx);
//
//		for (int i = 0; i < myLikeList.size(); i++) {
//			System.out.println(myLikeList.get(i).getWho());
//		}
//	}

//	@Test
//	public void MatchingTest() {
//		
//		int user_idx = 4; // '���ƿ�'�� ���������� �ε��� ��ȣ
//		int interested_idx = 1; // �����ִ� ȸ���� �ε��� ��ȣ
//
//		List<LikesVO> list = dao.selectLikes(user_idx);// ������ '���ƿ�'�� ���� ������� ����Ʈ
//		
//		for (int i = 0; i < list.size(); i++) {
//			//�����ִ� ������ '���ƿ�'�� �����Ե� ���ƿ並 ��������, true 
//			if(list.get(i).getWho() == u_dao.selectUser(interested_idx).getIdx()) {
//				//like ���� ����
//				dao.deleteLike(user_idx, interested_idx);
//
//				//match DB�� ����
//				MatchedUserVO matchedUserVO = new MatchedUserVO(user_idx, u_dao.selectUser(interested_idx).getId());
//				dao.insertMatch(matchedUserVO);
//				matchedUserVO = new MatchedUserVO(interested_idx, u_dao.selectUser(user_idx).getId());
//				dao.insertMatch(matchedUserVO);
//			}else {//�ƴҽ� likes DB�� ����
//				LikesVO vo = new LikesVO(user_idx, interested_idx);
//				dao.insertLike(vo);
//			}
//		}
//
//	}
	
	@Test
	public void getMyMatchesInfo() {
		int user_idx = 1;
		List<MatchedUserVO> list = dao.selectMatchs(user_idx);
		List<UserVO> user_list = new ArrayList<UserVO>();
		for (int i = 0; i < list.size(); i++) {
			UserVO vo = u_dao.selectUser(list.get(i).getMatched_user_id());
			user_list.add(vo);
		}
		
		
		
	}











}
