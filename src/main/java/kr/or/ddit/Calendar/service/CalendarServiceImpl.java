package kr.or.ddit.Calendar.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.Calendar.dao.CalendarDAO;
import kr.or.ddit.Calendar.vo.CalendarVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CalendarServiceImpl implements CalendarService {
	@Inject
	private CalendarDAO calendarDAO;

	@Override
	public List<CalendarVO> selectCalendar(String memNo) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberVOWrapper memberwrapper = (MemberVOWrapper) authentication.getPrincipal();

		if (!StringUtils.equalsIgnoreCase(memNo, "admin")) {
			MemberVO realUser = memberwrapper.getRealUser();
			memNo = realUser.getMemNo();
		}

		List<CalendarVO> calendarVOList = calendarDAO.selectMemCalendar(memNo);
		return calendarVOList;
	}

	@Override
	public int createCalendar(CalendarVO calendarVO) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberVOWrapper memberwrapper = (MemberVOWrapper) authentication.getPrincipal();
		MemberVO realUser = memberwrapper.getRealUser();
		calendarVO.setMemNo(realUser.getMemNo());
		return calendarDAO.insertCalendar(calendarVO);
	}

	@Override
	public Object modifyCalendar(CalendarVO calendarVO) {
		return calendarDAO.updateCalendar(calendarVO);
	}

	@Override
	public CalendarVO retrieveCalendar(int id) {
		CalendarVO calendarVO = calendarDAO.selectCalendar(id);
		return calendarVO;
	}

	@Override
	public Object modifyretrieveCalendar(CalendarVO calendarVO) {
		return calendarDAO.updateSelectCalendar(calendarVO);
	}

	@Override
	public int removeCalendar(CalendarVO calendarVO) {
		return calendarDAO.deleteCalendar(calendarVO);

	}

	@Override
	public List<CalendarVO> selectacademicCalendar(String MemNo) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberVOWrapper memberwrapper = (MemberVOWrapper) authentication.getPrincipal();
		MemberVO realUser = memberwrapper.getRealUser();
		MemNo = realUser.getMemNo();
		List<CalendarVO> calendarVOList = calendarDAO.selectMemCalendar(MemNo);
		return calendarVOList;
	}

}
