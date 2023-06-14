package kr.or.ddit.asgn.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.asgn.service.AsgnService;
import kr.or.ddit.asgn.vo.AsgnVO;
import kr.or.ddit.attendance.dao.AttendanceDAO;

@Controller
@RequestMapping("/asgn")
public class ProAsgnController {

	@Inject
	private AsgnService service;
	
	@Inject
	private AttendanceDAO attendanceDAO;
	
	@GetMapping("/proAsgn.do")
	public String getUI(
			Model model,
			@RequestParam("what") String lectNo
	) {
		model.addAttribute("lectNo",lectNo);
		model.addAttribute("lectName",attendanceDAO.selectMylectname(lectNo));
		return "asgn/proAsgnList";
	}
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE, value="/proAsgn.do")
	@ResponseBody
	public List<AsgnVO> proAsgnList(
		@RequestParam(value = "what") String lectNo
	){
		return service.retrieveProAsgnList(lectNo);
	}
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE, value="/proAsgnView.do")
	@ResponseBody
	public AsgnVO proRetrieveAsgn(
		@RequestParam(value = "what") String asgnNo
	) {
		return service.retrieveAsgn(asgnNo);
	}
	
}




