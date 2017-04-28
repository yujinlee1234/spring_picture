package com.dgit.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.dgit.domain.MemberVO;

@Repository
public class MemberDAOImple implements MemberDAO {
	private final String namespace = "com.dgit.mapper.MemberMapper";
	
	@Inject
	private SqlSession session;

	@Override
	public void insertMember(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertMember", vo);
	}

	@Override
	public MemberVO selectMemberByID(String id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".selectMemberByID", id);
	}

	@Override
	public MemberVO selectMemberByIDPW(String id, String pw) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<>();
		map.put("uid", id);
		map.put("upw", pw);
		
		return session.selectOne(namespace+".selectMemberByIDPW", map);
	}

}
