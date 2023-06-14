package kr.or.ddit.univBoard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.univBoard.vo.UnivBoardVO;
import kr.or.ddit.vo.Pagination;

@Mapper
public interface UnivBoardDAO {
	/**
	 * 학교게시판에 게시글을 등록하는 기능
	 * @param univboard
	 * @return
	 */
	public int insertUnivBoard(UnivBoardVO univboard);
	
	/**
	 * 학교 게시판 게시글 목록을 조회하는 기능 
	 * @param pagination
	 * @return
	 */
	public List<UnivBoardVO> selectUnivBoardList(Pagination<UnivBoardVO> pagination);
	
	/**
	 * 학교게시판 전체 게시글 수
	 * @param pagination
	 * @return
	 */
	public int selectTotalRecord(Pagination<UnivBoardVO> pagination);
	/**
	 * 학교게시판 게시글 하나를 조회하는 기능
	 * @param ubNo
	 * @return
	 */
	public UnivBoardVO selectUnivBoard(int ubNo);
	/**
	 * 학교게시판 조회시 조회수가 올라가는 기능
	 * @param ubCnt
	 * @return
	 */
	public int updateUbCnt(int ubCnt);
	
	/**
	 * 학교게시판 게시글을 수정하는 기능
	 * @param univboard
	 * @return
	 */
	public int updateUnivBoard(UnivBoardVO univboard);
	
	/**
	 * 학교게시판 게시글을 삭제하는 기능
	 * @param condition
	 * @return
	 */
	public int deleteUnivBoard(UnivBoardVO condition);
	
	/**
	 * 메인 화면 공지사항 리스트 출력
	 * @return
	 */
	public List<UnivBoardVO> selectMainNoticeBoardList();

}
