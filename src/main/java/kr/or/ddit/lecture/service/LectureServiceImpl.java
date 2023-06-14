package kr.or.ddit.lecture.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.academicyear.dao.AcademicYearDAO;
import kr.or.ddit.lecture.dao.LectureDAO;
import kr.or.ddit.lecture.vo.LectureRoomVO;
import kr.or.ddit.lecture.vo.LectureTimePlaceVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.lecture.vo.LectureWeekPlanVO;
import kr.or.ddit.lecture.vo.ScoreCRTRVO;

@Service
public class LectureServiceImpl implements LectureService {

	@Inject
	private LectureDAO lectDAO;
	@Inject
	private AcademicYearDAO academicYearDAO;
	
	@Override
	public List<LectureVO> retrieveLectureList(LectureVO lecture) {
		
		// 수정해야 함.
		lecture.setAyYear(academicYearDAO.selectNowAcademicYear().getAyYear());
		lecture.setAySemester(academicYearDAO.selectNowAcademicYear().getAySemester());
		
		List<LectureVO> lectList = lectDAO.selectLectureList(lecture);
		lectList.stream().forEach(vo->vo.setSignup(false));
		return lectList;
	}

	@Override
	public LectureVO retrieveLecture(String lectNo) {
		
		LectureVO lect = lectDAO.selectLecture(lectNo);
		
		if(lect==null) throw new RuntimeException();
		return lect;
	}

	@Override
	public int createLecture(LectureVO lecture) {
		lecture.setAyYear(academicYearDAO.selectNowAcademicYear().getAyYear());
		lecture.setAySemester(academicYearDAO.selectNowAcademicYear().getAySemester());
		
		int cnt = 0;
		cnt += lectDAO.insertLecture(lecture);
		
		String lectNo = lecture.getLectNo();
		
		for(int i =0; i< lecture.getLectDetailList().size(); i++) {
			lecture.getLectDetailList().get(i).setLectNo(lectNo);
		}
		
		for(int i =0; i< lecture.getLectPlanList().size(); i++) {
			lecture.getLectPlanList().get(i).setLectNo(lectNo);
		}
		
		for(int i =0; i< lecture.getScoreCRTRList().size(); i++) {
			lecture.getScoreCRTRList().get(i).setLectNo(lectNo);
		}
		cnt += lectDAO.insertLectureTime(lecture);
		cnt += lectDAO.insertLectureWeekPlan(lecture);
		cnt += lectDAO.insertLectureScoreCRTR(lecture);
		return cnt;
	}


	@Override
	public List<LectureWeekPlanVO> retrieveLectureWeekPlanList() {
		return lectDAO.selectLectureWeekPlanList();
	}

	@Override
	public List<LectureTimePlaceVO> retrieveLectureTimePlaceList() {
		return lectDAO.selectLectureTimePlaceList();
	}

	@Override
	public List<LectureRoomVO> retrieveLectureRoomList() {
		return lectDAO.selectLectureRoomList();
	}
	
	// 교수별 강의리스트 조회
	@Override
	public List<LectureVO> retrieveProLectureList(String proNo) {
		return lectDAO.selectProLectureList(proNo);
	}

	@Override
	public List<ScoreCRTRVO> retrieveCrtrList(String lectNo) {
		return lectDAO.selectCrtrList(lectNo);
	}
}
