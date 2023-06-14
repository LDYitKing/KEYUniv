package kr.or.ddit.tutition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sch.vo.SchRecVO;
import kr.or.ddit.tutition.vo.TuitionVO;
import kr.or.ddit.tutition.vo.TutiPayVO;
import kr.or.ddit.vo.Pagination;

@Mapper
public interface TuitionDAO {

//	/**
//	 * 등록금게시글 등록 기능
//	 * @param tutipay
//	 * @return
//	 */
//	public int insertTutiPay(TutiPayVO tutipay);
	
	/**
	 * 등록금 납입 리스트확인(교직원)
	 * @param pagination
	 * @return
	 */
	public List<TutiPayVO> selectTutiPayList(Pagination<TutiPayVO> pagination);
	/**
	 * 등록금 납입 리스트확인(학생)
	 * @param pagination
	 * @return
	 */
	public List<TutiPayVO> selectTutiPayMemList(Pagination<TutiPayVO> pagination);
	/**
	 * 등록금 상세보기
	 * @param tpNo
	 * @return
	 */
	public TutiPayVO selectTutiPay(TutiPayVO tutiPay);

//--------------------------------------------------------------------------
	/**
	 * 전체 페이지수 
	 * @param pagination
	 * @return
	 */
	public int selectTotalRecord(Pagination<TuitionVO> pagination);
	/**
	 * 등록금 리스트 확인(교직원)
	 * @param pagination
	 * @return
	 */
	public List<TuitionVO> selectTutiList(Pagination<TuitionVO> pagination);
	/**
	 * 등록금 리스트 확인(학생)
	 * @param pagination
	 * @return
	 */
	public List<TuitionVO> selectTutiMemList(Pagination<TuitionVO> pagination);
	/**
	 * 등록금 상세보기
	 * @param TuitionNo
	 * @return
	 */
	public TuitionVO selectTuti(String TuitionNo);
	/**
	 * 등록금 선택 삭제 
	 * @param condition
	 * @return
	 */
	public int deleteTuti(TuitionVO condition);
	/**
	 * 등록금 등록
	 * @param tuition
	 * @return
	 */
	public int insertTuti(TuitionVO tuition);
}

