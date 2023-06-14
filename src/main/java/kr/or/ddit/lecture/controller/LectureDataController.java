package kr.or.ddit.lecture.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.lecture.service.LectureDataService;
import kr.or.ddit.lecture.vo.LectureDataVO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/lecture")
public class LectureDataController {
	@Inject
	private LectureDataService service;
	@Inject
	private AttendanceDAO dao;
	@GetMapping
	public String getUI(Model model, @RequestParam(value ="what")String lectNo) {
	    Pagination<LectureDataVO> pagination = new Pagination<LectureDataVO>(5, 3);
	    // Initialize detailCondition
	    LectureDataVO detailCondition = new LectureDataVO();
	    detailCondition.setLectNo(lectNo);
	    pagination.setDetailCondition(detailCondition);
	    List<LectureDataVO> lectureDataList = service.retrieveLectureDataList(pagination);
	    model.addAttribute("lectureDataList", lectureDataList);
	    model.addAttribute("what", lectNo);
	    model.addAttribute("lectName", dao.selectMylectname(lectNo));
	    return "lecture/lectureDataList";
	}

	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE, value = "/lecture.do")
	@RequestMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Pagination<LectureDataVO> getJson(
	        @RequestParam(value="page",required=false,defaultValue="1") int currentPage,
	        SimpleCondition simpleCondition,
	        @RequestParam(value = "what") String lectNo){
	    Pagination<LectureDataVO> pagination = new Pagination<LectureDataVO>(5,3);
	    // Initialize detailCondition
	    LectureDataVO detailCondition = new LectureDataVO();
	    detailCondition.setLectNo(lectNo);
	    pagination.setDetailCondition(detailCondition);
	    pagination.setCurrentPage(currentPage);
	    pagination.setSimpleCondition(simpleCondition);
	    log.info("pagination의 값은?{}",pagination);
	    service.retrieveLectureDataList(pagination);
	    return pagination;
	}
}
