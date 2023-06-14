package kr.or.ddit.lecture.vo;

import java.io.IOException;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.Base64;
import java.util.stream.Collectors;

import javax.validation.constraints.NotBlank;

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
@EqualsAndHashCode(of = "ldNo")
public class LectureDataVO implements Serializable {

	private int rnum;
	@NotBlank(groups = { UpdateGroup.class, DeleteGroup.class })
	private String ldNo;
	@NotBlank
	private String lectNo;
	@NotBlank
	private String ldTitle;

	private String ldContent;
	@DateTimeFormat(iso = ISO.DATE)
	@JsonFormat(shape = Shape.STRING)
	private LocalDate ldWdate;

	private String lectName;

	private byte[] lectureDataImg;
	// 파일--------------------------------------------------------
	private Integer ldFile; // 첨부파일 atchId
	private String atchCount;
	private String proNo;
	private MultipartFile[] addFiles;// 업데이트

	private AttatchFileGroupVO atchFileGroup; // 인서트
	private AttatchFileGroupVO addFileGroup; // 업데이트
	private AttatchFileGroupVO delFileGroup; // 딜리트

	private MultipartFile[] lectFiles; // 인서트
	// insert 인서트

	public void setLectFiles(MultipartFile[] lectFiles) throws IOException {
		if (lectFiles == null || lectFiles.length == 0) return;
		this.lectFiles = lectFiles;
		if (lectFiles != null) {
			this.lectureDataImg = lectFiles[0].getBytes();
		}
		this.atchFileGroup = new AttatchFileGroupVO();
		atchFileGroup.setAtchfileList(Arrays.stream(lectFiles).filter((mf) -> !mf.isEmpty())
				.map((mf) -> new AttatchFileVO(mf)).collect(Collectors.toList()));
	}

	// update 수정
	public void setAddFiles(MultipartFile[] addFiles) {
		if (addFiles == null || addFiles.length == 0)
			return;

		this.addFiles = addFiles;

		this.addFileGroup = new AttatchFileGroupVO();
		addFileGroup.setAtchfileList(Arrays.stream(addFiles).filter((mf) -> !mf.isEmpty())
				.map((mf) -> new AttatchFileVO(mf)).collect(Collectors.toList()));
	}

	public String getBase64lectureDataImg() {
		if (lectureDataImg == null) {
			return null;
		} else {
			return Base64.getEncoder().encodeToString(lectureDataImg);
		}
	}
}
