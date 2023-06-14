package kr.or.ddit.sch.controller;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.member.dao.MemberDAO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.sch.dao.SchDAO;
import kr.or.ddit.sch.service.SchService;
import kr.or.ddit.sch.vo.SchRecVO;
import kr.or.ddit.student.dao.StudentDAO;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/sch/schRecInsert.do")
public class SchRecInsertController {
	
	@Inject
	private SchService schRecService;
	@Inject
	private DepartmentDAO depDAO;
	@Inject
	private MemberDAO memDAO;
	@Inject
	private SchDAO schDAO;
	@Inject
	private StudentDAO StuDAO;
	
	@ModelAttribute("schrec")
	public SchRecVO schrec(Authentication authentication) {
		SchRecVO schrec = new SchRecVO();
//		MemberVO member = new MemberVO();
//		
//		member.setMemName(authentication.getName());
//		schrec.setMember(member);
		return schrec;
	}
	
	
	@RequestMapping
	public String insertForm(Model model) {
		model.addAttribute("deptList", depDAO.selectDepartmentList());
		model.addAttribute("colList", depDAO.selectColleageList());
		model.addAttribute("memList", memDAO.selectMemberList());
		model.addAttribute("schList", schDAO.selectSchPackList());
		model.addAttribute("stuList", StuDAO.selectStudentPackList());
		return "sch/schRecForm";
	}
	
	@PostMapping
	public String schRecInsert(
			@Validated(InsertGroup.class)@ModelAttribute("schrec") SchRecVO schrec
			, BindingResult errors
			) {
		log.info("이게 모야 : {}",schrec);
		log.info("error {}",errors);
		
		if(!errors.hasErrors()) {
			schRecService.createSchRec(schrec);
			 return "redirect:/sch/schRecList.do";
		}else {
			return "sch/schRecForm";
		}
	}
	
}
