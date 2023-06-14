package kr.or.ddit.license.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="licenseNo")
@NoArgsConstructor
@AllArgsConstructor(access=AccessLevel.PACKAGE)
@ToString
public class LicenseAcqsVO implements Serializable{
	private int rnum;
	@NotBlank
	private String licenseNo;
	@NotBlank
	private String stuNo;
	@NotBlank
	private String laAdate;

}
