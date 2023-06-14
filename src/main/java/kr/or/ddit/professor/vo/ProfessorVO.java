package kr.or.ddit.professor.vo;

import java.time.LocalDate;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.groups.Default;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.LoginGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = true, of = "proNo")
@ToString(callSuper = true)
public class ProfessorVO extends MemberVO {

	@NotBlank(groups = {Default.class, DeleteGroup.class, LoginGroup.class})
	private String proNo;
	@NotBlank
	private String deptNo;
	private String deptName;
	@NotBlank
	private String colNo;
	private String colName;
	@NotBlank
	private String proPos;
	@NotBlank
	private String proLoe;
	@NotBlank
	private String proCareer;
	
	@NotBlank
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate proEdate;
	
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate proRdate;
	

	
//-------------------여기까지가 기본 컬럼---------------------------
	
	// list 연구vo 
}
