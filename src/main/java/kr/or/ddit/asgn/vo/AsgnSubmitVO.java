package kr.or.ddit.asgn.vo;

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
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="asNo")
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PACKAGE)
@ToString
public class AsgnSubmitVO implements Serializable{
	@NotBlank(groups = {UpdateGroup.class, DeleteGroup.class})
	private String asNo;
	@NotBlank
	private String asgnNo;
	@NotBlank
	private String courseNo;
	@NotBlank
	private String stuNo;
	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate asSdate;
	@NotBlank
	private String asContent;
	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
	private Integer asScore;
	
	private MultipartFile[] asFiles;
	public void setAsFiles(MultipartFile[] asFiles) {
		// 첨부파일이 없으면 그냥 셋팅
		if(asFiles==null || asFiles.length == 0) return;
		this.asFiles = asFiles;
		// 첨부파일이 있으면 
		this.atchFileGroup = new AttatchFileGroupVO();
		atchFileGroup.setAtchfileList(
		Arrays.stream(asFiles)
				.filter((mf)->!mf.isEmpty())
				.map((mf)->new AttatchFileVO(mf))
				.collect(Collectors.toList())
		);
		
	}
	private AttatchFileGroupVO atchFileGroup;//has many관계
	
	
	private AttatchFileGroupVO delFileGroup; 
	private AttatchFileGroupVO addFileGroup; 
	private MultipartFile[] addFiles; // 업데이트
	
	// update 수정
	public void setAddFiles(MultipartFile[] addFiles) {
		if(addFiles == null || addFiles.length==0) return;

		this.addFiles = addFiles;

		this.addFileGroup = new AttatchFileGroupVO();
		addFileGroup.setAtchfileList(
		Arrays.stream(addFiles)
				.filter((mf)->!mf.isEmpty())
				.map((mf)->new AttatchFileVO(mf))
				.collect(Collectors.toList())
		);
	}
	
	private Integer asFile;
	
	private String asgnName;
	
	private String memName;
	
	private String lectNo;
	
	
	
}
