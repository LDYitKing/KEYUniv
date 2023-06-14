package kr.or.ddit.attendance.controller;

import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.attendance.service.AttendanceService;
import kr.or.ddit.attendance.vo.AttendanceAdmitVO;
import kr.or.ddit.attendance.vo.AttendanceVO;
import kr.or.ddit.course.vo.CourseVO;

/**
 * 교수의 출석 정보를 관리하는 컨트롤러
 * @author 이다영
 * 사용권한 : 교수의 출석 및 출석인정신청 관리 
 */
@Controller
@RequestMapping
public class AttendanceController {
	
	@Inject
	private AttendanceDAO attendDAO;
	
	@Inject
	private AttendanceService attendService;
	
	/**
	 * 교수의 출석 페이지로 이동하여 UI를 받는 부분
	 * model에 담은 것 : 각 학생의 출석현황, 출석인정신청 내역, 강의번호, 강의명
	 * @param lectNo
	 * @param model
	 * @return
	 */
	@GetMapping("/attendance/attendance.do")
	public String getUI(
		@RequestParam("what") String lectNo
		, Model model
	) {
		// 학생 각각의 출석 현황을 조회
		List<AttendanceVO> attendList = attendService.retrieveStaticsAttendList(lectNo);

		// 강의에 대한 출석 인정 신청 내역을 조회
		List<AttendanceAdmitVO> attendAdmitList = attendService.retrieveAttendAdmitListAll(lectNo);
		
		// 강의 명을 가지고 다니기
		String lectName = attendDAO.selectMylectname(lectNo);
		
		// 모델에 담기
		model.addAttribute("lectName", lectName);
		model.addAttribute("attendList", attendList);
		model.addAttribute("attendAdmitList", attendAdmitList);
		model.addAttribute("what", lectNo);
		return "attendance/attendance";
	}
	
	/**
	 * 강의 날짜마다의 학생들의 출석상태 정보 조회
	 * @param lectNo
	 * @return
	 */
	@PostMapping(value="/attendance/attedStuList.do", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Map<String, Object> getAttedStuList(
		@RequestParam("what") String lectNo
	){
		// 수강하는 학생의 리스트 조회
		List<CourseVO> stuList =  attendService.retrieveStuList(lectNo);
		
		// set 컬렉션을 만들고, 
		Set<String> dateSet = new LinkedHashSet<>();
		
		// 학생리스트 하나하나 학생마다 날짜를 받아와서 set에 담고, 
		stuList.stream()
				.map(s->s.getAttendList())
				.forEach(al->al.stream().forEach(ad->{
						dateSet.add(ad.getAttendDate().format(DateTimeFormatter.ISO_DATE));
				}));
		
		//맵에 담는다.
		Map<String, Object> dataMap = new LinkedHashMap<>();
		dataMap.put("stuList", stuList);
		dataMap.put("dateSet", dateSet);
		return dataMap;
	}
	
	/**
	 * 교수가 학생의 날짜별 출석, 결석 상태 정보를 수정
	 * @param attendList
	 * @return
	 */
	@PostMapping(value = "/attendance/attedUpdate.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public int updateAttend(
		@RequestBody List<AttendanceVO> attendList
	) {
		return attendService.modifyAttend(attendList);
	}
	
	/**
	 * 교수가 학생의 출석인정신청에 응답하여 출석상태 및 반려사유 수정
	 * @param lectNo
	 * @param attendAdmit
	 * @return
	 */
	@PostMapping("/attendance/attendAdmitUpdate.do")
	public String modifyAttendAdmit(
		@RequestParam("what") String lectNo
		, @ModelAttribute("attendAdmit") AttendanceAdmitVO attendAdmit 
	) {
		attendService.modifyAttendAdmit(attendAdmit);
		String viewName = "redirect:/attendance/attendance.do?what="+lectNo;
		return viewName;
	}
	
	/**
	 * 교수가 학생의 전자출결 기능을 이용하여 당일의 출석 정보를 등록
	 * @param attendList
	 * @return
	 */
	@PostMapping(value = "/attendance/attendInsert.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public int createAttend(
		@RequestBody List<AttendanceVO> attendList
	) {
		return attendService.createAttend(attendList);
	}
	
}
