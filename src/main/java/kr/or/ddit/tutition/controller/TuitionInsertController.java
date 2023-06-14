package kr.or.ddit.tutition.controller;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.member.dao.MemberDAO;
import kr.or.ddit.sch.dao.SchDAO;
import kr.or.ddit.student.dao.StudentDAO;
import kr.or.ddit.tutition.service.TutitionService;
import kr.or.ddit.tutition.vo.TuitionVO;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/tuti/tutiInsert.do")
public class TuitionInsertController {

	@Inject
	private TutitionService tutiService;
	@Inject
	private DepartmentDAO depDAO;
	@Inject
	private MemberDAO memDAO;
	@Inject
	private SchDAO schDAO;
	@Inject
	private StudentDAO StuDAO;

	@ModelAttribute("tuti")
	public TuitionVO tuti(Authentication authentication) {
		TuitionVO tuti = new TuitionVO();
		return tuti;
	}

	@RequestMapping
	public String insertForm(Model model) {
		model.addAttribute("deptList", depDAO.selectDepartmentList());
		model.addAttribute("colList", depDAO.selectColleageList());
		model.addAttribute("memList", memDAO.selectMemberList());
		model.addAttribute("schList", schDAO.selectSchPackList());
		model.addAttribute("stuList", StuDAO.selectStudentPackList());
		return "tuti/tutiForm";
	}

	@PostMapping
	public String tutiInsert(
			@Validated(InsertGroup.class)
			@ModelAttribute("tuti") TuitionVO tuti
			,BindingResult errors
			) {
		log.info("이게 모야 : {}",tuti);
		log.info("error : {}",errors);

		if(!errors.hasErrors()) {
			tuti.setTuitionName(tuti.getTuitionName().substring(1));
			tutiService.createTuti(tuti);
			return "redirect:/tuti/tutiList.do";
		}else {
			return "tuti/tutiForm";
		}
	}
}
