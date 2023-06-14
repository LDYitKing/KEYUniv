package kr.or.ddit.sch.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.sch.service.SchService;
import kr.or.ddit.sch.vo.SchRecVO;
import kr.or.ddit.validate.UpdateGroup;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/sch/schRecUpdate.do")
@RequiredArgsConstructor
public class SchRecUpdateController {

	private final SchService service;
	
	@ModelAttribute("schRec")
	public SchRecVO schRec(@RequestParam("what")String schRecNo) {
		return service.retrieveSchRec(schRecNo);
	}
	
	
	@GetMapping
	public String updateForm() {
		return "sch/schRecEdit";
	}
	
	@PostMapping
	public String updateSchRec(
				@Validated(UpdateGroup.class) @ModelAttribute("schRec") SchRecVO schRec
				,Errors errors
				,Model model
			) {
			if(!errors.hasErrors()) {
				service.modifySchRec(schRec);
				return "redirect:/sch/schRecView.do?what ="+schRec.getSchRecNo();
			}else {
				return "sch/schRecEdit";
			}
	}
}
