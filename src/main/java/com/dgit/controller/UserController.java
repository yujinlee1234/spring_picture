package com.dgit.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dgit.domain.LoginDTO;
import com.dgit.domain.MemberVO;
import com.dgit.service.MemberService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	@Inject
	private MemberService mService;
	
	/* LOGIN */
	@RequestMapping(value = "login",method=RequestMethod.GET)
	public void getLogin(){}
	
	@RequestMapping(value = "login",method=RequestMethod.POST)
	public String postLogin(String uid, String upw, HttpSession session, RedirectAttributes rttr){
		logger.info("postLogin", "ID : "+uid+"UPW : "+upw);
		MemberVO vo = mService.login(uid, upw);
		if(vo != null){
			LoginDTO auth = new LoginDTO(vo.getUno(), vo.getUid(), vo.getUname(), vo.getUregdate());
			session.setAttribute("auth", auth);
			return  "redirect:/picture/list";
		}else if(vo == null){
			rttr.addFlashAttribute("result", "FAIL");
			rttr.addFlashAttribute("returnTo", "/user/login");
			return "redirect:/";
		}
		return null;
		
	}
	
	/* LOGOUT */
	@RequestMapping(value = "logout",method=RequestMethod.GET)
	public String getLogout(HttpSession session){
		if(session.getAttribute("auth")!=null){
			session.removeAttribute("auth");
		}
		return "redirect:/picture/list";
	}
	
	/* JOIN */
	@RequestMapping(value = "join",method=RequestMethod.GET)
	public void getJoin(){}
	
	@RequestMapping(value = "join",method=RequestMethod.POST)
	public String postJoin(MemberVO vo, RedirectAttributes rttr){
		logger.info("postJoin", vo);
		if(mService.registMember(vo)){
			rttr.addFlashAttribute("result", "SUCCESS");
			rttr.addFlashAttribute("returnTo", "/user/login");
		}else{
			rttr.addFlashAttribute("result", "SUCCESS");
			rttr.addFlashAttribute("returnTo", "/user/join");
		}
		return "redirect:/";
	}
	
	/* CHECK ID */
	@ResponseBody
	@RequestMapping(value = "check/{id}",method=RequestMethod.GET)
	public ResponseEntity<String> checkID(@PathVariable("id")String id){
		logger.info("checkID", id);
		ResponseEntity<String> result = null;
		if(mService.checkID(id)){//사용가능한 아이디
			result = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}else{
			result = new ResponseEntity<String>("FAIL",HttpStatus.OK);
		}
		return result;
	}
}
