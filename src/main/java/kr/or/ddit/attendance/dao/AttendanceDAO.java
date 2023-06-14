package kr.or.ddit.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.attendance.vo.AttendanceAdmitVO;
import kr.or.ddit.attendance.vo.AttendanceVO;
import kr.or.ddit.course.vo.CourseVO;

/**
 * 출석 DAO
 * - 23.05.11 생성
 * @author Lee Da Young
 *
 */
@Mapper
public interface AttendanceDAO {
	
	/*---------------------- 수강하는 학생들의 출석정보 통계만들기 ------------------------*/
	
	/**
	 * 강의를 수강하는 학생리스트
	 * @param lectNo
	 * @return
	 */
	public List<AttendanceVO> selectCourseStu(String lectNo);
	
	/**
	 * 학생의 등록된 출석정보 갯수
	 * @param stuNo
	 * @return
	 */
	public int countStuAttend(String stuNo);
	/**
	 * 학생의 등록된 결석정보 갯수
	 * @param stuNo
	 * @return
	 */
	public int countStuDeattend(String stuNo);
	/**
	 * 현재까지 진행된 총 수업일수 
	 * @param lectNo
	 * @return
	 */
	public int countCurrentAttend(String lectNo);
	/*---------------------------------------------------------------------------*/
	
	/*----------------------- 수강하는 학생마다의 출석정보 뽑기 -------------------------*/
	/**
	 * 수강하는 학생들의 출석정보 전체 
	 * @param lectNo
	 * @return
	 */
	public List<CourseVO> selectStuList(String lectNo);
	/*---------------------------------------------------------------------------*/
	
	/*------------------------- 교수가 학생의 출석정보 수정하기 -------------------------*/
	/**
	 * 출석 정보를 수정
	 * @param attendList
	 * @return
	 */
	public int updateAttend(AttendanceVO attend);
	/*---------------------------------------------------------------------------*/
	
	/*------------------------- 교수가 학생의 출석정보 전자출결로 입력하기 -------------------------*/
	/**
	 * 출석 정보를 입력
	 * @param attend
	 * @return
	 */
	public int insertAttend(AttendanceVO attend);
	/*---------------------------------------------------------------------------*/
		
	/*--------------------- 학생이 자신이 수강하는 강의 출석정보 조회하기-------------------*/
	/**
	 * 학생이 자신이 수강하는 강의 출석정보 조회하기
	 * @param attend
	 * @return
	 */
	public List<AttendanceVO> selectMyattendList(AttendanceVO attend);
	
	/**
	 * 강의 번호로 강의 이름을 조회
	 * @param lectNo
	 * @return
	 */
	public String selectMylectname(String lectNo);
	/*---------------------------------------------------------------------------*/
	
	/*-------------------------------- 출석인정신청 --------------------------------*/
	/**
	 * 학생의 하루 출석정보 조회
	 * @param attendNo
	 * @return
	 */
	public AttendanceVO selectMyattend(String attendNo);
	
	/**
	 * 학생의 출석인정신청
	 * @param attendAdmit
	 * @return
	 */
	public int insertMyattendAdmit(AttendanceAdmitVO attendAdmit);
	
	/**
	 * 수강번호로 강의번호 조회(페이지 이동 용)
	 * @param courseNo
	 * @return
	 */
	public String selectLectNo(String courseNo);
	/*---------------------------------------------------------------------------*/
	
	/*-----------------------------학생 한명의 출석인정신청 조회 ------------------------*/
	/**
	 * 출석인정 신청 내역을 조회
	 * @param attendAdmit
	 * @return
	 */
	public List<AttendanceAdmitVO> selectAttendAdmitList(AttendanceAdmitVO attendAdmit);
	/*---------------------------------------------------------------------------*/
	
	/*------------------------- 수강하는 학생들의 출석인정신청 조회------------------------*/
	/**
	 * 교수가 자신의 강의를 수강하는 학생들의 출석인정신청을 조회
	 * @param lectNo
	 * @return
	 */
	public List<AttendanceAdmitVO> selectAttendAdmitListAll(String lectNo);
	/**
	 * 교수가 수강하는 학생들의 출석인정 신청 결과를 수정, 반려사유 등록
	 * @param attendAdmit
	 * @return
	 */
	public int updateAttendAdmitNo(AttendanceAdmitVO attendAdmit);
	/**
	 * 교수가 수강하는 학생들의 출석인정 신청 결과를 수정
	 * @param attendAdmit
	 * @return
	 */
	public int updateAttendAdmitOK(AttendanceAdmitVO attendAdmit);
	/*---------------------------------------------------------------------------*/
}
