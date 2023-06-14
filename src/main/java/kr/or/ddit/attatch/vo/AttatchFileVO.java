package kr.or.ddit.attatch.vo;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * 파일 하나의 메타데이터
 *
 */
@Data
@EqualsAndHashCode(of = {"atchId", "atchSeq"})
@NoArgsConstructor
@ToString(exclude = "file")
public class AttatchFileVO implements Serializable{
	@JsonIgnore
	private transient MultipartFile file;
	
	public AttatchFileVO(MultipartFile file) {
		super();
		this.file = file;
		atchMime = file.getContentType();
		atchOrginName = file.getOriginalFilename();
		atchSaveName = UUID.randomUUID().toString();
		atchSize = file.getSize();
	}
	
	private Integer atchId;
	private Integer atchSeq;
	private String atchMime;
	private String atchOrginName;
	private String atchSaveName;
	private Long atchSize;
	private String atchDate;
	
	private File atchFile;
	
	public void saveTo(File saveFolder) throws IOException {
		if(file==null) return;
		file.transferTo(new File(saveFolder, atchSaveName));
	}
	
	// 삭제
//	public void delTo(File saveFolder) throws IOException {
//		if(file==null) return;
//	}
	
	
}
