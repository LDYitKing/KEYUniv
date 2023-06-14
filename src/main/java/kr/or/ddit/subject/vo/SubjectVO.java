package kr.or.ddit.subject.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString.Exclude;

@Data
@EqualsAndHashCode(of = "subNo")
public class SubjectVO implements Serializable{
	private int rnum; // 번호
	private String colName; // 단과대학명
	private String deptName; // 학과명
	private String subCommName; // 교과목유형명
	private String subStateName; // 승인상태명

	@NotBlank(groups = {UpdateGroup.class, DeleteGroup.class})
	private String subNo; //학과번호+ 시퀀스
	@NotBlank(groups = InsertGroup.class)
	private String deptNo; //학과번호
	@NotBlank(groups = InsertGroup.class)
	private String colNo; // 단과대학번호
	@NotBlank
	private String subName; //교과목명
	@NotBlank
	private String subExp; // 교과목설명
	@NotNull
	private Integer subGrade; // 학년

	@NotNull
	private Integer subHours; // 시수
	@NotNull
	private Integer subScr; // 학점
//	A001  전공필수
//	A002  전공선택
//	A003  전공심화
//	A004  교양필수
//	A005  교양선택
	@NotBlank(groups = InsertGroup.class)
	private String subComm; // 교과목 유형
//	B001  대기
//	B002  완료
//	B003  반려
//	B004  취소
	private String subState; // 상태 == COMM_NO
	@Exclude
	private String subReason; // 사유

	// 관련 개설 강의
	private List<LectureVO> lectList;

	private String commName;//단과이름

	private String cdNo;//커리디테일 고유넘버
	private String curriNo;

	private String cdPriority;

}
