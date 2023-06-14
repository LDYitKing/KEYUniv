package kr.or.ddit.sample.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.sample.service.SampleService;
import kr.or.ddit.sample.vo.SampleVO;

@Controller
public class SampleListController {
	
	@Inject
	private SampleService service;
	
	@RequestMapping("/sample/sampleList.do")
	public String list(Model model) {
		List<SampleVO> list = service.retrieveSampleList();
		model.addAttribute("list", list);
		
		return "sample/sampleList";
	}
}
