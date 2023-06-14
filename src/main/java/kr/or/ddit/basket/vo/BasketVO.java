package kr.or.ddit.basket.vo;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.lecture.vo.LectureVO;
import lombok.Data;

@Data
public class BasketVO {
	private String basketNo;
	private String stuNo;
	private String lectNo;

	private LectureVO lecture; // 강의vo	
	
	@DateTimeFormat(iso = ISO.DATE_TIME)
	@JsonFormat(shape = Shape.STRING)	
	private LocalDateTime basketRdate;
	
	private int basketNum; // 장바구니 담은 학생 수 
	
}
