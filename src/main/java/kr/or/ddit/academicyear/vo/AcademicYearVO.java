package kr.or.ddit.academicyear.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = {"ayYear","aySemester"})
public class AcademicYearVO implements Serializable{
	//현재 학년도 가져왔음. 
	@NotNull
	private Integer ayYear;
	@NotNull
	private Integer aySemester;

}
