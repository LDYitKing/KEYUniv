package kr.or.ddit.student.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.dao.CommDAO;
import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/group/students")
public class StudentController {
	
	@Inject
	private StudentService service;
	
	@Inject
	private DepartmentDAO depDAO;
	@Inject
	private CommDAO commDAO;
	
	@GetMapping
	public String getUI(Model model) {
		model.addAttribute("deptList", depDAO.selectDepartmentList());
//		log.info("deptList : {}", deptList);
		model.addAttribute("commList", commDAO.selectCommList("C"));
		
		return "group/students";
	}
	
	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Pagination<StudentVO> list(
		@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
		, @RequestParam(value = "screenSize", required = false, defaultValue = "10") int currentScreenSize
		, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
		, StudentVO detailCondition
	){
		
		Pagination<StudentVO> pagination = new Pagination<>();
		pagination.setScreenSize(currentScreenSize);
		
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		
		pagination.setDetailCondition(detailCondition);
		log.info("detailCondition : {}", detailCondition);
		
		service.retrieveStudentList(pagination);
		
		return pagination;
	}
	
	@PostMapping(value = "{memNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public StudentVO getStudent(@PathVariable String memNo) {
		return service.retrieveStudentForAuth(memNo);
	}
}



