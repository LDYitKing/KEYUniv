package kr.or.ddit.favorites.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.vo.Pagination;

/**
 * 즐겨찾기
 * 학생은 교과목을 즐겨찾기 할 수 있다.
 * @author Kim Eui Yeon
 *
 */
@Mapper
public interface FavoriteDAO {

	/**
	 * 즐겨찾기 리스트 조회
	 * @param memNo
	 * @return
	 */
	public List<FavoriteVO> selectFavorites(String memNo);
	
	/**
	 * 즐겨찾기 추가
	 * @param favorite
	 * @return
	 */
	public int insertFavorite(FavoriteVO favorite);
	/**
	 * 즐겨찾기 삭제
	 * @param favorite
	 * @return
	 */
	public int deleteFavorite(FavoriteVO favorite);
	/**
	 * 이건 교과목 삭제 또는 수정시 모든 구성원 즐겨찾기 삭제
	 * @param favorite
	 * @return
	 */
	public int deleteSubjectFavorite(FavoriteVO favorite); 
	
	/**
	 * 학과 교수 추천리스트 관련 교수 목록 가져오기.
	 * @param deptNo
	 * @return
	 */
	public List<FavoriteVO> selectSuggestions(String deptNo);
	
	public List<FavoriteVO> subjectsIHaveTaken(String memNo);
	public List<FavoriteVO> imsiLect(String memNo);
}
