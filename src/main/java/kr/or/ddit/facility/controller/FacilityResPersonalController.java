package kr.or.ddit.facility.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.asgn.vo.AsgnVO;
import kr.or.ddit.facility.service.FacilityService;
import kr.or.ddit.facility.vo.FacilityResVO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;

@Controller
@RequestMapping("/facility")
public class FacilityResPersonalController {
	
	@Inject
	private FacilityService service;
	
	@GetMapping("/facilityResPersonal.do")
	public String getUI() {
		return "facility/facilityResList";
	}
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE, value = "/facilityResPersonal.do")
	@ResponseBody
	public List<FacilityResVO> facilityResList(Authentication authentication) {
		List<FacilityResVO> facilityResList = service.retrieveFacilityResList(authentication.getName());
		return facilityResList;
		
	}
	
}
