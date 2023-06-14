package kr.or.ddit.univBoard.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.univBoard.service.UnivBoardService;
import kr.or.ddit.univBoard.vo.UnivBoardVO;

@Controller
public class UnivBoardViewController {
	@Inject
	private UnivBoardService service;
	
	@RequestMapping("/univBoard/univBoardView.do")
	public String univBoardView(@RequestParam("what") int ubNo, Model model) {
		UnivBoardVO univboard = service.retrieveUnivBoard(ubNo);
		model.addAttribute("univboard",univboard);
		return "univBoard/univBoardView";
	}
}
