package com.dgit.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.PictureVO;
import com.dgit.persistence.PictureDAO;
@Service
public class PictureServiceImpl implements PictureService{
	private static final Logger logger = LoggerFactory.getLogger(PictureServiceImpl.class);
	
	@Autowired
	private PictureDAO pDao;
	
	
	@Override
	public void registPicture(PictureVO vo) throws Exception {
		// TODO Auto-generated method stub
		pDao.insertPicture(vo);
	}

	@Override
	public PictureVO getPicture(String fullname) throws Exception {
		// TODO Auto-generated method stub
		return pDao.selectPicture(fullname);
	}

	@Override
	public List<PictureVO> getPictureList() throws Exception {
		// TODO Auto-generated method stub
		return pDao.selectPictureList();
	}

	@Override
	public void removeSelectedPicture(String fullname) throws Exception {
		// TODO Auto-generated method stub
		pDao.deletePicture(fullname);
	}

}
