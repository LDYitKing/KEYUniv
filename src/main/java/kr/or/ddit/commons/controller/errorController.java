package kr.or.ddit.commons.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class errorController {

	// 요청 url 패턴 (error.html)
	@RequestMapping(value = "/error/400")
	public String error400() {
		// view의 파일명
		return "error/400";
	}
	
	// 요청 url 패턴 (error.html)
	@RequestMapping(value = "/error/403")
	public String error403() {
		// view의 파일명
		return "error/403";
	}
	
	// 요청 url 패턴 (error.html)
	@RequestMapping(value = "/error/404")
	public String error404() {
		// view의 파일명
		return "error/404";
	}
	
	// 요청 url 패턴 (error.html)
	@RequestMapping(value = "/error/415")
	public String error415() {
		// view의 파일명
		return "error/415";
	}
	
	// 요청 url 패턴 (error.html)
	@RequestMapping(value = "/error/500")
	public String error500() {
		// view의 파일명
		return "error/500";
	}

	
}
