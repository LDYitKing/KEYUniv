package kr.or.ddit.exam.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.exam.service.ExamService;
import kr.or.ddit.exam.vo.ExamVO;
import kr.or.ddit.facility.vo.FacilityVO;

@Controller
@RequestMapping("/exam")
public class ExamController {
	
	@Inject
	private ExamService service;
	
	@Inject
	private AttendanceDAO attendanceDAO;
	
	@ModelAttribute("exam")
	public ExamVO exam() {
		return new ExamVO();
	}
	
	@GetMapping("/exam.do")
	public String getUI(
			Model model,
			@RequestParam("what") String lectNo
	) {
		model.addAttribute("lectName", attendanceDAO.selectMylectname(lectNo));
		model.addAttribute("lectNo",lectNo);
		return "exam/examList";		
	}
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE, value = "/exam.do")
	@ResponseBody
	public List<ExamVO> examList(
		@RequestParam(value = "what") String lectNo	
	){
		return service.retrieveExamList(lectNo);	
	}
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE, value = "/examView.do")
	@ResponseBody
	public ExamVO retrieveAsgn(
		@RequestParam(value = "what") String examNo
	) {
		return service.retrieveExam(examNo);
	}
	
}











