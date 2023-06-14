package kr.or.ddit.facility.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.facility.service.FacilityService;
import kr.or.ddit.facility.vo.FacilityVO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;

@Controller
@RequestMapping("/facility/facilityList.do")
public class FacilityListController {
	
	@Inject
	private FacilityService service;

	@RequestMapping
	public String getUI() {
		return "facility/facilityList";
	}
	
	@RequestMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Pagination<FacilityVO> getJson(
		@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
		, SimpleCondition simpleCondition
	){
		Pagination<FacilityVO> pagination = new Pagination<FacilityVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		service.retrieveFacilityList(pagination);
		return pagination;
	}
}

