package kr.or.ddit.tutition.controller;

import java.security.Principal;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.sch.vo.SchRecVO;
import kr.or.ddit.tutition.service.TutitionService;
import kr.or.ddit.tutition.vo.TutiPayVO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;

@Controller
@RequestMapping("tuti/tutiPayList.do")
public class TuitionPayListController {
	
	@Inject
	private TutitionService tutiService;
	
	@RequestMapping
	public String getUI(Model model) {
		return "tuti/tutiPayList";
	}
	
	
	@RequestMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Pagination<TutiPayVO> getJson(
			@RequestParam(value="page", required=false, defaultValue="1") int curruntPage,
			SimpleCondition simpleCondition,
			Principal principal 
			){
		// 사용자 ROLE 가져오기
		Authentication authentication = (Authentication)principal;
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		String memRole = memVO.getRealUser().getMemRole();
		String memNo = memVO.getRealUser().getMemNo();
		Pagination<TutiPayVO> pagination = new Pagination<TutiPayVO>();
		pagination.setCurrentPage(curruntPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setPageUser(memNo);
		tutiService.retriveTutiPayList(pagination,memRole);
		return pagination;
	}
}
