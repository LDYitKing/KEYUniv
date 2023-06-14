package kr.or.ddit.favorites.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.InsertGroup;
import lombok.Data;

@Data
public class FavoriteVO implements Serializable {
	@NotBlank(groups = {InsertGroup.class, DeleteGroup.class})
	private String memNo; //구성원번호
	@NotBlank(groups = {InsertGroup.class, DeleteGroup.class})
	private String subNo; // 교과목번호

	private String subName; // 교과목명

	private int rnum;
	private String deptName; // 학과명
	private String subCommName; // 교과목유형명
	private Integer subGrade; // 학년
	private Integer subHours; // 시수
	private Integer subScr; // 학점
	private String commName;//수업유형
	private String curriNo;	//커리 넘버
	
	private String memName; //구성원 이름
	private String proNo; // 교수 번호
	private String proLoe; // 교수 학력
    
	private String jobNo; // 직업번호
	private String jobName; // 직업이름
	
	private String lectName; //강의번호		
    private String lectNo; //강의번호		
    private String lectOnfName;	// 대면여부	
    private String lectStateName; // 개설여부
	

}
