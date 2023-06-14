package kr.or.ddit.attendance.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.attendance.service.AttendanceService;
import kr.or.ddit.attendance.vo.AttendanceVO;
import kr.or.ddit.member.vo.MemberVOWrapper;

@Controller
public class StuAttendanceConstroller {

	@Inject
	private AttendanceService attendService;
	
	@Inject
	private AttendanceDAO attendDAO;
	
	@GetMapping("/attendance/attendanceStu.do")
	public String getUI(
		@RequestParam("what") String lectNo
		, Model model
		, Authentication authentication
	) {
		// auth에서 로그인 한 사람의 학번 가져오기
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		String stuNo = memVO.getRealUser().getMemNo();
		
		// 출석 객체에 얻은 정보 넣어주기
		AttendanceVO attend = new AttendanceVO();
		attend.setLectNo(lectNo);
		attend.setStuNo(stuNo);
		
		// service에서 조회한 결과 모델에 넣어주기
		List<AttendanceVO> attendList = attendService.retrieveMyattendList(attend);
		model.addAttribute("attendList", attendList);
		
		// 강의정보 가지고 다니기
		String lectName = attendDAO.selectMylectname(lectNo);
		model.addAttribute("lectName", lectName);
		model.addAttribute("what", lectNo);
		
		// 리턴
		return "attendance/stuAttendance";
	}
}
