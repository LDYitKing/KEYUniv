package kr.or.ddit.professor.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Arrays;
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
import lombok.ToString.Exclude;

/**
 * 교수 연구 DataTransferObject
 * @author Kim Eui Yeon
 *
 */
@Data
@EqualsAndHashCode(of="studyNo")
public class StudyVO implements Serializable {
	private int rnum; 
	private String memName; // 야매야매~
	
	@NotBlank(groups = {UpdateGroup.class, DeleteGroup.class})
	private String studyNo;
	
	@NotBlank
	private String proNo;
	
	@NotBlank
	private String studyName;
	// 폼에서 받을 때 date-local 이여도 파라미터로 받아지기 때문에 파싱해야함.
	@DateTimeFormat(iso = ISO.DATE) // parsing >> String -> LocalDate
	@JsonFormat(shape = Shape.STRING)
	private LocalDate studySdate;
	
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate studyEdate;
	
	@Exclude
	private String studySubject;
	
	@Exclude
	private String studyPurpose;
	//파일--------------------------------------------------------
	private Integer studyFile; //atchId
	private String atchCount;
	
	private MultipartFile[] stuFiles; //인서트
	private MultipartFile[] addFiles;//업데이트
	
	private AttatchFileGroupVO atchFileGroup; //인서트
	private AttatchFileGroupVO addFileGroup; //업데이트
	private AttatchFileGroupVO delFileGroup; //딜리트
	
	// 인서트 셋
	public void setStuFiles(MultipartFile[] stuFiles) {
		if(stuFiles==null || stuFiles.length==0) return;
		
		this.stuFiles = stuFiles;
		
		this.atchFileGroup = new AttatchFileGroupVO();
		
		atchFileGroup.setAtchfileList(
				Arrays.stream(stuFiles)
				.filter((mf)->!mf.isEmpty())
				.map((mf)->new AttatchFileVO(mf))
				.collect(Collectors.toList())
				);
	}
	//업데이트 셋
	public void setAddFiles(MultipartFile[] addFiles) {
		if(addFiles==null || addFiles.length==0) return;
		
		this.addFiles = addFiles;
		
		this.addFileGroup = new AttatchFileGroupVO();
		addFileGroup.setAtchfileList(
				Arrays.stream(addFiles)
				.filter((mf)->!mf.isEmpty())
				.map((mf)-> new AttatchFileVO(mf))
				.collect(Collectors.toList())
				);
	}
	
	
	

}
