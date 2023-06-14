package kr.or.ddit.attendance.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.attendance.service.AttendanceService;
import kr.or.ddit.attendance.vo.AttendanceAdmitVO;
import kr.or.ddit.attendance.vo.AttendanceVO;
import kr.or.ddit.validate.InsertGroup;

@Controller
@RequestMapping("/attendance/attendAdmit.do")
public class StuAttendAdmitController {
	
	@Inject
	private AttendanceService attendService;
	
	@Inject
	private AttendanceDAO attendDAO;
	
	@ModelAttribute("attendAdmit")
	public AttendanceAdmitVO attendAdmit(
		@RequestParam("what") String attendNo	
		, @RequestParam("lectNo") String lectNo
	) {
		String lectName = attendDAO.selectMylectname(lectNo);
		
		AttendanceVO attend = attendService.retrieveMyattend(attendNo);
		AttendanceAdmitVO attendAdmit = new AttendanceAdmitVO();
		attendAdmit.setAttend(attend);
		attendAdmit.setLectName(lectName);
		return attendAdmit;
	}
	
	@GetMapping
	public String getUI() {
		return "attendance/attendAdmit";
	}
	
	@PostMapping
	public String createAttendAdmit(
		@RequestParam("what") String attendNo
		, @Validated(InsertGroup.class) @ModelAttribute("attendAdmit") AttendanceAdmitVO attendAdmit
		, Errors errors
	) {
		String viewName = null;
		if(!errors.hasErrors()) {
			// 검증성공하면, 
			AttendanceVO attend = new AttendanceVO();
			attend = attendService.retrieveMyattend(attendNo);
			String lectNo = attend.getLectNo();
			attendAdmit.setAttend(attend);
			attendAdmit.setCourseNo(attend.getCourseNo());
			attendAdmit.setStuNo(attend.getStuNo());
			
			attendService.createdMyattendAdmit(attendAdmit);
			
			viewName = "redirect:/attendance/attendanceStu.do?what=" + lectNo;
		}else {
			viewName = "attendance/attendAdmit";
		}
		return viewName;
	}
}
