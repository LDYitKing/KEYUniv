package kr.or.ddit.student.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "licenseNo")
public class ActivityVO implements Serializable{
	
	@NotBlank
	private String licenseNo;
	@NotBlank
	private String licenseName;
	private String licenseContent;
	@NotBlank
	private String licenseAgency;
	private String licenseLimit;
}
