package kr.or.ddit.commons.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.dao.CommDAO;
import kr.or.ddit.curri.service.HomeCurriService;
import kr.or.ddit.dgrade.service.DgradeService;
import kr.or.ddit.dgrade.vo.DgradeVO;
import kr.or.ddit.grid.service.GridService;
import kr.or.ddit.grid.vo.GridVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.student.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class IndexController {
	
	@Inject
	private CommDAO commDAO;
	
	@Inject
	private GridService gridService;
	
	@Inject
	private HomeCurriService homeCurriService;
	
	@Inject
	private DgradeService dgradeService;
	
	/**
	 * index 페이지 UI를 가져온다.
	 * @return
	 */
	@RequestMapping("/index.do")
	public String index(
		Authentication authentication, HttpSession session
	) {
		// 로그인한 사람이
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		String memRole = memVO.getRealUser().getMemRole();
		String memNo = memVO.getRealUser().getMemNo();
		// 누구냐에따라 리스트 받아오기
		List<LectureVO> navLectureList = null;
		switch (memRole) {
		case "ROLE_PRO":
			//dao에서 교수꺼
			navLectureList = commDAO.selectProLectList(memNo);
			break;
			
		case "ROLE_STU":
			//dao에서 학생꺼
			navLectureList = commDAO.selectStuLectList(memNo);
			break;
			
		default:
			break;
		}
		session.setAttribute("navLectureList", navLectureList);
		
		return "index";
	}
	
	/**
	 * 나의 그리드 리스트를 불러온다.
	 * @param authentication
	 * @return
	 */
	@GetMapping(produces = "application/json;charset=utf-8", value = "/selectUserGridList.do")
	@ResponseBody
	public List<GridVO> selectUserGridList(
			Authentication authentication
			){
		MemberVOWrapper memVOW = (MemberVOWrapper) authentication.getPrincipal();
		String memNo = memVOW.getRealUser().getMemNo();
		
		return gridService.retrieveUserGridList(memNo);
	}
	
	/**
	 * 첫 로그인시 그리드 생성
	 * @param gridVO
	 * @return
	 */
	@PostMapping(produces = "application/json;charset=utf-8", value="/gridInsert.do")
	@ResponseBody
	public Integer gridInsert(
			@RequestBody List<GridVO> gridVOList
			) {
		int cnt = 0;
		
		for(GridVO gridVO :gridVOList) {
			cnt += gridService.createGrid(gridVO);
		}
		
		return cnt;
		
	}
	
	/**
	 * 그리드 수정
	 * @param gridVO
	 * @return
	 */
	@PostMapping(produces = "application/json;charset=utf-8", value = "/girdUpdate.do")
	@ResponseBody
	public Integer girdUpdate(
			@RequestBody List<GridVO> gridVOList
			) {
		int cnt = 0;
		for(GridVO gridVO : gridVOList) {
			cnt += gridService.modifyGrid(gridVO);
		}
		return cnt;
	}
	/**
	 * 그리드 삭제
	 * @param gridVO
	 * @return
	 */
	@PostMapping(produces = "application/json;charset=utf-8", value = "/girdDelete.do")
	@ResponseBody
	public Integer girdDelete(
			@RequestBody List<GridVO> gridVOList
			) {
		int cnt = 0;
		for(GridVO gridVO : gridVOList) {
			cnt += gridService.removeGrid(gridVO);
		}
		return cnt;
	}
	
	/**
	 * 메인 크롤링 뉴스
	 * @return
	 */
	@GetMapping(produces = "application/json;charset=utf-8", value = "/CurriNews.do")
	@ResponseBody
	public List<String[]> CurriNews(){
		return homeCurriService.getUrlsAndTexts();
	}
	
	// 메인화면 - 현재 이수 학점 가져오기
	@PostMapping(value = "/getDgrade.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<DgradeVO> getDgrade(Authentication authentication) {
		List<DgradeVO> dgradeList = dgradeService.selectDgrade(authentication.getName());
		log.info("countScr dgradeList : {}", dgradeList);
		return dgradeList;
	}
	
	
}
