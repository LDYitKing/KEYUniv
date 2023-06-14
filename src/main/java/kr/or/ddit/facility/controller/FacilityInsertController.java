package kr.or.ddit.facility.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.facility.service.FacilityService;
import kr.or.ddit.facility.vo.FacilityVO;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/facility/facilityInsert.do")
public class FacilityInsertController {

	@Inject
	private FacilityService service;

	@ModelAttribute("facility")
	public FacilityVO facility() {
		return new FacilityVO();
	}
	
	@GetMapping
	public String insertForm() {
		return "facility/facilityForm";
	}
	
	@PostMapping
	public String insert(
		@Validated(InsertGroup.class) @ModelAttribute("facility") FacilityVO facility
		, BindingResult errors
	) {
		log.info("{}",facility);
		log.info("error {}",errors);
		
		if(!errors.hasErrors()) {
			service.createFacility(facility);
			return "redirect:/facility/facilityList.do";
		}else {
			return "facility/facilityForm";
		}
	}
	
	
}
