package kr.or.ddit.score.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.course.vo.CourseVO;
import kr.or.ddit.score.dao.ScoreDAO;
import kr.or.ddit.score.vo.CourseScoreDetailVO;
import kr.or.ddit.score.vo.CourseScoreVO;

@Service
public class ScoreServiceImpl implements ScoreService{
	
	@Inject
	private ScoreDAO scoreDAO;

	// 강의듣는 모든 학생의 성적 조회
	@Override
	public List<CourseScoreDetailVO> retrieveCourseScoreDetailList(String lectNo) {
		List<CourseScoreDetailVO> courseScoreDetailList = scoreDAO.selectCourseScoreDetailList(lectNo);
		
		return courseScoreDetailList;
	}

	@Override
	public List<CourseVO> retrieveCourseStuList(String lectNo) {
		List<CourseVO> courseStuList = scoreDAO.courseStuList(lectNo);
		return courseStuList;
	}

	@Override
	public void createCourseScore(CourseScoreVO courseScore) {
		scoreDAO.insertCourseScore(courseScore);
		
	}

	

}
