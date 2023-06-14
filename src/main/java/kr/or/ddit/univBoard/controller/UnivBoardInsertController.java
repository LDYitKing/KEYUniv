package kr.or.ddit.univBoard.controller;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.univBoard.service.UnivBoardService;
import kr.or.ddit.univBoard.vo.UnivBoardVO;
import kr.or.ddit.validate.InsertGroup;


@Controller
@RequestMapping("/univBoard/univBoardInsert.do")
public class UnivBoardInsertController {
	
	@Inject
	private UnivBoardService univBoardService;
	
	@ModelAttribute("univboard")
	public UnivBoardVO univboard(Authentication authentication) {
		UnivBoardVO univboard = new UnivBoardVO();
		univboard.setUbWriter(authentication.getName());
		return univboard;
	}
	

	
	@GetMapping
	public String insertForm() {
		return "univBoard/univBoardForm";
	}

	@PostMapping
	public String univboardInsert(
			@Validated(InsertGroup.class)@ModelAttribute("univboard") UnivBoardVO univboard
			, BindingResult errors
			) {
		if(!errors.hasErrors()) {
			univBoardService.createUnivBoard(univboard);
			 return "redirect:/univBoard/univBoardList.do";
		}else {
			return "univBoard/univBoardForm";
		}
	}
}
