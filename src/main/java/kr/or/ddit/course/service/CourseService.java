package kr.or.ddit.course.service;

import java.util.List;

import kr.or.ddit.course.vo.CourseVO;
import kr.or.ddit.enumpkg.ServiceResult;

public interface CourseService {
	/**
	 * 학생의 수강신청 내역 조회
	 * @param course
	 * @return
	 */
	public List<CourseVO> retrieveCourseList(CourseVO course);
	
	/**
	 * 수강신청 취소
	 * @param course (수강 테이블 수강신청 삭제, 강의 테이블 현재인원 수정) 
	 * @return
	 */
	public int removeCourse(CourseVO course);

	/**
	 * 수강신청
	 * @param course
	 * @return
	 */
	public ServiceResult createCourse(CourseVO course);

}
