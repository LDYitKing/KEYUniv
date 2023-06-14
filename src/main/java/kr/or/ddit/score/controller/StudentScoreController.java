package kr.or.ddit.score.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/score/stuScore.do")
public class StudentScoreController {
	
	
	@GetMapping
	public String stuScoreForm() {
		return "score/stuScoreForm";
	}
	
}
