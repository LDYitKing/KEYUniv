package kr.or.ddit.dgrade.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class DgradeVO implements Serializable {
	private String drNo;
	private Integer drGrades;
	private Integer drMc;
	private Integer drLac;
	private Integer drFcc;
	
	private String deptNo; // 학과 
	private String memNo;  
	
	private Integer countScr; // 신청학점
	
	
}
