package kr.or.ddit.lecture.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.lecture.service.LectureDataService;
import kr.or.ddit.lecture.vo.LectureDataVO;
import kr.or.ddit.validate.DeleteGroup;

@Controller
@RequestMapping("/lecture/lectureDelete.do")
public class LectureDataDeleteController {

	@Inject
	private LectureDataService service;
	
	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String deleteLectureDataAjax(
			@Validated(DeleteGroup.class) LectureDataVO condition
			, BindingResult errors
			, Model model
			) {
		boolean success = false;
		if(!errors.hasErrors()) {
			service.removeLectureData(condition);
			success = true;
			model.addAttribute("location","/lecture");
		}
		model.addAttribute("success",success);
		return "jsonView";
	}
	@PostMapping
	public String deleteLectureData(
			@Validated(DeleteGroup.class) LectureDataVO condition
			, BindingResult errors
			, RedirectAttributes redirectAttributes
		) {
		if(!errors.hasErrors()) {
			service.removeLectureData(condition);
			return "redirect:/lecture";
		}else {
			return "redirect:/lecture/lectureView.do?what=" +condition.getLdNo();
		}
	}
}
