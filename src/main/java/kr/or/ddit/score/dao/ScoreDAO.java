package kr.or.ddit.score.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
/**
 * 	점수 DAO
 *  - 23.05.24 생성
 * @author ShinYuCheol
 *
 */

import kr.or.ddit.course.vo.CourseVO;
import kr.or.ddit.score.vo.CourseScoreDetailVO;
import kr.or.ddit.score.vo.CourseScoreVO;
@Mapper
public interface ScoreDAO {
	
	/**
	 * 강의별 학생 성적조회(중간고사,기말고사,출석,과제)
	 * @param paramScore
	 * @return
	 */
	public List<CourseScoreDetailVO> selectCourseScoreDetailList(String lectNo);
	
	
	/**
	 * 강의를 듣는 수강생 리스트
	 * @param lectNo
	 * @return
	 */
	public List<CourseVO> courseStuList(String lectNo);
	
	/**
	 * 강의별 최종 성적 등록
	 * @param courseScore
	 * @return >= 0, 성공
	 */
	public int insertCourseScore(CourseScoreVO courseScore);
	
}
