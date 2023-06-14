package kr.or.ddit.student.vo;

import java.time.LocalDate;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.groups.Default;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.attendance.vo.AttendanceVO;
import kr.or.ddit.course.vo.CourseVO;
import kr.or.ddit.department.vo.ColleageVO;
import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.LoginGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = true, of = "stuNo")
@ToString(callSuper = true)
public class StudentVO extends MemberVO {
	private int rnum;
	
	@NotBlank(groups = {UpdateGroup.class, DeleteGroup.class, LoginGroup.class})
	private String stuNo;
	@NotBlank
	private String deptNo;
	private String deptName;
	@NotBlank
	private String colNo;
	private String colName;
//	@NotBlank
	private String drNo;
//	@NotBlank
	private String stuState;
	private String commName; // 학적상태
	
//	@NotBlank
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate stuEdate;
	
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate stuGdate;
	
//	@NotBlank
	private String stuEmploy;
	
	private Integer stuYear; // 학년
	
	private List<ActivityVO> actList; // 활동 list
	// 취득 자격증 list

	// list<교과목vo> -> 수강과목 list
	
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate empDate; // 취업일자
	private String empPlace; // 취업처
	
	private String ayYear;
//	private Integer aySemester;
	
	private List<StudentVO> stuList;
	
	private List<LectureVO> lectureList;//강의 has many
	private List<CourseVO> courseList; //수강 has many
	private MemberVO member; //멤버 has a
	private DepartmentVO department; //학과 has a
	private ColleageVO colleage; //단과대학 has a
	
	private List<AttendanceVO> attendList; //has many 
	
}
