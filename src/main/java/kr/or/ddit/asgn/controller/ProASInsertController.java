package kr.or.ddit.asgn.controller;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.asgn.service.AsgnService;
import kr.or.ddit.asgn.vo.AsgnVO;
import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/asgn/proAsgnInsert.do")
public class ProASInsertController {
	
	@Inject
	private AsgnService service;
	
	@Inject
	private AttendanceDAO attendanceDAO;
	
	@ModelAttribute("asgn")
	public AsgnVO asgnInsert(
			@RequestParam("what") String lectNo
			, Authentication authentication
	) {
		AsgnVO asgn = new AsgnVO();
		// 강의번호를 넣어서 쿼리문에서 처리
		asgn.setLectNo(lectNo);
		return asgn;	
	}
	
	@GetMapping
	public String getUI(
			Model model,
			@RequestParam("what") String lectNo
			) {
		model.addAttribute("lect", attendanceDAO.selectMylectname(lectNo));
		return "asgn/proAsgnForm";
	}
	
	@PostMapping
	public String proAsgnInsert(
			@RequestParam("what") String lectNo
			, @Validated(InsertGroup.class) @ModelAttribute("asgn") AsgnVO asgn
			, Errors errors
	) {
		log.info("오류 {} : ", errors);
		String viewName = null;
		if(!errors.hasErrors()) {
			service.createAsgn(asgn);
			viewName = "redirect:/asgn/proAsgn.do?what="+asgn.getLectNo();
		}else {
			viewName = "asgn/proAsgnForm";
		}
		return viewName;
		
	}
}


















