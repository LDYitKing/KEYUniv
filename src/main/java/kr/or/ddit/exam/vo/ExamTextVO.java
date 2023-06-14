package kr.or.ddit.exam.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "etNo")
public class ExamTextVO implements Serializable{
	@NotBlank
	private String etNo;	// 시험지문번호
	
	@NotBlank
	private String eqNo;	// 시험문제번호
	
	@NotBlank
	private String etQue;	// 보기문항
	
	private String etRightAnswer;	// 정답
}
