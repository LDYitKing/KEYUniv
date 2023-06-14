package kr.or.ddit.asgn.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
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
@EqualsAndHashCode(of = "asgnNo")
@NoArgsConstructor//스프링에서 쓰려면 필요?!
@AllArgsConstructor(access = AccessLevel.PACKAGE)
@ToString
public class AsgnVO implements Serializable{
	private int rnum;
	
	@NotBlank(groups = {UpdateGroup.class, DeleteGroup.class})
	private String asgnNo;
	
	@NotBlank
	private String lectNo;
	private String lectName;
	@NotBlank
	private String asgnName;
	@NotBlank
	private String asgnContent;
	
	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING, pattern = "yyyy-MM-dd")
	private LocalDate asgnRdate;
	
	@NotNull
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING, pattern = "yyyy-MM-dd")
	private LocalDate asgnDdate;
	
	// 파일----------------
	private Integer asgnFile; // 첨부파일 atchId
	
	private MultipartFile[] asgnFiles;
	public void setAsgnFiles(MultipartFile[] asgnFiles) {
		if(asgnFiles==null || asgnFiles.length==0) return;
		this.asgnFiles = asgnFiles; 
		this.atchFileGroup = new AttatchFileGroupVO();
		atchFileGroup.setAtchfileList(
		Arrays.stream(asgnFiles)
				.filter((mf)->!mf.isEmpty())
				.map((mf)->new AttatchFileVO(mf))				
				.collect(Collectors.toList())
		);
	}
	private AttatchFileGroupVO atchFileGroup;//has a관계 
	private List<AsgnSubmitVO> asgnSubmitList;//has many관계
	private boolean asgnSub;
	
	private String memName;
	private String asContent;
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate asSdate;
	private Integer asFile;
	private int asScore;
	private String asNo;
	
}