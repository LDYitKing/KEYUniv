package kr.or.ddit.subject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.professor.vo.ProfessorVO;
import kr.or.ddit.subject.vo.SubjectVO;
import kr.or.ddit.vo.Pagination;

/**
 * 교과목 관리
 * @author Kim Eui Yeon
 *
 */
@Mapper
public interface SubjectDAO {
	//교수-----------------------------------------------------------------
	/**
	 * 교과목 등록 요청
	 * @param subject
	 * @return  > 0 , 성공
	 */
	public int insertSubject(SubjectVO subject);
	

	/**
	 * 교과목 리스트 조회(완료)
	 * @return
	 */
	public List<SubjectVO> selectSubjectList();

	/**
	 * 교과목 상세 조회
	 * @param subNo
	 * @return 존재 X , null 반환
	 */
	public SubjectVO selectSubject(String subNo);
	/**
	 * 교과목 수정
	 * @param subject
	 * @return > 0 , 성공
	 */
	public int updateSubject(SubjectVO subject);
	
	/**
	 * 교과목 삭제(상태변경 업데이트)
	 * @param subNo
	 * @return >0 , 성공
	 */
	public int deleteSubject(String subNo);
	
	/**
	 * 임시 교수 정보 가져오기.
	 * @param proNo
	 * @return 교수정보
	 */
	public ProfessorVO temporaryProfessor(String proNo);
	
	/**
	 * 교과목 요청 전체 승인.
	 * @return 승인된 교과목 수.
	 */
	public int subjectOKAll();
	
	public int subjectProcess(SubjectVO subject);
	
	/**
	 * 내 즐겨찾기 교과목 관련 개설강의 목록
	 * @param memNo
	 * @return
	 */
	public List<SubjectVO> selectLectureWithFavorites(String memNo);
	
	/**
	 * 직업별 교과목 목록
	 * @return
	 */
	public List<FavoriteVO> selectJobList();
	
	/**
	 * 내가 들었던, 듣고있는 수강 교과목 리스트
	 * @param stuNo
	 * @return
	 */
	public List<FavoriteVO> myListenSub(String stuNo);
	
	
}
