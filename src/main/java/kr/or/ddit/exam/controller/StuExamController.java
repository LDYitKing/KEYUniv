package kr.or.ddit.exam.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.exam.dao.ExamDAO;
import kr.or.ddit.exam.service.ExamService;
import kr.or.ddit.exam.vo.ExamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/exam")
public class StuExamController {
	
	@Inject
	private ExamService service;
	
	@Inject
	private ExamDAO examDAO;
	
	@Inject
	private AttendanceDAO attendanceDAO;
	
	@GetMapping("/stuExam.do")
	public String getUI(
			Model model,
			@RequestParam("what") String lectNo
		){
		model.addAttribute("what",lectNo);
		model.addAttribute("lectNo",lectNo);
		model.addAttribute("lectName", attendanceDAO.selectMylectname(lectNo));
		model.addAttribute("lectureList", examDAO.selectExamList(lectNo));
		return "exam/stuExamList";	
	}
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE, value = "/stuExam.do")
	@ResponseBody
	public List<ExamVO> stuExamList(
		@RequestParam("what") String lectNo
	){
		log.info("알려줘 :  {}", service.retrieveExamList(lectNo));
		return service.retrieveExamSubList(lectNo);
		
	}

}
