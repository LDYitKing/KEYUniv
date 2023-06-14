package kr.or.ddit.lecture.service;

import java.util.List;

import kr.or.ddit.lecture.vo.LectureRoomVO;
import kr.or.ddit.lecture.vo.LectureTimePlaceVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.lecture.vo.LectureWeekPlanVO;
import kr.or.ddit.lecture.vo.ScoreCRTRVO;

public interface LectureService {
	/**
	 * 개설된 강의 전체 리스트 조회
	 * @param lecture (검색 조건)
	 * @return
	 */
	public List<LectureVO> retrieveLectureList(LectureVO lecture);
	
	/**
	 * 강의 상세 정보 조회
	 * @param lectNo
	 * @return
	 */
	public LectureVO retrieveLecture(String lectNo);
	/**
	 * 강의 등록
	 * @param lecture
	 * @return
	 */
	public int createLecture(LectureVO lecture);

	/**
	 * 강의 주간일정 조회
	 * @return
	 */
	public List<LectureWeekPlanVO> retrieveLectureWeekPlanList();
	/**
	 * 강의 시간표 조회
	 * @return
	 */
	public List<LectureTimePlaceVO> retrieveLectureTimePlaceList();
	/**
	 * 강의실 리스트 조회
	 * @return
	 */
	public List<LectureRoomVO> retrieveLectureRoomList();
	
	/**
	 * 교수별 강의리스트 조회
	 * @param proNo
	 * @return
	 */
	public List<LectureVO> retrieveProLectureList(String proNo);
	
	/**
	 * 강의별 성적처리비율 조회
	 * @param lectNo
	 * @return
	 */
	public List<ScoreCRTRVO> retrieveCrtrList(String lectNo);
	
}
