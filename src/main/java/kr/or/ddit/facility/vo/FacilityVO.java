package kr.or.ddit.facility.vo;

import java.io.IOException;
import java.io.Serializable;
import java.util.Arrays;
import java.util.Base64;
import java.util.stream.Collectors;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "faciNo")
public class FacilityVO implements Serializable{

	private int rnum;

	@NotBlank(groups = {UpdateGroup.class, DeleteGroup.class})
	private String faciNo; // 시설번호
	@NotBlank
	private String faciName; // 시설이름

	private String faciCaution; // 주의사항

	private byte[] facilityImg;
	// 파일----------------
	private Integer faciFile; // 첨부파일 atchId
	private int atchCount;

	private MultipartFile[] addFiles; // 업데이트

	private AttatchFileGroupVO atchFileGroup;
	private AttatchFileGroupVO addFileGroup;
	private AttatchFileGroupVO delFileGroup;

	private MultipartFile[] facilityFiles; // 인서트
	// insert 인서트

	public void setFacilityFiles(MultipartFile[] facilityFiles) throws IOException {
		if(facilityFiles == null || facilityFiles.length==0)  return;
		this.facilityFiles = facilityFiles;
		if(facilityFiles != null) {
			this.facilityImg = facilityFiles[0].getBytes();
		}
		this.atchFileGroup = new AttatchFileGroupVO();
		atchFileGroup.setAtchfileList(
				Arrays.stream(facilityFiles)
				.filter((mf)->!mf.isEmpty())
				.map((mf)->new AttatchFileVO(mf))
				.collect(Collectors.toList())
				);
	}
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

   public String getBase64FacilityImg() {
	      if(facilityImg==null) {
	         return null;
	      }else {
	         return Base64.getEncoder().encodeToString(facilityImg);
	      }
	   }


}





















