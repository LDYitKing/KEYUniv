package kr.or.ddit.exam.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.exam.service.ExamService;
import kr.or.ddit.exam.vo.ExamQuestionVO;
import kr.or.ddit.exam.vo.ExamTextVO;
import kr.or.ddit.exam.vo.ExamVO;

@Controller
@RequestMapping("/exam")
public class ProExamPaperController {
	
	@Inject
	private ExamService service;

	@ModelAttribute("exam")
	public ExamVO exam(@RequestParam("what") String lectNo) {
		return service.retrieveExam(lectNo);
	}
	
	@GetMapping("/proExamPaperForm.do")
	public String getUI(
			Model model,
			@RequestParam("what") String examNo
	) {
		model.addAttribute("examNo", examNo);
		List<ExamQuestionVO> examQueList = service.retrieveExamQueList(examNo);
	    List<ExamTextVO> examTextList = new ArrayList<>();
	    
	    for (ExamQuestionVO examQuestion : examQueList) {
	        String eqNo = examQuestion.getEqNo();
	        List<ExamTextVO> eqTextList = service.retrieveExamTextList(eqNo);
	        examTextList.addAll(eqTextList);
	    }
	    
	    model.addAttribute("examQue", examQueList);
	    model.addAttribute("examText", examTextList);
		return "exam/proExamPaperForm";

	}
	
	
	
	
	
	
}
