package kr.or.ddit.monthStudent.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="stuNo")
public class MonthStudentVO  implements Serializable  {
	private int rnum;
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	private String stuNo;
	@NotBlank
	private String deptNo;
	@NotBlank
	private String colNo;
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private String msDate;
	
	private StudentVO student;
	
	private List<String> stuNoList; //다중 선택한 stuNo의 값을 저장함
	
	private DepartmentVO department;
}
