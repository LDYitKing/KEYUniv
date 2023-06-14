package kr.or.ddit.student.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.student.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/group")
public class StudentUpdateController {
	
	@Inject
	private StudentService service;
	
	@PostMapping("studentUpdate.do")
	@ResponseBody
	public String updateStudent(@ModelAttribute StudentVO student) {
		
		log.info("student : {}", student);

		service.modifyStudent(student);
		
		return "";

	}
}


