package com.dgit.persistence;

import org.springframework.stereotype.Repository;

import com.dgit.domain.MemberVO;

@Repository
public interface MemberDAO {
	/* 회원가입 */
	public void insertMember(MemberVO vo) throws Exception;
	/* 아이디 중복 확인 */
	public MemberVO selectMemberByID(String id) throws Exception;
	/* 로그인 */
	public MemberVO selectMemberByIDPW(String id, String pw) throws Exception;
}
