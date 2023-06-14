package kr.or.ddit.sch.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.sch.service.SchService;
import kr.or.ddit.sch.vo.SchVO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;

@Controller
@RequestMapping("/sch/schList.do")
public class SchListController {
	@Inject
	private SchService schService;
	
	@RequestMapping
	public String getUI(){
		return "sch/schList";
	}
	
	@RequestMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Pagination<SchVO> getJson(
			@RequestParam(value="page", required = false, defaultValue = "1") int curruntPage,
			SimpleCondition simpleCondition
	){
		Pagination<SchVO> pagination = new Pagination<SchVO>();
		pagination.setCurrentPage(curruntPage);
		pagination.setSimpleCondition(simpleCondition);
		/*
		 * 
		 */
		schService.retrievSchList(pagination);
		return pagination;
	}
}