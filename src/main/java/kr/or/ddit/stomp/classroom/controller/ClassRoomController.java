package kr.or.ddit.stomp.classroom.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.attendance.service.AttendanceService;
import kr.or.ddit.attendance.vo.AttendanceVO;
import kr.or.ddit.course.vo.CourseVO;

@Controller
@RequestMapping("/classRoom")
public class ClassRoomController {
	
	@Inject
	private AttendanceDAO attendDAO;
	
	@Inject
	AttendanceService attendService;
	
	@RequestMapping("view")
	public String classRoomView(
		@RequestParam("what") String lectNo
		, Model model
	) {
		List<CourseVO> cosStuList = attendService.retrieveStuList(lectNo);
		
		String lectName = attendDAO.selectMylectname(lectNo);
		model.addAttribute("lectName", lectName);
		model.addAttribute("cosStuList", cosStuList);
		model.addAttribute("lectNo", lectNo);
		
		return "classroom/classRoomView";
	}
}