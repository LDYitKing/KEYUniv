package kr.or.ddit.asgn.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.asgn.service.AsgnService;
import kr.or.ddit.asgn.vo.AsgnSubmitVO;
import kr.or.ddit.asgn.vo.AsgnVO;
import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.student.vo.StudentVO;

@Controller
@RequestMapping("/asgn")
public class AsgnController {
	
	@Inject
	private AttendanceDAO attendDAO;
	
	@Inject
	private AsgnService service;
	
	@GetMapping("/asgn.do")
	public String getUI(
		@RequestParam(value = "what") String lectNo
		, Model model
	) {
		String lectName = attendDAO.selectMylectname(lectNo);
		model.addAttribute("lectName", lectName);
		model.addAttribute("what", lectNo);
		return "asgn/asgnList";
	}
	
	// 과제 리스트조회
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE, value = "/asgn.do")
	@ResponseBody
	public List<AsgnVO> asgnList(
		@RequestParam(value = "what") String lectNo
	) {
		return service.retrieveAsgnList(lectNo);
	}
	
	// 과제 상세조회
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE, value = "/asgnView.do")
	@ResponseBody
	public AsgnVO retrieveAsgn(
		@RequestParam(value = "what") String asgnNo
	) {
		return service.retrieveAsgn(asgnNo);
	}
}
