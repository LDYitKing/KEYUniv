package kr.or.ddit.member.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class SearchIdController {

	@Inject
	private MemberService service;

	@PostMapping(value = "searchId.do")
	public @ResponseBody List<MemberVO> searchId(@RequestBody MemberVO member) {
		log.info("member : {}", member);

		List<MemberVO> memList = service.searchId(member);

		return memList;
	}
	
}