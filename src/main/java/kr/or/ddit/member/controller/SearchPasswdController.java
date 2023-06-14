package kr.or.ddit.member.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.vo.MailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class SearchPasswdController {
	
	@Inject
	private MemberService service;
	
	@PostMapping(value = "searchPasswd.do")
	@ResponseBody
	public MailVO searchPasswd(@RequestBody MemberVO member) {
//		log.info("member : {}", member);

		MailVO mailVO = service.searchPasswd(member);
		
		return mailVO;
	}
}
