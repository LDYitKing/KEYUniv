package kr.or.ddit.Calendar.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.Calendar.service.CalendarService;
import kr.or.ddit.Calendar.vo.CalendarVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CalendarController {

    @Inject
    private CalendarService service;

    @GetMapping(value = "/calendar")
	public String calView() {
	//	List<CalendarVO> calendarList = service.selectCalendar();
	//	model.addAttribute("calendar", calendarList);

		return "calendar/calendar";
	}

    @GetMapping(value = "/calevents",produces = "application/json;charset=utf-8")
    @ResponseBody
	public List<Map<String, String>> calEvent(String memNo) {
	    List<CalendarVO> calendarList = service.selectCalendar(memNo);
	    List<Map<String, String>> calList = new ArrayList<Map<String,String>>();
	    Map<String, String> calEvent;
	    for (CalendarVO calendarVO : calendarList) {
	    	calEvent = new HashMap<String, String>();
	    	calEvent.put("id",calendarVO.getId().toString());
	    	calEvent.put("title",calendarVO.getTitle());
	    	calEvent.put("start", calendarVO.getSdate().toString()); // 형식
	    	calEvent.put("end",calendarVO.getEdate().toString());
	    	calEvent.put("backgroundColor",calendarVO.getBackgroundColor());
	    	calEvent.put("textColor",calendarVO.getTextColor());
	    	calList.add(calEvent);
		}
		return calList;
	}

    @PostMapping(value = "/calendarRadio",produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseEntity<List<Map<String, String>>> calendarRadio(@RequestBody Map<String, String> payload) {

    	log.info("payload : {}", payload);

        try {
            String memNo = payload.get("memNo");
            List<CalendarVO> calendarList = service.selectCalendar(memNo);
            List<Map<String, String>> calList = new ArrayList<Map<String,String>>();
            Map<String, String> calEvent;

            for (CalendarVO calendarVO : calendarList) {
                calEvent = new HashMap<String, String>();
                calEvent.put("id",calendarVO.getId().toString());
                calEvent.put("title",calendarVO.getTitle());
                calEvent.put("start", calendarVO.getSdate().toString());
                calEvent.put("end",calendarVO.getEdate().toString());
                calEvent.put("backgroundColor",calendarVO.getBackgroundColor());
                calEvent.put("textColor",calendarVO.getTextColor());
                calList.add(calEvent);
            }
            return ResponseEntity.ok(calList);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }


    @PostMapping(value = "/calendarInsert")
    @ResponseBody
    public int InsertCalendar(@RequestBody CalendarVO vo) {
    	return service.createCalendar(vo);
    }


	@PostMapping(value = "/calendarUpdate", produces = "application/json;charset=utf-8")
	@ResponseBody
	public Object empUpdate(@RequestBody CalendarVO vo) {
		return service.modifyCalendar(vo);
	}
	@PostMapping(value = "/calendarSelectUpdate",produces = "application/json;charset=utf-8")
	@ResponseBody
	public Object selectUpdateCalender(@RequestBody CalendarVO vo) {
		return service.modifyretrieveCalendar(vo);
	}

	@PostMapping(value = "/calendarView",produces = "application/json;charset=utf-8")
	@ResponseBody
	public CalendarVO ViewCalendar(@RequestBody Map<String, Object> payload) {
		int id = Integer.parseInt(payload.get("what").toString());
	    CalendarVO calendarVO = service.retrieveCalendar(id);
		return calendarVO;
	}

	@PostMapping(value = "/calendarDelete",produces = "application/json;charset=utf-8")
	@ResponseBody
	public int deleteCalendar(@RequestBody CalendarVO vo) {
		return service.removeCalendar(vo);
	}

}
