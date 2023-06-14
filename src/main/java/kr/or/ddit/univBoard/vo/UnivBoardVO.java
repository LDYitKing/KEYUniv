package kr.or.ddit.univBoard.vo;

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


@Data
@EqualsAndHashCode(of="ubNo")
public class UnivBoardVO implements Serializable{
	private int rnum;
	
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer ubNo;
	@NotBlank
	private String ubTitle;
	@NotBlank
	private String ubWriter;
	
	private String ubTag;
	@Exclude
	@NotBlank
	private String ubContent;
	
	private Integer ubFile;
	
	private int atchCount;
	
	private Integer ubCnt;
	
	private String memName;
	
	@DateTimeFormat(iso = ISO.DATE) // parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
	private LocalDate ubWdate;
	
	private AttatchFileGroupVO atchFileGroup;
	
	private MultipartFile[] ubFiles;
	
	public void setUbFiles(MultipartFile[] ubFiles) {
		if(ubFiles==null || ubFiles.length==0)return;
		this.ubFiles = ubFiles;
		this.atchFileGroup = new AttatchFileGroupVO();
		atchFileGroup.setAtchfileList(
			Arrays.stream(ubFiles)
					.filter((mf)->!mf.isEmpty())
					.map((mf)->new AttatchFileVO(mf))
					.collect(Collectors.toList())
		);
	}
	
//	private MultipartFile[] addFiles;
//	public void setAddFiles(MultipartFile[] addFiles) {
//		if(addFiles==null || addFiles.length==0) return;
//		this.addFiles = addFiles;
//		this.addFileGroup = new AttatchFileGroupVO();
//		addFileGroup.setAtchfileList(
//			Arrays.stream(addFiles)
//					.filter((mf)->!mf.isEmpty())
//					.map((mf)->new AttatchFileVO(mf))
//					.collect(Collectors.toList())
//		);
//	}
	
	//업데이트 그룹
	private AttatchFileGroupVO addFileGroup; 
	//딜리트 그룹
	private AttatchFileGroupVO delFileGroup;
}
