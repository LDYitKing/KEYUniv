package kr.or.ddit.asgn.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.asgn.service.AsgnService;
import kr.or.ddit.asgn.vo.AsgnSubmitVO;
import kr.or.ddit.asgn.vo.AsgnVO;
import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/asgn/proStuAsgnView.do")
public class ProStuAsgnViewController {
	
	@Inject
	private AsgnService service;
	
	@Inject
	private AttendanceDAO attendanceDAO;
	
	@ModelAttribute("asgn")
	public AsgnVO asgn() {
		return new AsgnVO();
	}
	
	@ModelAttribute("asgnSubmit")
	public AsgnSubmitVO asVO() {
		return new AsgnSubmitVO();
	}
	
	@RequestMapping
	public String getUI(
			@RequestParam("lect") String lectNo,
			Model model
			) {
		log.info("이게모니 : {}", lectNo);
		model.addAttribute("lectName", attendanceDAO.selectMylectname(lectNo));
		model.addAttribute("lectNo", lectNo);
		return "asgn/proStuAsgnView";
	}
	
	@RequestMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Pagination<AsgnVO> getJson(
	    @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
	    ,SimpleCondition simpleCondition
	    ,@RequestParam("what") String asgnNo
	    ,@RequestParam("lect") String lectNo	    
	) {
		log.info("강의번호 : {}", lectNo);
		log.info("과제번호 : {}", asgnNo);
		
		AsgnVO asgnVO = new AsgnVO();
		asgnVO.setLectNo(lectNo);
		asgnVO.setAsgnNo(asgnNo);
		
	    Pagination<AsgnVO> pagination = new Pagination<>();
	    pagination.setDetailCondition(asgnVO);
	    
	    pagination.setCurrentPage(currentPage);
	    pagination.setSimpleCondition(simpleCondition);
	    service.retrieveProStuAsgnList(pagination);
	    return pagination;
	}
}












