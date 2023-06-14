package kr.or.ddit.curri.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.curri.vo.CurriDetailVO;
import kr.or.ddit.curri.vo.CurriVO;
import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.subject.vo.SubjectVO;

@Mapper
public interface MyCurriDAO {
	/**
	 *  나의 커리 저장
	 * @param curri
	 * @return
	 */
	public int insertMyCurri(CurriVO curri);
	/**
	 * 나의 커리 리스트의 디테일 커리 저장
	 * @param curriDetail
	 * @return
	 */
	public int insertCurriDetail(CurriDetailVO curriDetail);
	/**
	 * 선택한 맴버의 커리리스트 출력
	 * @param designer
	 * @return
	 */
	public List<CurriVO> selectMemCurri(String designer);
	/**
	 *  교과목 목록 띄우기
	 * @return
	 */
	public List<SubjectVO>subjectList();
	/**
	 * 커리 클릭시 화면에 저장한 커리 디테일 출력
	 * @param curriNo
	 * @return
	 */
	public List<CurriDetailVO> curriDetailList(String curriNo);
	/**
	 * 커리 디테일 클릭시 교과목 상세 정보 출력
	 * @param subNo
	 * @return
	 */
	public List<SubjectVO> selectsubjectList(Map<String, String> params);
	/**
	 * 커리 디테일 삭제
	 * @param curridetail
	 * @return
	 */
	public int deleteCurriDetail(CurriDetailVO curriDetailVO);
	/**
	 * 커리 삭제
	 * @param curriVO
	 * @return
	 */
	public int deleteCurri(CurriVO curriVO);
	/**
	 * 커리 디테일 수정
	 * @param curriDetailVO
	 * @return
	 */
	public int updateCurriDetail(CurriDetailVO curriDetailVO);
	/**
	 * 선택된 td의 값을 선택해서 따로 저장하는 용도
	 * @param subNo
	 * @return
	 */
	public List<CurriDetailVO> selectCurriTd(Map<String, String> params);

	/**
	 * 즐겨찾기 리스트 출력~!
	 * @param favoriteVO
	 * @return
	 */
	public List<FavoriteVO> selectFavoriteList(String designer);

}
