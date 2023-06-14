package kr.or.ddit.exam.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "eqNo")
public class ExamQuestionVO implements Serializable{
	@NotBlank
	private String eqNo;	// 시험문제번호
	@NotBlank
	private String examNo;	// 시험번호
	
	private Integer eqNumber;	// 문제번호	
	@NotBlank
	private String eqQue;	// 문제
	
	private String eqScore;	// 문제당 배점

	private List<ExamTextVO> examTextList;
}
