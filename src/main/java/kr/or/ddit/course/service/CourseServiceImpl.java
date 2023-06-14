package kr.or.ddit.course.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.course.dao.CourseDAO;
import kr.or.ddit.course.vo.CourseVO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.lecture.dao.LectureDAO;
import kr.or.ddit.lecture.vo.LectureVO;

@Service
public class CourseServiceImpl implements CourseService{

	@Inject
	private CourseDAO courseDAO;
	
	@Inject
	private LectureDAO lectureDAO;
	
	@Override
	public List<CourseVO> retrieveCourseList(CourseVO course) {
		// 수정하기 (학기년도)
		course.setAyYear(2023);
		course.setAySemester(1);
		
		List<CourseVO> courseList = courseDAO.selectCourseList(course);
		courseList.stream().forEach(vo->vo.getLecture().setSignup(true));
		return courseList;
	}

	
	@Override
	public int removeCourse(CourseVO course) {
		// 수강신청 삭제
		int cnt = courseDAO.deleteCourse(course.getCourseNo());
		// 강의 현재인원 수정
		lectureDAO.updateLectPmMinus(course.getLectNo());
		return cnt;
	}


	@Override
	public ServiceResult createCourse(CourseVO course) {
		ServiceResult sr = null;
		
		// 정원 체크
		// 정원이 가득 찼으면 수강신청 안됨.
		LectureVO lect = lectureDAO.selectLecture(course.getLectNo());
		if(lect.getLectPm()>=lect.getLectMm()) {
			sr = ServiceResult.MAXMEMBER;

		}else {
			// 수강 신청
			int cnt = courseDAO.insertCourse(course);
			if(cnt > 0) {
				// 강의 현재인원 수정
				lectureDAO.updateLectPmPlus(course.getLectNo());
				sr = ServiceResult.OK;
			}else {
				sr = ServiceResult.FAIL;
			}
		}
		
		return sr;
	}


}
