package kr.or.ddit.univBoard.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.univBoard.dao.UnivBoardDAO;
import kr.or.ddit.univBoard.service.UnivBoardService;
import kr.or.ddit.univBoard.vo.UnivBoardVO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;

@Controller
@RequestMapping("/univBoard")
public class UnivBoardListController {

	@Inject
	private UnivBoardService service;
	
	@Inject
	private UnivBoardDAO dao;
	
	@RequestMapping("/univBoardList.do")
	public String getUI() {
		return "univBoard/univBoardList";
	}
	
	@RequestMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE, value = "/univBoardList.do")
	@ResponseBody
	public Pagination<UnivBoardVO> getJson(
		@RequestParam(value ="page", required = false, defaultValue = "1" ) int currentPage
			,SimpleCondition simpleCondition// 모델로 그대로 리턴
		){
			Pagination<UnivBoardVO> pagination = new Pagination<UnivBoardVO>();
			pagination.setCurrentPage(currentPage);
			pagination.setSimpleCondition(simpleCondition);
			
			service.retrievUnivBoardList(pagination);
			return pagination;
		
	}
	
	@GetMapping(produces = "application/json;charset=utf-8" , value = "/noticeUnivBoardList.do")
	@ResponseBody
	public List<UnivBoardVO> noticeUnivBoardList(){
		return dao.selectMainNoticeBoardList();
		
	}
	
}
