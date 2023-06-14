package kr.or.ddit.lecture.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.lecture.dao.LectEvalDAO;
import kr.or.ddit.lecture.service.LectEvalService;
import kr.or.ddit.lecture.vo.LectEvalArtiVO;
import kr.or.ddit.lecture.vo.LectureEvaluationVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LectEvalController {
	
	@Inject
	private LectEvalService lectEvalService;

	@Inject
	private LectEvalDAO lectEvalDAO;
	
	@ModelAttribute("lectEval")
	public LectureEvaluationVO lectEval(
		@RequestParam("what") String lectNo
		, Authentication authentication
		, Model model
	) {
		// 학생번호와 강의 번호로 수강 번호 가져오기(modelAttribute:courseNo, lectNo, stuNo, lectName)
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		String stuNo = memVO.getRealUser().getMemNo();
		
//		model.addAttribute("what", lectNo);
		
		LectureEvaluationVO lectEval = new LectureEvaluationVO();
		lectEval.setStuNo(stuNo);
		lectEval.setLectNo(lectNo);
		return lectEvalDAO.selectCourse(lectEval); 
	}
	
	@GetMapping("/lecture/lectEval.do")
	public String getUI(
		@ModelAttribute("lectEval") LectureEvaluationVO lectEval	
		, Model model
	) {
		// 평가항목들로 목록 띄워주기
		List<LectEvalArtiVO> lectEvalArti = lectEvalDAO.selectLectEvalArtiList();
		model.addAttribute("leaList", lectEvalArti);
		
		String lectName = lectEval.getLectName();
		model.addAttribute("lectName", lectName);
		
		// 학생이 이 강의에 대해 수강평가가 있으면 VIEW페이지로, 없으면 FORM페이지로
		String viewName = null;
		String courseNo = lectEval.getCourseNo();

		List<LectureEvaluationVO> lectEvalList = lectEvalDAO.selectLectEvalList(courseNo);
		int cnt = lectEvalList.size();
		if(cnt > 0) {
			model.addAttribute("lectEvalList", lectEvalList);
			model.addAttribute("message", "강의 평가 결과입니다. ");
			model.addAttribute("messageIcon", "info");
			viewName = "lecture/lectureEvalView";
		}else {
			model.addAttribute("message", "강의 평가 내역이 없습니다. 평가해주세요.");
			model.addAttribute("messageIcon", "info");
			viewName = "lecture/lectureEvaluation";
		}
		
		
		return viewName;
	}
	
	@PostMapping("/lecture/lectEval.do")
	public String createLectEval(
		@ModelAttribute("lectEval") LectureEvaluationVO lectEval
	) {
		// 평가항목 작성한 것 데이터베이스에 넣어주기
		log.info("lectEval:{}",lectEval);
		log.info("lectEval.lectEvalList:{}",lectEval.getLectEvalList());
		
		lectEvalService.createLectEval(lectEval);
		return "redirect:/lecture/lectEval.do?what=" + lectEval.getLectNo();
	}
}
