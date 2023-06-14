package kr.or.ddit.facility.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.facility.service.FacilityService;
import kr.or.ddit.facility.vo.FacilityResVO;
import kr.or.ddit.validate.DeleteGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/facility/facilityResDelete.do")
public class FacilityResDeleteController {
	
	@Inject
	private FacilityService service;
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> deleteFacilityResAjax(
	        @RequestParam("frNo") String frNo) {
	    Map<String, Object> resultMap = new HashMap<>();
	    boolean success = false;
	    if (frNo != null && !frNo.trim().isEmpty()) {
	        FacilityResVO condition = new FacilityResVO();
	        condition.setFrNo(frNo);
	        service.removeFacilityRes(condition);
	        success = true;
	    }
	    resultMap.put("success", success);
	    return resultMap;
	}
	
	@GetMapping
	public String deleteFacilityRes(
			@Validated(DeleteGroup.class) FacilityResVO condition,
			BindingResult errors,
			RedirectAttributes redirectAttributes) {
		if (!errors.hasErrors()) {
			service.removeFacilityRes(condition);
			redirectAttributes.addFlashAttribute("success", true);
		}
		return "redirect:/facility/facilityResList.do";
	}
}
