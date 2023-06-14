package kr.or.ddit.exam.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exam.vo.AnswerSubmitVO;
import kr.or.ddit.exam.vo.ExamQuestionVO;
import kr.or.ddit.exam.vo.ExamScoreVO;
import kr.or.ddit.exam.vo.ExamTextVO;
import kr.or.ddit.exam.vo.ExamVO;
/**
 * 시험 서비스 
 * 23.05.16 생성
 * @author ShinYuCheol
 *
 */
public interface ExamService {
	
	/**
	 * 강의별 시험 조회
	 * @param lectNo
	 * @return
	 */
	public List<ExamVO> retrieveExamList(String lectNo);
	
	/**
	 * 시험 상세 조회
	 * @param examNo
	 * @return
	 */
	public ExamVO retrieveExam(String examNo);
	
	/**
	 * 강의별 시험조회(제출여부도 조회)
	 * @param lectNo
	 * @return
	 */
	public List<ExamVO> retrieveExamSubList(String lectNo);
	
	/**
	 * 시험 등록
	 * @param exam
	 */
	public ServiceResult createExam(ExamVO exam);
	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	// 등록 관련(시험문제, 시험지문)
	/**
	 * 시험 문제 등록
	 * @param examQue
	 */
	public void createExamQuestion(ExamQuestionVO examQue);
	
	/**
	 * 시험별로 시험 문제 리스트
	 * @param examNo
	 * @return
	 */
	public List<ExamQuestionVO> retrieveExamQueList(String examNo);
	
	/**
	 * 시험별 문제별 지문 리스트
	 * @param list
	 * @return
	 */
	public List<ExamTextVO> retrieveExamTextList(String eqNo);

	/**
	 * 학생 입력 시험답 등록
	 * @param asVo
	 */
	public void createStuExamAnswerSubmit(AnswerSubmitVO asVo);
	
	/** 
	 * 시험별로 제출답리스트 조회
	 * @return
	 */
	public List<AnswerSubmitVO> retrieveAnswerSubmitList(String examNo);
	
	/**
	 * 시험 삭제
	 * @param condition
	 */
	public void removeExam(ExamVO condition);
	
	/**
	 * 시험 점수 등록
	 * @param examScore
	 */
	public void createExamScore(ExamScoreVO examScore);
}
