package kr.or.ddit.exam.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "examNo")
public class ExamVO implements Serializable {

	private String examNo; // 시험번호

	private String lectNo; // 강의번호

	private String examName; // 시험명

	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate examDate; // 시험일

	private String examType; // 시험구분

	private String examKind; // 시험종류

	private String examStime; // 시험 시작시간

	private String examEtime; // 시험 종료시간

	private String commName; // 공통코드명

	private String lectName; // 강의명

	private int ayYear; // 학사년도

	private int aySemester; // 학기

	private ExamQuestionVO examQuestionVO;

	private ExamTextVO examTextVO;

	private boolean asSub;
	
	private boolean eqSub;

}
