package kr.or.ddit.attendance.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="attendNo")
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PACKAGE)
@ToString
public class AttendanceVO implements Serializable{
	@NotBlank(groups = UpdateGroup.class)
	private String attendNo;
	@NotBlank
	private String courseNo;
	private String lectName;
	private String lectNo;
	@NotBlank
	private String stuNo;
	@NotNull(groups = InsertGroup.class)
	@DateTimeFormat(iso = ISO.DATE) //받을때
	@JsonFormat(shape = Shape.STRING) //마샬링할때
	private LocalDate attendDate;
	@NotBlank
	private String attendState;
	private int countAttend;
	private int countDeattend;
	private int countAllAttend;
	private int countCurrentAttend;
	
	private AttendanceAdmitVO attendanceAdmitVO; //has a관계
	
	private List<StudentVO> studentList;
}
