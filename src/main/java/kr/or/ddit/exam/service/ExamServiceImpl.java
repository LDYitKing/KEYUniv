package kr.or.ddit.exam.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exam.dao.ExamDAO;
import kr.or.ddit.exam.dao.ExamQuestionDAO;
import kr.or.ddit.exam.dao.ExamTextDAO;
import kr.or.ddit.exam.vo.AnswerSubmitVO;
import kr.or.ddit.exam.vo.ExamQuestionVO;
import kr.or.ddit.exam.vo.ExamScoreVO;
import kr.or.ddit.exam.vo.ExamTextVO;
import kr.or.ddit.exam.vo.ExamVO;
import kr.or.ddit.member.vo.MemberVOWrapper;

@Service
public class ExamServiceImpl implements ExamService{
	
	@Inject
	private ExamDAO examDAO;
	
	@Inject
	private ExamQuestionDAO examQuestionDAO;
	
	@Inject
	private ExamTextDAO examTextDAO;

	// 시험 목록
	@Override
	public List<ExamVO> retrieveExamList(String lectNo) {
		List<ExamVO> examList = examDAO.selectExamList(lectNo);
		return examList;
	}

	// 시험 상세 조회
	@Override
	public ExamVO retrieveExam(String examNo) {
		ExamVO exam = examDAO.selectExam(examNo);
		if(exam == null) throw new RuntimeException();
		return exam;
	}
	
	// 시험 등록
	@Override
	public ServiceResult createExam(ExamVO exam) {
		int result =examDAO.insertExam(exam);
		return result >0? ServiceResult.OK : ServiceResult.FAIL;
		
	}
	
	// 시험 문제, 지문 등록
	@Override
	public void createExamQuestion(ExamQuestionVO examQue) { 
		examQuestionDAO.insertExamQuestion(examQue);
		examQue.getEqNo();
		examQue.getExamTextList();
		
		examTextDAO.insertExamText(examQue);
		
	}
	// 강의별 시험조회(제출여부도 조회)
	@Override
	public List<ExamVO> retrieveExamSubList(String lectNo) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		String stuNo = memVO.getRealUser().getMemNo();
		
		Map<String, String> paramExam = new HashMap<>();
		paramExam.put("lectNo", lectNo);
		paramExam.put("stuNo", stuNo);
		
		// 시험정보 리스트 조회 -> 리턴할 강의당 시험 조회결과
		List<ExamVO> examList = examDAO.selectExamSubList(paramExam);
		return examList;
	}

	// 시험별로 시험 문제 리스트 조회
	@Override
	public List<ExamQuestionVO> retrieveExamQueList(String examNo) {
		List<ExamQuestionVO> examQueList = examDAO.selectExamQueList(examNo);
		return examQueList;
	}
	
	// 시험별 문제별 지문 리스트
	@Override
	public List<ExamTextVO> retrieveExamTextList(String eqNo) {
		List<ExamTextVO> examTextList = examDAO.selectExamTextList(eqNo);
		return examTextList;
	}

	// 학생 입력 시험답 등록
	@Override
	public void createStuExamAnswerSubmit(AnswerSubmitVO asVo) {
		examDAO.insertStuExamAnswerSubmit(asVo);
		
	}
	
	// 시험별로 제출답 리스트
	@Override
	public List<AnswerSubmitVO> retrieveAnswerSubmitList(String examNo) {
		List<AnswerSubmitVO> answerSubmitList =  examDAO.selectAnswerSubmitList(examNo);
		return answerSubmitList;
	}

	// 시험 삭제
	@Override
	public void removeExam(ExamVO condition) {
		int rowcnt = examDAO.deleteExam(condition);
		
	}

	// 시험 점수 등록
	@Override
	public void createExamScore(ExamScoreVO examScore) {
		examDAO.insertExamScore(examScore);
	}

	




}
