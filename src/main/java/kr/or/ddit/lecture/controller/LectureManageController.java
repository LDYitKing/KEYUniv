package kr.or.ddit.lecture.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.academicyear.dao.AcademicYearDAO;
import kr.or.ddit.commons.dao.CommDAO;
import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.lecture.service.LectureService;
import kr.or.ddit.lecture.vo.LectureRoomVO;
import kr.or.ddit.lecture.vo.LectureTimePlaceVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.lecture.vo.LectureWeekPlanVO;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/lectureManage")
public class LectureManageController {
	@Inject
	private LectureService lectureService;
	@Inject
	private DepartmentDAO depDAO;
	@Inject
	private CommDAO commDAO;
	@Inject
	private AcademicYearDAO academicYearDAO;
	
	
	
	@GetMapping("/lectureManageUI.do")
	public String getUI(Model model) {
		model.addAttribute("deptList", depDAO.selectDepartmentList());
		model.addAttribute("colList", depDAO.selectColleageList());		
		model.addAttribute("commList", commDAO.selectCommList("A"));
		
		return "lecture/lectureManage";
	}
	
	@PostMapping(value = "/lectureList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<LectureVO> lectureList(LectureVO lecture) {
		log.info("lecture : {}", lecture );
		log.info("lecture.getSearchData() : {}", lecture.getSearchData());
		
		// 검색어 lecture 받아서(json) 보내기
		List<LectureVO> lectList = lectureService.retrieveLectureList(lecture); 
		
		return lectList;
	}
	
	@PostMapping(value = "/lectureInfo/{lectNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public LectureVO lectureInfo(@PathVariable String lectNo) {
		LectureVO lecture = lectureService.retrieveLecture(lectNo);
		
		return lecture;
	}
	
	/**
	 * 강의 주차별 계획 조회
	 * @return
	 */
	@GetMapping(value = "/lectureWeekPlanList.do" , produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<LectureWeekPlanVO> lectureWeekPlanList(){
		return lectureService.retrieveLectureWeekPlanList();
	}
	
	/**
	 * 강의 시간표 조회
	 * @return
	 */
	@GetMapping(value = "/lectureTimePlaceList.do" , produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<LectureTimePlaceVO> lectureTimePlaceList(){
		return lectureService.retrieveLectureTimePlaceList();
	}
	
	/**
	 * 강의실 조회
	 * @return
	 */
	@GetMapping(value = "/lectureRoomList.do" , produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<LectureRoomVO> lectureRoomList(){
		return lectureService.retrieveLectureRoomList();
	}
	
	
	/**
	 * 강의 등록
	 * @param lecture
	 * @param errors
	 * @return
	 */
	@PostMapping(value ="/lectureInsert.do", produces = "application/json;charset=utf-8")
	@ResponseBody
	public Integer lectureInsert(
			@Validated(InsertGroup.class) @ModelAttribute("lectPlanForm") LectureVO lecture
			,Errors errors
			) {
		Integer cnt = 0;
		System.err.println("체킁");
		if(!errors.hasErrors()) {
			lectureService.createLecture(lecture);
			cnt = 1;
		}
		return cnt;
		
		
	}
}
