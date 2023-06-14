package kr.or.ddit.curri.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.curri.service.HomeCurriService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/curri")
public class HomeCurriController {

	@Inject
	private HomeCurriService service;

	@GetMapping
	public String getUI(Model model) {
		List<String[]> urlAndTextList = service.getUrlsAndTexts();
        model.addAttribute("urlAndTextList", urlAndTextList);
		return "curri/HomeCurri";
	}


}
