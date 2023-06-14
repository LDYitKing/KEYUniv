package kr.or.ddit.curri.vo;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class CurriDetailVO {
	@NotBlank
	private String cdNo;
	@NotBlank
	private String subNo;
	@NotBlank
	private String curriNo;
	@NotBlank
	private String cdPriority;
	@NotBlank
	private String subName;
	private String commName;
}
