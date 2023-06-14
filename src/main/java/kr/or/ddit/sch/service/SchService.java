package kr.or.ddit.sch.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.sch.vo.SchRecVO;
import kr.or.ddit.sch.vo.SchVO;
import kr.or.ddit.vo.Pagination;

public interface SchService {
//---------------------------------------------------------------	
	/**
	 * 장학금 등록 기능 
	 * @param sch
	 */
	public ServiceResult createSch(SchVO sch);
//---------------------------------------------------------------	
	
	/**
	 * 장학금 목록을 나타내는 기능
	 * @param pagination
	 */
	public List<SchVO> retrievSchList(Pagination<SchVO> pagination);
	// void를 쓰는 이유와 안쓰는 이유??
//---------------------------------------------------------------	
	/**
	 * 장학금 상세조회 기능
	 * @param schNo
	 * @return
	 */
	public SchVO retrieveSch(String schNo);
//---------------------------------------------------------------
	
	/**
	 * 장학금 등록내용 수정 기능
	 * @param sch
	 * @return
	 */
	public ServiceResult modifySch(SchVO sch);
//---------------------------------------------------------------
	
	/**
	 * 장학금 내용 삭제
	 * @param condition
	 */
	public void removeSch(SchVO condition);
//---------------------------------------------------------------	
	
	/**
	 * 장학생 선정 리스트 조회
	 * @param pagination
	 * @return
	 */
	public List<SchRecVO> retrievSchRecList(Pagination<SchRecVO> pagination, String memRole);
//---------------------------------------------------------------
	/**
	 * 
	 * @param param
	 * @return
	 */
	public String retrieveSchNoForDept(Map<String, String> param);
//---------------------------------------------------------------	
	/**
	 * 
	 * @param schrec
	 */
	public void createSchRec(SchRecVO schrec);
//---------------------------------------------------------------	
	/**
	 * 장학생 선정 상세보기
	 * @param schRecNo
	 * @return
	 */
	public SchRecVO retrieveSchRec(String schRecNo);
	
//---------------------------------------------------------------	
	/**
	 * 장학생 선정 수정
	 * @param schRec
	 * @return
	 */
	public ServiceResult modifySchRec(SchRecVO schRec);
//---------------------------------------------------------------	
	/**
	 * 장학생 목록 삭제
	 * @param condition
	 */
	public void removeSchRec(SchRecVO condition);
}
