package kr.or.ddit.student.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/group")
public class StudentInsertController {
	
	@Inject
	private StudentService service;
	
	@Inject
	private DepartmentDAO depDAO;
	
	@GetMapping("studentForm")
	public String getUI(Model model) {
		model.addAttribute("deptList", depDAO.selectDepartmentList());
		model.addAttribute("colList", depDAO.selectColleageList());
		return "group/studentForm";
	}
	
	@GetMapping("studentNo")
	@ResponseBody
	public String searchStuNo(@RequestParam Map<String, String> param) {
		return service.retrieveStudentNoForDept(param);
		
	}
	
	@PostMapping("studentInsert.do")
	@ResponseBody
	public String insertStudent(
			@Validated(InsertGroup.class) @ModelAttribute StudentVO student
			, Errors errors
		) { // List<StudentVO> stuList
		
		log.info("student : {}", student);
		log.info("errors : {}", errors);
		
		if(!errors.hasErrors()) {
			service.createStudent(student);
			// 오류날 때 처리 넣기
		}else {
			log.info("@@@@@@@@@@@@@@@errors : {}", errors);
			
		}

		return "";
	}
}



