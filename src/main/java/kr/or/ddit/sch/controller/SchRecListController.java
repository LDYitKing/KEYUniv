package kr.or.ddit.sch.controller;

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
import kr.or.ddit.sch.service.SchService;
import kr.or.ddit.sch.vo.SchRecVO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;

@Controller
@RequestMapping("/sch/schRecList.do")
public class SchRecListController {
	
	@Inject
	private SchService schService;
	
	@Inject
	private DepartmentDAO depDAO;
	
	@RequestMapping
	public String getUI(Model model) {
		model.addAttribute("deptList", depDAO.selectDepartmentList());
		model.addAttribute("colList", depDAO.selectColleageList());
		return "sch/schRecList";
	}
	
	@GetMapping("schRecNo")
	@ResponseBody
	public String searchschRecNo(@RequestParam Map<String, String> param) {
		return schService.retrieveSchNoForDept(param);
	}
	

	
	@RequestMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Pagination<SchRecVO> getJson(
			@RequestParam(value="page", required=false, defaultValue="1") int curruntPage,
			SimpleCondition simpleCondition,
			Principal principal 
			){
		// 사용자 ROLE 가져오기
		Authentication authentication = (Authentication)principal;
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		String memRole = memVO.getRealUser().getMemRole();
		String memNo = memVO.getRealUser().getMemNo();
		Pagination<SchRecVO> pagination = new Pagination<SchRecVO>();
		pagination.setCurrentPage(curruntPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setPageUser(memNo);
		schService.retrievSchRecList(pagination,memRole);
		return pagination;
		

	}
	
	
}
