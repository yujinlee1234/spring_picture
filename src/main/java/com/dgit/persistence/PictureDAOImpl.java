package com.dgit.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.dgit.domain.PictureVO;
@Repository
public class PictureDAOImpl implements PictureDAO{
	private final String namespace = "com.dgit.mapper.PictureMapper";
	
	@Inject
	private SqlSession session;
	
	@Override
	public void insertPicture(PictureVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertPicture", vo);
	}

	@Override
	public PictureVO selectPicture(String fullname) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".selectPicture", fullname);
	}

	@Override
	public List<PictureVO> selectPictureList() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectPictureList");
	}

}
