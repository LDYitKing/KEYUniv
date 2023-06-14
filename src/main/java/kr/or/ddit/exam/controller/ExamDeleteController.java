package kr.or.ddit.exam.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.exam.service.ExamService;
import kr.or.ddit.exam.vo.ExamVO;
import kr.or.ddit.validate.DeleteGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/exam/examDelete.do")
public class ExamDeleteController {
	
	@Inject
	private ExamService service;
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> deleteExamAjax(
		@RequestParam("examNo") String examNo) {
		Map<String, Object> resultMap = new HashMap<>();
		boolean success = false;
		if(examNo != null && !examNo.trim().isEmpty()) {
			ExamVO condition = new ExamVO();
			condition.setExamNo(examNo);
			service.removeExam(condition);
			success = true;
		}
		resultMap.put("success", success);
		return resultMap;
		
	}
	
	@GetMapping
	public String deleteExam(
			@Validated(DeleteGroup.class) ExamVO condition
			, BindingResult errors
			, RedirectAttributes redirectAttributes
	) {
		log.info("에러에러 : {} ", errors);
		if(!errors.hasErrors()) {
			service.removeExam(condition);
			redirectAttributes.addFlashAttribute("success", true);
		}
		return "redirect:/exam/exam.do";
	}
	
	
	
	
}
