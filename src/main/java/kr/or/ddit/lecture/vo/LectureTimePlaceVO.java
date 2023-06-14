package kr.or.ddit.lecture.vo;

import lombok.Data;

@Data
public class LectureTimePlaceVO {
	// LECT_TIMEPLACE_VIEW
	
	private String ltNo; // 강의시간 아이디
	private String lectNo; // 강의번호
	
	private String ltdNo; // 강의 상세 시간 번호
	private String ltdDay; // 강의요일
	private String ltdPeriod; // 강의교시
	
	private String lrNo; // 강의실 번호
	private String lrNum; // 강의실 호수
	
	private String builNo; // 강의동 번호
	private String builName; // 건물명
}
