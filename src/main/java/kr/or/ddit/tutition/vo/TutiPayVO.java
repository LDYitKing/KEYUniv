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

@Data
@EqualsAndHashCode(of="TP_NO")
public class TutiPayVO {
	
	private int rnum;
	
	@NotBlank(groups={UpdateGroup.class, DeleteGroup.class})
	private String tpNo;
	@NotBlank
	private String stuNo;
	@NotBlank
	private String tuitionNo;
	
	@DateTimeFormat(iso = ISO.DATE) // parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
	private LocalDate tpDate;
	@NotNull
	private int tpAmount;
	@NotBlank
	private String tpState;
	
	private String colNo;
	private String colName;
	
	private String deptName;
	private String deptNo;
	
	private String stuYear;
	
	private String schNo;
	private String schName;
	private String schCont;
	private int schAmount;
	
	private String schRecNo;
	private Date schRecDate;
	private int schRecSemester;
	private String schRecState;
	
	private String memName;
	private String memTel;
	private String memEmail;
	
	private String commNo;
	private String commName;
	private int tuitionPayment;
	private int tuitionSchrec;
	private int tuitionAmount;
	
	
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
