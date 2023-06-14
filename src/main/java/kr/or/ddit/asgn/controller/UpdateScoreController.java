package kr.or.ddit.asgn.controller;

import javax.inject.Inject;

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
import kr.or.ddit.validate.UpdateGroup;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/asgn/updateScore.do")
@RequiredArgsConstructor
public class UpdateScoreController {

	@Inject
	private AsgnService service;
	
	@Inject
	private AttendanceDAO attendanceDAO;
	
	@ModelAttribute("as")
	public AsgnSubmitVO as(@RequestParam("what") String asNo, @RequestParam("lect") String lectNo) {
		return service.retrieveAsgnSubmitInfo(asNo);
		
	}
	
	@GetMapping
	public String asUpdateForm(
			@RequestParam("lect") String lectNo,
			Model model
	) {
		model.addAttribute("lectName", attendanceDAO.selectMylectname(lectNo));
		return "asgn/scoreEdit";
	}
	
	@PostMapping
	public String updateScore(
			@Validated(UpdateGroup.class) @ModelAttribute("as") AsgnSubmitVO as
			, Errors errors
	) {
		String viewName = null;
		if(!errors.hasErrors()) {
			log.info("에러에러 : {} ", errors);
			service.modifyScore(as);
			viewName = "redirect:/asgn/proStuAsgnView.do?what="+as.getAsgnNo()+"&lect="+as.getLectNo();
		}else {
			log.info("에러러러러 : {} ", errors);
			viewName = "asgn/scoreEdit";
		}
		return viewName;
		
	}
	
	
}
