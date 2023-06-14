package kr.or.ddit.lecture.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.lecture.vo.LectEvalArtiVO;
import kr.or.ddit.lecture.vo.LectureEvaluationVO;

@Mapper
public interface LectEvalDAO {
	
	/**
	 * 강의, 수강정보 조회
	 * @param lectEval
	 * @return
	 */
	public LectureEvaluationVO selectCourse(LectureEvaluationVO lectEval);
	
	/**
	 * 강의 평가 항목을 조회
	 * @return
	 */
	public List<LectEvalArtiVO> selectLectEvalArtiList();
	
	/**
	 * 한번에 한 강의평가 모두 입력
	 * @param lectEval
	 * @return
	 */
	public int insertLectEval(LectureEvaluationVO lectEval);
	
	/**
	 * 강의에 대한 학생의 평가가 있는지 조회
	 * @param lectEval
	 * @return
	 */
	public List<LectureEvaluationVO> selectLectEvalList(String courseNo);
	
	/**
	 * 각 강의별 각 항목의 평균 구하기
	 * @return
	 */
	public List<LectEvalArtiVO> selectAVGEval(String lectNo);
	
	/**
	 * 각 강의별 7번 항목 평가 리스트
	 * @param lectNo
	 * @return
	 */
	public List<String> selectSevenEval(String lectNo);
}
