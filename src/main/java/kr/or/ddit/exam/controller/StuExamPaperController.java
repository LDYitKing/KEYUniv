package kr.or.ddit.exam.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.exam.service.ExamService;
import kr.or.ddit.exam.vo.AnswerSubmitVO;
import kr.or.ddit.exam.vo.ExamQuestionVO;
import kr.or.ddit.exam.vo.ExamTextVO;
import kr.or.ddit.exam.vo.ExamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/exam")
public class StuExamPaperController {
	
	@Inject
	private ExamService service;
	
	@ModelAttribute("exam")
	public ExamVO exam(@RequestParam("what") String lectNo) {
		return service.retrieveExam(lectNo);
	}
		
	@GetMapping("/stuExamPaperForm.do")
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
		return "exam/stuExamPaperForm";

	}
	
	@PostMapping("/stuExamPaperForm.do")
	public String insertAnswer(
	        @RequestParam Map<String, String> answers,
	        @RequestParam("stuNo") String stuNo,
	        @RequestParam("lectNo") String lectNo,
	        @RequestParam("examNo") String examNo
	) {
	    List<AnswerSubmitVO> answerList = new ArrayList<>();
	    
	    for (Map.Entry<String, String> entry : answers.entrySet()) {
	        String key = entry.getKey();
	        String value = entry.getValue();
	        
	        // asAnswer_로 시작하는 파라미터만 처리
	        if (key.startsWith("asAnswer_")) {
	            // key에서 지문 번호 추출
	            String eqNoStr = key.substring("asAnswer_".length());
	            log.info("이건모니 : {} ", eqNoStr);
	            // value는 선택된 값
	            String selectedValue = value;
	            
	            // AnswerSubmitVO에 데이터 저장
	            AnswerSubmitVO answer = new AnswerSubmitVO();
	            answer.setEtNo(selectedValue);
	            answer.setAsAnswer(selectedValue);
	            answer.setEqNo(eqNoStr);
	            answer.setStuNo(stuNo);
	            answer.setExamNo(examNo);
	            answerList.add(answer);
	            
	            answer.setAnswerSubmitList(answerList);
	            
	            service.createStuExamAnswerSubmit(answer);  
	        }
	    }
	    return "redirect:/exam/stuExam.do?what=" + lectNo;
	}
	
	 
	
	
	
	
}

