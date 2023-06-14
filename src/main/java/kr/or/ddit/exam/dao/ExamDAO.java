package kr.or.ddit.exam.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.exam.vo.AnswerSubmitVO;
import kr.or.ddit.exam.vo.ExamQuestionVO;
import kr.or.ddit.exam.vo.ExamScoreVO;
import kr.or.ddit.exam.vo.ExamTextVO;
import kr.or.ddit.exam.vo.ExamVO;

/**
 * 시험 DAO
 * 2023.05.16 생성
 * @author ShinYuCheol
 *
 */
@Mapper
public interface ExamDAO {
	/**
	 * 강의별 시험 조회
	 * @param lectNo
	 * @return
	 */
	public List<ExamVO> selectExamList(String lectNo);
	
	/**
	 * 시험 상세보기
	 * @param examNo
	 * @return
	 */
	public ExamVO selectExam(String examNo);
	/**	 
	 * 강의별 시험조회(제출여부도 조회)
	 * @param paramExam
	 * @return
	 */
	public List<ExamVO> selectExamSubList(Map<String, String> paramExam);
	
	/**
	 * 시험 등록
	 * @param exam
	 * @return >= 0, 성공
	 */
	public int insertExam(ExamVO exam);
	
	/**
	 * 시험별로 시험 문제 리스트
	 * @param examNo
	 * @return
	 */
	public List<ExamQuestionVO> selectExamQueList(String examNo);
	
	/**
	 * 시험별 문제별 지문 리스트
	 * @return
	 */
	public List<ExamTextVO> selectExamTextList(String eqNo);
	
	/**
	 * 학생 입력 시험답 등록
	 * @param asVo
	 * @return
	 */
	public int insertStuExamAnswerSubmit(AnswerSubmitVO asVo);
	
	/**
	 * 시험별 제출답리스트 조회
	 * @return
	 */
	public List<AnswerSubmitVO> selectAnswerSubmitList(String examNo);

	/**
	 * 하나의 시험 삭제 
	 * @param condition
	 * @return
	 */
	public int deleteExam(ExamVO exam);
	
	/**
	 * 시험 점수 등록
	 * @param examScore
	 * @return
	 */
	public int insertExamScore(ExamScoreVO examScore);
}
