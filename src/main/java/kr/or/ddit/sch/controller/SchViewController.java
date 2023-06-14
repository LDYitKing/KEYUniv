package kr.or.ddit.sch.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.sch.service.SchService;
import kr.or.ddit.sch.vo.SchVO;

@Controller
public class SchViewController {
	@Inject
	private SchService service;
	
	@RequestMapping("/sch/schView.do")
	public String sch(@RequestParam("what") String schNo, Model model ) {
		SchVO sch = service.retrieveSch(schNo);
		model.addAttribute("sch",sch);
		return "sch/schView";
	}
}
