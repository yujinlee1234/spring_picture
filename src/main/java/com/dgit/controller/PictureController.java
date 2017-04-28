package com.dgit.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dgit.domain.LoginDTO;
import com.dgit.domain.PictureVO;
import com.dgit.service.PictureService;
import com.dgit.util.MediaUtils;
import com.dgit.util.UploadFileUtils;

@Controller
@RequestMapping("/picture/*")
public class PictureController {
	@Autowired
	private PictureService service;
	
	private static final Logger logger = LoggerFactory.getLogger(PictureController.class);
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	
	@RequestMapping("list")
	public String getList(Model model) throws Exception{
		logger.info("getList start..................");
		List<PictureVO> pList = service.getPictureList();
		for(PictureVO vo : pList){
		System.out.println(vo);
		}
		
		model.addAttribute("picList", pList);
		return "/picture/list";
	}
	
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String getAdd(){
		return "/picture/register";		
	}
	
	@RequestMapping(value="add",method=RequestMethod.POST)
	public String postAdd(List<MultipartFile> imagefiles, HttpSession session,RedirectAttributes rttr){
		try{
			String[] files = setFileList(imagefiles);
			for(String fileName:files){
				PictureVO vo = new PictureVO();
				vo.setFullname(fileName);
				vo.setUno(((LoginDTO)session.getAttribute("auth")).getUno());
				service.registPicture(vo);
			}
			rttr.addFlashAttribute("result", "SUCCESS");
		}catch(Exception e){
			rttr.addFlashAttribute("result", "FAIL");
		}
		return "redirect:/picture/list";		
	}
	
	private String[] setFileList(List<MultipartFile> imagefiles) throws IOException, Exception {
		// TODO Auto-generated method stub
		ArrayList<String> filenames = new ArrayList<>();
		for(MultipartFile file:imagefiles){
			logger.info("ORIGINAL NAME : "+file.getOriginalFilename());
			logger.info("SIZE : "+file.getSize());
			logger.info("CONTENT TYPE : "+file.getContentType());
			if(file.getOriginalFilename() != null && file.getOriginalFilename() != ""){
				String savedName = UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
				filenames.add(savedName);
			}
		}
		String[] sFiles = filenames.toArray(new String[filenames.size()]);
		return sFiles;
	}
	
	@ResponseBody
	@RequestMapping(value="display")
	public ResponseEntity<byte[]> displayFile(String filename) throws IOException {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		logger.info("[displayFile] filename : "+filename);
		try{
			String format = filename.substring(filename.lastIndexOf(".")+1);//파일 확장자만 뽑기
			MediaType mType = MediaUtils.getMediaType(format);
			
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(mType);
			
			in = new FileInputStream(uploadPath+"/"+filename);
			
			//IOUtils.toByteArray(in);
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		}catch(IOException e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}finally {
			in.close();
		}
		
		return entity;	
	}
}
