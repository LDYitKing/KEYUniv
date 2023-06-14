package kr.or.ddit.lecture.vo;

import java.io.Serializable;
import java.util.List;
import java.util.stream.Collectors;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.subject.vo.SubjectVO;
import kr.or.ddit.ui.LectureListRenderer;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "lectNo")
public class LectureVO implements Serializable{
	@NotBlank(groups = UpdateGroup.class)
	private String lectNo; // 강의번호
	@NotBlank
	private String subNo; // 교과목 번호
	
	@NotBlank
	private String proNo; // 교수아이디
	private String memName; // 교수명
	
	@NotBlank
	private String lectName; // 강의명
	@NotBlank
	private String lectExp; /// 강의 설명
	@NotNull
	private Integer lectMm; // 최대수강인원
	@NotNull
	private Integer lectPm; // 현재수강인원
	
	@NotBlank
	private String lectOnf; // 대면여부 코드 (E001대면, E002비대면)
	private String lectOnfName; // 대면여부 명
	
	@NotBlank
	private String lectState; // 상태 코드 (J001개설, J002폐강)
	private String lectStateName; // 상태 명
	
	private Integer ayYear; // 연도
	private Integer aySemester; // 학기
	
	private String deptNo; // 학과코드
	private String deptName; // 학과명
	private String colNo; // 단과대학 코드
	private String colName; // 단과대학명
	
	// 교과목 vo
	private SubjectVO subject;
	private String subName; // 교과목명
	private Integer subGrade; // 학년 
	private Integer subHours; // 시수
	private Integer subScr; // 학점
	// 교과목 유형 (A001전공필수, A002전공선택, A003전공심화, A004교양필수, A005교양선택)
	private String subComm;
	private String subCommName;
	
	// 강의실, 강의시간
	private String ltNo; // 강의시간 아이디
	
	private List<LectureTimePlaceVO> lectDetailList; // 강의 상세 시간 리스트
	
	private String lectTime;
	// 강의 상세 시간 출력 (예-월 1 2, 수 6 7)
	public String getLectTime(List<LectureTimePlaceVO> lectDetailList) {
		if(ltNo==null||ltNo.isEmpty()) return "";
		
		StringBuffer lectDetailFormat = new StringBuffer();
		
		lectDetailFormat.append(lectDetailList.get(0).getLtdDay()+" ");
		lectDetailFormat.append(lectDetailList.get(0).getLtdPeriod()+" ");
		for(int i=1; i<lectDetailList.size(); i++) {
			LectureTimePlaceVO vo = lectDetailList.get(i);
			
			if(!vo.getLtdDay().equals(lectDetailList.get(i-1).getLtdDay())) {
				lectDetailFormat.append(", ");
				lectDetailFormat.append(vo.getLtdDay()+" ");
			}
			lectDetailFormat.append(vo.getLtdPeriod()+" ");
		}		
		
		return lectDetailFormat.toString();
	}
	
	public String getLectTimeNum(List<LectureTimePlaceVO> lectDetailList) {
		if(ltNo==null||ltNo.isEmpty()) return "";
		return lectDetailList.stream().map(vo->vo.getLtdNo()).collect(Collectors.joining(","));
	}
	
	private List<LectureWeekPlanVO> lectPlanList; // 강의 주차별 계획 리스트
	public void setLectDetailList(List<LectureTimePlaceVO> lectDetailList) {
		this.lectDetailList = lectDetailList;
	}
	
	// 강의 리스트 출력 (li태그 format)
	@JsonIgnore
	private transient LectureListRenderer renderer = new LectureListRenderer();
	public String getLectListHTML() {
		return renderer.renderList(this);
	}
	private boolean isSignup;
	
	private List<ScoreCRTRVO> scoreCRTRList; // 성적처리 기준.
	// 검색 조건
	private String searchData; // keyup 검색어
	private String ltdDay; // 요일(월..)
	private String lwpNo;
	private String scNo;
	
	// 강의동, 강의실번호
	private String builName;
	private String lrNum;
	
}
