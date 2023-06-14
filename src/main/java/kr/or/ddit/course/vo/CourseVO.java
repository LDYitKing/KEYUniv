package kr.or.ddit.course.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.attendance.vo.AttendanceVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.student.vo.StudentVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = {"courseNo","stuNo"})
public class CourseVO implements Serializable{
// 
	@NotBlank
	private String courseNo; // 수강강의번호
	@NotBlank
	private String stuNo; // 학생학번
	@NotBlank
	private String lectNo; // 강의번호
	private LectureVO lecture; // 강의vo
	
	@DateTimeFormat(iso = ISO.DATE) // parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
	@NotNull
	private LocalDateTime courseAdate; // 신청일시
	
	@DateTimeFormat(iso = ISO.DATE) // parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
	private LocalDateTime courseCdate; // 취소일시
	
	@NotBlank
	private String courseState; // 수강상태
	
	private List<AttendanceVO> attendList;
	private StudentVO student;
	
	private Integer ayYear;
	private Integer aySemester;
	
	// 수강생 리스트 가져오기 위해
	private String deptName;
	private String memName;
}









