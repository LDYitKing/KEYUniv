package kr.or.ddit.attendance.service;

import java.util.List;

import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.attendance.vo.AttendanceAdmitVO;
import kr.or.ddit.attendance.vo.AttendanceVO;
import kr.or.ddit.course.vo.CourseVO;

public interface AttendanceService {
	
	/**
	 * 강의를 수강하는 학생들의 정보와 학생들의 출석정보
	 * @param lectNo
	 * @return
	 */
	public List<AttendanceVO> retrieveStaticsAttendList(String lectNo);

	/**
	 * 수강하는 학생들의 출석인정신청 정보 조회
	 * @param lectNo
	 * @return
	 */
	public List<AttendanceAdmitVO> retrieveAttendAdmitListAll(String lectNo);
	
	/**
	 * 강의를 수강하는 학생들의 모든 정보
	 * @param lectNo
	 * @return
	 */
	public List<CourseVO> retrieveStuList(String lectNo);
	
	/**
	 * 여러 출석정보를 한번에 수정
	 * @param updateMap
	 * @return
	 */
	public int modifyAttend(List<AttendanceVO> attendList);
	
	/**
	 * 여러 출석정보를 한번에 입력
	 * @param attendList
	 * @return
	 */
	public int createAttend(List<AttendanceVO> attendList);
	
	/**
	 * 학생이 자신이 수강하는 강의 출석정보 조회하기
	 * @param attend
	 * @return
	 */
	public List<AttendanceVO> retrieveMyattendList(AttendanceVO attend);
	
	/**
	 * 출석인정신청시, 해당 출석정보 조회
	 * @param attendNo
	 * @return
	 */
	public AttendanceVO retrieveMyattend(String attendNo);
	/**
	 * 출석인정신청
	 * @param attendAdmit
	 * @return
	 */
	public int createdMyattendAdmit(AttendanceAdmitVO attendAdmit);
	/**
	 * 출석인정신청 조회
	 * @param attendAdmit
	 * @return
	 */
	public List<AttendanceAdmitVO> retrieveAttendAdmitList(AttendanceAdmitVO attendAdmit);
	public AttatchFileVO download(AttatchFileVO condition); // 파일 다운로드
	
	/**
	 * 출석인정신청 결과 수정 및 반려 사유 등록
	 * @param attendAdmit
	 * @return
	 */
	public int modifyAttendAdmit(AttendanceAdmitVO attendAdmit);
	
}
