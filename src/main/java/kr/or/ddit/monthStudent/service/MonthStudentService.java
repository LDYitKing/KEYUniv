package kr.or.ddit.monthStudent.service;

import kr.or.ddit.monthStudent.vo.MonthStudentVO;

public interface MonthStudentService {
	
	/**
	 * 이달의 선배를 등록하는 기능
	 * @param monthstudent
	 */
	public void createMonthStudent(MonthStudentVO monthstudent);
}
