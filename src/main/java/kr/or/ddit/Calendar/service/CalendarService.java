package kr.or.ddit.Calendar.service;

import java.util.List;

import kr.or.ddit.Calendar.vo.CalendarVO;

public interface CalendarService {

	public List<CalendarVO> selectCalendar(String MemNo) ;//리스트 보는 인터페이스!!
	public int createCalendar(CalendarVO calendarVO); // 캘린더에 일정 등록!!
	public Object modifyCalendar(CalendarVO calendarVO); //캘린더 드래그앤 드롭 일정 수정!!
	public CalendarVO retrieveCalendar(int id); //캘린더 일정 확인!!
	public Object modifyretrieveCalendar(CalendarVO calendarVO); // 캘린더 선택한 일정 수정하기
	public int removeCalendar(CalendarVO calendarVO); //캘린더 삭제!!!!
	public List<CalendarVO> selectacademicCalendar(String MemNo); //학사 일정 띄우깅
}
