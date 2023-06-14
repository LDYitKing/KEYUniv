package kr.or.ddit.exam.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class ExamScoreVO implements Serializable{
	
	private String examNo;	// 시험번호	
	
	private String stuNo;	// 학생아이디
	
	private String esFscore;	// 최종시험점수
}
