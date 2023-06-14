package kr.or.ddit.lecture.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "scNo")
public class ScoreCRTRVO implements Serializable{
	@NotBlank
	private String scNo;
	@NotBlank
	private String lectNo;
	@NotBlank
	private String scTitle;
	@NotNull
	private Integer scRatio;
	
	// 성적처리 기준 위해
	private String commName;

}
