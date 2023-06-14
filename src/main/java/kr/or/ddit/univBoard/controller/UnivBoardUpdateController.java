package kr.or.ddit.univBoard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.univBoard.UnivBoardInvalidPasswordException;
import kr.or.ddit.univBoard.service.UnivBoardService;
import kr.or.ddit.univBoard.vo.UnivBoardVO;
import kr.or.ddit.validate.UpdateGroup;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/univBoard/univBoardUpdate.do")// 도메인의성격
@RequiredArgsConstructor  // 하는 이유?
public class UnivBoardUpdateController {

	private final UnivBoardService service;
	
	@ModelAttribute("univboard")
	public UnivBoardVO univboard(@RequestParam("what")int ubNo) {
		return service.retrieveUnivBoard(ubNo);
	}
	@GetMapping
	public String updateForm() {
		return "univBoard/univBoardEdit";
	}
	
	@PostMapping
	public String updateBoard(
		@Validated(UpdateGroup.class) @ModelAttribute("univboard") UnivBoardVO univboard
		, Errors errors
		, Model model
	) {
		if(!errors.hasErrors()) {
				service.modifyUnivBoard(univboard);
				return "redirect:/univBoard/univBoardView.do?what="+univboard.getUbNo();
		}else {
			return "univBoard/univBoardEdit";
		}
	}
}
