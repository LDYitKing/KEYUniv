package kr.or.ddit.lecture.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.lecture.service.LectureDataService;
import kr.or.ddit.lecture.vo.LectureDataVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/lecture/lectureInsert.do")
public class LectureDataInsertController {

	@Inject
	private LectureDataService service;
	@Inject
	private AttendanceDAO dao;

	@ModelAttribute("lecture")
	public LectureDataVO lecture() {
		return new LectureDataVO();
	}

	@GetMapping
	public String insertForm(Model model,String lectNo) {
		 List<LectureVO> lectures = service.retrieveLectureDataTotalList();
		    model.addAttribute("lectures", lectures);
		    model.addAttribute("lectName", dao.selectMylectname(lectNo));
		    log.info("{} 들어가있는 값은??",lectures);
		    return "lecture/lectureDataForm";
	}

	@PostMapping
	public String insert(@Validated(InsertGroup.class) @ModelAttribute("lecture") LectureDataVO lecture,
			BindingResult errors,
			Model model) {
		log.info("{}",lecture);
		if (!errors.hasErrors()) {
			service.createLectureData(lecture);
				return "redirect:/lecture";
		} else {
			return "lecture/lectureDataForm";
		}
	}

}
