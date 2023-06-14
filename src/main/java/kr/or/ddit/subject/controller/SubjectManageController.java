package kr.or.ddit.subject.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.dao.CommDAO;
import kr.or.ddit.favorites.service.FavoriteService;
import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.professor.vo.ProfessorVO;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.subject.dao.SubjectDAO;
import kr.or.ddit.subject.service.SubjectService;
import kr.or.ddit.subject.vo.SubjectVO;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/subject")
public class SubjectManageController {
	@Inject
	private SubjectService subService;
	@Inject
	private CommDAO commDAO;
	@Inject
	private SubjectDAO subjectDAO;
	@Inject
	private FavoriteService favoriteService;
	
	@GetMapping("/subjectManagement.do")
	public String getUI(
			Authentication authentication
			,Model model
			) {
		MemberVOWrapper memVOW = (MemberVOWrapper) authentication.getPrincipal();
		String memNo = memVOW.getRealUser().getMemNo();
		String memRole = memVOW.getRealUser().getMemRole();
		if(memRole.equals("ROLE_PRO")) {
			ProfessorVO proVO = subjectDAO.temporaryProfessor(memNo);
			SubjectVO subject = new SubjectVO();
			subject.setColNo(proVO.getColNo());
			subject.setDeptNo(proVO.getDeptNo());
			model.addAttribute("insertForm",subject);
		}
		
		model.addAttribute("commList", commDAO.selectCommList(null));
		
		
		return "subject/subjectManagement";
	}
	

	/**
	 * 전체 리스트 조회
	 * @return
	 */
	@GetMapping(produces = "application/json;charset=utf-8" , value = "/subjectManagement.do")
	@ResponseBody
	public List<SubjectVO> subjectList(){
		return subService.retrieveSubjectList();
	}
	
	/**
	 * 상세보기
	 * @param subNo
	 * @return
	 */
	@RequestMapping(produces = "application/json;charset=utf-8", value = "/subjectView.do")
	@ResponseBody
	public SubjectVO subjectView(
			@RequestParam("what") String subNo
			) {
		return subService.retrieveSubject(subNo);
		
	}
	
	/**
	 * 등록
	 * @param subject
	 * @param errors
	 * @return
	 */
	@PostMapping(produces = "application/json;charset=utf-8", value = "/subjectInsert.do")
	@ResponseBody
	public Integer subjectInsert(
			@Validated(InsertGroup.class) @ModelAttribute("insertForm") SubjectVO subject
			, Errors errors
			) {
		Integer cnt = 0;
		System.err.println("체킁");
		if(!errors.hasErrors()) {
			subService.createSubject(subject);
			cnt = 1;
		}
		return cnt;
	}
	
	/**
	 * 전체승인
	 * @return 승인된 갯수
	 */
	@GetMapping(produces = "application/json;charset=utf-8" , value = "/subjectOKAll.do")
	@ResponseBody
	public Integer subjectOKAll(){
		return subjectDAO.subjectOKAll();
	}
	
	/**
	 * 이건 교과목 업데이트
	 * @param subject
	 * @param errors
	 * @return 성공하면 B001 상태됨
	 */
	@PostMapping(produces = "application/json;charset=utf-8", value = "/subjectUpdate.do")
	@ResponseBody
	public Integer subjectUpdate(
			@Validated(UpdateGroup.class) @ModelAttribute("updateSubjectForm") SubjectVO subject
			, Errors errors
			,Authentication authentication
			) {
		Integer cnt = 0;
		if(!errors.hasErrors()) {
			switch (subService.modifySubject(subject)) {
			case OK:
				FavoriteVO favorite = new FavoriteVO();
				MemberVOWrapper mvw = (MemberVOWrapper) authentication.getPrincipal();
				MemberVO vo = mvw.getRealUser();
				favorite.setMemNo(vo.getMemNo());
				favorite.setSubNo(subject.getSubNo());
				favoriteService.removeSubjectFavorite(favorite);
				cnt = 1;
				break;
			default:
				cnt = 0;
				break;
			} ;
			
		}
		return cnt;
	}
	
	/**
	 * 이건 교과목 삭제
	 * @param subNo
	 * @param authentication
	 * @return
	 */
	@PostMapping(produces = "application/json;charset=utf-8", value = "/subjectDelete.do")
	@ResponseBody
	public Integer subjectDelete(
			@RequestParam("what") String subNo
			,Authentication authentication
			) {
		Integer cnt = 0;
		
		switch (subService.removeSubject(subNo)) {
		case OK:
			FavoriteVO favorite = new FavoriteVO();
			MemberVOWrapper mvw = (MemberVOWrapper) authentication.getPrincipal();
			MemberVO vo = mvw.getRealUser();
			favorite.setMemNo(vo.getMemNo());
			favorite.setSubNo(subNo);
			favoriteService.removeSubjectFavorite(favorite);
			cnt = 1;
			break;
		default:
			cnt = 0;
			break;
		} 
		return cnt;
	}
	
	@PostMapping(produces = "application/json;charset=utf-8", value = "/subjectProcess.do")
	@ResponseBody
	public Integer subjectProcess(
			 @ModelAttribute("subjectProcessForm") SubjectVO subject
			) {
		System.err.println("체킁");
		return subService.subjectProcess(subject);
	}
	
	/**
	 * 직업별 리스트 조회
	 * @return
	 */
	@GetMapping(produces = "application/json;charset=utf-8" , value = "/jobSubjectList.do")
	@ResponseBody
	public List<FavoriteVO> jobSubjectList(){
		return subService.retrieveJobSubjectList();
	}
	
	/**
	 * 내가 들은 교과목 조회
	 * @param authentication
	 * @return
	 */
	@GetMapping(produces = "application/json;charset=utf-8" , value = "/myListenSub.do")
	@ResponseBody
	public List<FavoriteVO> myListenSub(
			Authentication authentication
			){
		MemberVOWrapper mvw = (MemberVOWrapper) authentication.getPrincipal();
		MemberVO vo = mvw.getRealUser();
		log.info("{} 왜 아무값도 안왔어", vo.getMemNo());
		
		return subjectDAO.myListenSub(vo.getMemNo()); 
//		return subjectDAO.myListenSub("220201021"); // 임시방편
	}
	

}
