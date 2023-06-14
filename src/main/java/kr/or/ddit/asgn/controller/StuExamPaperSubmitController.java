package kr.or.ddit.asgn.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.exam.service.ExamService;
import kr.or.ddit.exam.vo.AnswerSubmitVO;
import kr.or.ddit.exam.vo.ExamQuestionVO;
import kr.or.ddit.exam.vo.ExamScoreVO;
import kr.or.ddit.exam.vo.ExamTextVO;
import kr.or.ddit.exam.vo.ExamVO;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/exam")
public class StuExamPaperSubmitController {
	
	@Inject
	private ExamService service;
	
	@ModelAttribute("exam")
	public ExamVO exam(@RequestParam("what") String lectNo) {
		return service.retrieveExam(lectNo);
	}
	
	@GetMapping("stuExamPaperSubmitForm.do")
	public String getUI(
			Model model,
			@RequestParam("what") String examNo
	) {
		model.addAttribute("examNo", examNo);
	    List<ExamQuestionVO> examQueList = service.retrieveExamQueList(examNo);
	    List<ExamTextVO> examTextList = new ArrayList<>();
	    List<AnswerSubmitVO> answerSubmitList = service.retrieveAnswerSubmitList(examNo);
	    
	    for (ExamQuestionVO examQuestion : examQueList) {
	        String eqNo = examQuestion.getEqNo();
	        List<ExamTextVO> eqTextList = service.retrieveExamTextList(eqNo);
	        examTextList.addAll(eqTextList);
	    }
	    
	    model.addAttribute("examQue", examQueList);
	    model.addAttribute("examText", examTextList);
	    model.addAttribute("answerSubmit", answerSubmitList); 
	    
	    return "exam/stuExamPaperSubmitForm";
	}
	
	@PostMapping("stuExamPaperSubmitForm.do")
	public String insertExamScore(
	    @RequestParam("examNo") String examNo,
	    @RequestParam("stuNo") String stuNo,
	    @RequestParam("esFscore") String esFscore,
	    @RequestParam("what") String what
	) {
	    ExamScoreVO examScore = new ExamScoreVO();
	    examScore.setExamNo(examNo);
	    examScore.setStuNo(stuNo);
	    examScore.setEsFscore(esFscore);

	    service.createExamScore(examScore);

	    return "redirect:/exam/stuExamPaperSubmitForm.do?what=" + what;
	}
}
