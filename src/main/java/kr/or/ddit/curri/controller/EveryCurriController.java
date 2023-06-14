package kr.or.ddit.curri.controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.curri.dao.CurriCommentDAO;
import kr.or.ddit.curri.dao.TagDAO;
import kr.or.ddit.curri.service.CurriBoardService;
import kr.or.ddit.curri.service.CurriCommentService;
import kr.or.ddit.curri.service.MyCurriService;
import kr.or.ddit.curri.vo.CurriBoardVO;
import kr.or.ddit.curri.vo.CurriCommentVO;
import kr.or.ddit.curri.vo.CurriVO;
import kr.or.ddit.curri.vo.TagVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/curri/everyCurri")
public class EveryCurriController {

	@Inject
	private CurriBoardService cbService;
	@Inject
	private MyCurriService curriService;
	@Inject
	private CurriCommentService commentService;
	
	@Inject
	private TagDAO tagDAO;
	
//------------------------------------- 모두의 커리 리스트
	@GetMapping
	public String getEveryCurriListUI() {
		return "curri/everyCurri";
	}
	
	@PostMapping
	@ResponseBody
	public Pagination<CurriBoardVO> selectCurriList(
		@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
		, CurriBoardVO detailCondition
		){
		Pagination<CurriBoardVO> pagination = new Pagination<>();
		
		pagination.setCurrentPage(currentPage);
		pagination.setDetailCondition(detailCondition);
		
		log.info("pagination : {}", pagination);
		
		cbService.retrieveCurriBoardList(pagination);
		
		return pagination;
	}
	
	@PostMapping("tagRank")
	@ResponseBody
	public List<TagVO> getTagRank(){
		return tagDAO.getTagRank(5);
	}

//------------------------------------- 모두의 커리 등록
	@GetMapping("form")
	public String getEveryCurriFormUI(Authentication authentication, Model model) {
		List<CurriVO> myList = curriService.retrieveCurriList(authentication.getName());
		model.addAttribute("myList", myList);

		return "curri/everyCurri/form";
	}

	@PostMapping("form")
	public String insertEveryCurri(CurriBoardVO curriBoard, RedirectAttributes attributes) {
		log.info("curriBoard : {}", curriBoard);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberVOWrapper wrapper = (MemberVOWrapper) authentication.getPrincipal();
		MemberVO member = wrapper.getRealUser();

		curriBoard.setCbWriter(member.getMemNo());
		curriBoard.setMemName(member.getMemName());

		int res = cbService.createCurriBoard(curriBoard);

		// 등록 성공 시 , 등록한 board view로 redirect
		if (res > 0) {
			// 뷰 만들고 바꾸기
			attributes.addFlashAttribute("message", "등록되었습니다.");
			attributes.addFlashAttribute("messageIcon", "success");
			return "redirect:/curri/everyCurri/" + curriBoard.getCbNo();

		} else {
			// 등록 실패 시 , 등록 폼
			attributes.addFlashAttribute("message", "등록에 실패했습니다. 잠시후 다시 시도해주세요.");
			return "redirect:/curri/everyCurri/form";
		}

	}

//------------------------------------- 모두의 커리 뷰
	@GetMapping(value = "{cbNo}")
	public String selectCurriBoard(@PathVariable String cbNo, Model model, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html; charset=utf-8");
		log.info("cbNO : {}", cbNo);
//		model.addAttribute("cbNo", cbNo);
		
		// service 에서 curriBoard 가 존재하지 않으면 404 오류 처리 (select curriBoardVO 가 null 이면)
		// service 에서 조회수 증가
		try {
			CurriBoardVO curriBoard = cbService.retrieveCurriBoard(cbNo);		
			model.addAttribute("curriBoard", curriBoard);
			
		}catch (Exception e) {
			resp.sendError(404, "해당 게시글을 찾을 수 없습니다.");
		}
		
		return "curri/everyCurri/view";
	}
	
	// 글 삭제
	@PostMapping("deleteCurriBoard")
	@ResponseBody
	public void deleteCurriBoard(String cbNo) {
		log.info("cbNo : {}", cbNo);
		int res = cbService.removeCurriBoard(cbNo);
	}
	
	// 댓글 가져오기
	@PostMapping(value = "{cbNo}/comment")
	@ResponseBody
	public List<CurriCommentVO> selectCommentList(@PathVariable String cbNo){
		return commentService.retrieveCommentList(cbNo);
	}

	// 댓글 등록
	@PostMapping(value = "insertComment", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public void insertComment(@RequestBody CurriCommentVO comment, Model model) {
		log.info("comment : {}", comment);
		
		int res = commentService.createComment(comment);
		if(res<0) model.addAttribute("message", "등록에 실패했습니다. 잠시후 다시 시도해주세요.");
	}
	// 댓글 삭제
	@PostMapping("deleteComment")
	@ResponseBody
	public void deleteComment(String ccNo) {
		log.info("ccNo : {}", ccNo);
		int res = commentService.removeComment(ccNo);
	}
	
}



