package kr.or.ddit.score.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "csNo")
public class CourseScoreVO {
	
	private String csNo;	// 강의별성적번호
	
	private String courseNo;	// 수강강의번호
	
	private String stuNo;	// 학생아이디
	
	private Integer csScore;	// 점수

}
