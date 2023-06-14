package kr.or.ddit.subject.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.PKNotFoundException;
import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.subject.vo.SubjectVO;
import kr.or.ddit.vo.Pagination;

public interface SubjectService {
	/**
	 * 교과목 조회
	 * @return
	 */
	public List<SubjectVO> retrieveSubjectList();
	/**
	 * 교과목 상세조회
	 * @param subNo
	 * @return
	 * @throws PKNotFoundException
	 */
	public SubjectVO retrieveSubject(String subNo) throws PKNotFoundException;
	/**
	 * 교과목 등록
	 * @param subject
	 * @return
	 */
	public ServiceResult createSubject(SubjectVO subject);
	/**
	 * 교과목 수정
	 * @param subject
	 * @return
	 * @throws PKNotFoundException
	 */
	public ServiceResult modifySubject(SubjectVO subject) throws PKNotFoundException;
	/**
	 * 삭제
	 * @param subNo
	 * @return
	 * @throws PKNotFoundException
	 */
	public ServiceResult removeSubject(String subNo) throws PKNotFoundException;
	
	public Integer subjectProcess(SubjectVO subject);
	
	/**
	 * 내 즐겨찾기 교과목 관련 개설강의 목록
	 * @param memNo
	 * @return
	 */
	public List<SubjectVO> retrieveLectureWithFavorites(String memNo);
	/**
	 * 직업별리스트
	 * @return
	 */
	public List<FavoriteVO> retrieveJobSubjectList(); 
}
