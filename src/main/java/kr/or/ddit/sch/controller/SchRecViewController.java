package kr.or.ddit.sch.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.sch.service.SchService;
import kr.or.ddit.sch.vo.SchRecVO;

@Controller
public class SchRecViewController {
	@Inject
	private SchService service;
	
	@GetMapping("/sch/schRecView.do")
	public String getUI(Model model ,@RequestParam("what") String schRecNo) {
		SchRecVO schrec = service.retrieveSchRec(schRecNo); 
		model.addAttribute("schrec",schrec);
		return "sch/schRecView";
	}
	// produces 어떤방식으로 응답을 보낼건지 
	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE, value = "/sch/schRecView.do")
	@ResponseBody// model은 클라이언트로 받아야해서괜찮다.
	public SchRecVO schrecView(@RequestBody String schRecNo) {
//		SchRecVO schrec = service.retrieveSchRec(schRecNo); //보내는것
//		model.addAttribute("schrec",schrec);
//		return "sch/schRecView";
		return service.retrieveSchRec(schRecNo);
		
	}
}
