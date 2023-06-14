package kr.or.ddit.lecture.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.lecture.service.LectureDataService;
import kr.or.ddit.lecture.vo.LectureDataVO;
import kr.or.ddit.validate.UpdateGroup;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/lecture/lecutreDataUpdate.do")
@RequiredArgsConstructor
public class LectureDataUpdateController {

	private final LectureDataService service;
	@Inject
	private AttendanceDAO dao;
	
	@ModelAttribute("lecture")
	public LectureDataVO lectureData(@RequestParam("what") String ldNo){
		return service.retrieveLectureData(ldNo);
	}
	@GetMapping
	public String updateForm() {
		return "lecture/lectureDataEdit";
	}

	@PostMapping
	public String updateLectureData(
		@Validated(UpdateGroup.class) @ModelAttribute("lecture") LectureDataVO lectureData
		,Errors errors) {
		String viewName = null;
		if(!errors.hasErrors()) {
			service.modifyLectureData(lectureData);
			viewName =  "redirect:/lecture/lectureView.do?what=" +lectureData.getLdNo();
		}else {
			viewName = "lecture/lectureDataEdit";
		}
		return viewName;
	}
}
