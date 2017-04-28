package com.dgit.service;

import org.springframework.stereotype.Service;

import com.dgit.domain.MemberVO;

@Service
public interface MemberService {
	/* 회원가입 */
	public boolean registMember(MemberVO vo);
	/* 아이디 중복 확인 */
	public boolean checkID(String id);
	/* 로그인 */
	public MemberVO login(String id, String pw);
}
