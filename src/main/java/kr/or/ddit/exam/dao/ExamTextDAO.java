package kr.or.ddit.exam.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.exam.vo.ExamQuestionVO;
import kr.or.ddit.exam.vo.ExamTextVO;

/**
 * 시험 지문
 * 2023.05.17 생성
 * @author ShinYuCheol
 *
 */
@Mapper
public interface ExamTextDAO {
	
	/**
	 * 시험 지문 등록
	 * @param examText
	 * @return > 0, 성공
	 */
	public int insertExamText(ExamQuestionVO examQue);
}
