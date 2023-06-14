package kr.or.ddit.tutition.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.tutition.service.TutitionService;
import kr.or.ddit.tutition.vo.TutiPayVO;

@Controller
public class TuitionPayViewController{
//	@Inject
//	private TutitionService service;
//	
//	@GetMapping("/tuti/tutiPayView.do")
//	public String getUI(Model model, @RequestParam("what") String tpNo) {
//		TutiPayVO tutipay = service.retrieveTutiPay(tpNo);
//		model.addAttribute("tutipay",tutipay);
//		return "tuti/tutiPayView";
//	}
//	
//	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE, value = "/tuti/tutiPayView.do")
//	@ResponseBody
//	public TutiPayVO tutipayView(@RequestBody String tpNo) {
//		return service.retrieveTutiPay(tpNo);
//	}
}