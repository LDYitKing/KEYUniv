package kr.or.ddit.lecture.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.lecture.service.LectureDataService;
import kr.or.ddit.lecture.vo.LectureDataVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LectureDataViewController {
	@Inject
	private LectureDataService service;
	
	@Inject
	private AttendanceDAO dao;
	
	@RequestMapping("/lecture/lectureView.do")
	public String lectureDataView(@RequestParam("what")String ldNo,Model model) {
		LectureDataVO lectureData = service.retrieveLectureData(ldNo);
		String filePath = "D:/contractFiles/";
		model.addAttribute("filePath",filePath);
		model.addAttribute("lectureData",lectureData);
		log.info("filePath의 값은 {} ",filePath);
		log.info("lectureData의 값은 {} ",lectureData);
		return "lecture/lectureDataView";
	}

}
