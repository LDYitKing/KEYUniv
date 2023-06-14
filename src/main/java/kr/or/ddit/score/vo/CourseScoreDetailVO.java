package kr.or.ddit.score.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "cdsNo")
public class CourseScoreDetailVO {
	
	private String cdsNo;	// 세부성적번호
	
	private String scNo;	// 성적처리기준번호
	
	private String courseNo;	// 수강강의번호
	
	private String stuNo;	// 학생아이디
	
	private String csdScore;	// 점수
	
	private String commName; // 평가구분(중간고사,기말고사,출석,과제)
	
	private String memName; // 이름
	
	private String deptName; // 학과명
}
