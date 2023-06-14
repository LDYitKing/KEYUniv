package kr.or.ddit.curri.service;

import java.util.List;

import kr.or.ddit.curri.vo.CurriCommentVO;

public interface CurriCommentService {
	/**
	 * 댓글 등록
	 * @param comment
	 * @return
	 */
	public int createComment(CurriCommentVO comment);
	
	/**
	 * 게시글 하나의 전체 댓글 조회
	 * @param cbNo
	 * @return
	 */
	public List<CurriCommentVO> retrieveCommentList(String cbNo);

	/**
	 * 댓글 수정
	 * @param comment
	 * @return
	 */
	public int modifyComment(CurriCommentVO comment);
	/**
	 * 댓글 삭제
	 * @param ccNo
	 * @return
	 */
	public int removeComment(String ccNo);
}
