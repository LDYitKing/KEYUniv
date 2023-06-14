package kr.or.ddit.curri.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.curri.vo.CurriDetailVO;
import kr.or.ddit.curri.vo.CurriVO;
import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.subject.vo.SubjectVO;

public interface MyCurriService {

	/**
	 * 교과목 리스트 출력
	 * @return
	 */
	public List<SubjectVO> retrieveSubjectList();
	/**
	 * 커리,커리디테일 Insert
	 * @param curri
	 */
	public void createCurri(CurriVO curri);
	/**
	 * 해당 맴버의 커리 리스트 출력
	 * @param Designer
	 * @return
	 */
	public List<CurriVO> retrieveCurriList(String Designer);
	/**
	 * 선택한 커리의 커리 디테일 리스트 출력
	 * @param CuuriNo
	 * @return
	 */
	public List<CurriDetailVO> retrieveCurriDetailList(String CuuriNo);

	/**
	 * 선택한 과목의 상세정보 확인
	 * @param SubNo
	 * @param curriNo
	 * @return
	 */
	public List<SubjectVO> retrieveSubjectListOne(String SubNo,String curriNo);

	/**
	 * 커리 디테일 삭제
	 * @param curriDetail
	 * @return
	 */
	public int removeCurriDetail(CurriDetailVO curriDetailVO);

	/**
	 * 커리 삭제
	 * @param curriVO
	 * @return
	 */
	public int removeCurri(CurriVO curriVO);
	/**
	 * 커리 디테일 수정
	 * @param curriDetailVO
	 */
	public int modifyCurriDetail(CurriDetailVO curriDetailVO);

	/**
	 * 커리 디테일 선택
	 * @param params
	 * @return
	 */
	public List<CurriDetailVO> retrieveCurriDetail(Map<String, String> params);

	/**
	 * 즐겨찾기 리스트 출력
	 * @return
	 */
	public List<FavoriteVO> retrieveFavoriteList(String Designer);

}
