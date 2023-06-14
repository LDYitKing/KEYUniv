package kr.or.ddit.attendance.vo;

import java.io.Serializable;
import java.util.Arrays;
import java.util.stream.Collectors;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="aaNo")
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AttendanceAdmitVO implements Serializable {
	@NotBlank(groups = DeleteGroup.class)
	private String aaNo;
	@NotBlank
	private String attendNo;
	private String courseNo;
	private String lectNo;
	private String lectName;
	private String colName;
	private String deptName;
	private String stuNo;
	@NotBlank
	private String aaReason;
	private String aaState;
	private String attendState;

	private String aaRefuse;
	
	private MultipartFile[] aaFiles;
	public void setAaFiles(MultipartFile[] aaFiles) {
		if(aaFiles == null || aaFiles.length == 0) return;
		this.aaFiles = aaFiles;
		
		this.atchFileGroup = new AttatchFileGroupVO();
		atchFileGroup.setAtchfileList(
			Arrays.stream(aaFiles)
					.filter((mf)->!mf.isEmpty())
					.map((mf)->new AttatchFileVO(mf))
					.collect(Collectors.toList())
		);
	}
	private AttatchFileGroupVO atchFileGroup;
	
	private Integer aaFile;
	
	private AttendanceVO attend; // has a 관계
	private StudentVO student; // has a 관계
}
