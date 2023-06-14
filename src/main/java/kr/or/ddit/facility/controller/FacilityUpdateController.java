package kr.or.ddit.facility.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.facility.service.FacilityService;
import kr.or.ddit.facility.vo.FacilityVO;
import kr.or.ddit.validate.UpdateGroup;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/facility/facilityUpdate.do")
@RequiredArgsConstructor
public class FacilityUpdateController {
	
	private final FacilityService service;
	
	@ModelAttribute("facility")
	public FacilityVO facility(@RequestParam("what") String faciNo) {
		return service.retrieveFacility(faciNo);
	}
	
	@GetMapping
	public String updateForm() {
		return "facility/facilityEdit";
	}
	
	@PostMapping
	public String updateFacility(
		@Validated(UpdateGroup.class) @ModelAttribute("facility") FacilityVO facility
		, Errors errors
	) {
		String viewName = null;
		if(!errors.hasErrors()) {
			service.modifyFacility(facility);
			viewName = "redirect:/facility/facilityView.do?what="+facility.getFaciNo();
		}else {
			viewName = "facility/facilityEdit";
		}
		return viewName;
	}
	
	
}
