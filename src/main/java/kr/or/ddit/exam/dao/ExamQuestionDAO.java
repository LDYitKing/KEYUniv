package kr.or.ddit.exam.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.exam.vo.ExamQuestionVO;

/**
 * 시험 문제 등록
 * 2023.05.17 생성
 * @author ShinYuCheol
 *
 */
@Mapper
public interface ExamQuestionDAO {
	
	/**
	 * 시험 문제 등록
	 * @param examQue
	 * @return > 0, 성공
	 */
	public int insertExamQuestion(ExamQuestionVO examQue);
	

}
