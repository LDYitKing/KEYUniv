package kr.or.ddit.lecture.controller;

import java.util.HashMap;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.lecture.dao.LectureDAO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/lecture/lectureHome.do")
public class LectureController {

	@Inject
	private LectureDAO lectureDAO;

	@GetMapping
	public String getUI(
			Model model, @RequestParam HashMap<String, Object> params
			,@RequestParam("what") String lectNo
			) {
		log.info("렉츠앤오 : {} ",lectNo);
		log.info("params : ", params);
		model.addAllAttributes(params);
		model.addAttribute("lecture",lectureDAO.selectLecture(lectNo));
		model.addAttribute("crtrList",lectureDAO.selectCrtrList(lectNo));
		//param 1 : "what"을 키로 lectNo넘겼음.

		return "lecture/lectureHome";
	}
}
