package kr.or.ddit.curri.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.curri.vo.CurriCommentVO;

@Mapper
public interface CurriCommentDAO {
	/**
	 * 댓글 등록
	 * @param comment
	 * @return
	 */
	public int insertComment(CurriCommentVO comment);
	
	/**
	 * 게시글 하나의 전체 댓글 조회
	 * @param cbNo
	 * @return
	 */
	public List<CurriCommentVO> selectCommentList(String cbNo);

	/**
	 * 댓글 수정
	 * @param comment
	 * @return
	 */
	public int updateComment(CurriCommentVO comment);
	/**
	 * 댓글 삭제
	 * @param ccNo
	 * @return
	 */
	public int deleteComment(String ccNo);
}
