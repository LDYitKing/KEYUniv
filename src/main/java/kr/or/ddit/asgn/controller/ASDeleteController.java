package kr.or.ddit.asgn.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.asgn.service.AsgnService;
import kr.or.ddit.asgn.vo.AsgnSubmitVO;

@Controller
@RequestMapping("asgn/asDelete.do")
public class ASDeleteController {
	
	@Inject
	private AsgnService service;
	
	
	@GetMapping
	public String deleteAS(
			@RequestParam("asgn") String asNo
			, @RequestParam("what") String lectNo
	) {
		String viewName = null;
		String asgnNo = service.removeAsngSubmit(asNo);
		
		// asgnNo 가 널이 아니면 성공
		if(asgnNo != null) {
			//성공 
			viewName = "redirect:/asgn/asgn.do?what="+lectNo;
		}
		return viewName;
	}
	
	/*
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public int deleteAS(
			@RequestParam("asgn") String asNo
			, @RequestParam("what") String lectNo
	) {
//		String viewName = null;
		String asgnNo = service.removeAsngSubmit(asNo);
		int cnt = 0;
		// asgnNo 가 널이 아니면 성공
		if(asgnNo != null) {
			//성공 
//			viewName = "redirect:/asgn/asgn.do?what="+lectNo;
			cnt += 1 ;
		}
		return cnt;
	}
	*/
}
