package com.dgit.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.MemberVO;
import com.dgit.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	private MemberDAO mDao;
	
	@Override
	public boolean registMember(MemberVO vo) {
		boolean result = false;
		try{
			mDao.insertMember(vo);
			result = true;
		}catch(Exception e){
			logger.warn("registMember", e.getMessage());
		}
		return result;
	}

	@Override
	public boolean checkID(String id){
		// 아이디로 조회하여 멤버 객체가 return되지 않으면 true; - 사용가능한 아이디
		boolean result = false;
		try{
			MemberVO vo = mDao.selectMemberByID(id);
			if(vo==null){
				result = true;
			}
		}catch(Exception e){
			logger.warn("checkID", e.getMessage());
		}
		return result;
	}

	@Override
	public MemberVO login(String id, String pw){
		// TODO Auto-generated method stub
		MemberVO vo = null;
		try{
			vo = mDao.selectMemberByIDPW(id, pw);
		}catch(Exception e){
			logger.warn("login", e.getMessage());
		}
		return vo;
	}

}
