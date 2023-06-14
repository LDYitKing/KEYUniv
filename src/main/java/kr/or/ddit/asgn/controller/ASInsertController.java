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
import kr.or.ddit.asgn.vo.AsgnSubmitVO;
import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.validate.InsertGroup;

@Controller
@RequestMapping("/asgn/asgnInsert.do")
public class ASInsertController {
	
	@Inject
	private AsgnService service;
	
	@Inject
	private AttendanceDAO attendDAO;
	
	@ModelAttribute("asgnSubmit")
	public AsgnSubmitVO asgnSubmit(
			@RequestParam("asgn")String asgnNo
			, @RequestParam("what")String lectNo
			, Authentication authentication
	) {
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		String stuNo = memVO.getRealUser().getMemNo();
		AsgnSubmitVO asgnSubmit = new AsgnSubmitVO();
		asgnSubmit.setAsgnNo(asgnNo);
		asgnSubmit.setStuNo(stuNo);
		//강의번호를 수강번호에 넣어서 쿼리문에서 처리.
		asgnSubmit.setCourseNo(lectNo);
		return asgnSubmit;
	}

	@GetMapping
	public String getUI(
		@RequestParam(value = "what") String lectNo
		, Model model
	) {
		String lectName = attendDAO.selectMylectname(lectNo);
		model.addAttribute("lectName", lectName);
		model.addAttribute("what", lectNo);
		return "asgn/asgnForm";
	}

	
	@PostMapping
	public String createAsgnSubmit(
			@RequestParam("what") String lectNo
			, @Validated(InsertGroup.class) @ModelAttribute("asgnSubmit") AsgnSubmitVO asgnSubmit
			, Errors errors
	) {
		String viewName = null;
		if(!errors.hasErrors()) {
			service.createdAsgnSubmit(asgnSubmit);
			viewName = "redirect:/asgn/asgn.do?what="+lectNo;
		}else {
			viewName = "asgn/asgnForm";
		}
		return viewName;
	}
	
}



