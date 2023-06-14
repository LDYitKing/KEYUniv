package kr.or.ddit.univBoard.service;

import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.univBoard.vo.UnivBoardVO;
import kr.or.ddit.vo.Pagination;

public interface UnivBoardService {
//---------------------------------------------------------------
	/**
	 * 교직원이 게시글을 작성하는 기능
	 * @param univboard
	 */
	public void createUnivBoard(UnivBoardVO univboard);

//---------------------------------------------------------------	
	/**
	 * 학교게시판 게시글 리스트를 출력하는 기능
	 * @param pagination
	 */
	public void retrievUnivBoardList(Pagination<UnivBoardVO> pagination);
	
//---------------------------------------------------------------
	/**
	 * 학교게시판 게시글을 상세조회 하는 기능
	 * @param ubNo
	 * @return
	 */
	public UnivBoardVO retrieveUnivBoard(int ubNo);
	
//---------------------------------------------------------------
	/**
	 * 학교게시판 게시글을 수정하는 기능
	 * @param univboard
	 */
	public void modifyUnivBoard(UnivBoardVO univboard);
	
//---------------------------------------------------------------	
	/**
	 * 학교게시판 게시글을 삭제하는 기능
	 * @param condition
	 */
	public void removeUnivBoard(UnivBoardVO condition);
	
//---------------------------------------------------------------	
	/**
	 * 학교게시판 게시글 첨부파일을 다운로드하는 기능
	 * @param condition
	 * @return
	 */
	public AttatchFileVO download(AttatchFileVO condition);

//---------------------------------------------------------------
	
	
}
