package com.dgit.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.dgit.domain.PictureVO;
@Repository
public interface PictureDAO {
	public void insertPicture(PictureVO vo) throws Exception;
	
	public PictureVO selectPicture(String fullname) throws Exception;
	
	public List<PictureVO> selectPictureList()throws Exception;
	
	public void deletePicture(String fullname)throws Exception;
}
