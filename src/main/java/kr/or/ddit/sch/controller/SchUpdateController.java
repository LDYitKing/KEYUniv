package kr.or.ddit.sch.controller;

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
import kr.or.ddit.sch.vo.SchVO;
import kr.or.ddit.validate.UpdateGroup;
import lombok.RequiredArgsConstructor;


@Controller
@RequestMapping("/sch/schUpdate.do")
@RequiredArgsConstructor
public class SchUpdateController {
	
	private final SchService service;
	
	@ModelAttribute("sch")
	public SchVO sch(@RequestParam("what")String schNo) {
		return service.retrieveSch(schNo);
	}
	
	@GetMapping
	public String updateForm() {
		return "sch/schEdit";
	}
	
	@PostMapping
	public String updateSch(
			@Validated(UpdateGroup.class) @ModelAttribute("sch") SchVO sch
			,Errors errors
			,Model model
		) {
			if(!errors.hasErrors()) {
				service.modifySch(sch);
				return "redirect:/sch/schView.do?what="+sch.getSchNo();
			}else {
				return "sch/schEdit";
			}
	}
}	
