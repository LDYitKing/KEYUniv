package kr.or.ddit.tutition.vo;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.Date;
import java.util.stream.Collectors;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

// 장학금 고지서 VO
@Data
@EqualsAndHashCode(of="TUITION_NO")
public class TuitionVO {

	private int rnum; // 일련번호

	// 등록금 고지서 Table
	@NotBlank(groups={UpdateGroup.class, DeleteGroup.class})
	private String tuitionNo;
	@NotBlank
	private String tuitionCol;
	@NotBlank
	private String tuitionDept;
	@NotBlank
	private String tuitionStuNo;
	@NotBlank
	private String tuitionName;
	@NotNull
	private int tuitionGrade;
	@NotNull
	private int tuitionSemester;

	private int tuitionSchRec; // 수혜금액 - Null
	@NotNull
	private int tuitionAmount;
	@NotNull
	private int tuitionPayment;


	// 단과대학
	private String colNo;
	private String colName;

	// 학과
	private String deptName;
	private String deptNo;

	// 장학금
	private String schNo;
	private String schName;
	private String schCont;

	// 장학금 선정
	private String schRecNo;
	private Date schRecDate;
	private int schRecSemester;
	private String schRecState;

	// 등록금 납부
	@DateTimeFormat(iso = ISO.DATE) // parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
	private LocalDate tpDate;
	private String tpState;
	private String memName;

	// 현재 상태 확인
	private String commNo;
	private String commName;

	private MultipartFile[] tpFiles;
	public void setTpFiles(MultipartFile[] tpFiles) {
		if(tpFiles == null || tpFiles.length == 0) return;
		this.tpFiles = tpFiles;

		this.atchFileGroup = new AttatchFileGroupVO();
		atchFileGroup.setAtchfileList(
			Arrays.stream(tpFiles)
					.filter((mf)->!mf.isEmpty())
					.map((mf)->new AttatchFileVO(mf))
					.collect(Collectors.toList())
		);
	}

	private AttatchFileGroupVO atchFileGroup;

	private Integer tpFile;
}
