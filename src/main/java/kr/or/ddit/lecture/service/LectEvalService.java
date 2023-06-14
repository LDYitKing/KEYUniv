package kr.or.ddit.lecture.service;

import kr.or.ddit.lecture.vo.LectureEvaluationVO;

public interface LectEvalService {
	/**
	 * 강의 평가 등록
	 * @param lectEval
	 * @return
	 */
	public int createLectEval(LectureEvaluationVO lectEval);
}
