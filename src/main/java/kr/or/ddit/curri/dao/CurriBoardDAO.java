package kr.or.ddit.curri.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.curri.vo.CurriBoardVO;
import kr.or.ddit.vo.Pagination;

@Mapper
public interface CurriBoardDAO {
	/**
	 * 전체 게시글 수 (페이징, 태그 검색)
	 * @param pagination
	 * @return
	 */
	public int selectTotalRecord(Pagination<CurriBoardVO> pagination);
	
	/**
	 * 모두의 커리 리스트 조회 (페이징, 태그 검색)
	 * @param pagination
	 * @return
	 */
	public List<CurriBoardVO> selectCurriBoardList(Pagination<CurriBoardVO> pagination);
	
	/**
	 * 모두의 커리 상세조회
	 * @param cbNo 
	 * @return 없으면 null
	 */
	public CurriBoardVO selectCurriBoard(String cbNo);
	
	/**
	 * 모두의 커리 게시글 등록
	 * @param curriBoard
	 * @return
	 */
	public int insertCurriBoard(CurriBoardVO curriBoard);
	
	/**
	 * 조회수 증가
	 * @param cbNo
	 */
	public void updateCurriCnt(String cbNo);
	
//	public int updateCurriBoard(CurriBoardVO curriBoard);
	/**
	 * 모두의 커리 게시글 삭제
	 * @param cbNo
	 * @return
	 */
	public int deleteCurriBoard(String cbNo);
}



