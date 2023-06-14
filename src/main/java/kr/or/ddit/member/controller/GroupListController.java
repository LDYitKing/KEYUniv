package kr.or.ddit.member.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.Employee.service.EmployeeService;
import kr.or.ddit.Employee.vo.EmployeeVO;
import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.professor.service.ProfessorService;
import kr.or.ddit.professor.vo.ProfessorVO;

@Controller
@RequestMapping("/group/members")
public class GroupListController {
	
	@Inject
	private DepartmentDAO depDAO;
	
	@Inject
	private ProfessorService proService;
	@Inject
	private EmployeeService empService;
	
	@GetMapping
	public String getUI(Model model) {
		model.addAttribute("deptList", depDAO.selectDepartmentList());
		
		return "group/groups";
	}
	
	@PostMapping(value = "pro", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ProfessorVO> getProList(ProfessorVO professor) {
		List<ProfessorVO> proList = proService.retrieveProfessorList(professor);
		return proList;
	}
	@PostMapping(value = "emp", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<EmployeeVO> getEmpList(EmployeeVO employee) {
		List<EmployeeVO> empList = empService.retrieveEmployeeList(employee);
		return empList;
	}
	
	@PostMapping(value = "pro/{memNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ProfessorVO getPro(@PathVariable String memNo) {
		return proService.retrieveProfessor(memNo);
	}
	@PostMapping(value = "emp/{memNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public EmployeeVO getEmp(@PathVariable String memNo) {
		return empService.retrieveEmployee(memNo);
	}
}



