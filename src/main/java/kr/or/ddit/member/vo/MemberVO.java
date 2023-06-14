package kr.or.ddit.member.vo;

import java.io.Serializable;
import java.util.Arrays;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.groups.Default;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.LoginGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "memNo")
//@ToString(exclude = {"memPass", "memRrno1", "memRrno2"})
public class MemberVO implements Serializable{
	@NotBlank(groups = { DeleteGroup.class, LoginGroup.class})
	private String memNo;
	
	@NotBlank(groups = {DeleteGroup.class, LoginGroup.class})
	@JsonIgnore
	private transient String memPass;

	@NotBlank
	private String memName;
	@NotBlank
	private String memGender;
	@NotBlank
	@Pattern(regexp = "\\d{6}")
	private String memRrno1;
	@NotBlank
	@JsonIgnore
	@Pattern(regexp = "\\d{7}")
	private transient String memRrno2;
	@NotBlank
	@Pattern(regexp = "\\d{2,3}-\\d{3,4}-\\d{4}")
	private String memTel;
	@NotBlank
	private String memZip;
	@NotBlank
	private String memAdd1;
	@NotBlank
	private String memAdd2;
	@NotBlank
	@Email
	private String memEmail;
//	@NotBlank
	private String memIp;
//	@NotBlank
	private String memRole;
	
	private Integer memPhoto; // 첨부파일 그룹 아이디
	private String atchSaveName; // 저장 이름
	private String atchOrginName; // 원본 이름
	
	private MultipartFile memPhotoFile; // 프로필사진
	public void setMemPhotoFile(MultipartFile memPhotoFile) {
		if(memPhotoFile==null || memPhotoFile.isEmpty()) return;
		this.memPhotoFile = memPhotoFile;
		this.atchProfile = new AttatchFileVO(memPhotoFile);
		
		this.atchSaveName = atchProfile.getAtchSaveName();
		this.atchOrginName = atchProfile.getAtchOrginName();
		
		this.atchProfileGroup = new AttatchFileGroupVO();
		atchProfileGroup.setAtchfileList(Arrays.asList(atchProfile));
	}
	
	private AttatchFileVO atchProfile;
	private AttatchFileGroupVO atchProfileGroup;
	
	private String checkMemPass; // 현재 비밀번호 확인
}
