package kr.or.ddit.monthStudent.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.monthStudent.vo.MonthStudentVO;
import kr.or.ddit.univBoard.vo.UnivBoardVO;
import kr.or.ddit.vo.Pagination;

@Mapper
public interface MonthStudentDAO {
	
	/**
	 * 이달의 선배 등록
	 * @param monthstudent
	 * @return
	 */
	public int insertMonthStudent(MonthStudentVO monthstudent);
	
	
	
}
