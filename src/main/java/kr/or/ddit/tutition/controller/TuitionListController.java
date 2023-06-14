package kr.or.ddit.tutition.controller;

import java.security.Principal;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.tutition.service.TutitionService;
import kr.or.ddit.tutition.vo.TuitionVO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;

@Controller
@RequestMapping("/tuti")
public class TuitionListController {

	@Inject
	private TutitionService tutiService;
	
	@RequestMapping("/tutiList.do")
	public String getUI(Model model) {
		return "tuti/tutiList";
	}
	
	
	@RequestMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE, value = "/tutiList.do")
	@ResponseBody
	public Pagination<TuitionVO> getJson(
			@RequestParam(value="page", required=false, defaultValue = "1") int curruntPage,
			SimpleCondition simpleCondition,
			Principal principal
			){
		
		// principal 가져오기
		Authentication authentication = (Authentication)principal;// 인증객체 : 인증한 사람의 정보
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		
		// 현재 로그인유저의 Role 정보 가져오기
		String memRole = memVO.getRealUser().getMemRole();
		String memNo = memVO.getRealUser().getMemNo();
		
		//  pagination객체 생성
		Pagination<TuitionVO> pagination = new Pagination<TuitionVO>();
		
		//  pagination안에 값 담기
		pagination.setCurrentPage(curruntPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setPageUser(memNo);
		
		//
		tutiService.retriveTutiList(pagination,memRole);
		return pagination;
	}
}
