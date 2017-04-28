package com.dgit.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dgit.domain.PictureVO;

@Service
public interface PictureService {
	public void registPicture(PictureVO vo) throws Exception;
	
	public PictureVO getPicture(String fullname) throws Exception;
	
	public List<PictureVO> getPictureList()throws Exception;
	
	public void removeSelectedPicture(String fullname)throws Exception;
}
