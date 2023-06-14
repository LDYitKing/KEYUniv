package kr.or.ddit.professor.service;

import java.util.List;

import kr.or.ddit.professor.vo.ProfessorVO;

public interface ProfessorService {
	/**
	 * 교수 전체 리스트 조회 (검색 기능)
	 * @param professor 검색 조건 넣은 vo
	 * @return
	 */
	public List<ProfessorVO> retrieveProfessorList(ProfessorVO professor);
	
	/**
	 * 교수 상세 조회
	 * @param memNo 교수 사번으로 조회
	 * @return
	 */
	public ProfessorVO retrieveProfessor(String memNo);
	
	
}
