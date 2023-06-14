package kr.or.ddit.Calendar.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.Calendar.vo.CalendarVO;

@Mapper
public interface CalendarDAO {
	/**
	 * 캘린더 일정 등록하기!!
	 * @param calendarVO
	 * @return
	 */
	public int insertCalendar(CalendarVO calendarVO);

	/**
	 * 캘린더 일정 드래그앤 드롭 수정하깅!!!
	 * @param calendarVO
	 * @return
	 */
	public int updateCalendar(CalendarVO calendarVO);

	/**
	 * 상세보깅
	 * @param id
	 * @return
	 */
	public CalendarVO selectCalendar(int id);
	/**
	 * 선택한 일정 수정
	 * @param calendarVO
	 * @return
	 */
	public int updateSelectCalendar(CalendarVO calendarVO);

	/**
	 * 일정 삭젱
	 * @param calendarVO
	 * @return
	 */
	public int deleteCalendar(CalendarVO calendarVO);

	/**
	 *개인 캘린더 띄우깅
	 * @param memNo
	 * @return
	 */
	public List<CalendarVO> selectMemCalendar(String memNo);

	/**
	 * 학사일정 캘린더 띄위깅
	 * @param memNo
	 * @return
	 */
	public List<CalendarVO> selectacademicCalendar(String memNo);
}
