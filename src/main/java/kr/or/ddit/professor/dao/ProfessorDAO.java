package kr.or.ddit.professor.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.professor.vo.ProfessorVO;
import kr.or.ddit.professor.vo.StudyVO;
import kr.or.ddit.vo.Pagination;

/**
 * 교수 DAO
 * - 23.05.03 생성
 * @author Kim Eui Yeon
 *
 */
@Mapper
public interface ProfessorDAO {
	//--------------교수 연구 관리 시작--------------------------
	/**
	 * 연구를 등록하는 기능
	 * @param study
	 * @return >=0, 성공
	 */
	public int insertStudy(StudyVO study);
	/**
	 * 연구를 수정하는 기능
	 * @param study
	 * @return >=0, 성공
	 */
	public int updateStudy(StudyVO study); 
	/**
	 * 연구를 삭제하는 기능
	 * @param condition
	 * @return >=0, 성공
	 */
	public int deleteStudy(StudyVO condition); 
	/**
	 * 연구 목록 전체 조회
	 * @return
	 */
	public List<StudyVO> selectStudyList(); 
	
	/**
	 * 페이징 처리를 위한 전체 레코드 수 조회
	 * @param pagination
	 * @return
	 */
//	public int selectTotalRecord(Pagination<StudyVO> pagination);
	
	/**
	 * 연구 상세 조회
	 * @param studyNo
	 * @return 존재하지 않는 경우, null 반환
	 */
	public StudyVO selectStudy(String studyNo); 
	
	//--------------교수 연구 관리 끝--------------------------
	
	/**
	 * 교수 전체 리스트 조회 (검색 기능)
	 * @param professor 검색 조건 넣은 vo
	 * @return
	 */
	public List<ProfessorVO> selectProfessorList(ProfessorVO professor);
	
	/**
	 * 교수 상세 조회
	 * @param memNo 교수 사번으로 조회
	 * @return
	 */
	public ProfessorVO selectProfessor(String memNo);

}
