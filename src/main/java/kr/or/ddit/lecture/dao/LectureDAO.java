package kr.or.ddit.lecture.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.lecture.vo.LectureRoomVO;
import kr.or.ddit.lecture.vo.LectureTimePlaceVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.lecture.vo.LectureWeekPlanVO;
import kr.or.ddit.lecture.vo.ScoreCRTRVO;

@Mapper
public interface LectureDAO {
	
	/**
	 * 개설된 강의 전체 리스트 조회
	 * @param lecture (검색 조건)
	 * @return
	 */
	public List<LectureVO> selectLectureList(LectureVO lecture);
	
	/**
	 * 강의 상세 정보 조회
	 * @param lectNo
	 * @return
	 */
	public LectureVO selectLecture(String lectNo);
	
	/**
	 * 강의 등록
	 * @param lecture
	 * @return
	 */
	public int insertLecture(LectureVO lecture);
	/**
	 * 강의 주차별 계획 등록
	 * @param lectPlanList
	 * @return
	 */
	public int insertLectureWeekPlan(LectureVO lecture);
	/**
	 * 강의 시간 등록
	 * @param lectDetailList
	 * @return
	 */
	public int insertLectureTime(LectureVO lecture);
	
	/**
	 * 성적평가처리 기준 등록
	 * @param lecture
	 * @return
	 */
	public int insertLectureScoreCRTR(LectureVO lecture);
	
	/**
	 * 강의 주간일정 조회
	 * @return
	 */
	public List<LectureWeekPlanVO> selectLectureWeekPlanList();
	/**
	 * 강의 시간표 조회
	 * @return
	 */
	public List<LectureTimePlaceVO> selectLectureTimePlaceList();
	/**
	 * 강의실 리스트 조회
	 * @return
	 */
	public List<LectureRoomVO> selectLectureRoomList();
	
	/**
	 * 현재 수강 인원 증가
	 * @param lectNo
	 * @return
	 */
	public int updateLectPmPlus(String lectNo);
	/**
	 * 현재 수강 인원 감소
	 * @param lectNo
	 * @return
	 */
	public int updateLectPmMinus(String lectNo);
	
	/**
	 * 교수별 강의리스트 조회
	 * @param proNo
	 * @return
	 */
	public List<LectureVO> selectProLectureList(String proNo);
	
	/**
	 * 강의별 성적처리비율 조회
	 * @param lectNo
	 * @return
	 */
	public List<ScoreCRTRVO> selectCrtrList(String lectNo);
}
