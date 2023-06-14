package kr.or.ddit.exam.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.tiles.request.ApplicationAccess;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.exam.service.ExamService;
import kr.or.ddit.exam.vo.ExamQuestionVO;
import kr.or.ddit.exam.vo.ExamTextVO;
import kr.or.ddit.exam.vo.ExamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/exam")
public class ExamQueInsertController {
	
	@Inject
	private ExamService service;
	
	@GetMapping("examQue.do")
	public String getUI(
		@RequestParam(value = "what") String examNo
		,Model model
	) {
		model.addAttribute("exam",service.retrieveExam(examNo));
		return "exam/examQueForm";
	}
	
	@PostMapping(produces = MediaType.APPLICATION_JSON_VALUE, value = "examQuetext.do")
	@ResponseBody
	public Map<String, String> insertExamQueText(@RequestBody List<Map<String, Object>> requestDataList) {
	  for (Map<String, Object> requestData : requestDataList) {
	    log.info("selectedValues: {}", requestData);
	  
	    ExamQuestionVO eqVO = new ExamQuestionVO();
	    eqVO.setEqNumber(Integer.parseInt((String) requestData.get("eqNumber")));
	    eqVO.setEqQue((String) requestData.get("eqQue"));
	    eqVO.setExamNo((String) requestData.get("examNo"));
	    eqVO.setEqScore(String.valueOf(requestData.get("eqScore")));
	  
	    List<ExamTextVO> list = new ArrayList<ExamTextVO>();
	  
	    for (int i = 0; i < 4; i++) {
	      ExamTextVO etVO = new ExamTextVO();
	      etVO.setEtNo(String.valueOf(i + 1));
	      etVO.setEtQue(((List<String>) requestData.get("etQue")).get(i));
	      etVO.setEtRightAnswer(((List<String>) requestData.get("eqRightAnswer")).get(i));
	      list.add(etVO);
	    }
	  
	    eqVO.setExamTextList(list);
	    service.createExamQuestion(eqVO);
	  }
	  
	  Map<String, String> response = new HashMap<>();
	  response.put("result", "success");
	  
	  return response;
	}
}
