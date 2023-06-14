package kr.or.ddit.curri.service;

import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.curri.dao.CurriBoardDAO;
import kr.or.ddit.curri.dao.TagDAO;
import kr.or.ddit.curri.vo.CurriBoardVO;
import kr.or.ddit.vo.Pagination;

@Service
public class CurriBoardServiceImpl implements CurriBoardService {

	@Inject
	private CurriBoardDAO cbDAO;
	@Inject
	private TagDAO tagDAO;
	
	@Override
	public int createCurriBoard(CurriBoardVO curriBoard) {
		// curriBoard 등록
		int res = cbDAO.insertCurriBoard(curriBoard);
		if(res>0) {
			// tag 등록
			Optional.ofNullable(curriBoard.getTagContent()).ifPresent((tag)->{
				tagDAO.insertTagList(curriBoard);
			});
		}
		return res;
	}

	@Override
	public List<CurriBoardVO> retrieveCurriBoardList(Pagination<CurriBoardVO> pagination) {
		pagination.setTotalRecord(cbDAO.selectTotalRecord(pagination));
		List<CurriBoardVO> curriBoardList = cbDAO.selectCurriBoardList(pagination);
		pagination.setDataList(curriBoardList);
		
		return curriBoardList;
	}

	@Override
	public CurriBoardVO retrieveCurriBoard(String cbNo) {
		
		CurriBoardVO curriBoard = cbDAO.selectCurriBoard(cbNo);	
		if(curriBoard==null) throw new RuntimeException();
		
		cbDAO.updateCurriCnt(cbNo);
		
		return curriBoard;
	}

	@Override
	public int removeCurriBoard(String cbNo) {
		return cbDAO.deleteCurriBoard(cbNo);
	}

}

