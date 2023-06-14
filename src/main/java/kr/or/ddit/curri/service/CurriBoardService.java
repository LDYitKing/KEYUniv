package kr.or.ddit.curri.service;

import java.util.List;

import kr.or.ddit.curri.vo.CurriBoardVO;
import kr.or.ddit.vo.Pagination;

public interface CurriBoardService {
	public List<CurriBoardVO> retrieveCurriBoardList(Pagination<CurriBoardVO> pagination);
	
	public CurriBoardVO retrieveCurriBoard(String cbNo);
	
	public int createCurriBoard(CurriBoardVO curriBoard);
	
//	public int updateCurriBoard(CurriBoardVO curriBoard);
	public int removeCurriBoard(String cbNo);
}



