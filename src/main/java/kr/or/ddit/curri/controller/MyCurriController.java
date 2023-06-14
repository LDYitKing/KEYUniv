package kr.or.ddit.curri.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.curri.service.MyCurriService;
import kr.or.ddit.curri.vo.CurriDetailVO;
import kr.or.ddit.curri.vo.CurriVO;
import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.subject.vo.SubjectVO;
import kr.or.ddit.vo.SimpleCondition;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/curri/myCurri.do")
public class MyCurriController {
	@Inject
	private MyCurriService service;

	/**
	 * 기본 커리 페이지 출력
	 *
	 * @return
	 */
	@GetMapping
	public String getUI() {
		return "curri/myCurri";
	}

	/**
	 * 교과목 리스트 출력
	 *
	 * @param simpleCondition
	 * @return
	 */
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<SubjectVO> subjectList1(SimpleCondition simpleCondition) {
		List<SubjectVO> subject = new ArrayList<SubjectVO>();
		subject = service.retrieveSubjectList();
		return subject;
	}
	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<SubjectVO> subjectList2(SimpleCondition simpleCondition) {
		List<SubjectVO> subject = new ArrayList<SubjectVO>();
		subject = service.retrieveSubjectList();
		return subject;
	}
	@PostMapping(value = "/favoriteList",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<FavoriteVO> favoritesubjectList(String curriString){
		List<FavoriteVO> favorite = new ArrayList<FavoriteVO>();
		favorite = service.retrieveFavoriteList(curriString);
		return favorite;
	}

	/**
	 * 나의 커리 리스트 출력
	 *
	 * @param curriString
	 * @return
	 */
	@GetMapping(value = "/curriList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<CurriVO> CurriList(String curriString) {
		List<CurriVO> curri = new ArrayList<CurriVO>();
		curri = service.retrieveCurriList(curriString);
		return curri;
	}

	/**
	 * 나의 커리 Insert
	 *
	 * @param curri
	 */
	@PostMapping(value = "/curriInsert", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String curriInsert(@RequestBody CurriVO curri) {
		log.info("curri의 Controller에서의 값은?{}", curri);
		service.createCurri(curri);
		return "success";
	}

	/**
	 * 나의 커리 디테일 리스트 출력
	 *
	 * @param curriNo
	 * @return
	 */
	@PostMapping(value = "/curriDetailList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<CurriDetailVO> curriDetailList(String curriNo) {
		List<CurriDetailVO> curriDetail = new ArrayList<CurriDetailVO>();
		curriDetail = service.retrieveCurriDetailList(curriNo);
		return curriDetail;
	}

	@PostMapping(value = "/selectSubjectList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<SubjectVO> selectSubjectList(@RequestParam("what") String subNo,
			@RequestParam("curriNo") String curriNo,
			Model model) {
		String subName = "subName";
		model.addAttribute("subName", subName); // 모델에 subName 변수 추가
		return service.retrieveSubjectListOne(subNo, curriNo);
	}

	@PostMapping(value = "/mycurriDetailDelete",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int mycurriDetailDelete(@RequestBody CurriDetailVO vo) {
		return service.removeCurriDetail(vo);
	}

	@PostMapping(value = "/mycurriDelete",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int mycurriDelete(@RequestBody CurriVO vo) {
		log.info("deleteCurriVO값은?{}",vo);
		return service.removeCurri(vo);
	}

	@PostMapping(value="/mycurriDetailUpdate",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int mycurriDetailUpdate(@RequestBody CurriDetailVO vo) {
		return service.modifyCurriDetail(vo);
	}
	@PostMapping(value="/mycurriDetailSelect",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<CurriDetailVO> mycurriDetailSelect(@RequestBody Map<String, String> params) {
	    return service.retrieveCurriDetail(params);
	}

}
