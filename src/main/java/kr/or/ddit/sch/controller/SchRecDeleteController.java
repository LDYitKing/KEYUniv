package kr.or.ddit.sch.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.facility.vo.FacilityResVO;
import kr.or.ddit.facility.vo.FacilityVO;
import kr.or.ddit.sch.service.SchService;
import kr.or.ddit.sch.vo.SchRecVO;
import kr.or.ddit.sch.vo.SchVO;
import kr.or.ddit.validate.DeleteGroup;

@Controller
@RequestMapping("/sch/schRecDelete.do")
public class SchRecDeleteController {
	@Inject
	private SchService service;	

	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String deleteSchAjax(
			@Validated(DeleteGroup.class) SchRecVO condition
			, BindingResult errors
			, Model model
	) {
	    boolean success = false;
	    if (!errors.hasErrors()) {
			service.removeSchRec(condition);
			success = true;
			model.addAttribute("location", "/sch/schRecList.do");
	}
	model.addAttribute("success", success);
	return "jsonView";
}
	

	
	@PostMapping
	public String deleteSchRec(
			@Validated(DeleteGroup.class) SchRecVO condition,
			BindingResult errors,
			RedirectAttributes redirectAttributes
	) {
		if(!errors.hasErrors()) {
			service.removeSchRec(condition);
			return "redirect:/sch/schRecList.do";
		}else {
			return "redirect:/sch/schRecView.do?what="+condition.getSchRecNo();
		}
	}
}