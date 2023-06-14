package kr.or.ddit.sch.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="schRecNo")
public class SchRecVO implements Serializable{
	private int rnum;
//-----------------------------------------------------------------------------------
	//SCH_REC Table 컬럼
	@NotBlank(groups = {UpdateGroup.class , DeleteGroup.class})
	private String schRecNo;
	@NotBlank
	private String schNo;
	@NotBlank
	private String stuNo;
	@DateTimeFormat(iso = ISO.DATE) // parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
	private LocalDate schRecDate;
	@NotBlank
	private String SchRecState; //장학금 상태 
	

//-----------------------------------------------------------------------------------
	// JOIN 필요 컬럼
	private String memName; //학생이름
	private String colName; // 단과 대학
	private String deptName; // 학과이름
	@NotNull
	private int schRecSemester;	 // 수혜학기
	
	private String commNo; //상태 번호
	private String commName; //상태 이름

//-----------------------------------------------------------------------------------	
	
	// has a 관계 -- 
	private SchVO addsch;//장학금 has a
	
	private StudentVO addstu; // 학생 has a
	
	private MemberVO member; //멤버 has a
	
	private DepartmentVO department; //학과 has a
}
