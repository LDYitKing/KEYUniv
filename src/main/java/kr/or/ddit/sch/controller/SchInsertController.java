package kr.or.ddit.sch.controller;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.sch.service.SchService;
import kr.or.ddit.sch.vo.SchVO;
import kr.or.ddit.validate.InsertGroup;

@Controller
@RequestMapping("/sch/schInsert.do")
public class SchInsertController {
	@Inject
	private SchService schService;
	
	@ModelAttribute("sch")
	public SchVO sch() {
		SchVO sch = new SchVO();
		System.out.println(sch);
		return sch;
	}
	@GetMapping
	public String insertForm() {
		return "sch/schForm";
	}
	
	// 핸들러 메서드(schInsert)라는 요청 경로에 대한 처리 담당
	@PostMapping // post방식에만 동작
	public String schInsert(
			@Validated(InsertGroup.class)@ModelAttribute("sch") SchVO sch
			,BindingResult errors
		) {
	if(!errors.hasErrors()) {
		schService.createSch(sch);
		return "redirect:/sch/schList.do";
	}else {
		return "sch/schForm";
		
		}
	}
}
	

