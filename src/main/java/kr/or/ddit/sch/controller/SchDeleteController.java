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
import kr.or.ddit.sch.vo.SchVO;
import kr.or.ddit.validate.DeleteGroup;

@Controller
@RequestMapping("/sch/schDelete.do")
public class SchDeleteController {
	@Inject
	private SchService service;	

	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String deleteSchAjax(
			@Validated(DeleteGroup.class) SchVO condition
			, BindingResult errors
			, Model model
	) {
	    boolean success = false;
	    if (!errors.hasErrors()) {
			service.removeSch(condition);
			success = true;
			model.addAttribute("location", "/sch/schList.do");
	}
	model.addAttribute("success", success);
	return "jsonView";
}
	

	
	@PostMapping
	public String deleteSch(
			@Validated(DeleteGroup.class) SchVO condition,
			BindingResult errors,
			RedirectAttributes redirectAttributes
	) {
		if(!errors.hasErrors()) {
			service.removeSch(condition);
			return "redirect:/sch/schList.do";
		}else {
			return "redirect:/sch/schView.do?what="+condition.getSchNo();
		}
	}
}