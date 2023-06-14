package kr.or.ddit.lecture.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="lwpNo")
public class LectureWeekPlanVO implements Serializable{
	@NotBlank
	private String lwpNo;
	@NotBlank
	private String lectNo;
	@NotBlank
	private String lwpWeek;
	@NotBlank
	private String lwpContent;
}
