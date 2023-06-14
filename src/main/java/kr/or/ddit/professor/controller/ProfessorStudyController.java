package kr.or.ddit.professor.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import kr.or.ddit.professor.service.ProfessorStudyService;
import kr.or.ddit.professor.vo.StudyVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.extern.slf4j.Slf4j;

/**
 * 교수 연구 컨트롤러
 * @author Kim Eui Yeon
 *
 */
@Slf4j
@Controller
@RequestMapping("/professor")
public class ProfessorStudyController {
	
	@Inject
	private ProfessorStudyService professorStudyService;
	//인서트
	@ModelAttribute("studyVO")
	public StudyVO studyVO(Authentication authentication) {
		StudyVO study = new StudyVO();
		study.setProNo(authentication.getName());
		return study;
	}
//	//업뎃
//	@ModelAttribute("studyVO")
//	@RequestMapping("/professor/professorStudyUpdate.do")
//	public StudyVO study(
//			@RequestParam("what") String StudyNo
//			) {
//		return professorStudyService.retrieveStudy(StudyNo);
//	}
	
	//UI읽기------------------------------------------------------------------------
	@GetMapping("/professorStudy.do")
	public String getUI() {
		return "professor/professorStudyList";
	}
	//List 출력---------------------------------------------------------------------
	@GetMapping(produces = "application/json;charset=utf-8", value = "/professorStudyList.do")
	@ResponseBody
	public List<StudyVO> professorStudyList(){
		 return professorStudyService.retrieveStudyList();
	}
	//연구 상세조회-----------------------------------------------------------------
	@GetMapping(produces = "application/json;charset=utf-8" ,value = "/professorStudyView.do")
	@ResponseBody
	public StudyVO professorStudyView(
			@RequestParam("what") String studyNo
			) {
		return professorStudyService.retrieveStudy(studyNo);
		
	}
	//연구 등록----------------------------------------------------------------- professorStudyInsert
	@PostMapping(produces = "application/json;charset=utf-8" ,value ="/professorStudyInsert.do")
	@ResponseBody
	public int professorStudyInsert(
			@Validated(InsertGroup.class) @ModelAttribute("studyVO") StudyVO study
			, Errors errors
			) {
		int reNum = 0;
		if(!errors.hasErrors()) {
			reNum = professorStudyService.createStudy(study);
		}
		
		return reNum;
	}
	//연구 수정-------------------------------------------------------------------
	@PostMapping(produces = "application/json;charset=utf-8", value="/professorStudyUpdate.do")
	@ResponseBody
	public int professorStudyUpdate(
			@Validated(UpdateGroup.class) @ModelAttribute("studyVO") StudyVO study
			, @RequestParam("what") String studyNo
			, Errors errors
			, Model model
			) {
		System.err.println(study);
		int reNum = 0;
		if(!errors.hasErrors()) {
			// 자기꺼만 수정되게 하지않았음.
			reNum = professorStudyService.modifyStudy(study);
			
		}else {
			model.addAttribute("message", "연구 오류");
		}
		
		return reNum;
	}
	//연구 삭제--------------------------------------------------------
	@PostMapping(produces = "application/json;charset=utf-8", value="/professorStudyDelete.do" )
	@ResponseBody
	public int professorStudyDelete(
			@Validated(DeleteGroup.class) @ModelAttribute("studyVO") StudyVO condition
			, BindingResult errors
			, Model model
			) {
		int reNum = 0;
		if(!errors.hasErrors()) {
			// 자기꺼만 수정되게 하지않았음.
			reNum = professorStudyService.removeStudy(condition);
			
		}else {
			model.addAttribute("message", "연구 삭제 오류 ");
		}
		
		return reNum;
		
	}
	
	

}
