package kr.or.ddit.tutition.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.tutition.vo.TuitionVO;
import kr.or.ddit.tutition.vo.TutiPayVO;
import kr.or.ddit.univBoard.vo.UnivBoardVO;
import kr.or.ddit.vo.Pagination;

public interface TutitionService {

	/**
	 * 등록금 작성 기능
	 * @param tutipay
	 */
	public void createTutiPay(TutiPayVO tutipay);
	/**
	 * 등록금 리스트 확인
	 * @param pagination
	 */
	public List<TutiPayVO> retriveTutiPayList(Pagination<TutiPayVO> pagination, String memRole);
	/**
	 * 등록금 내용 상세보기
	 * @param tpNo
	 * @return
	 */
	public TutiPayVO retrieveTutiPay(TutiPayVO tutiPay);
	/**
	 * 등록금 내용 삭제
	 * @param condition
	 */
	public void removeTutiPay(TutiPayVO condition);
	/**
	 * 등록금 고지서 리스트보기
	 * @param pagination
	 * @param memRole
	 * @return
	 */
	public List<TuitionVO> retriveTutiList(Pagination<TuitionVO> pagination,String memRole);
	/**
	 * 등록금 고지서 상세보기
	 * @param tuitionNo
	 * @return
	 */
	public TuitionVO retriveTuti(String tuitionNo);
	/**
	 * 등록금 선택 삭제 
	 * @param condition
	 */
	public void removeTuti(TuitionVO condition);
	
	/**
	 * 등록금 게시글 등록
	 * @param univboard
	 */
	public void createTuti(TuitionVO tuition);
}
