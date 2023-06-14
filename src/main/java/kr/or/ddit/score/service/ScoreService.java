package kr.or.ddit.score.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.course.vo.CourseVO;
import kr.or.ddit.score.vo.CourseScoreDetailVO;
import kr.or.ddit.score.vo.CourseScoreVO;

/**
 * 점수 서비스
 * @author ShinYuCheol
 *
 */
public interface ScoreService {
	
	/**
	 * 강의별 학생 성적조회(중간고사,기말고사,출석,과제)
	 * @param paramScore
	 * @return
	 */
	public List<CourseScoreDetailVO> retrieveCourseScoreDetailList(String lectNo);
	
	/**
	 * 강의를 듣는 수강생 리스트
	 * @param lectNo
	 * @return
	 */
	public List<CourseVO> retrieveCourseStuList(String lectNo);

	/**
	 * 강의별 최종성적 등록
	 * @param courseScore
	 */
	public void createCourseScore(CourseScoreVO courseScore);
}
