package kr.or.ddit.facility.controller;

import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.facility.dao.FacilityDAO;
import kr.or.ddit.facility.service.FacilityService;
import kr.or.ddit.facility.vo.FacilityResVO;
import kr.or.ddit.facility.vo.FacilityTimeVO;
import kr.or.ddit.facility.vo.FacilityVO;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/facility/facilityReserve.do")
public class FacilityReserveController {

	@Inject
	private FacilityService service;

	@Inject
	private FacilityDAO facilityDAO;

	@ModelAttribute("facilityRes")
	public FacilityResVO facilityRes(Authentication authentication) {
		FacilityResVO facilityRes = new FacilityResVO();
		facilityRes.setMemNo(authentication.getName());
		return facilityRes;
	}

	@ModelAttribute("facility")
	public FacilityVO facility(@RequestParam("what") String faciNo) {
		return service.retrieveFacility(faciNo);
	}

	@GetMapping
	public String insertForm(Model model) {
		List<FacilityTimeVO> facilityTime = facilityDAO.selectFacilityTimeList();
		List<FacilityResVO> ftNoList = service.retrieveAllFacilityResList();

		model.addAttribute("facilityTime", facilityTime);
		model.addAttribute("ftNoList", ftNoList.stream().map(FacilityResVO::getFtNo).collect(Collectors.toList())); // get the ftNo from each FacilityResVO and add it to the model

		return "facility/facilityResForm";
	}


	@PostMapping
	public String insert(
			@Validated(InsertGroup.class) @ModelAttribute("facilityRes") FacilityResVO facilityRes
			, BindingResult errors
		) {
		log.info("{}",facilityRes);
		log.info("error {}",errors);
		if(!errors.hasErrors()) {
			service.createFacilityRes(facilityRes);
			return "redirect:/facility/facilityResPersonal.do";
		}else {
			return "facility/facilityResForm";
		}

	}


}







