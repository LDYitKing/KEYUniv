package kr.or.ddit.sch.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.sch.vo.SchRecVO;
import kr.or.ddit.sch.vo.SchVO;
import kr.or.ddit.vo.Pagination;

@Mapper
public interface SchDAO {
//------------------------------------------------------------	
	/**
	 * 장학금 등록 기능
	 * @param sch
	 * @return
	 */
	public int insertSch(SchVO sch);
	
//------------------------------------------------------------
	/**
	 * 장학금 목록을 조회하는 기능
	 * @param pagination
	 * @return
	 */
	public List<SchVO> selectSchList(Pagination<SchVO> pagination);
	
//------------------------------------------------------------
	/**
	 * 전체 장학금 페이지 수  
	 * @param pagination
	 * @return
	 */
	public int selectTotalRecord(Pagination<SchVO> pagination);
	
//------------------------------------------------------------
	/**
	 * 하나의 장학금 상세보기 기능
	 * @param schNo
	 * @return
	 */
	public SchVO selectSch(String schNo);
	
//------------------------------------------------------------
	/**
	 * 하나의 장학금 내용 수정 기능
	 * @param sch
	 * @return
	 */
	public int updateSch(SchVO sch);
	
//------------------------------------------------------------
	/**
	 * 하나의 장학금 삭제 기능
	 * @param condition
	 * @return
	 */
	public int deleteSch(SchVO condition);
//------------------------------------------------------------
	
	/**
	 * 장학금 선발 학생 리스트 확인
	 * @param pagination
	 * @return
	 */
	public List<SchRecVO> selectSchRecList(Pagination<SchRecVO> pagination);
//-----------------------------------------------------------------------------
	
	/**
	 * 전체 장학생리스트 목록수
	 * @param pagination
	 * @return
	 */
	public int selectRecTotalRecord(Pagination<SchRecVO> pagination);
//---------------------------------------------------------------------------------------------------
	/**
	 * 장학금 해당학생의 학과번호 
	 * @param param
	 * @return
	 */
	public String selectSchNoForDept(Map<String, String> param);
//---------------------------------------------------------------------------------------------------	
	
	/**
	 * 장학생 선정 등록
	 * @param schrec
	 * @return
	 */
	public int insertSchRec(SchRecVO schrec);
//---------------------------------------------------------------------------------------------------
	/**
	 * 장학금 선정 목록 리스트(버튼)
	 * @return
	 */
	public List<SchVO> selectSchPackList();
//---------------------------------------------------------------------------------------------------	
	
	/**
	 * 장학생 상세보기
	 * @param schRecNo
	 * @return
	 */
	public SchRecVO selectSchRec(String schRecNo);
//---------------------------------------------------------------------------------------------------	
	
		/**
		 * 장학생 상세보기
		 * @param schRecNo
		 * @return
		 */
	public List<SchRecVO> selectSchRecMemList(Pagination<SchRecVO> pagination);	
//-------------------------------------------------------------------------------------------------------
	/**
	 * 장학생 선발 수정
	 * @param schRec
	 * @return
	 */
	public int updateSchRec(SchRecVO schRec);
//-------------------------------------------------------------------------------------------------------
	/**
	 * 장학생 선발 선택 삭제
	 * @param condition
	 * @return
	 */
	public int deleteSchRec(SchRecVO condition);
//-------------------------------------------------------------------------------------------------------
}
