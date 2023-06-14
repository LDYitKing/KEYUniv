package kr.or.ddit.tutition.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.tutition.service.TutitionService;
import kr.or.ddit.tutition.vo.TuitionVO;
import kr.or.ddit.validate.DeleteGroup;

@Controller
@RequestMapping("/tuti/tutiDelete.do")
public class TuitionDeleteController {
	
	@Inject
	private TutitionService tutiService;
	
	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String deleteTuti(
			@Validated(DeleteGroup.class) TuitionVO condition
			,BindingResult errors
			,Model model
			) {
		boolean success= false;
		if(!errors.hasErrors()) {
			tutiService.removeTuti(condition);
			success= true;
			model.addAttribute("location","/tuti/tutiList.do");
		}
		model.addAttribute("success",success);
		return "jsonView";
	}
	
	@PostMapping
	public String deleteTuti(
			@Validated(DeleteGroup.class) TuitionVO condition
			, BindingResult errors
			, RedirectAttributes redirectAttributes
			) {
		if(!errors.hasErrors()) {
			tutiService.removeTuti(condition);
			return "redirect:/tuti/tutiList.do";
		}else {
			return "redirect:/tuti/tutiView.do?what="+condition.getTuitionNo();
		}
	}
	
}
