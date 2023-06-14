package kr.or.ddit.exam.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "asNo")
public class AnswerSubmitVO implements Serializable{
	private String asNo;	// 답안제출번호
	
	private String etNo;	// 시험지문번호	
	
	private String eqNo;	// 시험문제번호
	
	private String courseNo;	// 수강강의번호
	
	private String stuNo;	// 학생아이디	
	
	private String asAnswer;	// 제출답
	
	private String examNo; // 시험번호
	
	private List<AnswerSubmitVO> answerSubmitList;
}
