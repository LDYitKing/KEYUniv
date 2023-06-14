package kr.or.ddit.univBoard.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.univBoard.service.UnivBoardService;
import kr.or.ddit.univBoard.vo.UnivBoardVO;
import kr.or.ddit.validate.DeleteGroup;

@Controller
@RequestMapping("/univBoard/univBoardDelete.do")
public class UnivBoardDeleteController {
	@Inject
	private UnivBoardService service;
	
	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String deleteUnivBoard(
			@Validated(DeleteGroup.class) UnivBoardVO condition
			,BindingResult errors
			,Model model
	) {
		boolean success = false;
		if(!errors.hasErrors()) {
				service.removeUnivBoard(condition);
				success= true;
				model.addAttribute("location","/univBoard/univBoardList.do");
		}
		model.addAttribute("success",success);
		return "jsonView";
	}
	
	@PostMapping
	public String deleteUnivBoard(
			@Validated(DeleteGroup.class) UnivBoardVO condition
			, BindingResult errors
			, RedirectAttributes redirectAttributes
			) {
		if(!errors.hasErrors()) {
				service.removeUnivBoard(condition);
				return "redirect:/univBoard/univBoardList.do";
		}else {
			return "redirect:/univBoard/univBoardView.do?what="+ condition.getUbNo();
		}
	}
}
