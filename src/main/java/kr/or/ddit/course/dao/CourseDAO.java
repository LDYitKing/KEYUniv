package kr.or.ddit.course.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.course.vo.CourseVO;

/**
 * 수강 DAO
 *  - 23.05.12 생성
 * @author ShinYuCheol
 *
 */
@Mapper
public interface CourseDAO {
	/**
	 * 학생의 수강신청 내역 조회
	 * @param course
	 * @return
	 */
	public List<CourseVO> selectCourseList(CourseVO course);

	/**
	 * 수강신청 취소
	 * @param courseNo
	 * @return
	 */
	public int deleteCourse(String courseNo);
	
	/**
	 * 수강신청
	 * @param course
	 * @return
	 */
	public int insertCourse(CourseVO course);
	
	/**
	 * 현재 수강중인 강의 총 학점
	 * @param stuNo
	 * @return
	 */
	public int countScr(String stuNo);
	
}
