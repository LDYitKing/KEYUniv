package kr.or.ddit.score.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.attendance.service.AttendanceService;
import kr.or.ddit.course.vo.CourseVO;
import kr.or.ddit.lecture.dao.LectureDAO;
import kr.or.ddit.score.dao.ScoreDAO;
import kr.or.ddit.score.service.ScoreService;
import kr.or.ddit.score.vo.CourseScoreVO;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/score")
public class ProScoreController {
	
	@Autowired
	private ScoreService service;
	
	@Autowired
	private AttendanceService attService;
	
	@Inject
	private LectureDAO lectureDAO;
	
	@Inject
	private ScoreDAO scoreDAO;
	
	@Inject
	private AttendanceDAO attendanceDAO;
	
	@GetMapping("/proScore.do")
	public String getUI(
		Model model,
		@RequestParam("what") String lectNo
	) {
		model.addAttribute("lectNo", lectNo);
		model.addAttribute("crtrList", lectureDAO.selectCrtrList(lectNo));
		model.addAttribute("stuList", scoreDAO.selectCourseScoreDetailList(lectNo));
		model.addAttribute("courseStuList", scoreDAO.courseStuList(lectNo));
		model.addAttribute("lectName", attendanceDAO.selectMylectname(lectNo));
		return "score/scoreList";
	}
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE, value = "/proScore.do")
	@ResponseBody
	public List<CourseVO> stuList(
		@RequestParam("what") String lectNo
	){
		return service.retrieveCourseStuList(lectNo);
	}
	
	@PostMapping("/stuScoreInsert.do")
	public String insert(
		@Validated(InsertGroup.class) 
		@ModelAttribute("courseScore") CourseScoreVO course,
		BindingResult errors,
		@RequestParam("what") String lectNo,
		@RequestParam("stuNo") String stuNo,
		@RequestParam("courseNo") String courseNo,
		RedirectAttributes attributes
			) {
		
		course.setCourseNo(courseNo);
		course.setStuNo(stuNo);
		log.info("에러에러1 : {} ", errors);
		String viewName = null;
		if(!errors.hasErrors()) {
			service.createCourseScore(course);
			log.info("에러에러2 : {} ", errors);
			
			attributes.addFlashAttribute("message", "성적이 등록되었습니다.");
			attributes.addFlashAttribute("messageIcon", "success");
			
			viewName = "redirect:/score/proScore.do?what="+lectNo;
		}else {
			log.info("에러에러3 : {} ", errors);
			viewName = "redirect:/score/proScore.do?what="+lectNo;
		}
		
		return viewName;
		
	}
//	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE, value ="/stuScore.do")
//	@ResponseBody
//	public List<CourseScoreDetailVO> stuScoreList(
//		@RequestParam("what") String lectNo
//	){
//		return service.retrieveCourseScoreDetailList(lectNo);	
//	}
	
}
