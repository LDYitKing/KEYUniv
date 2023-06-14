package kr.or.ddit.facility.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.facility.service.FacilityService;
import kr.or.ddit.facility.vo.FacilityVO;
import kr.or.ddit.validate.DeleteGroup;

@Controller
@RequestMapping("/facility/facilityDelete.do")
public class FacilityDeleteController {
	
	@Inject
	private FacilityService service;
	
	
	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String deleteFacilityAjax(
			@Validated(DeleteGroup.class) FacilityVO condition
			, BindingResult errors
			, Model model
	) {
		boolean success = false;
		if(!errors.hasErrors()) {
				service.removeFacility(condition);
				success = true;
				model.addAttribute("location", "/facility/facilityList.do");
		}
		model.addAttribute("success", success);
		return "jsonView";
	}
	
	@PostMapping
	public String deleteFacility(
			@Validated(DeleteGroup.class) FacilityVO condition
			, BindingResult errors
			, RedirectAttributes redirectAttributes
		) {
		if(!errors.hasErrors()) {
			service.removeFacility(condition);
			return "redirect:/facility/facilityList.do";
		}else {
			return "redirect:/facility/facilityView.do?what="+condition.getFaciNo();
		}
	}
	
}
