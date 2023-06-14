package kr.or.ddit.exam.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.inject.Inject;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.exam.dao.ExamDAO;
import kr.or.ddit.exam.service.ExamService;
import kr.or.ddit.exam.vo.ExamVO;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/exam/examInsert.do")
public class ExamInsertController {

	@Inject
	private ExamService service;
	
	@Inject
	private ExamDAO examDAO;
	
	@Inject
	private AttendanceDAO attendanceDAO;
	
	@ModelAttribute("exam")
	public ExamVO exam(
		@RequestParam("what") String lectNo
			) {
		ExamVO exam = new ExamVO();
		exam.setLectNo(lectNo);
		return exam;
	}
	
	@GetMapping
	public String examForm(
			@RequestParam("what") String lectNo,
			Model model
	) {
		model.addAttribute("lectName", attendanceDAO.selectMylectname(lectNo));
		return "exam/examForm";
	}
	
	@PostMapping
	public String insertExam(
			@RequestParam("what") String lectNo
			,@Validated(InsertGroup.class) @ModelAttribute("exam") ExamVO exam
			, Errors errors
	) {
		log.info("에러에러 : {}",errors);
		if(!errors.hasErrors()) {
			service.createExam(exam);
			return "redirect:/exam/exam.do?what="+exam.getLectNo();
		}else {
			return "exam/examForm";
		}
	}
	
	

}
