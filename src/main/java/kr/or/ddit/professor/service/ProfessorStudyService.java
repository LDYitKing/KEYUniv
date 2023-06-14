package kr.or.ddit.professor.service;

import java.util.List;

import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.professor.vo.StudyVO;
import kr.or.ddit.vo.Pagination;

/**
 * 교수 연구 서비스
 * 23.05.03 생성
 * @author Kim Eui Yeon
 *
 */
public interface ProfessorStudyService {
	/**
	 * 연구 등록
	 * @param study
	 */
	public int createStudy(StudyVO study);
	/**
	 * 전체 연구 리스트 조회 (페이징)
	 */
	public List<StudyVO> retrieveStudyList();
	/**
	 * 연구 상세 조회
	 * @param studyNo
	 * @return
	 */
	public StudyVO retrieveStudy(String studyNo);
	/**
	 * 연구 수정
	 * @param study
	 */
	public int modifyStudy(StudyVO study);
	/**
	 * 연구 삭제
	 * @param condition
	 */
	public int removeStudy(StudyVO condition);
	/**
	 * 파일 다운로드
	 * @param condition
	 * @return
	 */
	public AttatchFileVO download(AttatchFileVO condition);


}
