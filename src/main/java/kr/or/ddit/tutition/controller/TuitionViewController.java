package kr.or.ddit.tutition.controller;

import java.security.Principal;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.tutition.service.TutitionService;
import kr.or.ddit.tutition.vo.TuitionVO;
import kr.or.ddit.tutition.vo.TutiPayVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TuitionViewController {
	
	@Inject
	private TutitionService tutiService;
	
	@GetMapping("/tuti/tutiView.do")
	public String getUI(Model model, @RequestParam("what") String tuitionNo, Principal principal) {
		TuitionVO tuti = tutiService.retriveTuti(tuitionNo);
		
//		Authentication authentication = (Authentication)principal;
//		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
//		String stuNo = memVO.getRealUser().getMemNo();
		
		TutiPayVO tutiPay = new TutiPayVO();
		tutiPay.setTuitionNo(tuitionNo);
//		tutiPay.setTuitionNo(tuti.getTuitionNo());
//		tutiPay.setStuNo(stuNo);
//		tutiPay.setStuNo(stuNo);
		
//		log.info("{}스튜엔오",stuNo);
		log.info("{}튜이션엔오",tuti.getTuitionNo());
		
		tutiPay = tutiService.retrieveTutiPay(tutiPay);
		model.addAttribute("tuti",tuti);
		model.addAttribute("tutiPay",tutiPay);
		return "tuti/tutiView";
	}
	
	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE, value = "tuti/tutiView.do")
	@ResponseBody
	public TuitionVO tutiView(@RequestBody String tuitionNo) {
		return tutiService.retriveTuti(tuitionNo);
	}
	
}
