package kr.or.ddit.facility.controller;


import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.facility.service.FacilityService;
import kr.or.ddit.facility.vo.FacilityVO;

@Controller
public class FacilityViewController {

	@Inject
	private FacilityService service;

	@RequestMapping("/facility/facilityView.do")
	public String facilityView(@RequestParam("what") String faciNo, Model model) {
		FacilityVO facility = service.retrieveFacility(faciNo);
		String filePath = "D:/contractFiles/";
		model.addAttribute("filePath",filePath);
		model.addAttribute("facility", facility);
		return "facility/facilityView";
	}
}











