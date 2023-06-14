package kr.or.ddit.Employee.vo;

import java.time.LocalDate;

import javax.validation.constraints.NotBlank;
import javax.validation.groups.Default;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.LoginGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = true, of = "empNo")
@ToString(callSuper = true)
public class EmployeeVO extends MemberVO{

	@NotBlank(groups = {Default.class, DeleteGroup.class, LoginGroup.class})
	private String empNo;
	@NotBlank
	private String empDept;
	@NotBlank
	private String empPos;
	
	@NotBlank
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate empEdate;
	
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate empRdate;
	
}
