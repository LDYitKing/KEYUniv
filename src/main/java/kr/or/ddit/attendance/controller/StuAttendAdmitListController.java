package kr.or.ddit.attendance.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.attendance.service.AttendanceService;
import kr.or.ddit.attendance.vo.AttendanceAdmitVO;
import kr.or.ddit.attendance.vo.AttendanceVO;
import kr.or.ddit.member.vo.MemberVOWrapper;

@Controller
public class StuAttendAdmitListController {
	
	@Inject
	private AttendanceService attendService;
	
	@Inject
	private AttendanceDAO attendDAO;
	
	@ModelAttribute("attendAdmitList")
	public List<AttendanceAdmitVO> attendAdmitList(
		@RequestParam("what") String lectNo
		, Model model
		, Authentication authentication
	){	
		//강의 정보 가지고 다니기
		String lectName = attendDAO.selectMylectname(lectNo);
		model.addAttribute("lectName", lectName);
		model.addAttribute("what", lectNo);
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		String stuNo = memVO.getRealUser().getMemNo();
		
		AttendanceAdmitVO attendAdmit = new AttendanceAdmitVO();
		attendAdmit.setLectNo(lectNo);
		attendAdmit.setStuNo(stuNo);
		
		List<AttendanceAdmitVO> attendAdmitList = attendService.retrieveAttendAdmitList(attendAdmit);
		for(AttendanceAdmitVO attendAdmitOne : attendAdmitList) {
			attendAdmitOne.setLectNo(lectNo);
		}
		return attendAdmitList;
	}
	
	@GetMapping("attendance/attendAdmitList.do")
	public String getUI(){
		return "attendance/stuAttendAdmitList";
	}
}
