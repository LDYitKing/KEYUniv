package kr.or.ddit.lecture.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.lecture.dao.LectEvalDAO;
import kr.or.ddit.lecture.service.LectEvalService;
import kr.or.ddit.lecture.vo.LectEvalArtiVO;
import kr.or.ddit.lecture.vo.LectureEvaluationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LectureProEvalController {
	
	@Inject
	private AttendanceDAO attendDAO;
	
	@Inject
	private LectEvalDAO lectEvalDAO;
	
	@Inject
	private LectEvalService lectEvalService;
	
	@GetMapping("lecture/lectProEval.do")
	public String getUI(
		@RequestParam("what") String lectNo
		, Authentication authentication
		, Model model
	) {
		model.addAttribute("what", lectNo);
		// 각 강의당 각 항목과 항목마다 평균
		List<LectEvalArtiVO> lectEvalAVG = lectEvalDAO.selectAVGEval(lectNo);
		log.info("lectEvalAVG:{}", lectEvalAVG.size());
		if(lectEvalAVG.size() == 0) {
			log.info("if:lectEvalAVG:{}", lectEvalAVG);
			model.addAttribute("message", "강의 평가 기간이 아닙니다.");
			return "redirect:/lecture/lectureHome.do";
		}
		String lectName = attendDAO.selectMylectname(lectNo);
		model.addAttribute("lectName", lectName);
		model.addAttribute("lectEvalAVG",lectEvalAVG );
		
		// 7번문항 응답 리스트
		List<String> leAnswerList = lectEvalDAO.selectSevenEval(lectNo);
		model.addAttribute("leAnswerList", leAnswerList);
		
		return "lecture/lectEvalChart";
	}
}
