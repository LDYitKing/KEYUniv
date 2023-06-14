package kr.or.ddit.subject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/subjectRenewal")
public class SubjectRenewalController {
	
	@GetMapping("/RenewalUI.do")
	public String getUI() {
		return "subject/subjectRenewal";
		
	}

}
