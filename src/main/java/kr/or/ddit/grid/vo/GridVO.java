package kr.or.ddit.grid.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;

@Data
public class GridVO implements Serializable {
	
	/**
	 	Z001 나의 성적
		Z002 나의 캘린더
		Z003 내 시간표
		Z004 오늘의 뉴스
		Z005 공지
		Z006 식단
		
		Z100 생성
		Z200 삭제
	 */
	@NotBlank(groups = UpdateGroup.class)
	private String gridCode; // 그리드 코드
	
	@NotBlank(groups = UpdateGroup.class)
	private String memNo; // 구성원번호
	
	@NotNull(groups = UpdateGroup.class)
	private Integer gridX; // X좌표
	
	@NotNull(groups = UpdateGroup.class)
	private Integer gridY; // Y좌표
	
	@NotNull(groups = UpdateGroup.class)
	private Integer gridW; // 넓이
	
	@NotNull(groups = UpdateGroup.class)
	private Integer gridH; // 높이
	
	@NotBlank(groups = UpdateGroup.class)
	private String gridStatus; // 그리드 상태
	
}
